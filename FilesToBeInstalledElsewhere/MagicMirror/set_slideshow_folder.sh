#!/bin/bash
path_to_images_prefix="\['modules\/MMM-BackgroundSlideshow\/"
path_to_images_postfix="\/'\]\,"
replacement=$1
replacement=${replacement//\\/\\\\}
replacement=${replacement//\//\\/}
replacement=${replacement//&/\\&}
path_to_insert=${replacement//$'\n'/\\$'\n'}
fullpath=$path_to_images_prefix$path_to_insert$path_to_images_postfix
sed -i "s/\(^[[:space:]]*imagePaths:\).*/\1 $fullpath/" ~/MagicMirror/config/config.js
pm2 restart ~/MagicMirror/mm.sh
