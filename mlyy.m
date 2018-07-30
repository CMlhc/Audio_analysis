clear 
[Y,length_wav,filenum] = start();%取出文件 length_wav文件点数

fs = 16000;wlen = 1024;inc = 512;IS = 0.15;%前0.15秒，认为是无声状态
%[min_x,max_x] = figurey(length_wav,fs,x);%画出第一个图
fn = fix((length_wav - wlen +inc) / inc);%帧数237
%frameTime = (((1:fn)-1)*inc+wlen/2)/fs;%计算每帧对应的时间

%Q = zeros(wlen,fn,filenum);%1024*237*6分帧结果
signs = zeros(fn,filenum);%237*6
%sign = zeros(fn,1);%237合并到个标志
Z = zeros(wlen,fn,filenum);%1024*237*6傅里叶变换结果
w2 = wlen/2+1;%513
Fnum = (0:w2-1) * fs/wlen;%计算FFT后的频率刻度

for i=1:filenum
    x = Y(:,i);
    [SF,y] = judge(x,wlen,inc,IS,fn,fs);
    %Q(:,:,i) = y';%y'1024*237
    signs(:,i) = SF;
    z = fft(y');%傅里叶变换 z为1024*237
    Z(:,:,i) = z;
end
sign = (sum(signs,2)==6);
%addline(fn,SF,min_x,max_x);%加竖线

d = 0.0435;
distant = dis(d);
time = -distant./340;%360 * 6
w = (2 * pi * Fnum)';%513个角频率
%new = zeros(w2,filenum,360,fn);
clear i
% 每帧，有360个方向
P = zeros(360,fn);
PMAX = zeros(fn,1);
e = zeros(filenum,filenum);
axis([1 250 0 360]);
for a=1:fn %237个帧
    old = Z(1:w2,a,:);
    old = squeeze(old);%去掉中间长度为1的那个维 513 * 6
    aa = old ./ abs(old);
    for b=1:360 %360个方向
        tau = w * time(b,:);%513 * 6 wΔt
        bu = exp(i * tau);
        y2 = aa .* bu;
        s = abs(sum(y2,2)).^2;
        P(b,a) = trapz(w,s);
    end
    [h,j] = max((P(:,a)));
    if sign(a) == 1
        PMAX(a) = j;
    else
        PMAX(a) = nan;
    end
    pause(0.001);
    axis([1 237 0 360]);
    scatter(a,PMAX(a),8,'filled');
    hold on;
end
%scatter(1:fn,PMAX);

