% Demo macro to very, very simple color detection in LAB color space.
% The RGB image is converted to LAB color space and then the user draws
% some freehand-drawn irregularly shaped region to identify a color.
% The Delta E (the color difference in LAB color space) is then calculated
% for every pixel in the image between that pixel's color and the average
% LAB color of the drawn region.  The user can then specify a number that
% says how close to that color would they like to be.  The software will
% then find all pixels within that specified Delta E of the color of the drawn region.
%
% Note: This demo differs from my demo on color detection by thresholding in the
% hsv color space because with that one you are essentially extracting out a
% pie-shaped sector out of the LAB color space gamut while in this demo
% we're extracting out a sphere centered at the mean LAB color of the user-drawn region.
% by ImageAnalyst, Ph.D.

function DeltaE()
clc;	% Clear command window.
clear;	% Delete all variables.
close all;	% Close all figure windows except those created by imtool.
% imtool close all;	% Close all figure windows created by imtool.
workspace;	% Make sure the workspace panel is showing.

% Change the current folder to the folder of this m-file.
if(~isdeployed)
	cd(fileparts(which(mfilename))); % From Brett
end

try
	% Check that user has the Image Processing Toolbox installed.
	hasIPT = license('test', 'image_toolbox');
	if ~hasIPT
		% User does not have the toolbox installed.
		message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
		reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
		if strcmpi(reply, 'No')
			% User said No, so exit.
			return;
		end
	end

	% Continue with the demo.  Do some initialization stuff.
	close all;
	fontSize = 14;
	figure;
	% Maximize the figure. 
	set(gcf, 'Position', get(0, 'ScreenSize')); 
	set(gcf,'name','Color Matching Demo by ImageAnalyst','numbertitle','off') 

	% Change the current folder to the folder of this m-file.
	% (The line of code below is from Brett Shoelson of The Mathworks.)
	if(~isdeployed)
		cd(fileparts(which(mfilename)));
	end

	% Ask user if they want to use a demo image or their own image.
	message = sprintf('Do you want use a standard demo image,\nOr pick one of your own?');
	reply2 = questdlg(message, 'Which Image?', 'Demo','My Own', 'Demo');
	% Open an image.
	if strcmpi(reply2, 'Demo')
		% Read standard MATLAB demo image.
		message = sprintf('Which demo image do you want to use?');
		selectedImage = questdlg(message, 'Which Demo Image?', 'Onions', 'Peppers', 'Stained Fabric', 'Onions');
		if strcmp(selectedImage, 'Onions')
			fullImageFileName = 'onion.png';
		elseif strcmp(selectedImage, 'Peppers')
			fullImageFileName = 'peppers.png';
		else
			fullImageFileName = 'fabric.png';
		end
	else
		% They want to pick their own.
		% Change default directory to the one containing the standard demo images for the MATLAB Image Processing Toolbox. 
		originalFolder = pwd; 
		folder = fullfile(matlabroot, '\toolbox\images\imdemos');
		if ~exist(folder, 'dir') 
			folder = pwd; 
		end 
		cd(folder); 
		% Browse for the image file. 
		[baseFileName, folder] = uigetfile('*.*', 'Specify an image file'); 
		fullImageFileName = fullfile(folder, baseFileName); 
		% Set current folder back to the original one. 
		cd(originalFolder);
		selectedImage = 'My own image'; % Need for the if threshold selection statement later.
	end

	% Check to see that the image exists.  (Mainly to check on the demo images.)
	if ~exist(fullImageFileName, 'file')
		message = sprintf('This file does not exist:\n%s', fullImageFileName);
		WarnUser(message);
		return;
	end

	% Read in image into an array.
	[rgbImage storedColorMap] = imread(fullImageFileName); 
	[rows columns numberOfColorBands] = size(rgbImage); 
	% If it's monochrome (indexed), convert it to color. 
	% Check to see if it's an 8-bit image needed later for scaling).
	if strcmpi(class(rgbImage), 'uint8')
		% Flag for 256 gray levels.
		eightBit = true;
	else
		eightBit = false;
	end
	if numberOfColorBands == 1
		if isempty(storedColorMap)
			% Just a simple gray level image, not indexed with a stored color map.
			% Create a 3D true color image where we copy the monochrome image into all 3 (R, G, & B) color planes.
			rgbImage = cat(3, rgbImage, rgbImage, rgbImage);
		else
			% It's an indexed image.
			rgbImage = ind2rgb(rgbImage, storedColorMap);
			% ind2rgb() will convert it to double and normalize it to the range 0-1.
			% Convert back to uint8 in the range 0-255, if needed.
			if eightBit
				rgbImage = uint8(255 * rgbImage);
			end
		end
	end
	
	% Display the original image.
	h1 = subplot(3, 4, 1);
	imshow(rgbImage);
	drawnow; % Make it display immediately. 
	if numberOfColorBands > 1 
		title('Original Color Image', 'FontSize', fontSize); 
	else 
		caption = sprintf('Original Indexed Image\n(converted to true color with its stored colormap)');
		title(caption, 'FontSize', fontSize);
	end
	
	% Let user outline region over rgb image.
