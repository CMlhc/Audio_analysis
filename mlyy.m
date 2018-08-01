clear
[Y,length_wav,filenum] = start();%ȡ���ļ� length_wav�����ļ�����

fs = 16000;wlen = 1024;inc = 512;IS = 0.15;%ǰ0.15�룬��Ϊ������״̬
fn = fix((length_wav - wlen +inc) / inc);%֡��
nwlen = 200; ninc = 100;
fd = fix((fs/2 - nwlen + ninc) / ninc);%����79

signs = zeros(fn,filenum);%fn*6
Z = zeros(wlen,fn,filenum);%1024*fn*6����Ҷ�任���
v513 = wlen/2+1;%513
Fnum = (0:v513-1) * fs/wlen;
w = (0:v513-1) * fs/wlen * 2 * pi;%����FFT���Ƶ�ʿ̶�

for i=1:filenum
    x = Y(:,i);
    [SF,y] = judge(x,wlen,inc,IS,fn,fs);
    signs(:,i) = SF;
    z = fft(y');%����Ҷ�任 zΪ1024*fn
    Z(:,:,i) = z;
end
sign = (sum(signs,2)==6);%��־����

d = 0.0435;
distant = dis(d);
time = -distant./340;%360 * 6

e=zeros(513,360,6);%��ʱ��������
for a=1:513
    for j=1:360
        for k =1:6
            e(a,j,k) = exp(w(a)*time(j,k)*1j);
        end
    end
end

M = zeros(v513,filenum,360);
for b=1:360
    M(:,:,b) = squeeze(e(:,b,:));
end

num = fix((v513*nwlen*2)/ fs);%12
u = 5;
limit = 2;

q = zeros(fd,num);%79*12 - ȡƵ��
q(:,:) = doublefen(num,ninc,fd,Fnum);
q2(:,:) = q(:,:)/(fs/wlen);%Ƶ�ʶ�Ӧ�� 79 * 12
 

ys = zeros(360,fn);

for pp=1:fn
    if sign(pp) == 1
        tic;
        zstatic = 4;%��ֵ
        g = zeros(360,1);
        Y = zeros(v513,360);
        for b=1:360
            %M2 = squeeze(e(:,b,:));%513*6
            X = squeeze(Z(1:v513,pp,:));%513*6
            G = 1 ./ abs(X);
            h = M(:,:,b);
            Y(:,b) = abs(sum(G.*X.*h,2));
        end
        for c=1:fd %fd=79
            s = q2(c,1);
            en = q2(c,12);
            s2 = q(c,:)*2*pi;
            P = trapz(s2,Y(s:en,:).^2);
            [no, angle] = max(P);
            g(angle) = g(angle) + 1;
        end
        mul = zeros(limit,1);
        count = 1;
        while count < limit
            [c,m] = max(g);
            if c > zstatic
                mul(count) = m;
                count = count + 1;
                if m-u <= 0
                    g(1:m+u) = 0;
                elseif m+u > 360
                    g(m-u:360) = 0; 
                else
                    g(m-u:m+u) = 0;
                end
                zstatic = max(c/2,zstatic);
            else
                break;
            end
        end
        figure(1);
        axis([1 fn+10 0 360]);
        if mul(1) > 0
            plot(pp,mul(1),'.');
        end
        if mul(2) > 0
            plot(pp,mul(2),'.');
        end
        hold on;
        toc;
    end
end

        
