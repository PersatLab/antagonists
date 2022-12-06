// Modify:
normalize = 0; // normalization by BacSTalk works better, so this setting is not used anymore

sample = "name of your demograph image file";
image_name = sample+".tif";
open("directory/"+sample+"/"+image_name); // modify "directory" according to your system
roiManager("Open", "directory/"+sample+"/"+sample+"_ROI_all_split.zip"); // modify "directory" according to your system | must contain the ROIs of the individual cells
ROIs = roiManager("count");
selectWindow(image_name);
run("32-bit");

setBatchMode(true);
for (i = 0; i < ROIs; i++) {
	selectWindow(image_name);
	roiManager("Select", i);
	run("Duplicate...", " ");
	
	if (normalize) {
		run("Measure");
		area = getResult("Area", 0);
		mean = getResult("Mean", 0);
		total = area*mean;
		run("Clear Results");
		run("Divide...", "value="+total);
	}
	
	run("Scale...", "x=- y=- width=200 height=60 interpolation=Bilinear average create"); // scales every cell to the same length
	if (i<10) {
		saveAs("Tiff", "directory/"+sample+"/Upsampled/"+sample+"_0"+i+".tif"); // modify "directory" according to your system
	} else {
		saveAs("Tiff", "directory/"+sample+"/Upsampled/"+sample+"_"+i+".tif"); // modify "directory" according to your system
	}
	close();
	selectWindow(sample+"-1.tif");
	close();
}
selectWindow(sample+".tif");
close();
if (normalize) {
	selectWindow("Results");
	run("Close");
}
selectWindow("ROI Manager");
run("Close");

folder_data = "AveragePicks/"+sample;
dir = "directory/"+folder_data+"/"; // modify "directory" according to your system
run("Image Sequence...", "select=["+dir+"Upsampled/] dir=["+dir+"Upsampled/] sort");

//run("Images to Stack", "name=Stack title=[] use");
//run("Z Project...", "projection=[Max Intensity]");
run("Z Project...", "projection=[Average Intensity]");
run("Red Hot");
run("Invert LUT");
setMinAndMax(0, 275); // adjust as needed
saveAs("Tiff", dir+"FinalAverageImage/"+sample+"_averaged_"+ROIs+"cells.tif");
saveAs("Jpeg", dir+"FinalAverageImage/"+sample+"_averaged_"+ROIs+"cells.jpg");
run("Close All");
setBatchMode(false);