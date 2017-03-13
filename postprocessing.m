% The post-processing of image is carried out in this script.

%First remove the salt and pepper noise by applying the opening followed by
%closing morphological opearations.
I = imread('binarizedImage02.bmp');

%structuring element of size 3*3
se = strel('square',3);

%opening operation on image
I = imopen(I,se);

%closing operation on image
I = imclose(I,se);

imshow(I);
%Save the image.
imwrite(I,'salt_pepper_removed_image.bmp');

% Now apply the shrink and swell operation on image.
I = imread('salt_pepper_removed_image.bmp');

Num1_white = 0; Num2_white = 0;

%Calculate the #white pixels in A
[m,n] = size(I);
M = CalcStrokeWidth(I);
w = M/2;
for i = 1 : m
    for j = 1 : n
        [Num1_white] = calculate_white_pixels(I,i,j,w);
        [Num2_white] = calculate_white_pixels(I,i,j,w-1);
        if(Num1_white==Num2_white)
            fill_white_pixels(I,i,j,w-1);
        else if(Num1_white ==(Num2_white +2*(n+n-2)))
            fill_black_pixels(I,i,j,w-1);
            end 
        end 
    i = i+ M;
    j = j+ M;
    end    
end
imshow(I);
imwrite(I,'final_enhanced_image.bmp');