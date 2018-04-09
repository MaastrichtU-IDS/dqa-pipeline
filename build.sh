#!/bin/bash

docker build -t dqa-fairsharing-metrics ./fairsharing-metrics
docker build -t dqa-rdfunit ./RDFUnit
docker build -t dqa-descriptive-statistics ./dqa_descriptive_statistics
docker build -t dqa-combine-statistics ./dqa_combine_statistics
docker build -t dqa-rdfupload ./RdfUpload
