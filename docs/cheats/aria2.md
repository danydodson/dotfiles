1. Install aria2 package:
```bash
sudo pacman -S aria2
```

2. Create a configuration file for aria2. You can create a configuration file at `~/.aria2/aria2.conf` with the following content:
```plaintext
enable-rpc=true
rpc-listen-all=true
rpc-listen-port=6800
rpc-secret=yourSecretTokenHere
```
Replace `yourSecretTokenHere` with your desired secret token.

3. Start the aria2 daemon with the configuration file:
```bash
aria2c --conf-path=~/.aria2/aria2.conf -D
```

4. You should now be able to access the aria2 server at http://localhost:6800 in your web browser. You can use a tool like AriaNg to interact with the server.

Remember to replace `yourSecretTokenHere` with a secure token of your choice for better security.
