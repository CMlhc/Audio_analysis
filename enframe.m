function f=enframe(x,win,inc,fn)
%把语音信号按帧长和帧移进行分帧
nwin=length(win);           % 取窗长
if (nwin == 1)              % 判断窗长是否为1，若为1，即表示没有设窗函数
   len = win;               % 是，帧长=win
else
   len = nwin;              % 否，帧长=窗长
end
if (nargin < 3)             % 如果只有两个参数，设帧inc=帧长
   inc = len;
end

%f = zeros(fn,len);            % 初始化
indf= inc*(0:(fn-1))';     % 设置每帧在x中的位移量位置
inds = (1:len);             % 每帧数据对应1:len
f = x(indf(:,ones(1,len))+inds(ones(fn,1),:));   % 对数据分帧237*1024
if (nwin > 1)               % 若参数中包括窗函数，把每帧乘以窗函数
    w = win(:)';            % 把win转成行数据
    f = f .* w(ones(fn,1),:);  % 乘窗函数
end
