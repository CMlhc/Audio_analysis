function [SF,y] = judge(x,wlen,inc,IS,fn,fs)
x = x(:);
NIS = fix((IS * fs - wlen)/inc + 1); %����NISǰ������״̬֡��
FrameLen = hanning(wlen);     % ����������          
y = enframe(x,FrameLen,inc,fn);
amp = sum(y.^2,2); %��ʱƽ������
ampth = mean(amp(1:NIS));
%������������
amplimit = 2 * ampth;

SF = zeros(fn,1);
for i=1:fn
    if amp(i)>amplimit
        SF(i) = 1;
    end
end


