# Build all skills into uploadable zips

set -e
cd "$(dirname "$0")/../skills"
mkdir -p ../dist
for d in */; do
  name="${d%/}"
  (cd "$d" && zip -qr "../../dist/${name}.zip" .)
  echo "built dist/${name}.zip"
done
