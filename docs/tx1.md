## JetPack 3.1 does not come with CP210x kernel moduel installed

The problem I personally had was I needed a USB to UART driver `CP210x` which
is normally built with a default Linux kernel, however Nvidia's Jetpack
installs one without. Through reading the Nvidia TX1 forums it was suggested
that instead of compiling kernel modules on the TX1 itself, one has to setup a
cross compile on the HOST computer (not TX1) and then build needed kernel
modules then flash the built kernel image over to the TARGET (TX1).

The limitation of not being able to compile kernel moduels on the TARGET (TX1)
is not clear to me, any attempt in compiling kernel modules on the TX1 may
result in `"gcc: error: unrecognized comand line option '-mgeneral-regs-only'"
when running 'make install'`, this is because you probably installed a 32 bit
TX1 when in fact the kernel is 64 bit, this is by design and you cannot change
the kernel to 32bit, nor can you simply install an 64 bit ARM GCC. The exact
reasoning is not clear, the only consensus is that only cross compilation to
install additional kernel modules is possible.

Sources:
- [Jetson TX1 Kernel Compilation](https://devtalk.nvidia.com/default/topic/929186/jetson-tx1-kernel-compilation/)
- [building TX1 kernel from source](https://devtalk.nvidia.com/default/topic/901677/building-tx1-kernel-from-source/)
- [Compiling Kernel Modules for Jetson TX1](https://devtalk.nvidia.com/default/topic/912219/compiling-kernel-modules-for-jetson-tx1/)
- [Problems communicating via USB to Serial (CP210x)](https://devtalk.nvidia.com/default/topic/962782/jetson-tx1/problems-communicating-via-usb-to-serial-cp210x-/)
- [How to compile tegra X1 source code](https://devtalk.nvidia.com/default/topic/930642/how-to-compile-tegra-x1-source-code/)

This process as you can imagine is not trivial, I have personally made a script
to try and make it as easy as possible. Before you begin using my script, I
**strongly advise** you perform the following instructions in a VM, I have
provided notes to fix a few VirtualBox issues inorder for cross compile to
work.

### Assumptions
- JetPack 2.2.1 (Latest as of 8th September 2016)
- You are going to use a VM to install Jetpack etc

### Instructions

1. Install VirtualBox on your HOST
2. Create a VM and install Ubuntu 16.04 (64 bit)
3. Follow the `virtualbox_settings.md` and fix various default issues
4. On the VM, download the latest Jetpack
5. Go through the Jetpack process of installing both HOST and TARGET software
   (to make sure VM can communicate with TX1)

**Note**: Make sure you have fixed the VirtualBox USB access issue (see
virtualbox_settings.md), if you have done so you should be able to access the
USB device in the VM.

For the `CP210x` driver you can enable it via the kernel configuration (`make
menuconfig`). `Device Drivers` > `USB Support` > `USB Serial Converter Support`
> `USB CP210x family of UART Bridge Controllers`. (For more information see
this [doc](https://www.silabs.com/Support%20Documents/TechnicalDocs/an809.pdf))


### VirtualBox Settings
The following fixes* VirtualBox problems:

- Slow network speed
- Access to USB devices
- Higher screen resolution


#### Slow network speed

Select the virtual machine in my case my VM is called `ubuntu-x86_64-1404`,
then right click to select **Settings > Network > Advanced > Adaptor Type
> PCnet-FAST III (Am79C973)**.

![Network Configuration](http://i.imgur.com/cGihesY.png)


#### Access to USB devices
The following instructions assume you are running Ubuntu 14.04, if you are
using a different platform the instructions may not work for you.

1. Know which version of VirtualBox you are running. You can obtain that
   information by typing the following command in the terminal.

		$ VBoxManage --version
		4.3.36 Ubuntur105129

Alternatively you can simply launch virtual box and go to `Help` > `About
VirtualBox`, the version is listed at the bottom of the dialog popup.

2. Download the Oracle VirtualBox Extension Pack by visiting the download page
	 [here](http://download.virtualbox.org/virtualbox/), use the version
	 information from the previous step to navigate down to the expansion pack,
   note that the revision version is also important (`r105129` for example)

3. Once you have downloaded the extension pack install it and then enable USB
   access by selecting the VM **Settings > USB** and checkbox "Enable USB
   Controller" and "Enable 2.0 (EHCI) Controller"

![USB Configuration](http://i.imgur.com/GUfr43L.png)

4. Start the VM, now to access USB devices perform the following: select
   **Devices > USB Devices > "Device of your choice"** in the VM GUI.

![USB Selection](http://i.imgur.com/8o8rZAE.jpg)


#### Higher screen resolution

1. Run `sudo apt-get install virtualbox-guest-additions-iso` in the terminal on
   the HOST (not VM)
2. Start the VM and on the VM GUI select `Devices` > `Insert Guest Additions CD
   image`.

![Insert Guest Additions CD image](http://i.imgur.com/IWmtgk6.png)

3. Execute install script for Guest Additions on the VM via

  cd /media/<cd name>
  sudo sh ./VBoxLinuxAdditions.run
  # or alternatively run
  ./autorun.sh

Or you can navigate to the CD via a File Browser such as Nautilus or Thunar
and double click on `autorun.sh`.

4. Turn off VM and increase video memory by selecting the VM then right click
to **Settings > Display**, under Video Memory set the slider to `128MB`.

  ![Display Setting](http://i.imgur.com/BeBqyMj.png)

5. Next time you turn on the VM the screen resolution should vary as you vary
the VM GUI window size.
