### **Cheat Sheet for `dracut`**

#### **Overview**:
`dracut` is a tool used to generate an initial ramdisk image (initramfs) that the Linux kernel uses during the boot process. Unlike traditional `initrd` generation tools like `mkinitrd`, `dracut` starts with an empty image and only installs the necessary components. It's highly modular and allows flexible customization of the initramfs.

---

### **Basic Syntax**:
```bash
dracut [options] [outputfile] [kernelversion]
```

- **`[outputfile]`**: The name of the generated initramfs file. If not specified, it defaults to `/boot/initramfs-$(uname -r).img`.
- **`[kernelversion]`**: Specifies the kernel version for which the initramfs should be generated. If not specified, the currently running kernel version is used.

---

### **Common Use Cases**:

#### 1. **Generate a Basic Initramfs**:
To create an initramfs for the currently running kernel:
```bash
dracut
```
This will generate an initramfs and save it as `/boot/initramfs-$(uname -r).img`.

---

#### 2. **Specify a Kernel Version**:
To create an initramfs for a specific kernel version:
```bash
dracut /boot/initramfs-5.8.0.img 5.8.0
```
This will create an initramfs file for kernel version `5.8.0` and save it as `/boot/initramfs-5.8.0.img`.

---

#### 3. **Force Regeneration of Initramfs**:
If an initramfs already exists and you need to regenerate it:
```bash
dracut --force
```
This will overwrite the existing initramfs for the current kernel.

---

### **Options**:

- **`-f`, `--force`**: Force the generation of the initramfs, overwriting any existing files.
- **`-H`, `--hostonly`**: Only include the drivers and modules needed for the current host system. This creates a minimal initramfs tailored to the specific system.
- **`-m`, `--modules`**: Specify which modules should be included in the initramfs.
  ```bash
  dracut --modules "lvm mdraid"
  ```
  This will include the LVM and MDRAID modules.
- **`--no-hostonly`**: Generate a generic initramfs that can boot on different hardware systems.
- **`-v`, `--verbose`**: Show detailed output of what `dracut` is doing during initramfs generation.
- **`--kver`**: Specify the kernel version to use. Useful if you are generating an initramfs for a kernel version other than the one currently running.

---

### **Advanced Options and Parameters**:

- **`--install`**: Manually include specific files in the initramfs.
  ```bash
  dracut --install "/etc/fstab"
  ```
  This will ensure that `/etc/fstab` is included in the initramfs.

- **`--omit`**: Exclude specific modules from the initramfs.
  ```bash
  dracut --omit "network" /boot/initramfs-custom.img
  ```
  This will create an initramfs without networking support.

- **`--strip`**: Remove unnecessary files (such as man pages and documentation) from the initramfs to reduce its size.

- **`-M`, `--no-compress`**: Skip compression of the initramfs.
  ```bash
  dracut -M /boot/initramfs-no-compress.img
  ```

- **`--xz`, `--lzma`, `--gzip`**: Choose the compression algorithm for the initramfs. `dracut` defaults to `gzip` but supports several compression formats.
  ```bash
  dracut --xz /boot/initramfs-compressed.img
  ```
  This will use `xz` compression.

- **`--rebuild`**: Clean the dracut cache and rebuild the initramfs from scratch.
  ```bash
  dracut --rebuild
  ```

---

### **Working with Dracut Modules**:

Dracut is modular, and modules can be added or removed based on your needs. Modules are stored in `/usr/lib/dracut/modules.d`.

#### **List Available Modules**:
To see a list of available modules that can be included or excluded from the initramfs:
```bash
ls /usr/lib/dracut/modules.d
```

#### **Include Modules**:
```bash
dracut --add "crypt lvm" /boot/initramfs-lvm.img
```
This will include encryption and LVM support in the generated initramfs.

#### **Omit Modules**:
To exclude specific modules from the initramfs:
```bash
dracut --omit "network" /boot/initramfs-no-network.img
```
This example will omit the network modules, which can be useful for creating a smaller initramfs in environments where network drivers are unnecessary.

---

### **Real-World Scenarios**:

#### **Scenario 1: Rebuilding Initramfs After System Updates**:
Sometimes, kernel updates or significant hardware changes (like moving from BIOS to UEFI) require you to rebuild the initramfs. For example:
```bash
dracut --force /boot/initramfs-$(uname -r).img $(uname -r)
```
This will ensure that the latest changes are included in the initramfs for the current kernel.

---

#### **Scenario 2: Host-Only Initramfs for Embedded Systems**:
If you're working with an embedded or minimal system, you may want to generate a host-only initramfs that contains only the modules required to boot that specific hardware:
```bash
dracut --hostonly --force /boot/initramfs-embedded.img $(uname -r)
```
This reduces the size of the initramfs, which is beneficial for environments with limited storage.

