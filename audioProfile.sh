#!/bin/sh

# Pc-Jack
pacmd set-card-profile alsa_card.pci-0000_09_00.1 off
# Pc-Jack-2
pacmd set-card-profile alsa_card.pci-0000_09_00.6 off
# WebCam
pacmd set-card-profile alsa_card.usb-Sonix_Technology_Co.__Ltd._Rapoo_Camera_SN0001-02 off
# Usb-Headset
pacmd set-card-profile alsa_card.usb-GeneralPlus_USB_Audio_Device-00 output:analog-stereo+input:mono-fallback
