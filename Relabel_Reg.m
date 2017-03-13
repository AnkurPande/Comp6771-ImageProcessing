function [Num,Imean,Istd] = Relabel_Reg(I,C,a,b,T1)
% This function relabel the near text pixel in the image
% C is the contrast image. 
w = CalcStrokeWidth(C);
Num = 0;Imean =0; Istd =0;
[m,n] =size(C);
for x = a-w: a+w 
    for y = b-w :b+w
    if(x >= 1 && x <= m && y >= 1 && y <= n)
        if(C(x,y)>=T1)
            C(x,y) = 1;
            Num = Num + 1;
        else    
            C(x,y) = 0;
        end
    end
    end
end

%Calculate the mean Imean of pixels.
sum = 0;
for x = a-w: a+w
    for y =b-w : b+w
        if(x >= 1 && x <= m && y >= 1 && y <= n)
        if(Num>0)
            sum = sum + I(x,y)*C(x,y);
        end
        end
    end
end

if(Num>0)
            Imean = sum/Num;
end

%Calculate standard deviation
temp =0; 
for x = a-w: a+w
    for y = b-w: b+w
        if(x >= 1 && x <= m && y >= 1 && y <= n)
        if(Num>0)
            std = (I(x,y)*C(x,y) - Imean)^2;
            temp = temp + std ;
        end
        end
    end
end

if(Num>0)
            c = double(temp/Num);
            Istd = sqrt(c);
end




