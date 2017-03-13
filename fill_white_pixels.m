function  fill_white_pixels(I,i,j,w)
%Fill with white pixels
[m,n] =size(I);
for x = i-w : i+w
    for y = j-w : j+w
    if(x >= 1 && x <= m && y >= 1 && y <= n)
       I(x,y)=1;
    end 
    end
end
end

