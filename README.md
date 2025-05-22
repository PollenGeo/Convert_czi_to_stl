# CONVERT IMAGES FROM CZI TO STL EXTENSION
## OVERVIEW
This script is designed to run as a macro in FIJI. It converts .czi images acquired via the Airyscan confocal microscopy system into 3D models in .STL format, suitable for 3D printing or further analysis.
## Features
-	Image preprocessing in FIJI using: Brightness and Constrast adjustment, Fill Holes, Erode
-	Image segmentation and 3D mesh visualization
-	Export of segmented images as. STL files
-	Automatic files renaming during export
## Requirements
-	FIJI (Image J) installed (v. 1.54p)
-	FIJI plugins: Bio-Formats, 3D Viewer
-	Java 1.8 or higher
## Installation
1.Download and install FIJI from [the oficial website]: https://imagej.net/software/fiji/
2.Update and enable **Bio-Formats**:
-	Go Help > Update
-	Click on Manage update sites
-	Check Bio-Formats, apply changes, and restart FIJI
3. Ensure 3D Viewer plugin is available in the Plugins menu
## Usage:
1.	Open Fiji.
2.	Go to Plugins > Macros > Run and load the macro file.
-	Alternatively, drag and drop the macro file into the FIJI window.
3.	Select the working directory (replace “/” with of “\” in the file.
## Workflow:
1.	Follow all instructions provided by the dialog boxes during execution.
2.	Convert the image from 16-bit to 8-bit.
3.	Crop Z-slices (planes) that contain no relevant information.
4.	Apply filters to enhance image quality and remove background noise.
5.	Adjust the threshold to segment each object of interest (e.g. pollen grains) accurately.
6.	Visualize the result using the 3D Viewer plugin.
7.	Export the segmented 3D mesh as an  .STL file to the select subfolder. (STL folder create by default)

## Version
V1.0

## Author
Brenda Orosco
oroscob@si.edu

Ingrid Romero
romeroic@si.edu
