#!/bin/bash

# auto add trackers from nosang's tracker list
# cmd: nohup ./add-trackers.sh </dev/null >$HOME/.dotfiles/logs/add-trackers.log 2>&1 &

# Get transmission credentials and ip or dns address
auth=user:pass
host=localhost

# set trackers list space separated
trackers=https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt
pt_trackers=()

while true; do
  sleep 25

  add_trackers() {
    torrent_hash=$1
    id=$2
    trackerslist=/tmp/trackers.txt

    for base_url in $trackers; do
      if [ ! -f $trackerslist ]; then
        curl -o "$trackerslist" "${base_url}"
      fi

      Local=$(wc -c <$trackerslist)
      Remote=$(curl -sI "${base_url}" | awk '/Content-Length/ {sub("\r",""); print $2}')
      if [ "$Local" != "$Remote" ]; then
        curl -o "$trackerslist" "${base_url}"
      fi

      echo "URL for ${base_url}"
      echo "Adding trackers for $torrent_name..."

      grep -v '^ *#' <$trackerslist | while IFS= read -r tracker; do
        echo "${tracker}..."
        if transmission-remote "$host" --auth="$auth" --torrent "${torrent_hash}" -td "${tracker}" | grep -q 'success'; then
          echo ' failed.'
        else
          echo ' done.'
        fi
      done
    done

    sleep 3m
    rm -f "/tmp/TTAA.$id.lock"
  }

  # Get list of active torrents
  ids="$(transmission-remote "$host" --auth="$auth" --list | grep -vE 'Seeding|Stopped|Finished|[[:space:]]100%[[:space:]]' | grep '^ ' | awk '{ print $1 }')"

  for id in $ids; do
    add_date="$(transmission-remote "$host" --auth="$auth" --torrent "$id" --info | grep '^  Date added: ' | cut -c 21-)"
    add_date_t="$(date -d "$add_date" "+%Y-%m-%d %H:%M")"
    dater="$(date "+%Y-%m-%d %H:%M")"
    dateo="$(date -d "1 minutes ago" "+%Y-%m-%d %H:%M")"
    tracker0="$(transmission-remote "$host" --auth="$auth" -t "$id" -it | sed -n '2,2p' | awk '{print $3}' | awk -F : '{print $2}' | sed -e 's/\/\///')"
    for value in "${pt_trackers[@]}"; do
      if [[ $tracker0 =~ $value ]]; then
        echo "skip id=" "$id" "$tracker0"
        continue
      fi
    done

    if [ ! -f "/tmp/TTAA.$id.lock" ]; then
      if [ "$add_date_t" = "$dater" ] || [ "$add_date_t" = "$dateo" ]; then
        hash="$(transmission-remote "$host" --auth="$auth" --torrent "$id" --info | grep '^  Hash: ' | awk '{ print $2 }')"
        torrent_name="$(transmission-remote "$host" --auth="$auth" --torrent "$id" --info | grep '^  Name: ' | cut -c 9-)"
        add_trackers "$hash" "$id" &
        touch "/tmp/TTAA.$id.lock"
      fi
    fi
  done
done
