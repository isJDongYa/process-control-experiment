
%两点法建立二阶系统模型 
t=[0 10 20 40 60 80 100 140 180 250 300 400 500 600]; 
h=[0 0 0.2 0.8 2.0 3.6 5.4 8.8 11.8 14.4 16.6 18.4 19.2 19.6]; 
delta_u=20/100; 
%求系统稳态增益 k 
k=(h(end)-h(1))/delta_u;
%将系统输出化为无纲量形式 
y=h/h(end); 
% 用插值法求系统输出到达0.4和0.8两点处时间t1和t2 
% 因插值函数inerp1 的输出样本数据不允许有重复，故此处舍去系统输出无变化时间段 
t_tau=10;%输出无变化的时间 
tw=t(2:end)-t_tau; 
yw=y(2:end); 
h1=0.4; 
t1=interp1(yw,tw,h1)+t_tau; 
h2=0.8; 
t2=interp1(yw,tw,h2)+t_tau; 
% 由t1和t2确定系统的时间常数T和T2 
T12=(t1+t2)/2.16;%T1+T2 
T1T2=(1.74*t1/t2-0.55)*T12^2;%T1*T2 
%比较两点法所得二阶系统与实际系统在阶跃响应上的差异
%两点法确立的二阶惯性加纯延迟模型G 
G=tf(k,[T1T2 T12 1],'inputdelay',t_tau); 
[yG,tG]=step(G,linspace(t(1),t(end),50)); 
yG=yG*delta_u; 
%输入delta_u时的二阶系统输出 
% 前述两点法所得一阶系统模型G1及其阶跃响应 
G1=tf(k,[136.7 3],'inputdelay',58); 
[yG1,tG1]=step(G1,linspace(t(1),t(end),50));
yG1=yG1*delta_u; %输入delta_u时的一阶系统输出 
plot(t,h,'-',tG,yG,'--',tG1,yG1,':') 
legend('实际系统','两点法所求二阶系统','两点法所求一阶系统') 
xlabel('t(s)') 
ylabel('h(cm)')