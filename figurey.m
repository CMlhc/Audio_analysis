function [min_x,max_x] = figurey(length_wav,fs,x)
time = (0:length_wav-1)/fs;%音频时间
plot(time,x);
fighty = get(gca,'Ylim');
%图像y轴最小，最大值
min_x = fighty(1);max_x = fighty(2);
end