---

#### **Scenario 3: Custom Kernel Build and Initramfs**:
When compiling and installing a custom kernel, you need to create an initramfs for it:
```bash
dracut /boot/initramfs-5.10-custom.img 5.10.0-custom
```
This command creates an initramfs specifically for your custom kernel.

---

#### **Scenario 4: Debugging Initramfs Generation**:
If you are troubleshooting an initramfs issue, use verbose mode to get detailed logs:
```bash
dracut --verbose --force /boot/initramfs-debug.img $(uname -r)
```
This provides insight into what `dracut` is doing, which can be helpful for identifying missing drivers or misconfigurations.

---

### **Handling Errors**:

`dracut` may fail for several reasons. Common issues include missing kernel versions or incomplete configurations.

- **Missing Kernel**: If the specified kernel version doesn’t exist, you’ll see an error like:
  ```
  dracut: No such kernel version found
  ```
  Make sure the kernel version is installed or correctly specified.

- **Missing Modules**: If critical modules are not included in the initramfs, the system may fail to boot. You can always force the inclusion of necessary modules:
  ```bash
  dracut --add "kernel-modules" /boot/initramfs-rescue.img
  ```

---

### **Exit Codes**:
Like other command-line tools, `dracut` provides exit codes that help identify whether the operation succeeded or failed:

- **0**: The command executed successfully.
- **1**: There was a failure in generating the initramfs (e.g., missing kernel modules, incorrect parameters).
- **2**: One of the files passed as a parameter (e.g., a non-existent module or kernel version) was not found.
- **4**: System-level error or an unhandled case within `dracut`.

---



### **Bootloader Corruption and Recovery in UEFI Systems**

#### **Understanding Bootloader Corruption**:
A bootloader is a critical part of the boot process, responsible for loading the kernel and passing control to the operating system. When the bootloader (such as GRUB) is corrupted, the system cannot boot properly. In UEFI systems, this can happen due to several reasons, such as:

- Accidental deletion or modification of GRUB files.
- Filesystem corruption.
- Incorrect UEFI boot entries.
- Changes to partitioning that invalidate GRUB configurations.

---

### **Symptoms of Bootloader Corruption**:
1. **GRUB Rescue Mode**: You may be dropped into the **GRUB rescue** shell, indicating that the main GRUB configuration is inaccessible.
2. **Black Screen with UEFI Error**: In some cases, UEFI firmware may show an error message about missing or corrupted boot entries.
3. **GRUB Command Line Prompt**: GRUB cannot find the boot configuration file and will drop you into a command-line environment (`grub>`).
4. **Boot device not found**: The UEFI may show this error if it cannot locate the bootloader.

---

### **Step-by-Step Guide to Recovering from Bootloader Corruption**:

#### **Scenario 1: Bootloader Corruption in a UEFI Environment**

---

#### **Step 1: Boot from a Live USB**:
When the bootloader is corrupted, and you can't access the system, the first step is to boot into a **Live USB** or **Live CD** of the Linux distribution.

1. Insert a Live USB stick and boot from it. This will give you a working environment to fix the corrupted bootloader.
2. Open a terminal from the live environment.

---

#### **Step 2: Mount Your Root and EFI Partitions**:
Once you're in the live environment, you'll need to mount the root and EFI partitions of your system.

1. Identify your root and EFI partitions:
   ```bash
   sudo fdisk -l
   ```
   Look for the partition where Linux is installed (usually something like `/dev/sda2`) and the EFI partition (typically a small FAT32 partition around 100MB to 500MB, usually `/dev/sda1`).

2. Mount the root partition:
   ```bash
   sudo mount /dev/sda2 /mnt
   ```

3. Mount the EFI partition:
   ```bash
   sudo mount /dev/sda1 /mnt/boot/efi
   ```

---

#### **Step 3: Bind the Virtual Filesystems**:
Bind the necessary virtual filesystems to your mount point so that you can perform a `chroot` operation.

```bash
sudo mount --bind /dev /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys
```

---

#### **Step 4: Chroot into the System**:
Now that everything is mounted, you can chroot into your existing system environment. This allows you to operate as if you had booted into the installed system.

```bash
sudo chroot /mnt
```

---

#### **Step 5: Reinstall GRUB**:
Now, reinstall GRUB in the UEFI environment.

1. For UEFI systems:
   ```bash
   grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
   ```

   This command reinstalls GRUB and updates the UEFI firmware’s boot entries to point to the new bootloader.

2. Regenerate the GRUB configuration file:
   ```bash
   grub-mkconfig -o /boot/grub/grub.cfg
   ```

3. Exit the `chroot` environment:
   ```bash
   exit
   ```

