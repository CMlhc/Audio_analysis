function [min_x,max_x] = figurey(length_wav,fs,x)
time = (0:length_wav-1)/fs;%��Ƶʱ��
plot(time,x);
fighty = get(gca,'Ylim');
%ͼ��y����С�����ֵ
min_x = fighty(1);max_x = fighty(2);
end