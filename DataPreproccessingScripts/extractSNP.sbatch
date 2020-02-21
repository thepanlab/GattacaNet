#!/bin/bash

#SBATCH --partition=omicsbio
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=60:00:00
#SBATCH --job-name=plink
#SBATCH --mem=80G
#SBATCH --workdir=/work/breastcancer/clean_test/train
#SBATCH --output=plink_%J_stdout.txt
#SBATCH --error=plink_%J_stderr.txt
#SBATCH --mail-user=adrien.f.badre-1@ou.edu
#SBATCH --mail-type=ALL
#SBATCH --nodelist c660

#SBATCH --chdir=/work/breastcancer/clean_test/train

module load PLINK

#plink association analysis(mynewdata.bed,mynewdata.fam,mynewdata.bim)

#0.01

plink --bfile train --logistic --pfilter 1e-2 --threads 10 --out logistic_filter_0_01

#get significant SNP IDs

awk '{print $2}' logistic_filter_0_01.assoc.logistic >sig_SNPs_assoc_0_01.txt

#extract subset bed files

plink --bfile train --extract sig_SNPs_assoc_0_01.txt --make-bed --out sig0.01

#0.001

plink --bfile train --logistic --pfilter 1e-3 --threads 10 --out logistic_filter_0_001

#get significant SNP IDs

awk '{print $2}' logistic_filter_0_001.assoc.logistic >sig_SNPs_assoc_0_001.txt

#extract subset bed files

plink --bfile train --extract sig_SNPs_assoc_0_001.txt --make-bed --out sig0.001


#0.0001

plink --bfile train --logistic --pfilter 1e-4 --threads 10 --out logistic_filter_0_0001


#get significant SNP IDs

awk '{print $2}' logistic_filter_0_0001.assoc.logistic >sig_SNPs_assoc_0_0001.txt

#extract subset bed files

plink --bfile train --extract sig_SNPs_assoc_0_0001.txt --make-bed --out sig0.0001

#0.00001

plink --bfile train --logistic --pfilter 1e-5 --threads 10 --out logistic_filter_0_00001


#get significant SNP IDs

awk '{print $2}' logistic_filter_0_00001.assoc.logistic >sig_SNPs_assoc_0_00001.txt

#extract subset bed files

plink --bfile train --extract sig_SNPs_assoc_0_00001.txt --make-bed --out sig0.00001


