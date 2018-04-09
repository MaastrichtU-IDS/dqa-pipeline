[![License](https://img.shields.io/badge/FAIR-metrics-orange.svg)](http://fairmetrics.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
# dqa_pipeline

## check out
TODO: this does not work yet
```
git clone --recursive <this repo url>
```

## build
```
chmod +x *.sh && ./build.sh
```

## run

```
sudo ./dqa_pipeline.sh \
-wd <work-directory> \
-fsu <fairsharing url> \
-iep <input-endpoint> \
-oep <your sparql endpoint> \
-ouep <optional sparql update endpoint> \
-oun <optional sparql endpoint username> \
-opw <optional sparql endpoint password>
```
