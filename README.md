# GattacaNet
predictive genomics
## Requirements
  * Python 3.6
    * Tensoflow v1.13
    * pandas_plink
    * pandas
    * numpy
    * sklearn v0.22
    * deep explain
    * LIME
  * R
    * bwgr
    * read.plink
  
 ## How to use it 
 
 This github contains the base code to run our experimentations. Each module represent a step of analysis. 
  1. DataPartioning
    * Comports the data partioning notebooks
  2. DataProcessingScript
    * Comports the data Processing scripts to extract SNPs significiant
  3. Learning
    1. Full_vs_Reduced
      * Comport the notebooks to analyze the optimal SNP reduction
    2. Architecture Comparison
      * Comport the notebooks to compare architectures
    3. Classic_Machine_Learning
      * COmport the notebook to compare the classic machine learning models
    4. Classic_Bio_Learning_Technics
      * COmport the R scripts to analyze BLUP, BayesA.... and the bash script for LDpred
  4. Interpretation
    * Comport the notbooks for LIME and DeepLift

