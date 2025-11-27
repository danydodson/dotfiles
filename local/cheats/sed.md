# Sed Cheat-sheet

## Uncomment all the "Server = ..." lines:

```bash
sudo sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist
```

---

## Remove all backslashes from a file 

```shell
sed 's/\\//g' input.txt > output.txt
```

---

## Place single-quotes around every word in a file

```shell
sed -E "s/^'?([^']+)'?$/\'\1\'/" input.txt > output.txt
```
