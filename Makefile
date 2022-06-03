conda-create:
	conda env create --file ./environ/conda-environment.yml

conda-activate:
	source activate nyc-taxi

env-create:
	az ml environment create --file ./environments/base-train/base_train.yml

dataset-upload:
	az ml data create --file raw_data.yml

train:
	az ml job create --file ./safe-driver/src/train/job.yml

pipeline:
	az ml job create --file ./pipeline.yml --stream

rundetails:
	az ml job show --name plucky_ship_rgxq2g21xj

debug-pipeline:
	python safe-driver/src/pipeline/pipeline.py --skip-registration --debug

publish-pipeline:
	python safe-driver/src/pipeline/pipeline.py --publish-pipeline
