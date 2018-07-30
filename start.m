function [Y,length_wav,filenum] = start()
Y = [];%122129*6
folder = 'E:\Workplace\mlyy\static\';
diroutput = dir([folder,'*.wav']);
filenum = length(diroutput);
for i=1:filenum
    filename = [folder,diroutput(i).name];
    [x] = audioread(filename);
    Y = [Y x];
end
length_wav = length(x);
end