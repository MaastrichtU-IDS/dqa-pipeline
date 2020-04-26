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

# Installation usage

## Using CWL workflows

The DQA pipeline can be run using the [Common Workflow Language](https://www.commonwl.org/). See the [d2s-cwl-workflows repository](https://github.com/MaastrichtU-IDS/d2s-cwl-workflows).

See the workflow file [workflow-dqa.cwl](https://github.com/MaastrichtU-IDS/d2s-cwl-workflows/blob/master/workflows/workflow-dqa.cwl) and the config file [config-cwl-dqa.yml](https://github.com/MaastrichtU-IDS/d2s-cwl-workflows/blob/master/support/config-cwl-dqa.yml).

> See the [documentation to install CWL runner](http://d2s.semanticscience.org/docs/cwl-install#install-cwl-runner).

```bash
# Create workspace
mkdir -p /data/dqa-workspace/output/tmp-outdir
sudo chown -R ${USER}:${USER} /data/dqa-workspace

# Clone the CWL workflows repository
git clone https://github.com/MaastrichtU-IDS/d2s-cwl-workflows
cd d2s-cwl-workflows

# Run the CWL workflow, providing the config YAML file
cwl-runner --custom-net d2s-core_network \
  --outdir /data/dqa-workspace/output \
  --tmp-outdir-prefix=/data/dqa-workspace/output/tmp-outdir/ \
  --tmpdir-prefix=/data/dqa-workspace/output/tmp-outdir/tmp- \
  workflows/workflow-dqa.cwl \
  support/config-cwl-dqa.yml
```

> Workflow files goes to `/data/dqa-workspace`.

## Using Argo workflows

The DQA pipeline can be run using [Argo workflow](https://argoproj.github.io/argo). See the [d2s-argo-workflows repository](https://github.com/MaastrichtU-IDS/d2s-argo-workflows).

> See documentation to [run Argo workflows on the DSRI](https://maastrichtu-ids.github.io/dsri-documentation/docs/workflows-argo) or on [a single machine](https://maastrichtu-ids.github.io/dsri-documentation/docs/guide-local-install).

```bash
# Clone the Argo workflows repository
git clone https://github.com/MaastrichtU-IDS/d2s-argo-workflows
cd d2s-argo-workflows

# Run the Argo workflow, using a config file
argo submit workflows/dqa-workflow-argo.yaml -f support/config-dqa-pipeline.yml
```

You might need to specify the service account

```bash
argo submit --serviceaccount argo workflows/dqa-workflow-argo.yaml -f support/config-dqa-pipeline.yml
```

---

# Deprecated installation and Usage

## Download
```shell
git clone --recursive https://github.com/MaastrichtU-IDS/dqa-pipeline.git
```

## Build
```shell
chmod +x *.sh && ./build.sh
```

## Command
- wd (workDirectory): Path where intermediate files will be stored
	 fsu (FAIRSharingURL):	a FAIRSharing URL
- iep (input SPARQL endpoint): SPARQL URL of input endpoint
	 iun (input user name)	[Optional]: username for SPARQL input endpoint
	 ipw (input password)	[Optional]: password for SPARQL input endpoint
	 oep (output endpoint):	URL of output SPARQL endpoint 
- ouep (output update endpoint): URL of update SPARQL endpoint
	 oun (output user name):	[Optional] username for output SPARQL endpoint
	 opw (output password):	[Optional] password for output SPARQL endpoint

## Run

We take an input endpoint, the corresponding fairsharing URL (for the input dataset), the output endpoint where the triples will be loaded (GraphDB at the moment)

```shell
./run.sh \
-wd <work-directory> \
-fsu <fairsharing url> \
-iep <input-endpoint> \
-sch <your schema> \
-oep <your sparql endpoint> \
-ouep <optional sparql update endpoint> \
-ogr <output graphdb repository> \
-oun <optional sparql endpoint username> \
-opw <optional sparql endpoint password>
```
## Example
```shell
# For WikiPathways (using HTTP repository for RdfUpload) 
./run.sh \
-wd /data/dqa-pipeline/wikipathways/ \
-fsu https://fairsharing.org/FAIRsharing.1x53qk \
-iep http://sparql.wikipathways.org/ \
-sch https://www.w3.org/2012/pyRdfa/extract?uri=http://vocabularies.wikipathways.org/wp# \
-oep http://graphdb.dumontierlab.com \
-ogr test2 \
-oun import_user \
-opw password


# Legacy RdfUpload (using SPARQL repository). Not working anymore
./run.sh \
-wd /data/dqa-pipeline/wikipathways/2018-03-29-1330/ \
-fsu https://fairsharing.org/FAIRsharing.1x53qk \
-iep http://sparql.wikipathways.org/ \
-oep http://graphdb.dumontierlab.com/repositories/test2 \
-ouep http://graphdb.dumontierlab.com/repositories/test2/statements \
-oun import_user \
-opw password
```

# TODO

To implement in Java using jsoup
