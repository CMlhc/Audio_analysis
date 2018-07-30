function addline(fn,SF,min_x,max_x)
flag = 0;
for i=1:fn
    if SF(i) == 0 && flag == 0
        flag = 1;
        middle = (i-1) * inc / fs;
        line([middle,middle],[min_x,max_x],'color','r');
    elseif SF(i) == 1 && flag == 1
        flag = 0;
        middle = (i-1) * inc / fs;
        line([middle,middle],[min_x,max_x],'color','r');
    end
end    
end