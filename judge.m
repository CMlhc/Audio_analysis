function [SF,y] = judge(x,wlen,inc,IS,fn,fs)
x = x(:);
NIS = fix((IS * fs - wlen)/inc + 1); %计算NIS前端无声状态帧数
FrameLen = hanning(wlen);     % 给出海宁窗          
y = enframe(x,FrameLen,inc,fn);
amp = sum(y.^2,2); %短时平均能量
ampth = mean(amp(1:NIS));
%调整能量门限
amplimit = 2 * ampth;

SF = zeros(fn,1);
for i=1:fn
    if amp(i)>amplimit
        SF(i) = 1;
    end
end