% 	[xCoords, yCoords, roiPosition] = DrawBoxRegion(h1);  % Draw a box.
	mask = DrawFreehandRegion(h1, rgbImage);  % Draw a freehand, irregularly-shaped region.
	
	% Mask the image.
	maskedRgbImage = bsxfun(@times, rgbImage, cast(mask, class(rgbImage)));
	% Display it.
	subplot(3, 4, 5);
	imshow(maskedRgbImage);
	title('The Region You Drew', 'FontSize', fontSize); 

	% Convert image from RGB colorspace to lab color space.
	cform = makecform('srgb2lab');
	lab_Image = applycform(im2double(rgbImage),cform);
	
	% Extract out the color bands from the original image
	% into 3 separate 2D arrays, one for each color component.
	LChannel = lab_Image(:, :, 1); 
	aChannel = lab_Image(:, :, 2); 
	bChannel = lab_Image(:, :, 3); 
	
	% Display the lab images.
	subplot(3, 4, 2);
	imshow(LChannel, []);
	title('L Channel', 'FontSize', fontSize);
	subplot(3, 4, 3);
	imshow(aChannel, []);
	title('a Channel', 'FontSize', fontSize);
	subplot(3, 4, 4);
	imshow(bChannel, []);
	title('b Channel', 'FontSize', fontSize);

	% Get the average lab color value.
	[LMean, aMean, bMean] = GetMeanLABValues(LChannel, aChannel, bChannel, mask);
	
	% Get box coordinates and get mean within the box.
% 	x1 = round(roiPosition(1));
% 	x2 = round(roiPosition(1) + roiPosition(3) - 1);
% 	y1 = round(roiPosition(2));
% 	y2 = round(roiPosition(2) + roiPosition(4) - 1);
% 	
% 	LMean = mean2(LChannel(y1:y2, x1:x2))
% 	aMean = mean2(aChannel(y1:y2, x1:x2))
% 	bMean = mean2(bChannel(y1:y2, x1:x2))

	% Make uniform images of only that one single LAB color.
	LStandard = LMean * ones(rows, columns);
	aStandard = aMean * ones(rows, columns);
	bStandard = bMean * ones(rows, columns);
	
	% Create the delta images: delta L, delta A, and delta B.
	deltaL = LChannel - LStandard;
	deltaa = aChannel - aStandard;
	deltab = bChannel - bStandard;
	
	% Create the Delta E image.
	% This is an image that represents the color difference.
	% Delta E is the square root of the sum of the squares of the delta images.
	deltaE = sqrt(deltaL .^ 2 + deltaa .^ 2 + deltab .^ 2);
	
	% Mask it to get the Delta E in the mask region only.
	maskedDeltaE = deltaE .* mask;
	% Get the mean delta E in the mask region
	% Note: deltaE(mask) is a 1D vector of ONLY the pixel values within the masked area.
 	meanMaskedDeltaE = mean(deltaE(mask));
	% Get the standard deviation of the delta E in the mask region
	stDevMaskedDeltaE = std(deltaE(mask));
	message = sprintf('The mean LAB = (%.2f, %.2f, %.2f).\nThe mean Delta E in the masked region is %.2f +/- %.2f',...
		LMean, aMean, bMean, meanMaskedDeltaE, stDevMaskedDeltaE);	
	
	% Display the masked Delta E image - the delta E within the masked region only.
	subplot(3, 4, 6);
	imshow(maskedDeltaE, []);
	caption = sprintf('Delta E between image within masked region\nand mean color within masked region.\n(With amplified intensity)');
	title(caption, 'FontSize', fontSize);

	% Display the Delta E image - the delta E over the entire image.
	subplot(3, 4, 7);
	imshow(deltaE, []);
	caption = sprintf('Delta E Image\n(Darker = Better Match)');
	title(caption, 'FontSize', fontSize);

	% Plot the histograms of the Delta E color difference image,
	% both within the masked region, and for the entire image.
	PlotHistogram(deltaE(mask), deltaE, [3 4 8], 'Histograms of the 2 Delta E Images');
	
	message = sprintf('%s\n\nRegions close in color to the color you picked\nwill be dark in the Delta E image.\n', message);
	msgboxw(message);

	% Find out how close the user wants to match the colors.
	prompt = {sprintf('First, examine the histogram.\nThen find pixels within this Delta E (from the average color in the region you drew):')};
	dialogTitle = 'Enter Delta E Tolerance';
	numberOfLines = 1;
	% Set the default tolerance to be the mean delta E in the masked region plus two standard deviations.
	strTolerance = sprintf('%.1f', meanMaskedDeltaE + 3 * stDevMaskedDeltaE);
	defaultAnswer = {strTolerance};  % Suggest this number to the user.
	response = inputdlg(prompt, dialogTitle, numberOfLines, defaultAnswer);
	% Update tolerance with user's response.
	tolerance = str2double(cell2mat(response));

	% Let them interactively select the threshold with the threshold() m-file.
	% (Note: This is a separate function in a separate file in my File Exchange.)
