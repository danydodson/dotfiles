# Javascript Cheat-sheet

---

## Delimiters

### version 1

```javascript

/* ------------------------------------------------------
   If we’re on YouTube, move the button into the masthead
-------------------------------------------------------*/

```

### version 2

```javascript

/* -------------- move badge into YouTube masthead -------------- */


```

---

## JRE/JDK Troubleshooting

The following is the actual script that jre11-openjdk installs at `/var/lib/pacman/local/jre11-openjdk-11.0.27.u6-1`. Read it in order to see how to fix Java:

```bash

THIS_JRE='java-11-openjdk'

fix_default() {
  if [ ! -x /usr/bin/java ]; then
    /usr/bin/archlinux-java unset
    echo ""
  else
    /usr/bin/archlinux-java get
  fi
}

post_install() {
  default=$(fix_default)
  case ${default} in
    "")
      /usr/bin/archlinux-java set ${THIS_JRE}
      ;;
    ${THIS_JRE})
      # Nothing
      ;;
    *)
      echo "Default Java environment is already set to '${default}'"
      echo "See 'archlinux-java help' to change it"
      ;;
  esac

  echo "when you use a non-reparenting window manager,"
  echo "set _JAVA_AWT_WM_NONREPARENTING=1 in /etc/profile.d/jre.sh"
}

post_upgrade() {
  if [ -z "$(fix_default)" ]; then
    /usr/bin/archlinux-java set ${THIS_JRE}
  fi
}

```
