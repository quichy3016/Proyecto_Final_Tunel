%usar solo con datos generados por PUTTY
%usar solo con datos generados por processing

[ALL]=csvread('Corriente_escalon4.csv'); %%valor de muestras
[A]=ALL(:,2); %temp
[B]=ALL(:,3); %hum
[C]=ALL(:,4); %pres
[D]=ALL(:,5); %densidad
[E]=ALL(:,6); %lec DdP (V)
[F]=ALL(:,7); %DdP (P)
[G]=ALL(:,8); %DdPc/filtro
[H]=ALL(:,9); %DdPc/filtro
[I]=ALL(:,10); % DdPc/filtroM
[J]=ALL(:,11); %v-presionSF21
[K]=ALL(:,12); %v-ADCFilterM1
[L]=ALL(:,13);  %v-presionCF21             
[M]=ALL(:,14);  %v-S21
[T]=ALL(:,15); %Tiempo
[O]=ALL(:,16); %PW
[O2]=((ALL(:,16))/45);% pwm
[P]=ALL(:,17); %paro
T=T/1000;

%plot(T,O2,'b:',T,M,'r',T,K,'g',T,L,'y')
plot(T,K)
ylim([0 15]);




k= 0.014049587;
T1=0.64;
ts=1.407;

U1=193;
U2=314;
V1=6.1;
% num=[k];
% den=[ts 1];
% hs=tf(num,den)

s=tf('s');
H2=(k/(ts*s+1))*exp(-T1*s);
h3=V1+H2*(U2-U1);
%figure(2)
%step(h3);

k3=0.01322314;
ta=2;
tu=0.7;
T3=0.21;
tao3=0.448430493;


H4= (k3/(1+tao3*s)^4)*exp(-T3*s);

k4=0.0133;
tao4=0.42;
T4=0.6;


H5= (k4/(1+tao4*s)^4)*exp(-T4*s);

%%%% de Segundo orden

wn=1.326098609;
epsi=0.768138662;
epsi2=0.7;
T2o=0.22;

H6=(k4*wn^2)/(s^2+2*epsi*wn*s+wn^2)


a1=40;
for i=a1:1:1334;
    A11(i-39,1)=K(i,1);
    T11(i-39,1)=T(i,1);
    O22(i-39,1)=O2(i,1);
end







[A1]=ScopeData1.time;
[B1]=ScopeData1.signals(:,1).values;
[C1]=ScopeData1.signals(:,2).values;
figure(3)
plot(A1,B1,A1,C1+2,T11,A11,T11,O22)
%plot(T11,A11,T11,O22)
