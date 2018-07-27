function [SF,y,amp] = endpoint_detection(x,wlen,inc,IS,fn)
%端点检测函数，对整个wav文件进行处理,SF表示表示每一帧是否是说话,amp表示每一帧的能量，y表示所有的情况
x = x(:);
fs = 16000;
NIS = fix((IS * fs - wlen)/inc + 1); %计算NIS前端无声状态帧数
FrameLen = hanning(wlen);     % 给出海宁窗          
y = enframe( x, FrameLen, inc);
amp = sum(y.^2,2); %短时平均能量 237*1
ampth = mean(amp(1:NIS));
%调整能量门限
amplimit = 2 * ampth;
SF = zeros(fn,1);
for i=1:fn
    if amp(i)>amplimit
        SF(i) = 1;
    end
end


