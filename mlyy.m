clear;
Y = []; %�����������ź� 122129*6

%��ȡ����wav�ļ�����Y����
folder = 'E:\Workplace\mlyy\static\';
diroutput = dir([folder,'*.wav']);
filenum = length(diroutput); %filenum=6
for i=1:filenum
    filename = [folder,diroutput(i).name];
    [x] = audioread(filename);
    Y = [Y x];
end




%��ͼ����з�֡����
wlen = 1024;
inc = 512;
fs=16000;
h = enframe(x,wlen,inc);%ȡ���һ���ķ�֡
fn = size(h,1);%֡��
Q = zeros(wlen,fn,6);%1024*237*6
IS = 0.3;

%��wav�ļ�����ȡһ�봦��
W2 = wlen/2; %W2=512
n2 = 1:W2;


signs=[];%6�����伯�ϣ��ж��Ƿ���˵�����Ǿ�����1Ϊ˵����0Ϊ����
for i=1:filenum
    x = Y(:,i); %122129*1
    [SF,y,amp] = endpoint_detection(x,wlen,inc,IS,fn,fs);
    Q(:,:,i) = y';
    signs = [signs SF];
    z = fft(y');%����Ҷ�任 ZΪ1024*237
    Q_fft(:,:,i) = z;
end

% Mic7.wav�ķ�֡ͼ��
figure(1);
fs = 16000;
time = (0:length(x)-1)/fs;
plot(time,x);
y = get(gca,'Ylim');
min_x = y(1);
max_x = y(2);
title('Mic7.wav�ķ�֡ͼ��');

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



%Mic7.wav�ĵ�һ֡����Ҷ�任ͼ��
z=Q_fft(:,:,6);
figure(2);
ayy = abs(z(:,1));
F = (0:W2-1) * fs/wlen;
plot(F,ayy(1:W2));
title('Mic7.wav�ĵ�һ֡����Ҷ�任ͼ��');











