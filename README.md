[![License](https://img.shields.io/badge/FAIR-metrics-orange.svg)](http://fairmetrics.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![DOI](https://zenodo.org/badge/128502130.svg)](https://zenodo.org/badge/latestdoi/128502130)
# dqa_pipeline

## check out
```
git clone --recursive https://github.com/MaastrichtU-IDS/dqa_pipeline.git
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
## example
- FAIRsharing URL: https://fairsharing.org/FAIRsharing.1x53qk
- Input endpoint: http://sparql.wikipathways.org/
