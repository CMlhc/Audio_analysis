function [Z,z] = fft_temp(x,wlen,inc,IS,fn,filenum,Y)
%
%Z表示进行傅里叶变换后所有的分帧后的结果，返回对所有文件进行傅里叶变换后的矩阵1024*237*6 

for i=1:filenum
    x = Y(:,i);
    [SF,y,amp] = endpoint_detection(x,wlen,inc,IS,fn);
    Q(:,:,i) = y';
    signs(:,i) = SF;
    z = fft(y');%傅里叶变换 Z为1024*237
    Z(:,:,i) = z;
end
