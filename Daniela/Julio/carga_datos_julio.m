
%% CARGA DE DATOS
[ALL]=csvread('Prueba_5.csv'); %%valor de muestras
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
[L]=ALL(:,13);  %pwm f
[M]=ALL(:,14);  %control
[T]=ALL(:,15); %v ref
[O]=ALL(:,16); %error


figure(1)
plot(K,J,'k',K,T,'b');%v c/f. + v ref

grid on
grid minor


%% DATOS DE LA PLANTA - Modificar
%Datos que se deben modificar al estimar plantas.
%Observar "ima1.png" e "ima2.png"
Dy=2.75;%4.18; %
Du=170;%300; % 
tu=1.21;%1.64; %modificar STREJC
ta=2.8;
TSS=0;

%%%datos de segundo orden
DQ=0.03;%  sobreoscilacion- 2º orden estándar con retardo
tpQ=2.5; % tiempo pico-2º orden estándar con retardo
TQ=0;%1.2; %retardo puro- 2º orden estándar con retardo
TQQ=0.5;
%--

%%%%%Parámetros de Strejc con retardo
%%%%%(https://rua.ua.es/dspace/bitstream/10045/18965/1/Identificacion%20experimental%20de%20sistemas.pdf)
%%%%%pag 9.
%%tu1=tu-TSS;
f=tu/ta;
tu1=tu;
% tu1=tu-TSS;
 %f=tu1/ta;
kS= Dy/Du;

if (0<f)&&(f<=0.104)
    n=2;
    tS1=ta/2.7;
    tS2=tu1/0.28;
elseif (0.104<f)&&(f<=0.22)
    n=3;
    tS1=ta/3.7;
    tS2=tu1/0.8;
elseif (0.22<f)&&(f<=0.32)
    n=4;    
    tS1=ta/4.46;
    tS2=tu1/1.42;
elseif (0.32<f)&&(f<=0.46)
    n=5;
    tS1=ta/5.12;
    tS2=tu1/2.1;
else
    print('error');
end
s=tf('s');
S1=(kS/(tS1*s+1)^n); %prueba con un tao
S2=(kS/(tS2*s+1)^n); %prueba con el otro tao
S1_apro=pade(S1,1); %hace la funcion con nom/den polinomios
S2_apro=pade(S2,1); 
[nS1,dS1] = tfdata(S1_apro,'v');%num y den para utilizar en Simulink
[nS2,dS2] = tfdata(S2_apro,'v');%num y den para utilizar en Simulink
%%%%%%%%FIN ESTIMACIÓN DE PLANTA
pause(1);


%%%calculo segundo orden%%%
kQ=Dy/Du;
syms eQ wQ;
ecA=((-eQ*pi)/sqrt(1-eQ^2))-log(DQ)== 0;
eQ= vpa(solve(ecA,eQ)); %valor epsilon
e1=double(eQ);
ecB=(pi/(wQ*(sqrt(1-eQ^2))))-tpQ==0;
wQ= vpa(solve(ecB,wQ)); %valor ohmega
w1=double(wQ);
s=tf('s');
Q=tf(exp(-TQ*s)*(kQ*(w1)^2)/(s^2+2*e1*w1*s+(w1)^2));
Q_apro=pade(Q,1); %muestra la tf en forma de polinomio
[nQ,dQ] = tfdata(Q_apro,'v');

%% SIMULINK Y MUESTRA DE GRAFICOS

open_system('simu_julio');
set_param(gcs,'SimulationMode','normal');
set_param(gcs,'SimulationCommand','start');
pause(2);


for i=1:1:9642;
    A11(i,1)=J(i,1); %v medida
    T11(i,1)=K(i,1); %tiempo
    O22(i,1)=L(i,1); %pwm
end
% 
%esto es para tomar los valores del simulink!
[A1]=ScopeData1.time;
[B1]=ScopeData1.signals(:,1).values; %S1
[D1]=ScopeData1.signals(:,3).values; %vref- set point
figure(3)
plot(A1,B1,'b',A1,D1,'g',T11,A11,'r')
xlim([0 650]);