# cluster: master node
Host cluster-master
    Hostname <IP_ADDRESS>
    User <USER_NAME>
    Port <PORT>

# cluster: internal node (goes through cluster-master)
Host cluster-node
    Hostname <NODE_NAME>
    ProxyJump <USER_NAME>@<IP_ADDRESS>:<PORT>
    User <USER_NAME>

# your typical aws ec2 instance
Host aws-ec2-instance
    Hostname <EC2_IP_ADDRESS|EC2_HOSTNAME>
    IdentityFile ~/.ssh/<PEM_FILENAME>.pem
    User ec2-user
    # useful if running jupyter lab or notebook remotely
    # jupyter notebook runs on port 8888 remotely but will be accessible locally at 9999
    LocalForward 9999 localhost:8888
    # useful if running a simple webserver remotely
    # python3 -m http.server runs on port 8000 remotely but will be accessible locally at 9999
    LocalForward 9000 localhost:8000

# LocalForward above is equivalent to -L localhost:9999:localhost:8888
# https://unix.stackexchange.com/questions/433923/ssh-port-forwarding-via-jump-host-ssh-config-files-and-only-ssh-targethost