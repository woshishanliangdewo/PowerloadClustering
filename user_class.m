clear
n = 10;%产生的样本数量
z = 0.2;%随机数的衰减值，可在此决定整个轮廓离散程度，z越大轮廓越大
shift = shift(n);%生成1行n列的只含0(40%),1(30%),-1(30%)的向量
 a = 1:1:96;
 d = [];
%rand(m,n) 生成m行n列 (0,1)的随机数
for i = 1:n
    %0am-5am; 时长5小时，每15分钟取样，共20个点; 此时跨度为 0.1; 故步长(下记为deta)0.1/20=0.005记为如下
    %0-5 0.1/20=0.005
    x1 = (0.7+0.005):0.005:0.8;%0.8-0.7 = 0.1
    r1 = z*(rand(1,20)*2-1);
    x1 = x1 + r1;
    x1 = flip(x1);%赋值时递增幅值，此处反转，表示折线递减，下同
    %5-9 0.25/16
    deta = 0.25/16;
    x2 = (0.7+deta):deta:0.95;%0.95-0.7 = 0.25
    r2 = z*(rand(1,16)*2-1);
    x2 = x2 + r2;
    %9-12 0.12/12
    deta = 0.12/12;
    x3 = (0.83+deta):deta:0.95;%0.95-0.83 = 0.12
    r3 = z*(rand(1,12)*2-1);
    x3 = x3 + r3;
    x3 = flip(x3);
    %12-14
    deta = 0.08/8;
    x4 = (0.83+deta):deta:0.91;%0.91-0.83 = 0.08
    r4 = z*(rand(1,8)*2-1);
    x4= x4 + r4;
    %14-24
    deta = 0.1/40;
    x5 = (0.81+deta):deta:0.91;%0.91-0.81 = 0.1
    r5 = z*(rand(1,40)*2-1);
    x5 = x5 + r5;
    x5 = flip(x5);
    %汇总
    x = [x1,x2,x3,x4,x5];
    x = circle_shift(x,shift(i));
    b(2*i - 1,:)=a;
    b(2*i,:) = x;
    xn(i,:) = x;%(i,:)指第i行全部数值
    d = [d;a'];
end
b = b';
y2 = xn';
y2 = reshape(y2,96*n,1);
e = mean(xn);
figure(3)
plot(e);
axis([0 96 0 1.2])

%绘制样本点
for i= 1:n%可在此处指定第i条曲线
    figure(1)
    plot(xn(i,:))%加's'隐藏折线，不加's'显示折线
    axis([0 96 0 1.2])
    set(gcf,'color','white');
    hold on
end
