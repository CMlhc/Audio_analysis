%路程差的计算
function [distant] = dis(d)
data = zeros(360,6);
for i = 1:6
    for j = 1:360
        data(j, i) = cos(abs((pi/6+(i-1)*pi/3)-j*pi/180))*d;
    end
end
distant = data;
end