# GattacaNet
predictive genomics
## Requirements
  * Python 3.6
    * Tensoflow v1.13
    * pandas_plink
    * pandas
    * numpy
    * sklearn v0.22
    * DeepExplain
    * LIME
  * R
    * bwgr
    * read.plink
  * LDpred
    * https://github.com/bvilhjal/ldpred
   
 ## How to use it 
 
 This github contains the base code to run our experimentations. Each module represent a step of analysis. 
  * DataPartioning
    * Comports the data partioning notebooks
  * DataProcessingScript
    * Comports the data Processing scripts to extract SNPs significiant
  * Learning
    * Full_vs_Reduced
      * Comport the notebooks to analyze the optimal SNP reduction
    * Architecture Comparison 
      * Comport the notebooks to compare architectures
    * Classic_Machine_Learning
      * Comport the notebook to compare the classic machine learning models
    * Classic_Bio_Learning_Technics
      * Comport the R scripts to analyze BLUP, BayesA.... and the bash script for LDpred
  * Interpretation
    * Comport the notbooks for LIME and DeepLift

