function f=enframe(x,win,inc,fn)
%�������źŰ�֡����֡�ƽ��з�֡
nwin=length(win);           % ȡ����
if (nwin == 1)              % �жϴ����Ƿ�Ϊ1����Ϊ1������ʾû���贰����
   len = win;               % �ǣ�֡��=win
else
   len = nwin;              % ��֡��=����
end
if (nargin < 3)             % ���ֻ��������������֡inc=֡��
   inc = len;
end

%f = zeros(fn,len);            % ��ʼ��
indf= inc*(0:(fn-1))';     % ����ÿ֡��x�е�λ����λ��
inds = (1:len);             % ÿ֡���ݶ�Ӧ1:len
f = x(indf(:,ones(1,len))+inds(ones(fn,1),:));   % �����ݷ�֡237*1024
if (nwin > 1)               % �������а�������������ÿ֡���Դ�����
    w = win(:)';            % ��winת��������
    f = f .* w(ones(fn,1),:);  % �˴�����
end
