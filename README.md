# kaggle
Setup of GCP instance with fastai for Kaggle competitions.

## Setup
```bash
## INSTANCE SETUP

# create GCP instance
export IMAGE_FAMILY="pytorch-latest-gpu"
export ZONE="europe-west4-b"
export INSTANCE_NAME="jeremy-coward"
export INSTANCE_TYPE="n1-highmem-8"

gcloud compute instances create $INSTANCE_NAME \
        --zone=$ZONE \
        --image-family=$IMAGE_FAMILY \
        --image-project=deeplearning-platform-release \
        --maintenance-policy=TERMINATE \
        --accelerator="type=nvidia-tesla-p4,count=1" \
        --machine-type=$INSTANCE_TYPE \
        --boot-disk-size=200GB \
        --metadata="install-nvidia-driver=True" \
        --preemptible

# connect to instance
# create an alias for this in ~/.bash_aliases
gcloud compute ssh --zone=$ZONE jupyter@$INSTANCE_NAME -- -L 8080:localhost:8080

# configure git
git config --global user.name <name>
git config --global user.email <e>@<mail>.com

# download repo
git clone https://github.com/Huizerd/kaggle.git

# update fastai repo + library and pytorch
./kaggle/update.sh

# create pre-commit hook for black formatter
sudo conda install -c conda-forge pre_commit
cd ~/kaggle/
pre-commit install

# create filter for nbstripout
# to strip notebook output
sudo conda install -c conda-forge nbstripout
nbstripout --install

# install kaggle
sudo conda install -c conda-forge kaggle

# start jupyter in local browser: localhost:8080/tree

# upload kaggle credentials:
# - download from https://www.kaggle.com/<username>/account
# - upload in jupyter

# move credentials to correct folder
mv ~/kaggle.json .kaggle/

# download cactus competition data
kaggle competitions download -c aerial-cactus-identification -p ~/kaggle/cactuses/data/

# unzip and remove
# add option -d to unzip to dir
cd ~/kaggle/cactuses/data/
unzip train.zip
unzip test.zip
rm *.zip

## RESTART

# connect to instance
gcloud compute ssh --zone=$ZONE jupyter@$INSTANCE_NAME -- -L 8080:localhost:8080

# update
./kaggle/update.sh
```