4. Unmount the filesystems:
   ```bash
   sudo umount /mnt/boot/efi
   sudo umount /mnt
   ```

5. Reboot the system:
   ```bash
   sudo reboot
   ```

---

### **Scenario 2: Emergency Recovery Using the GRUB Command Line**

If you're dropped into the **GRUB command line** (`grub>`), it indicates GRUB can’t find the `grub.cfg` file to boot the system. You can still manually boot from here.

---

#### **Step 1: Identify the Root and Boot Partitions**:
At the GRUB prompt, you need to identify the partition that contains your root filesystem and the kernel.

1. List the available partitions:
   ```bash
   ls
   ```
   This will output a list of disks and partitions such as `(hd0,msdos1)`, `(hd0,gpt2)`, etc.

2. Check each partition to find the root filesystem:
   ```bash
   ls (hd0,gpt2)/
   ```
   You're looking for a partition that contains folders like `/boot`, `/etc`, and `/lib`.

---

#### **Step 2: Set the Root and Boot Directories**:
Once you've identified the correct partition, set it as the root for GRUB.

```bash
set root=(hd0,gpt2)
```

If the `/boot` directory is on a separate partition, set it up as well:
```bash
set boot=(hd0,gpt1)
```

---

#### **Step 3: Load the Linux Kernel and Initrd**:
Now, manually load the Linux kernel and the initrd (initial ramdisk) image.

```bash
linux /boot/vmlinuz-5.10.0 root=/dev/sda2
initrd /boot/initrd.img-5.10.0
```

Here:
- `/boot/vmlinuz-5.10.0` is the kernel.
- `/dev/sda2` is your root partition.
- `/boot/initrd.img-5.10.0` is the initrd image.

---

#### **Step 4: Boot the System**:
Now boot into the system:

```bash
boot
```

If successful, the system should boot normally, allowing you to log in and fix the GRUB configuration permanently.

---

### **Scenario 3: Repairing UEFI Boot Entries**

In UEFI environments, sometimes the UEFI firmware loses the boot entries pointing to GRUB. You can manually fix these using tools like `efibootmgr`.

---

#### **Step 1: Check UEFI Boot Entries**:
To list the current UEFI boot entries:
```bash
efibootmgr
```

You should see something like:
```
BootCurrent: 0002
BootOrder: 0002,0001,0000
Boot0000* Windows Boot Manager
Boot0001* Linux
Boot0002* GRUB
```

---

#### **Step 2: Add a New UEFI Boot Entry for GRUB**:
If the GRUB entry is missing, you can add it manually.

1. Create a new boot entry pointing to the GRUB EFI binary:
   ```bash
   efibootmgr --create --disk /dev/sda --part 1 --label "GRUB" --loader /EFI/grub/grubx64.efi
   ```

   - `/dev/sda` is the disk containing your EFI partition.
   - `--part 1` indicates that the EFI partition is the first partition.
   - `/EFI/grub/grubx64.efi` is the path to the GRUB EFI binary on the EFI partition.

2. Verify that the new entry is created:
   ```bash
   efibootmgr
   ```

3. Set the new GRUB entry as the first boot option:
   ```bash
   efibootmgr --bootorder 0003,0001,0000
   ```

---

### **Scenario 4: Recovering from GRUB Rescue Mode**

If you are dropped into **GRUB rescue mode**, it means GRUB cannot find its `normal.mod` module, which is essential for booting.

---

#### **Step 1: Locate the `normal.mod` Module**:
First, identify the correct partition by running:
```bash
ls
```

Check each partition to locate where the `/boot/grub/` directory is:
```bash
ls (hd0,gpt2)/boot/grub/
```

You are looking for a partition that contains files like `normal.mod`.

---

#### **Step 2: Load the `normal.mod` Module**:
Once you find it, tell GRUB to load `normal.mod`:
```bash
set prefix=(hd0,gpt2)/boot/grub
insmod normal
normal
```

This should bring you back to the standard GRUB menu, allowing you to boot normally.

---

### **Tips for Preventing Bootloader Corruption**:
- **Backup the GRUB Configuration**: Regularly back up the `/boot/grub/grub.cfg` file and UEFI entries using `efibootmgr`.
- **Use a Bootable Rescue Disk**: Always keep a bootable USB with a live Linux environment to recover from serious boot issues.
- **Careful Partition Changes**: Avoid making partition changes without regenerating GRUB afterward.

---

### **Conclusion**:
Bootloader corruption, especially in UEFI environments, can be tricky to fix but with the right approach (live USB, GRUB command-line recovery, and `efibootmgr`), systems can be recovered without reinstalling the OS. Knowing how to handle the GRUB command line and UEFI boot entries empowers you to troubleshoot and repair boot issues effectively.
