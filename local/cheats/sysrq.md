README.md: Magic SysRq Key Explained
------------------------------------

* * *

### **Table of Contents**

1.  [Introduction to Magic SysRq](#introduction-to-magic-sysrq)
2.  [Available Magic SysRq Commands](#available-magic-sysrq-commands)
3.  [Step\-by\-Step Guide to Using Magic SysRq](#step-by-step-guide-to-using-magic-sysrq)
    *   [1. Checking Kernel Configuration](#1-checking-kernel-configuration)
    *   [2. Enabling SysRq](#2-enabling-sysrq)
    *   [3. Executing SysRq Commands](#3-executing-sysrq-commands)
4.  [Examples of Magic SysRq Usage](#examples-of-magic-sysrq-usage)
    *   [Safe System Shutdown](#safe-system-shutdown)
    *   [Immediate Power Off](#immediate-power-off)
    *   [System Diagnostics](#system-diagnostics)
5.  [Common Use Cases](#common-use-cases)
6.  [Potential Risks and Considerations](#potential-risks-and-considerations)
7.  [Conclusion](#conclusion)

* * *

### **Introduction to Magic SysRq**

The Magic SysRq key is a powerful feature in the Linux kernel that allows you to perform low-level system commands regardless of the system's state. It can be a lifesaver when the system becomes unresponsive, providing tools to debug, restart, or safely shut down the system.

SysRq commands are triggered via a special keyboard sequence or by writing to `/proc/sysrq-trigger`.

* * *

### **Available Magic SysRq Commands**

The following commands can be triggered using the Magic SysRq key:

**Key**

**Action**

`R`

Switch keyboard from raw mode to XLATE mode

`E`

Send `SIGTERM` to all processes except `init`

`I`

Send `SIGKILL` to all processes except `init`

`S`

Sync all mounted filesystems

`U`

Remount all filesystems as read-only

`B`

Reboot immediately

`O`

Power off the system immediately

`F`

Trigger an Out-Of-Memory (OOM) kill

`H`

Display help message in kernel logs

`P`

Show registers and CPU state in kernel logs

`T`

Show task (process) information

`M`

Show memory usage information

`C`

Trigger a kernel crash (for debugging)

`K`

Kill all processes on the current VT

* * *

### **Step-by-Step Guide to Using Magic SysRq**

#### **1\. Checking Kernel Configuration**

Ensure the kernel supports SysRq:

```bash
cat /proc/sys/kernel/sysrq
```

*   `1`: Fully enabled.
*   `0`: Disabled.
*   Other values enable specific functionalities (e.g., `128` for reboot).

#### **2\. Enabling SysRq**

Enable SysRq dynamically:

```bash
echo 1 | sudo tee /proc/sys/kernel/sysrq
```

To make this setting persistent across reboots:

```bash
echo "kernel.sysrq = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

#### **3\. Executing SysRq Commands**

To invoke a SysRq command:

```bash
echo <KEY> | sudo tee /proc/sysrq-trigger
```

Replace `<KEY>` with the desired command key (e.g., `b` for reboot).

* * *

### **Examples of Magic SysRq Usage**

#### **1\. Safe System Shutdown**

```bash
echo s | sudo tee /proc/sysrq-trigger  # Sync filesystems
echo u | sudo tee /proc/sysrq-trigger  # Remount filesystems as read-only
echo o | sudo tee /proc/sysrq-trigger  # Power off the system
```

*   **Use Case**: Safe shutdown when the system is unresponsive.

#### **2\. Immediate Power Off**

```bash
echo o | sudo tee /proc/sysrq-trigger
```

*   **Use Case**: Force the system to power off instantly.

#### **3\. System Diagnostics**

```bash
echo t | sudo tee /proc/sysrq-trigger  # Show all tasks
echo m | sudo tee /proc/sysrq-trigger  # Show memory usage
echo p | sudo tee /proc/sysrq-trigger  # Show CPU registers
```

*   **Use Case**: Gather debugging information.

* * *

### **Common Use Cases**

*   **Unresponsive Systems**: Safely reboot or power down without corrupting filesystems.
*   **Debugging**: Capture critical system logs for analysis.
*   **Emergency Recovery**: Kill unresponsive processes or remount filesystems.

* * *

### **Potential Risks and Considerations**

*   **Data Loss**: Commands like `b` (reboot) and `o` (power off) can cause data loss if filesystems aren't synced.
*   **Kernel Access**: Misuse can destabilize the system; restrict access to trusted users only.
*   **Configuration Persistence**: Improper settings in `/etc/sysctl.conf` can inadvertently enable or disable critical functionality.

* * *

### **Conclusion**

The Magic SysRq key is an invaluable tool for system recovery and diagnostics. Understanding its commands and proper usage ensures you can leverage its full potential while minimizing risks.

For quick access, you can use the following alias in your `.bashrc`:

```bash
alias magic="echo o > /proc/sysrq-trigger"  # Immediate power off
```
