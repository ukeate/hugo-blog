# 默认声卡
	pactl list short sources
	pactl list short sinks
	pactl set-default-source alsa_input.pci-0000_00_1b.0.analog-stereo
	pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
# 亮度
	#!/usr/bin/expect -f 

	spawn sudo vim /sys/class/backlight/intel_backlight/brightness  
	expect "*password*"
	send -- "asdf\r"
	interact
# 电量
	cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0A:00/power_supply/BAT0/capacity
