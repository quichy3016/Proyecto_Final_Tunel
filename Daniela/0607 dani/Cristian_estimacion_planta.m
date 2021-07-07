%% CARGA DE DATOS
[ALL]=csvread('Prueba_6.csv'); %%valor de muestras
[A]=ALL(:,2); %temp
[B]=ALL(:,3); %hum1
[C]=ALL(:,4); %hum
[D]=ALL(:,5); %pres
[E]=ALL(:,6); %densidad
[F]=ALL(:,7); %lec DdP (V)  
[G]=ALL(:,8); %DdP (P)
[H]=ALL(:,9); %DdP c/filtro  
[I]=ALL(:,10); %v s/filtro
[J]=ALL(:,11); %v c/filtro
[K]=ALL(:,12); %tiempo
K=K/1000;
[L]=ALL(:,13);  %pwm 
[M]=ALL(:,14);  %control
[T]=ALL(:,15); %v ref
[O]=ALL(:,16); %error


figure(1)
plot(K,J,'k',K,T,'b');%v c/f. + v ref

grid on
grid minor


%%%calculo planta S
%%valores
dy=2.75;
du=170;
n=5;
kS=dy/du;
kQ=kS;
tS1=0.55;
%%cuentas
s=tf('s');
S1=(kS/(tS1*s+1)^n)
S1_apro=pade(S1,1); %hace la funcion con nom/den polinomios
[nS1,dS1] = tfdata(S1_apro,'v');%num y den para utilizar en Simulink

%%%datos de segundo orden
DQ=0.03;%  sobreoscilacion- 2º orden estándar con retardo
tpQ=3.8; % tiempo pico-2º orden estándar con retardo
TQ=0;%1.2; %retardo puro- 2º orden estándar con retardo
TQQ=2;
%--

syms eQ wQ;
ecA=((-eQ*pi)/sqrt(1-eQ^2))-log(DQ)== 0;
eQ= vpa(solve(ecA,eQ)); %valor epsilon
e1=double(eQ);
ecB=(pi/(wQ*(sqrt(1-eQ^2))))-tpQ==0;
wQ= vpa(solve(ecB,wQ)); %valor ohmega
w1=double(wQ);
Q=tf((kQ*(w1)^2)/(s^2+2*e1*w1*s+(w1)^2));
Q_apro=pade(Q,1); %muestra la tf en forma de polinomio
[nQ,dQ] = tfdata(Q_apro,'v');



%%graficos

[A1]=ScopeData.time;
[B1]=ScopeData.signals(:,1).values; %S1
[D1]=ScopeData.signals(:,3).values; %vref- set point
figure(3)
plot(A1,B1,'b',A1,D1,'g',K,J,'r')
xlim([0 250]);