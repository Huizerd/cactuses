#!/usr/bin/env bash

cd ~/tutorials/fastai/course-v3/
git checkout .
git pull
cd ~

sudo /opt/anaconda3/bin/conda install -c fastai fastai
sudo /opt/anaconda3/bin/conda install -c pytorch pytorch

