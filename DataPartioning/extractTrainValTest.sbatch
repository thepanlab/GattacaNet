#!/bin/bash

#SBATCH --partition=omicsbio
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=60:00:00
#SBATCH --job-name=plink
#SBATCH --mem=80G
#SBATCH --workdir=/work/breastcancer/clean_test
#SBATCH --output=plink_%J_stdout.txt
#SBATCH --error=plink_%J_stderr.txt
#SBATCH --mail-user=adrien.f.badre-1@ou.edu
#SBATCH --mail-type=ALL

#SBATCH --chdir=/work/breastcancer/clean_test

module load PLINK


##extract subset bed files to create train validation and test sets


plink --bfile mynewdata --keep train_indiv.txt --make-bed --out train/train
plink --bfile mynewdata --keep validation_indiv.txt --make-bed --out validation/validation
plink --bfile mynewdata --keep test_indiv.txt --make-bed --out test/test






