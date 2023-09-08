#!/bin/bash

# Step 1: Define the URL of the OSM PBF file you want to download
osm_url="https://download.geofabrik.de/south-america/argentina-latest.osm.pbf"

# Step 2: Specify the destination directory where you want to save the downloaded file
destination_dir="~/Downloads"

# Step 3: Check if the file already exists in the destination directory
if [ -e "$destination_dir/argentina-latest.osm.pbf" ]; then
  echo "File already exists. Skipping download."
else
  # If the file doesn't exist, use wget to download the OSM PBF file
  wget -P "$destination_dir" "$osm_url"

  # Check if the download was successful
  if [ $? -eq 0 ]; then
    echo "Download successful. The OSM PBF file has been saved to $destination_dir."
  else
    echo "Download failed. Please check the URL and try again."
    exit 1
  fi
fi

# Step 4: Check the operating system and install dependencies accordingly
if [ "$(uname)" == "Linux" ]; then
  # Check if it's Ubuntu (you can adjust this for other Linux distributions if needed)
  if [ -f "/etc/lsb-release" ]; then
    # Install dependencies on Ubuntu
    sudo apt install -y build-essential libboost-dev libboost-filesystem-dev libboost-iostreams-dev libboost-program-options-dev libboost-system-dev liblua5.1-0-dev libprotobuf-dev libshp-dev libsqlite3-dev protobuf-compiler rapidjson-dev
  else
    echo "Unsupported Linux distribution. Please install dependencies manually."
    exit 1
  fi
elif [ "$(uname)" == "Darwin" ]; then
  # Install dependencies on macOS using Homebrew
  brew install protobuf boost lua51 shapelib rapidjson
else
  echo "Unsupported operating system. Please install dependencies manually."
  exit 1
fi


# steps 5 Install tilemaker
sudo apt install tilemaker

# Step 6: Check if the installation was successful
if [ $? -eq 0 ]; then
  echo "Tilemaker has been successfully installed."
else
  echo "Tilemaker installation failed. Please check the build process and try again."
  exit 1
fi

# Step 7: Use Tilemaker to convert the OSM PBF file to MBTiles with input and output in the same directory
input_file="$destination_dir/argentina-latest.osm.pbf"
output_file="$destination_dir/output.mbtiles"
tilemaker --input "$input_file" --output "$output_file"

# Step 8: Check if the conversion was successful
if [ $? -eq 0 ]; then
  echo "Conversion to MBTiles successful. The MBTiles file has been saved to $output_file."
else
  echo "Conversion to MBTiles failed. Please check the input file path and try again."
  exit 1
fi

# Step 9: Install Tessera and @mapbox/mbtiles globally using npm
npm install -g tessera
npm install -g @mapbox/mbtiles

# Step 10: Check if the npm package installation was successful
if [ $? -eq 0 ]; then
  echo "Tessera and @mapbox/mbtiles have been successfully installed."
else
  echo "npm package installation failed. Please check the installation process and try again."
  exit 1
fi

# Step 11: Serve the tiles using Tessera
tessera mbtiles://"$output_file"

# Step 12: Check if the tile serving was successful
if [ $? -eq 0 ]; then
  echo "Tiles served successfully with Tessera."
else
  echo "Tile serving with Tessera failed. Please check the MBTiles file path and try again."
  exit 1
fi
