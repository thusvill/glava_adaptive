#!/bin/bash

# Read the colors from the file
background_color=$(awk 'NR==7{print $1}' $HOME/.cache/wal/colors)
background_color_2=$(awk 'NR==6{print $1}' $HOME/.cache/wal/colors)
outline=$(awk 'NR==5{print $1}' $HOME/.cache/wal/colors)

# Escape the colors for use in sed
background_color_escaped=$(echo $background_color | sed 's/[\/&]/\\&/g')
background_color_2_escaped=$(echo $background_color_2 | sed 's/[\/&]/\\&/g')
outline_escaped=$(echo $outline | sed 's/[\/&]/\\&/g')

# Replace {color} in C code with background color
sudo -S sed -i "s/#define COLOR .*$/#define COLOR (${background_color_escaped} * ((d \/ 90) + 0.5))/" /etc/xdg/glava/radial.glsl
sudo -S sed -i "s/#define COLOR .*$/#define COLOR (${background_color_escaped} * ((d \/ 90) + 0.5))/" /etc/xdg/glava/bars.glsl
sudo -S sed -i "s/#define COLOR .*$/#define COLOR mix(${background_color_escaped}, ${background_color_2_escaped}, clamp(pos \/ GRADIENT_SCALE, 0, 1))/" /etc/xdg/glava/graph.glsl

# Replace {outline} in the C code
sudo -S sed -i "s/#define OUTLINE .*$/#define OUTLINE ${outline_escaped}/" /etc/xdg/glava/circle.glsl

exit 0
