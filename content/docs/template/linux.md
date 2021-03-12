---
title: linux模板
type: docs
---

# /etc/resolv.conf
    nameserver 114.114.114.114

# /etc/X11/xorg.conf.d/70-synaptics.conf
    Section "InputClass"
        Identifier "touchpad"
        Driver "synaptics"
        MatchIsTouchpad "on"
                Option "TapButton1" "1"
                Option "TapButton2" "3"
                Option "TapButton3" "2"
                Option "VertEdgeScroll" "on"
                Option "VertTwoFingerScroll" "on"
                Option "HorizEdgeScroll" "on"
                Option "HorizTwoFingerScroll" "on"
                Option "CircularScrolling" "on"
                Option "CircScrollTrigger" "2"
                Option "EmulateTwoFingerMinZ" "40"
                Option "EmulateTwoFingerMinW" "8"
                Option "FingerLow" "30"
                Option "FingerHigh" "50"
                Option "MaxTapTime" "125"
            Option "VertScrollDelta" "-50"
            Option "HorizScrollDelta" "-50"
    EndSection
# /etc/systemd/system/docker.service.d/http-proxy.conf
    Environment="HTTP_PROXY=http://127.0.0.1:8123"
        "HTTPS_PROXY=http://127.0.0.1:8123"
        "NO_PROXY=192.168.1.1,localhost"
# ~/scripts/work/app/set-brightness
    #!/usr/bin/expect -f 

    spawn sudo vim /sys/class/backlight/intel_backlight/brightness  
    expect "*password*"
    send -- "\r"
    interact


