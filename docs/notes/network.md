## List network devices

List network devices in Arch with:

    ip link

or:

    ls /sys/class/net


## Enable / disable network device

    # using ip
    ip link set eth0 up
    ip link set eth0 down
