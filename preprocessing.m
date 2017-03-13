
%Close all figures opened.
close all;

% Read the image into the matrix
img = imread('H02.bmp');

% Convert the 3 D image into GrayScale format ie 2D format. 
grayImage = rgb2gray(img);

% Image before adjusting and its histogram.
figure , imshow(grayImage);
figure ,imhist(grayImage);

% Image after adjusting intensity amd its histogram.
adj_image = imadjust(grayImage);
figure , imshow(adj_image);
figure, imhist(adj_image);

% Calculate Character Stroke width.
M = CalcStrokeWidth(adj_image);

% Closing of image
se = strel('square',2*M+1);
im2= imclose(adj_image, se);
figure,imshow(im2);

% Subtract image to get contrast image
C = imsubtract(im2,adj_image);

% Save contrast image.
imwrite(C, 'contrastImage02.bmp');
figure,imshow(C);
