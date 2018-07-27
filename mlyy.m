clear;
Y = []; %整个波长的信号 122129*6

%读取所有wav文件进入Y矩阵
folder = 'E:\Workplace\mlyy\static\';
diroutput = dir([folder,'*.wav']);
filenum = length(diroutput); %filenum=6
for i=1:filenum
    filename = [folder,diroutput(i).name];
    [x] = audioread(filename);
    Y = [Y x];
end




%对图像进行分帧处理
wlen = 1024;
inc = 512;
fs=16000;
h = enframe(x,wlen,inc);%取最后一个的分帧
fn = size(h,1);%帧数
Q = zeros(wlen,fn,6);%1024*237*6
IS = 0.3;

%对wav文件进行取一半处理
W2 = wlen/2; %W2=512
n2 = 1:W2;


signs=[];%6个区间集合，判断是否是说话还是静音，1为说话，0为静音
for i=1:filenum
    x = Y(:,i); %122129*1
    [SF,y,amp] = endpoint_detection(x,wlen,inc,IS,fn,fs);
    Q(:,:,i) = y';
    signs = [signs SF];
    z = fft(y');%傅里叶变换 Z为1024*237
    Q_fft(:,:,i) = z;
end

% Mic7.wav的分帧图像
figure(1);
fs = 16000;
time = (0:length(x)-1)/fs;
plot(time,x);
y = get(gca,'Ylim');
min_x = y(1);
max_x = y(2);
title('Mic7.wav的分帧图像');

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



%Mic7.wav的第一帧傅里叶变换图像
z=Q_fft(:,:,6);
figure(2);
ayy = abs(z(:,1));
F = (0:W2-1) * fs/wlen;
plot(F,ayy(1:W2));
title('Mic7.wav的第一帧傅里叶变换图像');