% 	threshold(deltaE);
	
	% Place a vertical bar at the threshold location.
	handleToSubPlot8 = subplot(3, 4, 8);  % Get the handle to the plot.
	PlaceVerticalBarOnPlot(handleToSubPlot8, tolerance, [0 .5 0]);  % Put a vertical red line there.
	
	% Find pixels within that delta E.
	binaryImage = deltaE <= tolerance;
	subplot(3, 4, 9);
	imshow(binaryImage, []);
	title('Matching Colors Mask', 'FontSize', fontSize);
	
	% Mask the image with the matching colors and extract those pixels.
	matchingColors = bsxfun(@times, rgbImage, cast(binaryImage, class(rgbImage)));
	subplot(3, 4, 10);
	imshow(matchingColors);
	caption = sprintf('Matching Colors (Delta E <= %.1f)', tolerance);
	title(caption, 'FontSize', fontSize);

	% Mask the image with the NON-matching colors and extract those pixels.
	nonMatchingColors = bsxfun(@times, rgbImage, cast(~binaryImage, class(rgbImage)));
	subplot(3, 4, 11);
	imshow(nonMatchingColors);
	caption = sprintf('Non-Matching Colors (Delta E > %.1f)', tolerance);
	title(caption, 'FontSize', fontSize);

	% Display credits: the MATLAB logo and my name.
	ShowCredits(); % Display logo in plot position #12.
	
	% Alert user that the demo has finished.
	message = sprintf('Done!\n\nThe demo has finished.\nRegions close in color to the color you picked\nwill be dark in the Delta E image.\n');
	msgbox(message);
	
catch ME
	errorMessage = sprintf('Error running this m-file:\n%s\n\nThe error message is:\n%s', ...
		mfilename('fullpath'), ME.message);
	errordlg(errorMessage);
end
return; % from SimpleColorDetection()
% ---------- End of main function ---------------------------------


%----------------------------------------------------------------------------
% Display the MATLAB logo.
function ShowCredits()
try
% 	xpklein;
% 	surf(peaks(30));
	logoFig = subplot(3, 4, 12);
	caption = sprintf('A MATLAB Demo\nby ImageAnalyst');
	text(0.5,1.15, caption, 'Color','r', 'FontSize', 18, 'FontWeight','b', 'HorizontalAlignment', 'Center') ;
	positionOfLowerRightPlot = get(logoFig, 'position');
	L = 40*membrane(1,25);
	logoax = axes('CameraPosition', [-193.4013 -265.1546  220.4819],...
		'CameraTarget',[26 26 10], ...
		'CameraUpVector',[0 0 1], ...
		'CameraViewAngle',9.5, ...
		'DataAspectRatio', [1 1 .9],...
		'Position', positionOfLowerRightPlot, ...
		'Visible','off', ...
		'XLim',[1 51], ...
		'YLim',[1 51], ...
		'ZLim',[-13 40], ...
		'parent',gcf);
	s = surface(L, ...
		'EdgeColor','none', ...
		'FaceColor',[0.9 0.2 0.2], ...
		'FaceLighting','phong', ...
		'AmbientStrength',0.3, ...
		'DiffuseStrength',0.6, ... 
		'Clipping','off',...
		'BackFaceLighting','lit', ...
		'SpecularStrength',1.1, ...
		'SpecularColorReflectance',1, ...
		'SpecularExponent',7, ...
		'Tag','TheMathWorksLogo', ...
		'parent',logoax);
	l1 = light('Position',[40 100 20], ...
		'Style','local', ...
		'Color',[0 0.8 0.8], ...
		'parent',logoax);
	l2 = light('Position',[.5 -1 .4], ...
		'Color',[0.8 0.8 0], ...
		'parent',logoax);

