[![License](https://img.shields.io/badge/FAIR-metrics-orange.svg)](http://fairmetrics.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![DOI](https://zenodo.org/badge/128502130.svg)](https://zenodo.org/badge/latestdoi/128502130)
# LODQuA: Large-scale RDF-based Data Quality Assessment Pipeline

LODQuA is a large-scale automated quality assessment pipeline specifically for Linked Open Data.
This repository links three containers, each of which measures different quality metrics as follows:
- https://github.com/MaastrichtU-IDS/dqa_descriptive_statistics: The descriptive statistics are metrics from eight queries defined by the Health Care and the Life Sciences ([HCLS](https://www.w3.org/TR/hcls-dataset/\#s6_6}(https://www.w3.org/TR/hcls-dataset/\#s6_6)) group on the description of datasets using the Resource Description Framework. That is, the number of triples, entities, subjects, properties, objects and graphs of the dataset are reported. 
- https://github.com/MaastrichtU-IDS/fairsharing-metrics: The [FAIRSharing](https://fairsharing.org/)(https://fairsharing.org/) metrics extract information from the FAIRSharing resource, which covers standards (terminologies, formats, models and reporting guidelines), databases, and data policies in the life sciences, broadly encompassing the biological, environmental and biomedical sciences. The license information, terminologies used and scope and datatypes of the specified resource are extracted.
- https://github.com/MaastrichtU-IDS/RDFUnit: RDFUnit is a tool, which measures several computational metrics to analyze syntactic validity and consistency metrics on the datasets.

The https://github.com/MaastrichtU-IDS/dqa_combine_statistics module then combines the outputs of all the three containers, adds a timestamp and the https://github.com/MaastrichtU-IDS/RdfUpload container uploads the output file to the specified SPARQL endpoint. 

# Installation and Usage

## Check out
```
git clone --recursive https://github.com/MaastrichtU-IDS/dqa_pipeline.git
```

## Build
```
chmod +x *.sh && ./build.sh
```

## Command
- wd (workDirectory): Path where intermediate files will be stored
- fsu (FAIRSharingURL):	a FAIRSharing URL
- iep (input SPARQL endpoint): SPARQL URL of input endpoint
- iun (input user name)	[Optional]: username for SPARQL input endpoint
- ipw (input password)	[Optional]: password for SPARQL input endpoint
- oep (output endpoint):	URL of output SPARQL endpoint 
- ouep (output update endpoint): URL of update SPARQL endpoint
- oun (output user name):	[Optional] username for output SPARQL endpoint
- opw (output password):	[Optional] password for output SPARQL endpoint

## Run

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
## Example
```
./dqa_pipeline.sh \
-wd /data/dqa_pipeline/wikipathways/2018-03-29-1330/ \
-fsu https://fairsharing.org/FAIRsharing.1x53qk \
-iep http://sparql.wikipathways.org/ \
-oep http://graphdb.dumontierlab.com/repositories/test2 \
-ouep http://graphdb.dumontierlab.com/repositories/test2/statements \
-oun import_user \
-opw test
```
