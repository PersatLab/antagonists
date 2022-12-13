// @File(Label="Select data path", style="directory") choose_1
// @File(Label="Select data path", style="directory") choose_2
// @File(Label="Select data path", style="directory") choose_3
// @File(Label="Select data path", style="directory") choose_4

/*
 * delete or add above lines as required
 * opens all movie folders in selected directory 
 * must be the intervall directory! 
 * run make_video before
 * comment out elements that are not needed using /*
 */


print("\\Clear");

do_non_moving = 0; // set to 1 only when that option was selected in Matlab and movies of non-moving cells exist

addition = ""; // addition to the filename in between "_trajectory" and ".tif", e.g. "_noSL"

dir=choose_1;
print(dir);

file=getFileList(dir);

for(j=0; j<file.length; j++) {
	l = lengthOf(file[j]);
	folder = file[j].substring(l-2,l-1);	
	directory=dir+File.separator+folder+File.separator+"Movie"+File.separator;
	print("Opening "+directory+"PC_with_trajectory"+addition+".tif");

	open(directory+"PC_with_trajectory"+addition+".tif");

	if (do_non_moving) {
		open(directory+"Non_Moving_PC_with_trajectory.tif");
	}
}

print("Done with "+dir);


dir=choose_2;
print(dir);

file=getFileList(dir);

for(j=0; j<file.length; j++) {
	l = lengthOf(file[j]);
	folder = file[j].substring(l-2,l-1);	
	directory=dir+File.separator+folder+File.separator+"Movie"+File.separator;
	print("Opening "+directory+"PC_with_trajectory"+addition+".tif");

	open(directory+"PC_with_trajectory"+addition+".tif");

	if (do_non_moving) {
		open(directory+"Non_Moving_PC_with_trajectory.tif");
	}
}

print("Done with "+dir);


dir=choose_3;
print(dir);

file=getFileList(dir);

for(j=0; j<file.length; j++) {
	l = lengthOf(file[j]);
	folder = file[j].substring(l-2,l-1);	
	directory=dir+File.separator+folder+File.separator+"Movie"+File.separator;
	print("Opening "+directory+"PC_with_trajectory"+addition+".tif");

	open(directory+"PC_with_trajectory"+addition+".tif");

	if (do_non_moving) {
		open(directory+"Non_Moving_PC_with_trajectory.tif");
	}
}

print("Done with "+dir);


dir=choose_4;
print(dir);

file=getFileList(dir);

for(j=0; j<file.length; j++) {
	l = lengthOf(file[j]);
	folder = file[j].substring(l-2,l-1);	
	directory=dir+File.separator+folder+File.separator+"Movie"+File.separator;
	print("Opening "+directory+"PC_with_trajectory"+addition+".tif");

	open(directory+"PC_with_trajectory"+addition+".tif");

	if (do_non_moving) {
		open(directory+"Non_Moving_PC_with_trajectory.tif");
	}
}

print("Done with "+dir);


/*
dir=choose_5;
print(dir);

file=getFileList(dir);

for(j=0; j<file.length; j++) {
	l = lengthOf(file[j]);
	folder = file[j].substring(l-2,l-1);	
	directory=dir+File.separator+folder+File.separator+"Movie"+File.separator;
	print("Opening "+directory+"PC_with_trajectory"+addition+".tif");

	open(directory+"PC_with_trajectory"+addition+".tif");

	if (do_non_moving) {
		open(directory+"Non_Moving_PC_with_trajectory.tif");
	}
}

print("Done with "+dir);


/*
dir=choose_6;
print(dir);

file=getFileList(dir);

for(j=0; j<file.length; j++) {
	l = lengthOf(file[j]);
	folder = file[j].substring(l-2,l-1);	
	directory=dir+File.separator+folder+File.separator+"Movie"+File.separator;
	print("Opening "+directory+"PC_with_trajectory"+addition+".tif");

	open(directory+"PC_with_trajectory"+addition+".tif");

	if (do_non_moving) {
		open(directory+"Non_Moving_PC_with_trajectory.tif");
	}
}

print("Done with "+dir);


dir=choose_7;
print(dir);

file=getFileList(dir);

for(j=0; j<file.length; j++) {
	l = lengthOf(file[j]);
	folder = file[j].substring(l-2,l-1);	
	directory=dir+File.separator+folder+File.separator+"Movie"+File.separator;
	print("Opening "+directory+"PC_with_trajectory"+addition+".tif");

	open(directory+"PC_with_trajectory"+addition+".tif");

	if (do_non_moving) {
		open(directory+"Non_Moving_PC_with_trajectory.tif");
	}
}

print("Done with "+dir);


dir=choose_8;
print(dir);

file=getFileList(dir);

for(j=0; j<file.length; j++) {
	l = lengthOf(file[j]);
	folder = file[j].substring(l-2,l-1);	
	directory=dir+File.separator+folder+File.separator+"Movie"+File.separator;
	print("Opening "+directory+"PC_with_trajectory"+addition+".tif");

	open(directory+"PC_with_trajectory"+addition+".tif");

	if (do_non_moving) {
		open(directory+"Non_Moving_PC_with_trajectory.tif");
	}
}

print("Done with "+dir);

/*
dir=choose_9;
print(dir);

file=getFileList(dir);

for(j=0; j<file.length; j++) {
	l = lengthOf(file[j]);
	folder = file[j].substring(l-2,l-1);	
	directory=dir+File.separator+folder+File.separator+"Movie"+File.separator;
	print("Opening "+directory+"PC_with_trajectory"+addition+".tif");

	open(directory+"PC_with_trajectory"+addition+".tif");

	if (do_non_moving) {
		open(directory+"Non_Moving_PC_with_trajectory.tif");
	}
}

print("Done with "+dir);
*/