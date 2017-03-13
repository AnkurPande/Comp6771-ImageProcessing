function  fill_black_pixels(I,i,j,w)
%fill with black pixels   
[m,n] =size(I);
for x = i-w : i+w
    for y = j-w : j+w
    if(x >= 1 && x <= m && y >= 1 && y <= n)
       I(x,y)=0;
    end
    end
end
end
