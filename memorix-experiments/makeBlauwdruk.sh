# combines the separate entity-definitions into one blauwdruk.ttl-file

cat archief.ttl groep.ttl bestanddeel.ttl afbeelding.ttl akte.ttl > blauwdruk-temp.ttl
rapper -i turtle -o turtle blauwdruk-temp.ttl > blauwdruk.ttl
rm blauwdruk-temp.ttl