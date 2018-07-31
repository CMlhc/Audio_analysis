function q=doublefen(num,ninc,fd,Fnum)

%f = zeros(fd,num);
q = zeros(fd,num);%79*12
for j=1:fd
        a = Fnum(Fnum>(j-1)*ninc & Fnum<(j+1)*ninc);
        q(j,:) = a(1:num);
        %f(j,:) = z(a(1:num) / (fs/wlen));
end
end