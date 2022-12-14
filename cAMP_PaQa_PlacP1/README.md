# Run with Python (v3.8.5) in jupyter notebook

* Easy install altogether through Anaconda (https://www.anaconda.com/products/distribution)


# cAMP_PaQa.ipynb: This script calculates cAMP ratios acquired using the PaQa plasmid and pre-analysed using stock BacStalk

* Change all directories in this script according to your system
* Record images of your cells containing the PaQa plasmid
* Segment cells with BacStalk (v1.8, https://drescherlab.org/data/bacstalk/docs/index.html)
  * Recommended to name the Channels "PaQa" for YFP fluorescence and "RFP" for mKate2 fluorescence (in case of PaQa plasmid)
  * You can use the ImageJ macro "SplitImage_MJK.ijm" in the static_localization folder on GitHub (https://github.com/PersatLab/antagonists) to split multichannel images to use for BacStalk
  * Export one csv file per sample containing at least: MeanCellIntensity_PaQa, MeanCellIntensity_RFP ("..._PaQa" and "..._RFP" are the names of the channels you enter in BacStalk)
  * Save BacStalk file if you want to go back and change some analysis parameters 
  * !!! Important !!! Format of the names of the csv files must be:
    * date_strain-number_Data_strain-name_PaQa_condition_replicate
    * no underscores within the strain name or other items
    * conditions must include liq or sol, because this script looks for "liq" or "sol" in the file name
    * same for "rep"
    * example: 20220421_1591_Data_fliC-chpALOF-cpdA-_PaQa_3hsol_rep2.csv
* Run this script, modify directories according to your system, and enter reference strain and strains to plot in function "plottingData" (last cell)


# cAMP_PlacP1.ipynb: This script calculates cAMP ratios acquired using the PlacP1 plasmid, recorded by flow cytometry and data exported to a csv file

* It does essentially the same as the script cAMP_PaQa.ipynb
* However, it uses a csv file as input containing fluorescent readings of YFP and mKate2 exported from flow cytometry measurements
* The input csv files contain two columns named "yfp" and "mKate2" (this can be different but then the script must be modified accordingly as specified in the relevant cell)
  * each row represents one measured cell
  * one csv file per sample
  * !!! Important !!! Format of the names of the csv files must be:
    * date_strain-number_Data_strain-name_PaQa_condition_replicate
    * no underscores within the strain name or other items
    * conditions must include liq or sol, because this script looks for "liq" or "sol" in the file name
    * same for "rep"
    * example: 20200908_413_Data_WT_lacP1_liq_rep1.csv
* To plot cAMP ratios, first change all directories in this script according to your system
* Then, run this script, enter reference strain and strains to plot in function "plottingData" (last cell)
