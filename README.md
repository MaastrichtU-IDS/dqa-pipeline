[![License](https://img.shields.io/badge/FAIR-metrics-orange.svg)](http://fairmetrics.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![DOI](https://zenodo.org/badge/128502130.svg)](https://zenodo.org/badge/latestdoi/128502130)
# LODQuA: Large-scale RDF-based Data Quality Assessment Pipeline

LODQuA is a large-scale quality assessment pipeline specifically for Linked Open Data.
This repository links of three containers, each of which measures different quality metrics as follows:
- https://github.com/MaastrichtU-IDS/dqa_descriptive_statistics: The descriptive statistics are metrics from eight queries defined by the Health Care and the Life Sciences ([HCLS](https://www.w3.org/TR/hcls-dataset/\#s6_6}(https://www.w3.org/TR/hcls-dataset/\#s6_6}) group on the description of datasets using the Resource Description Framework. That is, the number of triples, entities, subjects, properties, objects and graphs of the dataset are reported. 
- https://github.com/MaastrichtU-IDS/fairsharing-metrics: The FAIRSharing metrics extract information from the FAIRSharing resource, which covers standards (terminologies, formats, models and reporting guidelines), databases, and data policies in the life sciences, broadly encompassing the biological, environmental and biomedical sciences. The license information, terminologies used and scope and datatypes of the specified resource is extracted.
- https://github.com/MaastrichtU-IDS/RDFUnit: RDFUnit is a tool, which measures several computational metrics to analyze syntactic validity and consistency metrics on the datasets.

The https://github.com/MaastrichtU-IDS/dqa_combine_statistics module then combines the outputs of all the three containers, adds a timestamp and the https://github.com/MaastrichtU-IDS/RdfUpload container uploads the output file to the specified SPARQL endpoint. 

# Installation and Usage

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
./dqa_pipeline.sh \
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
