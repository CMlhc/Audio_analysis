clear
[Y,length_wav,filenum] = start();%取出文件 length_wav最后的文件点数

fs = 16000;wlen = 1024;inc = 512;IS = 0.15;%前0.15秒，认为是无声状态
fn = fix((length_wav - wlen +inc) / inc);%帧数
nwlen = 200; ninc = 100;
fd = fix((fs/2 - nwlen + ninc) / ninc);%段数79

signs = zeros(fn,filenum);%fn*6
Z = zeros(wlen,fn,filenum);%1024*fn*6傅里叶变换结果
w2 = wlen/2+1;%513
Fnum = (0:w2-1) * fs/wlen;%计算FFT后的频率刻度

for i=1:filenum
    x = Y(:,i);
    [SF,y] = judge(x,wlen,inc,IS,fn,fs);
    signs(:,i) = SF;
    z = fft(y');%傅里叶变换 z为1024*fn
    Z(:,:,i) = z;
end
sign = (sum(signs,2)==6);%标志向量

d = 0.0435;
distant = dis(d);
time = distant./340;%360 * 6
clear i

num = fix((w2*nwlen*2)/ fs);%12
zstatic =10;%阈值
uw = 15;
limit = 2;


q = zeros(fd,num);%79*12 - 取频率

q(:,:) = doublefen(num,ninc,fd,Fnum);
q(:,:) = doublefen(num,ninc,fd,Fnum);
     
ss = zeros(360,fn);
f1 = zeros(fn,fd,num,filenum);%79*12*6 - 取FFT的结果
for pp=1:fn
      for a=1:filenum
           o = Z(1:w2,pp,a);
           for b=1:fd
                f1(pp,b,:,a) = o(q(b,:)/(fs/wlen));
           end
      end 
end



for pp=1:fn
    tic;
    if sign(pp) == 1
        %ss = zeros(360,1);
        for a=1:fd %79个段数
            old = f1(pp,a,:,:);% 1*12*6
            w = q(a,:) * 2 * pi; %1*12
            old = squeeze(old);%去掉长度为1的那个维 12 * 6
            gx = old ./ abs(old);
            t = zeros(360,1);
            
            w1=w(1:6);
           
            %w1=repmat(w1,360,1);
            w2=w(7:12);
            %w2=repmat(w2,360,1);
            
            tau1=time*w1'; %360*1
            tau2=time*w2'; %360*1
            
            

%             for b=1:360 %360个方向
%                 tau =  time(b,:)'*w;%6* 12 wΔt
%                 bu = exp(i * tau);
%                 y2 = gx' .* bu;
%                 s = abs(sum(y2)).^2;
%                 t(b) = trapz(w,s);
%             end            
            

            
%             for b=1:360 %360个方向
%                 tau = w' * time(b,:);%12 * 6 wΔt
%                 bu = exp(i * tau);
%                 y2 = gx .* bu;
%                 s = abs(sum(y2,2)).^2;
%                 t(b) = trapz(w,s);
%             end

            [h,j] = max(t);
            ss(j,pp) = ss(j,pp) + 1;
        end
        count = 1;
        double = zeros(limit,1);
        c = 0;
        for b=1:360 
            if count > limit
                break
            end
            if ss(b,pp) >= zstatic && b > c
                double(count) = b;
                count = count + 1;
                %zstatic = max(ss(b,pp)/2,zstatic);
                c = b + uw;
            end
        end
        figure(1)
        axis([1 fn+10 0 360]);
        if double(1) ~= 0 
            plot(pp,double(1),'.');
        end
        if double(2) ~= 0 
            plot(pp,double(2),'*');
        end
        hold on;
    end
    toc;
end
