#!/bin/sh

usage() {
  echo "Usage"
  echo " Work directory, input- and output-SPARQL endpoints are mandatory"
  echo " -wd, --workDirectory		Path where intermediate files will be stored"
  echo " -fsu --fairSharingUrl		Fair Sharing Url"
  echo " -iep, --inputEndpoint		URL of SPARQL input endpoint"
  echo " -iun, --inputUserName		Optional username for input endpoint"
  echo " -ipw, --inputPassword		Optional password for input endpoint"
  echo " -oep, --outputEndpoint		URL of SPARQL or HTTP output endpoint"
  echo " -ouep, --outputUpdateEndpoint  URL of SPARQL update endpoint"
  echo " -oun, --outputUsername		Optional username for output endpoint"
  echo " -opw, --outputPassword		Optional password for output endpoint"
  echo " -ogr, --outputGraphdbRepository=test      specify a GraphDB repository for HTTP repository RDF upload. Default: test"
}

until [ $# -eq 0 ]; do
  case "$1" in
    -wd | --workDirectory ) WD=$(realpath $2); shift 2 ;;
    -fsu  | --fairsharingUrl )		FSU=$2; shift 2 ;;
    -iep  | --inputEndPoint ) 		IEP=$2; shift 2 ;;
    -iun  | --inputUserName ) 		IUN=$2; shift 2 ;;
    -ipw  | --inputPassword ) 		IPW=$2; shift 2 ;;
    -oep  | --outputEndPoint ) 		OEP=$2; shift 2 ;;
    -ouep | --outputUpdateEndpoint ) 	OUEP=$2; shift 2 ;;
    -oun  | --outputUserName ) 		OUN=$2; shift 2 ;;
    -opw  | --outputPassword ) 		OPW=$2; shift 2 ;;
    -gr   | --graphdb-repository )    GRAPHDB_REPOSITORY=$2; shift 2 ;;
    * ) shift ;;
  esac
done

if [[ -z "$FSU" || -z "$IEP" || -z "$OEP" || -z "$WD" ]]; then
  usage
  exit
fi


#echo "wd=${WD}"
#echo "iep=${IEP}"
#echo "iun=${IUN}"
#echo "ipw=${IPW}"
#echo "oep=${OEP}"
#echo "ouep=${OUEP}"
#echo "oun=${OUN}"
#echo "opw=${OPW}"


mkdir -p $

## fairsharing statistics
CMD1="docker run --rm -i -v ${WD}/fairsharing/:/data dqa-fairsharing-metrics \"$FSU\""
echo $CMD1

## rdfunit
CMD2="docker run --rm -i -v ${WD}:/data dqa-rdfunit -d \"$IEP\" -e \"$IEP\" -f /data/ -o ttl"
echo $CMD2

## create descriptive statistics
CMD3="docker run --rm -i -v ${WD}:/data dqa-descriptive-statistics ${IEP} /data/descriptive_stats.nt"
echo $CMD3

start=`date +%s`

eval $CMD1 &
eval $CMD2 &
eval $CMD3 &

echo waiting for containers to finish
wait

end=`date +%s`
runtime=$((end-start))

echo runtime $runtime

## combine rdf files
cp $WD/results/*.ttl $WD/rdfunit.ttl
cp $WD/fairsharing/*.nt $WD/fairsharing.nt

CMD4="docker run --rm -i -v ${WD}:/data dqa-combine-statistics /data/output.nt /data/descriptive_stats.nt /data/rdfunit.ttl /data/fairsharing.nt"
echo $CMD4

eval $CMD4

## upload rdf files
#CMD5="docker run -it --rm -v ${WD}:/data dqa-rdfupload -if \"/data/output.nt\" -ep \"${OEP}\""
#if [ ! -z "$OUEP" ]; then
#  CMD5+=" -uep \"${OUEP}\""
#fi
#if [ ! -z "$OUN" ]; then
#  CMD5+=" -un \"${OUN}\""
#fi
#if [ ! -z "$OPW" ]; then
#  CMD5+=" -pw \"${OPW}\""
#fi

# OEP: http://localhost:7200 for instance
# New RdfUpload
docker run -it --rm -v ${WD}:/data rdf-upload \
  -m "HTTP" \
  -if "/data/output.nt" \
  -url "$OEP" \
  -rep "$GRAPHDB_REPOSITORY" \
  -un ${OUN} -pw ${OPW}
  

echo $CMD5
eval $CMD5
