clear 
[Y,length_wav,filenum] = start();%ȡ���ļ� length_wav�ļ�����

fs = 16000;wlen = 1024;inc = 512;IS = 0.15;%ǰ0.15�룬��Ϊ������״̬
%[min_x,max_x] = figurey(length_wav,fs,x);%������һ��ͼ
fn = fix((length_wav - wlen +inc) / inc);%֡��237
%frameTime = (((1:fn)-1)*inc+wlen/2)/fs;%����ÿ֡��Ӧ��ʱ��

%Q = zeros(wlen,fn,filenum);%1024*237*6��֡���
signs = zeros(fn,filenum);%237*6
%sign = zeros(fn,1);%237�ϲ�������־
Z = zeros(wlen,fn,filenum);%1024*237*6����Ҷ�任���
w2 = wlen/2+1;%513
Fnum = (0:w2-1) * fs/wlen;%����FFT���Ƶ�ʿ̶�

for i=1:filenum
    x = Y(:,i);
    [SF,y] = judge(x,wlen,inc,IS,fn,fs);
    %Q(:,:,i) = y';%y'1024*237
    signs(:,i) = SF;
    z = fft(y');%����Ҷ�任 zΪ1024*237
    Z(:,:,i) = z;
end
sign = (sum(signs,2)==6);
%addline(fn,SF,min_x,max_x);%������

d = 0.0435;
distant = dis(d);
time = -distant./340;%360 * 6
w = (2 * pi * Fnum)';%513����Ƶ��
%new = zeros(w2,filenum,360,fn);
clear i
% ÿ֡����360������
P = zeros(360,fn);
PMAX = zeros(fn,1);
e = zeros(filenum,filenum);
axis([1 250 0 360]);
for a=1:fn %237��֡
    old = Z(1:w2,a,:);
    old = squeeze(old);%ȥ���м䳤��Ϊ1���Ǹ�ά 513 * 6
    aa = old ./ abs(old);
    for b=1:360 %360������
        tau = w * time(b,:);%513 * 6 w��t
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

