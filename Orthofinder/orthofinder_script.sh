mamba create -n ortho -c bioconda orthofinder

#The prmiary_transcript folder contains the proteomes dwonloaded from the ENSEMBL
#The final longest isoform models were incoroporated (for both black swan and mute swan)
#python2 ~/miniconda3/envs/ortho/bin/primary_transcript.py

orthofinder -t 20 -p ${TMPDIR}/ -o results -f primary_transcripts

#The final results will be in the results/ folder
