#!/bin/bash

# Specify the output file/directory
user_home_dir=~
destination_dir="${user_home_dir}/Downloads"
output_file="$destination_dir/output.mbtiles"

# Step 1: Install Tessera and @mapbox/mbtiles globally using npm
npm install -g tessera
npm install -g @mapbox/mbtiles

# Step 2: Check if the npm package installation was successful
if [ $? -eq 0 ]; then
  echo "Tessera and @mapbox/mbtiles have been successfully installed."
else
  echo "npm package installation failed. Please check the installation process and try again."
  exit 1
fi

# Step 3: Serve the tiles using Tessera
tessera mbtiles://"$output_file"

# Step 4: Check if the tile serving was successful
if [ $? -eq 0 ]; then
  echo "Tiles served successfully with Tessera."
else
  echo "Tile serving with Tessera failed. Please check the MBTiles file path and try again."
  exit 1
fi