catch ME
	errorMessage = sprintf('Error running ShowCredits().\n\nThe error message is:\n%s', ...
		ME.message);
	errordlg(errorMessage);
end
return; % from ShowCredits()

%-----------------------------------------------------------------------------
function [xCoords, yCoords, roiPosition] = DrawBoxRegion(handleToImage)
	try
	% Open a temporary full-screen figure if requested.
	enlargeForDrawing = true;
	axes(handleToImage);
	if enlargeForDrawing
		hImage = findobj(gca,'Type','image');
		numberOfImagesInside = length(hImage);
		if numberOfImagesInside > 1
			imageInside = get(hImage(1), 'CData');
		else
			imageInside = get(hImage, 'CData');
		end
		hTemp = figure;
		hImage2 = imshow(imageInside, []);
		[rows columns NumberOfColorBands] = size(imageInside);
		set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
	end
	
	txtInfo = sprintf('Draw a box over the unstained fabric by clicking and dragging over the image.\nDouble click inside the box to finish drawing.');
	text(10, 40, txtInfo, 'color', 'r', 'FontSize', 24);

    % Prompt user to draw a region on the image.
	msgboxw(txtInfo);
	
	% Erase all previous lines.
	if ~enlargeForDrawing
		axes(handleToImage);
% 		ClearLinesFromAxes(handles);
	end
	
	hBox = imrect;
	roiPosition = wait(hBox);
	roiPosition
	% Erase all previous lines.
	if ~enlargeForDrawing
		axes(handleToImage);
% 		ClearLinesFromAxes(handles);
	end

	xCoords = [roiPosition(1), roiPosition(1)+roiPosition(3), roiPosition(1)+roiPosition(3), roiPosition(1), roiPosition(1)];
	yCoords = [roiPosition(2), roiPosition(2), roiPosition(2)+roiPosition(4), roiPosition(2)+roiPosition(4), roiPosition(2)];

	% Plot the mask as an outline over the image.
	hold on;
	plot(xCoords, yCoords, 'linewidth', 2);
	close(hTemp);
	catch ME
		errorMessage = sprintf('Error running DrawRegion:\n\n\nThe error message is:\n%s', ...
			ME.message);
		WarnUser(errorMessage);
	end
	return; % from DrawRegion
	
%-----------------------------------------------------------------------------
function [mask] = DrawFreehandRegion(handleToImage, rgbImage)
try
	fontSize = 14;
	% Open a temporary full-screen figure if requested.
	enlargeForDrawing = true;
	axes(handleToImage);
	if enlargeForDrawing
		hImage = findobj(gca,'Type','image');
		numberOfImagesInside = length(hImage);
		if numberOfImagesInside > 1
			imageInside = get(hImage(1), 'CData');
		else
			imageInside = get(hImage, 'CData');
		end
		hTemp = figure;
		hImage2 = imshow(imageInside, []);
		[rows columns NumberOfColorBands] = size(imageInside);
		set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
	end
	
	message = sprintf('Left click and hold to begin drawing.\nSimply lift the mouse button to finish');
	text(10, 40, message, 'color', 'r', 'FontSize', fontSize);

    % Prompt user to draw a region on the image.
	uiwait(msgbox(message));
	
	% Now, finally, have the user freehand draw the mask in the image.
	hFH = imfreehand();

	% Once we get here, the user has finished drawing the region.
	% Create a binary image ("mask") from the ROI object.
	mask = hFH.createMask();
	
	% Close the maximized figure because we're done with it.
	close(hTemp);

	% Display the freehand mask.
	subplot(3, 4, 5);
	imshow(mask);
	title('Binary mask of the region', 'FontSize', fontSize);
	
	% Mask the image.
	maskedRgbImage = bsxfun(@times, rgbImage, cast(mask,class(rgbImage)));
	% Display it.
	subplot(3, 4, 6);
	imshow(maskedRgbImage);
