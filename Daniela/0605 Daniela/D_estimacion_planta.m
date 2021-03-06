%06 de Mayo 2021

%Programa para sacar la cargar datos desde processing, visualizarlos,
%cargar processing, estima la planta y da como resultado la muestra
%gr�fica.
%Simulink tiene un bloque donde se le cargaron los valores de los
%escalones.

%% CARGA DE DATOS
[ALL]=csvread('Prueba_10_17.csv'); %%valor de muestras
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
[P]=ALL(:,17); %paro Q no se utiliza aca
[R]=ALL(:,18); %humedad
[U]=ALL(:,19); %set point vref
[V]=ALL(:,20); %error
%U=round(U*60.17);
U=(U*60.17);
%U=U-52;
T=T/1000;
figure(1)
plot(T,K,'k',T,O2,':r',T,U/60.17,'m');%T,V,'b'
figure(2)
plot(T,V,'k',T,U,'r');%T,V,'b'
%ylim([0 15]);
grid on
grid minor

%% DATOS DE LA PLANTA - Modificar
%Datos que se deben modificar al estimar plantas.
%Observar "ima1.png" e "ima2.png"
% Dy=0.83;%4.18; %
% Du=50;%300; % 
Dy=4.18; %
Du=300; % 

DQ=0.03;%  sobreoscilacion- 2� orden est�ndar con retardo
tpQ=3.7; % tiempo pico-2� orden est�ndar con retardo
TQ=0;%1.2; %retardo puro- 2� orden est�ndar con retardo
TQQ=1.2;
%--

tu=1.64; %modificar STREJC
ta=1.42; %modificar STREJC
TS=0;%1.2;
TSS=1.2;

%% ESTIMACI�N DE LA PLANTA
% No modificar nada ac�
% % % %%2� orden est�ndar con retardo.
% % % %%https://rua.ua.es/dspace/bitstream/10045/18965/1/Identificacion%20experimental%20de%20sistemas.pdf
% % % %%p�g14
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
%%%%%Par�metros de Strejc con retardo
%%%%%(https://rua.ua.es/dspace/bitstream/10045/18965/1/Identificacion%20experimental%20de%20sistemas.pdf)
%%%%%pag 9.

tu1=tu-TSS;
kS= Dy/Du;
f=tu1/ta;
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
elseif (0.32<f)&&(f<=0.41)
    n=5;
    tS1=ta/5.12;
    tS2=tu1/2.1;
else
    print('error');
end
s=tf('s');
S1=(kS/(tS1*s+1)^n)*exp(-TS*s); %prueba con un tao
S2=(kS/(tS2*s+1)^n)*exp(-TS*s); %prueba con el otro tao
S1_apro=pade(S1,1); %hace la funcion con nom/den polinomios
S2_apro=pade(S2,1); 
[nS1,dS1] = tfdata(S1_apro,'v');%num y den para utilizar en Simulink
[nS2,dS2] = tfdata(S2_apro,'v');%num y den para utilizar en Simulink
%%%%%%%%FIN ESTIMACI�N DE PLANTA
pause(1);

%% SIMULINK Y MUESTRA DE GRAFICOS

open_system('D1_simuprueba');
set_param(gcs,'SimulationMode','normal');
set_param(gcs,'SimulationCommand','start');
pause(2);

a1=408;
for i=a1:1:3900+a1;
    A11(i-407,1)=K(i,1); %v medida
    T11(i-407,1)=T(i,1);
    O22(i-407,1)=O2(i,1);
end
% 
%esto es para tomar los valores del simulink!
[A1]=ScopeData1.time;
[B1]=ScopeData1.signals(:,1).values; %S1
%[C1]=ScopeData1.signals(:,2).values; %Q
[D1]=ScopeData1.signals(:,3).values; %vref- set point
figure(3)
plot(A1,B1,'b',A1,D1,'g',T11,A11,'r')%A1,C1,'k',
xlim([0 250]);
