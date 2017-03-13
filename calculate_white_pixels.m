function [Num_white] = calculate_white_pixels(I,i,j,w)
%Calculate the number of white pixels in the region.
[m,n] =size(I);
Num_white =0;
for x = i-w : i+w
    for y = j-w : j+w
        if(x >= 1 && x <= m && y >= 1 && y <= n)
            if(I(x,y)==1)
                Num_white = Num_white + 1;
            end
        end    
    end 
end



