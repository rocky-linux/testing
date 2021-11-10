#!/bin/bash
set -eu

docker kill openqa_db || true
docker kill openqa_webui || true
docker kill openqa_worker_1 || true
docker rm openqa_db || true
docker rm openqa_webui || true
docker rm openqa_worker_1 || true

