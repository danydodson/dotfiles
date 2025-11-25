# --- // Setup_XFS // ========

# Parted:
sudo parted /dev/sdd
(parted) mklabel gpt
(parted) mkpart primary xfs 1MiB 100%
(parted) print

# Make filesystem and dir:
sudo mkfs.xfs -f /dev/sdd1
sudo mkdir -p /mnt/data_storage

# Remount with the `prjquota` option:
sudo mount -o prjquota /dev/sdd1 /mnt/data_storage

# Update /etc/fstab:
sudo sed -i '/\/mnt\/data_storage/s/defaults/defaults,prjquota/' /etc/fstab

# XFS project quotas require 2 entries in: /etc/projects and /etc/projid:
echo "myproject:/mnt/data_storage/myproject" | sudo tee -a /etc/projects
echo "myproject:100" | sudo tee -a /etc/projid

# Create project dir and set perms:
sudo mkdir -p /mnt/data_storage/myproject
sudo chown $USER:$USER /mnt/data_storage/myproject

# Assign project to the dir:
sudo xfs_quota -x -c 'project -s myproject' /mnt/data_storage

# Set quota limit for the project:
sudo xfs_quota -x -c 'limit -p bhard=10G myproject' /mnt/data_storage
