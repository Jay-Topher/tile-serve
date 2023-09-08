# Tile Serve
This script downloads tiles from a provided source, converts them to a format that can be served by a web server (MBTiles) and serves the tiles to the client.

## Steps to Create Tiles
1. Clone this repository
1. Update the `osm_url` variable in `serve.sh` to point to the source you want to download from
1. Run `chmod +x ./create.sh`
1. Run `./create.sh`

## Steps to Serve Tiles
1. After tiles have been created, run `chmod +x ./serve.sh`
1. Run `./serve.sh`
1. The resulting tiles would be hosted on `http://localhost:8080/` 