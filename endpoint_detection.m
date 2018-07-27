function [SF,y,amp] = endpoint_detection(x,wlen,inc,IS,fn)
%�˵��⺯����������wav�ļ����д���,SF��ʾ��ʾÿһ֡�Ƿ���˵��,amp��ʾÿһ֡��������y��ʾ���е����
x = x(:);
fs = 16000;
NIS = fix((IS * fs - wlen)/inc + 1); %����NISǰ������״̬֡��
FrameLen = hanning(wlen);     % ����������          
y = enframe( x, FrameLen, inc);
amp = sum(y.^2,2); %��ʱƽ������ 237*1
ampth = mean(amp(1:NIS));
%������������
amplimit = 2 * ampth;
SF = zeros(fn,1);
for i=1:fn
    if amp(i)>amplimit
        SF(i) = 1;
    end
end


