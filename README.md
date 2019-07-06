# cactuses
Setup of GCP instance with fastai and simple cactus classification from Kaggle.

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

# update fastai repo
cd ~/tutorials/fastai/course-v3/
git checkout .
git pull
cd ~

# update/install libraries
sudo /opt/anaconda3/bin/conda install -c fastai fastai
sudo /opt/anaconda3/bin/conda install -c conda-forge kaggle

# start jupyter in local browser: localhost:8080/tree

# upload kaggle credentials:
# - download from https://www.kaggle.com/<username>/account
# - upload in jupyter

# move credentials to correct folder
mv ~/kaggle.json .kaggle/

# download competition data
mkdir -p data/aerial-cactus-identification/
cd data/aerial-cactus-identification/
kaggle competitions download -c aerial-cactus-identification

# unzip and remove
unzip train.zip
unzip test.zip
rm train.zip
rm test.zip

# download cactuses repo
cd ~
git clone https://github.com/Huizerd/cactuses.git



## RESTART

# connect to instance
gcloud compute ssh --zone=$ZONE jupyter@$INSTANCE_NAME -- -L 8080:localhost:8080

# update fastai repo
cd ~/tutorials/fastai/course-v3/
git checkout .
git pull
cd ~

# update/install libraries
sudo /opt/anaconda3/bin/conda install -c fastai fastai
sudo /opt/anaconda3/bin/conda install -c pytorch pytorch torchvision
```
