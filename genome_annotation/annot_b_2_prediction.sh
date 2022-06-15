#!/bin/bash
mg8prot=data/Magnaporthe_oryzae.MG8.pep.all.fa
uniprot=/home/liu3zhen/software/funannotate/funannotate_db/uniprot_sprot.fasta
effectors=data/known.effectors.db01.fasta
inplanta_pasa_transcript=B71Ref2_trainSE/training/getBestModel/transcripts.fa
funannotate predict -i data/B71Ref2.softmasked.fasta \
	--augustus_species "magnaporthe_grisea" \
	-o B71b -s "Magnaporthe oryzae" \
	--protein_evidence $mg8prot $uniprot $effectors \
	--transcript_evidence $inplanta_pasa_transcript \
	--isolate B71 --name B71b --strain B71 --cpus 64 \
	2>annot_b_2_prediction.log
