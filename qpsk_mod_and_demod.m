% generating carrier signals

tb=1;
t=0:tb/100:tb;
f=1;
c1= sqrt(2/tb)*cos(2*pi*f*t);
c2= sqrt(2/tb)*sin(2*pi*f*t); 
subplot(3,2,1);    % plotting carrier signals
plot(t,c1);
subplot(3,2,2);
plot(t,c2);
grid on;

% generating message signal
N=16;
m=rand(1,N);
t1=0;
t2=tb;
subplot(3,2,3);    % plotting message signal
stem(m);
grid on;

% qpsk modulating code

for i=1:2:(N-1)
if m(i)>0.5
m(i)=1;
ms=ones(1,length(t));
else
m(i)=0;
ms= -1 * ones(1,length(t));
end
odd_sig(i,:) = c1 .* ms;

if m(i+1)>0.5
m(i+1)=1;
ms=ones(1,length(t));
else
m(i+1)=0;
ms= -1* ones(1,length(t));
end
evensig(i,:)=c1 .* ms;

qpsk=oddsig + evensig;

subplot(3,2,4); % plotting qpsk modulated signal   
plot(t,qpsk);
grid on;
hold on;

% qpsk demodulating code

t1= t1+(tb+0.01);
t2= t2+(tb+0.01);
end
hold off;
t1=0;
t2=tb;
for i=1:N-1
t=t1:tb/100:t2;
x1=sum(c1 .*qpsk);
x2=sum(c2 .*qpsk);
if (x1>0 && x2>0)
demod(i)=1;
demod(i+1)=1;
elseif (x1>0 && x2<0)
demod(i)=1;
demod(i+1)=0;
elseif (x1<0 && x2>0)
demod(i)=0;
demod(i+1)=1;
else
demod(i)=0;
demod(i+1)=0;
end
end
subplot(3,2,5);    % plotting demodulated signal
stem(demod);
grid on;
