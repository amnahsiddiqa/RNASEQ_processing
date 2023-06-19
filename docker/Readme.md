cd ./docker/rnaseq
docker build -t rnaseq .
docker image tag rnaseq amnahsid/rnaseq:latest
docker image push amnahsid/rnaseq:latest
singularity pull docker://amnahsid/rnaseq
