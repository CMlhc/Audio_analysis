function [Z,z] = fft_temp(x,wlen,inc,IS,fn,filenum,Y)
%
%Z��ʾ���и���Ҷ�任�����еķ�֡��Ľ�������ض������ļ����и���Ҷ�任��ľ���1024*237*6 

for i=1:filenum
    x = Y(:,i);
    [SF,y,amp] = endpoint_detection(x,wlen,inc,IS,fn);
    Q(:,:,i) = y';
    signs(:,i) = SF;
    z = fft(y');%����Ҷ�任 ZΪ1024*237
    Z(:,:,i) = z;
end
