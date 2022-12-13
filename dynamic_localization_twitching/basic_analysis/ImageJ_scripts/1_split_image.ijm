/* AIM of this macro:
 *  - create folder in correct position to run the Matlab analysis directely after
 *  - open the .nd2 file and save as tiff the two channels separately (C0-Phase contract & C1- fluorescent channel)
 *  - C0 channel save each time frame independently (for backstalk)
 *  - save a csv file in the folder with all the info of the video (original name, pixel size, time interval) that will be used for the analysis
*/

// TO MODIFY: search for directory and change according to your system, only change strings, not variables

/*
* Note: Files names should have the following format: number_whatever_condition_frameinterval_whatever.fileending (e.g. 923_0p5agarose_TrpNC_OD0p2_2h37_5s_001.nd2)
* This code splits the name between every underscore. It saves in the csv file the frame interval used to calculate the tracked time and the condition (here time after surface contact). 
*/
index_int=2; // position of the frame interval, counted from back to front. In the above example the frame interval is at position 2 (5s)
index_time=3; // position of the condition, counted from back to front. In the above example the condition is at position 3 (2h37)

number=newArray("923","315"); // strain numbers of the files that should be opened. Number must be at the start of the file name
Pil_type=newArray("fliC- mNG_PilG","fliC- mNG_PilH"); // Name of the strain

same_date = 1; // if same date 1, uses the first date/folder_name entry for all numbers, otherwise put date/folder_name for every item of the number vector

folder_name=newArray("Folder that contains the image files"); // If multiple folders, enter the folder name for every item of the number vector
date=newArray("20220105"); // date of the image acquisition. Important for the file sorting. Creates a folder with that date. If multiple folders, enter the date for every item of the number vector.

match=".*2h37.*" // Opens only files that contain the string in betwee .* .*
dir_save="directory/"; // !! Modify according to your system!! This is where all the split images are going to be saved, sorted into folder according to what information you entered above and what's in the file name
only_PC=0 // 1 for single channel phase contrast image sequences, 0 for phase contrast + 1 fluorescent channel
correct_drift=1 // 1 to run MultiStackReg_translation plugin, works well with multi channel stacks

reg_file_loc = "directory/TransformationMatrices.txt"; // !! Modify according to your system!! folder where registration file is saved, folder must exist


// STEP 1: chose folder nd2 douments are

dir_data = "directory/" // !! Modify according to your system!! This is the directory of the folers (entered in the variable folder_name) that contain the images

setBatchMode(true)

for(s=0; s<lengthOf(number);s++){

	if (same_date) {
		dir=dir_data+folder_name[0]+"/";
	}
	else {
		dir=dir_data+folder_name[s]+"/";
	}
	
	list=getFileList(dir); // get list of all the microscope videos of the folder 
	
	// STEP 2: create folder
	directory=dir_save+number[s]+" "+Pil_type[s]+"/";
	File.makeDirectory(directory); // don't modify this directory, this is a variable
	
	for(i=0; i<list.length;i++){
		if (startsWith(list[i],number[s])){
			if (matches(list[i], match)){ 
			print("Working on:");
			print(dir); // check point
			print(list[i]); // check point
			// STEP a): split name of video to get all required info 
			split_name=split(list[i],"_"); // splits the file name between every underscore
			interval=split_name[split_name.length-index_int]+" interval"; // for the interval time between frames
			interval=interval+"-"+split_name[split_name.length-index_time]; // for the condition, i.e. time on surface
		
			// STEP b): create folders
			if (same_date) {
				dir_date=directory+date[0];
			}
			else {
				dir_date=directory+date[s];
				}
			
			File.makeDirectory(dir_date);
			File.makeDirectory(dir_date+"/"+interval)
		
			nbr_folder=getFileList(dir_date+"/"+interval); // to know how many folders are aleady present 
			name_folder=nbr_folder.length+1;
			new_directory=dir_date+"/"+interval+"/"+name_folder;
			
			File.makeDirectory(new_directory)
			File.makeDirectory(new_directory+"/Movie") // MATLAB will save the each image separately there. Video_maker.ijm will make a video with images from there
		
		
		// STEP 3: open video and extract info
			open(dir+list[i]);
			saveAs("Tiff", new_directory+"/data");
			getPixelSize(unit, pw, ph);
		
			if(!only_PC){				
			
		// STEP 4: split the channels
			run("Split Channels");

		// STEP 5 : save phase contract channel al C0-data + save each time frae separately (for BackStalk)
			selectWindow("C1-data"+".tif");
			if(correct_drift){
				stack_name_ref = "C1-data"+".tif";
				run("MultiStackReg", "stack_1="+stack_name_ref+" action_1=Align file_1=["+reg_file_loc+"] stack_2=None action_2=Ignore file_2=[] transformation=Translation save");
			}
			C0_data=new_directory+"/C0-data.tif";
			saveAs("Tiff", C0_data);
			run("Image Sequence... ", "format=TIFF name=C0-data_t digits=3 save=["+new_directory+"]");
			close();			
			
		// STEP 6 : save fluorescent channel al C1-data
			selectWindow("C2-data"+".tif");
			run("Subtract Background...", "rolling=50 stack");
			if(correct_drift){
				stack_name_fluo = "C2-data"+".tif";
				run("MultiStackReg", "stack_1="+stack_name_fluo+" action_1=[Load Transformation File] file_1=["+reg_file_loc+"] stack_2=None action_2=Ignore file_2=[] transformation=Translation");
			}
			C1_data=new_directory+"/C1-data.tif";
			run("Yellow");
			saveAs("Tiff", C1_data);
			close();
			}
				
			
			if(only_PC) {	
		// STEP 6 : save phase contract channel al C0-data + save each time frae separately (for BackStalk)
			if(correct_drift){
				run("StackReg ", "transformation=Translation");
				}
			C0_data=new_directory+"/C0-data.tif";
			saveAs("Tiff", C0_data);
			run("Image Sequence... ", "format=TIFF name=C0-data_t digits=3 save=["+new_directory+"]");
			close();
				
			}
		// STEP 7: save csv file containing all the info needed for analysis (original name, pixel size, time interval)
			// save csv file
			print("\\Clear"); // clear 'LOG' page
			print(dir);
			print(list[i]);
			print(pw);
			print(ph);
			frame_interval=split(interval,"s");
			print(frame_interval[0]);
			selectWindow("Log");
			saveAs("Text",new_directory+"/parameters.csv");
			
			print("\\Clear"); // clear 'LOG' page
			ok = File.delete(new_directory+"/data.tif"); 
			}
		}		
	}
}

setBatchMode(false)

print("Done with:");
print(dir);
