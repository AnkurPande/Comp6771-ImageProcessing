%Close all figures.
close all;

%Read the contrast Image
C = imread('contrastImage02.bmp');

%Calculate the histogram and store it into a vector.
h = imhist(C);

%Calculate the size of image.
[m,n] = size(C);

%Calculate Probablities and store it into a vector
P = h/m*n;

%Initialize the counters.
Maximum = 0; T1 = 0; T2 = 0;
Hb  = 0;
Hbw = 0;
Hw  = 0;
c  = zeros(1,256);
c1 = zeros(1,256);
c2 = zeros(1,256);

%Outer for Loop
for t1= 1 : 255
    Pb =0; Pbw = 0; Pw = 0;
    
    %Inner for loop
    for t2 = t1+1 : 256
        %Calculate cumulative sum for ist group of pixels.
        for i= 1 :t1
            Pb = Pb +P(i);
        end
        
        %Calculate cumulative sum for 2nd group of pixels.
        for i = t1 +i :t2
            Pbw = Pbw + P(i);
        end    
        
        %Calculate cumulative sum for 3rd group of pixels.
        for i = t2+1 : 256
            Pw = Pw + P(i);
        end
        
        %Calculate entropie for ist group of pixels.
        if Pb>0
            for i=1:t1
                if P(i) > 0
                    Hb = Hb + (P(i)/Pb)*log(P(i)/Pb);                      
                end
            end
        end
        Hb = -1*Hb;
        
        %Calculate entropie for 2nd group of pixels.
        if Pbw>0
            for i=t1+1:t2
                if P(i)>0
                    Hbw = Hbw + (P(i)/Pbw)*log(P(i)/Pbw);
                end
            end
        end
        Hbw = -1*Hbw;
        
        %Calculate entropie for 3rd group of pixels.
        if Pw>0
            for i=t2+1:256
                if P(i)>0
                    Hw = Hw + (P(i)/Pw)*log(P(i)/Pw);
                end
            end
        end
        Hw = -1*Hw;
        
        %total entropie of system.
        Hs = Hb + Hbw + Hw;
        
        %Threshold values
        if Hs > Maximum
            Maximum = Hs;
            T1=t1;
            T2=t2;
        end    
    end 
end

% Binarization process starts.
Image = imread('H02.bmp');
I = rgb2gray(Image);

%Calculate size of an image
[m,n] = size(I);

% Calculate Character Stroke width.
w = CalcStrokeWidth(C);
I1 = ones(size(I));

%Apply Threshold on text and non text pixels
for i = 1 : m
    for j = 1 : n
        if(C(i,j) <= T1)
           I1(i,j) = 1;
        else if(C(i,j)>= T2)
            I1(i,j) =0;     
            end    
        end
    end
end 

%Relabelling of near text pixels.
for i = 1 : m
    for j = 1 : n
        if(C(i,j)>=T1)
           [Num,Imean,Istd] = Relabel_Reg(I,C,i,j,T1);    
           if(I(i,j)< min(Imean + Istd,T2) && (Num>0))
                I(i,j) = 1;
                I1(i,j) = 1;
           else 
                I(i,j) = 0;
                I1(i,j) = 0;
           end    
        i = i + w;
        j = j + w;
        end    
    end
end    

%Save the binarized image
imwrite(I1, 'binarizedImage02.bmp');
figure,imshow(I1);