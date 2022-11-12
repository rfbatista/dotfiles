#!/bin/bash
text_scale=$(gsettings get org.gnome.desktop.interface text-scaling-factor)
/usr/bin/google-chrome-stable --high-dpi-support=1 --force-device-scale-factor=1.5 %U