catch ME
	errorMessage = sprintf('Error running DrawFreehandRegion:\n\n\nThe error message is:\n%s', ...
		ME.message);
	WarnUser(errorMessage);
end
return; % from DrawFreehandRegion

%-----------------------------------------------------------------------------
% Get the average lab within the mask region.
function [LMean, aMean, bMean] = GetMeanLABValues(LChannel, aChannel, bChannel, mask)
try
	LVector = LChannel(mask); % 1D vector of only the pixels within the masked area.
	LMean = mean(LVector);
	aVector = aChannel(mask); % 1D vector of only the pixels within the masked area.
	aMean = mean(aVector);
	bVector = bChannel(mask); % 1D vector of only the pixels within the masked area.
	bMean = mean(bVector);
catch ME
	errorMessage = sprintf('Error running GetMeanLABValues:\n\n\nThe error message is:\n%s', ...
		ME.message);
	WarnUser(errorMessage);
end
return; % from GetMeanLABValues

%==========================================================================================================================
function WarnUser(warningMessage)
	uiwait(warndlg(warningMessage));
	return; % from WarnUser()
	
%==========================================================================================================================
function msgboxw(message)
	uiwait(msgbox(message));
	return; % from msgboxw()
	
%==========================================================================================================================
% Plots the histograms of the pixels in both the masked region and the entire image.
function PlotHistogram(maskedRegion, doubleImage, plotNumber, caption)
try
	fontSize = 14;
	subplot(plotNumber(1), plotNumber(2), plotNumber(3)); 

	% Find out where the edges of the histogram bins should be.
	maxValue1 = max(maskedRegion(:));
	maxValue2 = max(doubleImage(:));
	maxOverallValue = max([maxValue1 maxValue2]);
	edges = linspace(0, maxOverallValue, 100);

	% Get the histogram of the masked region into 100 bins.
	pixelCount1 = histc(maskedRegion(:), edges);

	% Get the histogram of the entire image into 100 bins.
	pixelCount2 = histc(doubleImage(:), edges);

	% Plot the  histogram of the entire image.
	plot(edges, pixelCount2, 'b-');
	
	% Now plot the histogram of the masked region.
	% However there will likely be so few pixels that this plot will be so low and flat compared to the histogram of the entire
	% image that you probably won't be able to see it.  To get around this, let's scale it to make it higher so we can see it.
	gainFactor = 1.0;
	maxValue3 = max(max(pixelCount2));
	pixelCount3 = gainFactor * maxValue3 * pixelCount1 / max(pixelCount1);
	hold on;
	plot(edges, pixelCount3, 'r-');
	title(caption, 'FontSize', fontSize);
	
	% Scale x axis manually.
	xlim([0 edges(end)]);
	legend('Entire', 'Masked');
	
catch ME
	errorMessage = sprintf('Error running PlotHistogram:\n\n\nThe error message is:\n%s', ...
		ME.message);
	WarnUser(errorMessage);
end
return; % from PlotHistogram

%=====================================================================
% Shows vertical lines going up from the X axis to the curve on the plot.
function lineHandle = PlaceVerticalBarOnPlot(handleToPlot, x, lineColor)
	try
		% If the plot is visible, plot the line.
		if get(handleToPlot, 'visible')
			axes(handleToPlot);  % makes existing axes handles.axesPlot the current axes.
			% Make sure x location is in the valid range along the horizontal X axis.
			XRange = get(handleToPlot, 'XLim');
			maxXValue = XRange(2);
			if x > maxXValue
				x = maxXValue;
			end
			% Erase the old line.
			%hOldBar=findobj('type', 'hggroup');
			%delete(hOldBar);
			% Draw a vertical line at the X location.
			hold on;
			yLimits = ylim;
			lineHandle = line([x x], [yLimits(1) yLimits(2)], 'Color', lineColor, 'LineWidth', 3);
			hold off;
		end
	catch ME
		errorMessage = sprintf('Error running PlaceVerticalBarOnPlot:\n\n\nThe error message is:\n%s', ...
			ME.message);
		WarnUser(errorMessage);
end
	return;	% End of PlaceVerticalBarOnPlot


