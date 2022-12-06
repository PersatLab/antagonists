# Preparation

* Prepare folders for data storage and results as specified in the various scripts
  * folder for your protein of interest containing
    * Input_Profile_Analysis.xlsx (what you add here must match exactly how you name the BacStalk file, see below for details)
      * each line represents one set of data
      * **column 1** - strain number
      * **column 2** - name (whatever is in between "Dataset_" and "_condition"
      * **column 1** - date
      * **column 1** - condition
    * folder "data"
    * folder "mat"
    * folder "svg_files"
    * folder "fig_files"
  * jpg files of the plots are just saved in the protein of interest directory
  * all of the final folders must be contained in a parent folder with the name of your protein of interest, either all together or separated in different protein of interest folder (for example to separate the final graphs from the data)
      
* Make sure all directores in the Matlab scripts are matching your personal system's directories


# How to run this code

* Run one of the SplitImage macros (Fiji ImageJ, v1.53, https://fiji.sc/) to prepare for BacStalk analysis
  * **SplitImage_MJK.ijm** - for single images with first channel phase contrast + second channel fluorescence
  * **SplitImage_MJK_mNG+mScI.ijm** - for single images with first channel phase contrast + second channel fluorescence + third channel fluorescence (the final code will only use one of the fluorescence channels at a time)
	* **..._firstPic_MJK.ijm** - same but for image sequences, only saves the first image

* Run BacStalk (Matlab, v1.8, https://drescherlab.org/data/bacstalk/docs/index.html) to segment the cells
* save BacStalk mat file
	* mat files must be saved in dir_data directory (see localization_profile_static.m)
  * the file name must follow the following format: **date_"DataSet"_number_condition** (e.g. 20220106_DataSet_923_mNG_PilG_sol0h)
  * file name elements must match the fields in Input_Profile_Analysis.xlsx

* Run localization_profile_static.m (Matlab) located in graph_plotting
  * change lines according to the protein (folder name) you want to plot and the name you gave the fluorescence channel
  * modify the lines containing "directory" (search for it) to match your system
