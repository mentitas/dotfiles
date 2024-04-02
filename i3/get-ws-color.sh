#! /bin/bash

# Catppuccin
# case $1 in
#     1) echo "#cba6f7" ;;
#     2) echo "#f5c2e7" ;;
#     3) echo "#f38ba8" ;;
#     4) echo "#fab387" ;;
#     5) echo "#f9e2af" ;;
#     6) echo "#a6e3a1" ;;
#     7) echo "#94e2d5" ;;
#     8) echo "#89dceb" ;;
#     9) echo "#74c7ec" ;;
#     *) echo "#89b4fa" ;;
# esac


current_theme=$(tail -n 1 /tmp/theme)

if [ "$current_theme" = "dark" ]
then
    # New catppuccin 
    # https://colorkit.co/color-palette-generator/b688ea-e8a3d4-eb6c8f-f19d69-edd090-89db80-53c9b4-6bd2e3-56bae6-6c9eef/
    case $1 in
         1) echo "#b688ea" ;;
         2) echo "#e8a3d4" ;;
         3) echo "#eb6c8f" ;;
         4) echo "#f19d69" ;;
         5) echo "#edd090" ;;
         6) echo "#89db80" ;;
         7) echo "#53c9b4" ;;
         8) echo "#6bd2e3" ;;
         9) echo "#56bae6" ;;
         *) echo "#6c9eef" ;;
    esac
else
    # Mocha bright
    # https://colorkit.co/color-palette-generator/b96ae3-fd7fc0-fd556e-fd9449-fdcc65-70f04a-34eec0-59d7e3-4ab9e3-6390e3/
    case $1 in
         1) echo "#b96ae3" ;;
         2) echo "#fd7fc0" ;;
         3) echo "#fd556e" ;;
         4) echo "#fd9449" ;;
         5) echo "#fdcc65" ;;
         6) echo "#70f04a" ;;
         7) echo "#34eec0" ;;
         8) echo "#59d7e3" ;;
         9) echo "#4ab9e3" ;;
         *) echo "#6390e3" ;;
    esac
fi