// @File(Label="Select data path", style="directory") dir
print("\\Clear");
run("Close All");
print("Working on directory: "+dir);
dir_p=dir+File.separator+"processed";
File.makeDirectory(dir_p);

number=newArray("923","315"); // number of the strain to look for, files must be named correctly starting with a number and underscore, e.g. "923_"
match=".*5s.*"; // only considers files containing anywhere the string in between .*
max="750"; // sets min and max pixel values to 0 and "max"

setBatchMode(true);
for (n = 0; n < number.length; n++) {
	print("Selected number: "+number[n]);
	print("Matching: "+match);
	
	files=getFileList(dir);
	for(i=0; i<files.length; i++){
		if (startsWith(files[i],number[n])){
		if (matches(files[i], match)){
				print("Working on file: "+files[i]);
				print("Opening...");
			open(dir+File.separator+files[i]);		
			name_ori=getTitle();
			name_save=substring(files[i], 0, files[i].length-4);
			//print("name_ori: "+name_ori);
			//print("name_save: "+name_save);
				print("Doing my thing...");
			run("Split Channels");
			
			selectWindow("C1-"+name_ori);
			run("Duplicate...", "duplicate range=1-1");
			if (matches(name_ori, ".*series.*")) {
				selectWindow("C1-"+name_ori+"-1");
				//print("checkpoint_series: "+"C1-"+name_ori+"-1");
			}else {
				selectWindow("C1-"+name_save+"-1.nd2");
				//print("checkpoint_noBS: "+"C1-"+name_save+"-1.nd2");
			}
	 		saveAs("Tiff", dir_p+File.separator+name_save+"_PC"+".tif");
			
			selectWindow("C2-"+name_ori);
			run("Subtract Background...", "rolling=50 stack");
			setMinAndMax(0, max);
			run("Duplicate...", "duplicate range=1-1");
			if (matches(name_ori, ".*series.*")) {
				selectWindow("C2-"+name_ori+"-1");
				//print("checkpoint_series: "+"C1-"+name_ori+"-1");
			}else {
				selectWindow("C2-"+name_save+"-1.nd2");
				//print("checkpoint_noBS: "+"C1-"+name_save+"-1.nd2");
			}
			saveAs("Tiff", dir_p+File.separator+name_save+"_mNG"+".tif");

			selectWindow("C3-"+name_ori);
			run("Subtract Background...", "rolling=50 stack");
			setMinAndMax(0, max/5);
			run("Duplicate...", "duplicate range=1-1");
			if (matches(name_ori, ".*series.*")) {
				selectWindow("C3-"+name_ori+"-1");
				//print("checkpoint_series: "+"C1-"+name_ori+"-1");
			}else {
				selectWindow("C3-"+name_save+"-1.nd2");
				//print("checkpoint_noBS: "+"C1-"+name_save+"-1.nd2");
			}			
				print("Saving...");
			saveAs("Tiff", dir_p+File.separator+name_save+"_mScI"+".tif");
	
			run("Close All");
				print("Done!");
				print(" ");
		}
		}
	}
}
setBatchMode(false);
print("Done with all files!");