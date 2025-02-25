clc
%两点法建立一阶系统模型
t=[0 10 20 40 60 80 100 140 180 250 300 400 500 600];
h=[0 0 0.2 0.8 2.0 3.6 5.4 8.8 11.8 14.4 16.6 18.4 19.2 19.6];
delta_u=20/100;
%求系统稳态增益 k
k=(h(end)-h(1))/delta_u;
%将系统输出化为无纲量形式
y=h/h(end);
% 用插值法求系统输出到达 0.39 和 0.63 两点处时间 t1 和 t2
% 因插值函数 inerp1 的输出样本数据不允许有重复，故此处舍去系统输出无变化时间段
t_tau=10; %输出无变化的时间
tw=t(2:end)-t_tau;
yw=y(2:end);
h1=0.39;
t1=interp1(yw,tw,h1)+t_tau;
h2=0.63;
t2=interp1(yw,tw,h2)+t_tau;
% 由 t1 和 t2 确定系统的惯性时间常数 T 和纯延迟时间 tao
T=2*(t2-t1);
tao=2*t1-t2;
% 比较两点法结果与实际系统在阶跃响应上的差异
% 两点法确立的一阶惯性加纯延迟模型 G
G=tf(k,[T,1],'inputdelay',tao);
[yG,tG]=step(G,linspace(t(1),t(end),50));
yG=yG*delta_u;
plot(t,h,'-',tG,yG,'--')
legend('实际系统','两点法所求近似系统')
