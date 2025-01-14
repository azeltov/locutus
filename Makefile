conda-create:
	conda env create --file ./environ/conda-environment.yml

conda-activate:
	source activate nyc-taxi

env-create:
	az ml environment create --file ./environments/base-train/base_train.yml
    az ml environment create -f ./environments/ptca-train/ptca_train.yml
	az ml environment create --name hf-transformers-inference --version 1 --conda-file conda_inference.yml --image mcr.microsoft.com/azureml/openmpi4.1.0-cuda11.0.3-cudnn8-ubuntu18.04

dataset-upload:
	az ml data create -f cloud/data.yml

train:
	az ml job create --file ./safe-driver/src/train/job.yml

components:
    az ml component create -f components/finetune-ptca.yml
    az ml component create -f components/huggingface.yml
    az ml component create -f components/register_model.yml
    az ml component create -f components/process.yml    

pipeline:
	az ml job create --file ./pipeline.yml --stream

rundetails:
	az ml job show --name plucky_ship_rgxq2g21xj

debug-pipeline:
	python safe-driver/src/pipeline/pipeline.py --skip-registration --debug

publish-pipeline:
	python safe-driver/src/pipeline/pipeline.py --publish-pipeline

deploy-me:
	az ml online-endpoint create --name buildaidemoaz --auth-mode key
