/*
 * Macro template to process multiple images in a folder
 */
 
#@ File (label = "Input directory", style = "directory") input
#@ String (label = "File suffix", value = "p.roi.zip") suffix

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix


function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, list[i]);
	}
}



function processFile(input, file) {
	// Do the processing here by adding your own code.


print("\\Clear");

print("Track,Point_ID,x,y,File");

roiManager("open", input+"/"+file);

f = input+file;

ff=replace(f,".roi.zip",".tif"); 

open(ff);

numROIs = roiManager("count");

// loop through ROIs

for(i=0; i<numROIs;i++) {// loop through ROIs
	roiManager("Select", i);
	getSelectionCoordinates(x, y);//if the ROI is a multipoint ROIs x and y are arrays

	for (j=0; j<x.length; j++) {
		print(i+","+j+","+x[j]+ ","+y[j]+","+input+"/"+file);
	}
}

roiManager("reset");


selectWindow("Log");

saveAs("Text", input+"/"+file+".csv"); 


}


// clear log

print("\\Clear");

run("Close All");

