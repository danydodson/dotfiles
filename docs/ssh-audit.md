# ssh_audit.sh — Deterministic SSH Audit & Alignment (Universal)

**Purpose:**  
Pin host keys, install `authorized_keys` from GitHub (or optional sources), harden `sshd`, verify key-only authentication, and output per-host reports.

---

## Features

1. Ensures local SSH client prerequisites and directories.
2. Pins the host’s **ED25519** key into `~/.ssh/known_hosts` (hashed).
3. Installs merged public keys into the host’s `~/.ssh/authorized_keys`.
4. Hardens `sshd_config`:
   - `PasswordAuthentication no`
   - `KbdInteractiveAuthentication no`
   - `PubkeyAuthentication yes`
   - `PermitRootLogin no`
   - Optional: `AllowUsers <user>`
   - Controlled: `AllowTcpForwarding` and `X11Forwarding`
5. Writes or updates a host entry in `~/.ssh/config`.
6. Verifies handshake → must use `ssh-ed25519` + `publickey`.
7. Writes Markdown reports to `~/.ssh_align/reports/`.

---

## Usage

```bash
bash ssh_audit.sh [--hosts "ip1 ip2"] [--user <username>] [--github <username>]
                  [--mode enforce|report|strict]
````

If any required values are missing, you’ll be interactively prompted.

---

## Typical Run

```bash
bash ssh_audit.sh --mode enforce
# Prompts:
#   Enter host(s): 192.168.1.50
#   Enter remote username: admin
#   Enter GitHub username for key import: johndoe
```

---

## Modes

| Mode        | Description                                           |
| ----------- | ----------------------------------------------------- |
| **enforce** | Install keys, harden `sshd`, verify, report (default) |
| **report**  | Non-destructive audit only                            |
| **strict**  | Enforce, then fail if post-checks mismatch            |

---

## Host Key Hygiene

Always pre-trust new SSH endpoints to avoid hangs or MITM warnings:

```bash
ssh-keyscan -t ed25519 <host> >> ~/.ssh/known_hosts
ssh-keygen -H -f ~/.ssh/known_hosts
rm -f ~/.ssh/known_hosts.old  # optional cleanup
```

---

## Outputs

| Type        | Location                                        |
| ----------- | ----------------------------------------------- |
| Reports     | `~/.ssh_align/reports/<host>_report.md`         |
| Logs        | `~/.ssh_align/logs/`                            |
| Known Hosts | `~/.ssh/known_hosts` (hashed)                   |
| Config      | `~/.ssh/config` updated with current host block |

---

## Security Notes

* Pulls public keys securely from `https://github.com/<user>.keys`
* Uses `sudo` only for modifying `/etc/ssh/sshd_config`
* Idempotent: safe to rerun anytime; duplicates automatically removed.

---

## Example Integration

```bash
# Run interactive setup
bash ssh_audit.sh

# Run quietly with known values
bash ssh_audit.sh --hosts "server1.local server2.local" \
                  --user sysadmin \
                  --github myuser \
                  --mode enforce
```

---

## Troubleshooting

* **SSH still asks for password:**
  Check `/etc/ssh/sshd_config` → ensure `PasswordAuthentication no`.

* **New host key warning:**
  Refresh using:

  ```bash
  ssh-keygen -R <host>
  ssh-keyscan -t ed25519 <host> >> ~/.ssh/known_hosts
  ssh-keygen -H -f ~/.ssh/known_hosts
  ```

* **Firewall/Port blocked:**
  Confirm with `nc -z <host> 22`.

---

## Version

`ssh_audit.sh 3.1.0`
