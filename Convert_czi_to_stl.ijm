//CZI a STL
//Select and open directory
dir = "C:/Users/usuario/Downloads/ILX/";
//Create subfolder for STL files
newFolder = dir + "STL/";
if (!File.exists(newFolder)) {
    File.makeDirectory(newFolder);
}
// Get list of files czi
list = getFileList(dir);
destDir = dir;
minSize = 0;
maxSize = 9999999999;

// Loop through each file
for (i = 0; i < list.length; i++) {
    if (!endsWith(list[i], ".czi")) {
        print("Skipping (no at .czi): " + list[i]);
        continue;
    }

    // Build full file path
    filePath = dir + list[i];
    open(filePath);

    // Check if image was opened
    imageCount = nImages;
    if (imageCount == 0) {
        print("Warning: Could not open file: " + filePath);
        continue;
    }
    //Convert to 8 bit and Cropping Z
    run("8-bit");
    waitForUser("Browse the image and decide up to wich Z-slice to crop.Click OK to continue.");
    
    startZ = getNumber("Enter the starting Z-slice number:", 5);
    endZ = getNumber("Enter the ending Z-slice number:", 15);
    
    slices = endZ - startZ + 1;

    run("Duplicate...", "duplicate range=" + startZ + "-" + endZ + " use");
    run("Stack to Hyperstack...", "order=xyczt(default) channels=1 slices=" + slices + " frames=1 display=Color");
    run("Subtract Background...", "rolling=50 stack");
   //Set manually Brightness and Conrast
	run("Brightness/Contrast...");
	waitForUser("Adjust brightness/contrast, then just click OK.");
	//Set previous user settings and close window
	run("Apply LUT");
	run("Close");
	//Set manually Treshold configuration
    run("Threshold...");
    waitForUser("Adjust the Threshold values, then click 'Apply' to confirm.");
    run("Apply LUT");
    setOption("BlackBackground", true);
    //run Process for improve the image performance
	run("Erode");
	run("Fill Holes");
	//Let user validate final image
	waitForUser("Erode and fill holes were aplied, if everithing is fine then click OK.");
    // Open 3D Viewer and load processed image
    run("3D Viewer");
    call("ij3d.ImageJ3DViewer.setCoordinateSystem", "false");
    // Use the current image title to add and select in 3D Viewer
    imageTitle = getTitle();

    call("ij3d.ImageJ3DViewer.add", imageTitle, "White", imageTitle, "50", "true", "true", "true", "4", "2");
    call("ij3d.ImageJ3DViewer.select", imageTitle);

    // Ask for STL filename
    baseName = list[i].substring(0, list[i].lastIndexOf("."));
    stlName = getString("Enter a name to save the STL file (no extension or path):", baseName);

    stlFilePath = newFolder + stlName + ".stl";
    call("ij3d.ImageJ3DViewer.exportContent", "STL Binary", stlFilePath);

    print("Exporting STL to: " + stlFilePath);
    call("ij3d.ImageJ3DViewer.close");

    waitForUser("Review the 3D model. When you're ready, click OK to close and continue");
    // Close all open images
   while (nImages > 0) {
        selectImage(nImages);
        close();
    }
}
