%1ro CORRER ESTO
%2do ABRIR SIMULINK Y CORRER   D1_simuprueba.slx 
%3ro VOLVER A CORRER ESTE PROGRAMA
%%%%D1_simuprueba 

% %usar solo con datos generados por PUTTY
[ALL]=importdata('Corriente_7_putty.csv'); %%valor de muestras

[B]=str2double(ALL.textdata(:,1)); %temp
[C]=str2double(ALL.textdata(:,2));%hum
%[D1]=ALL.textdata(:,3); %Presion->class "cell"
%[D2]=cell2mat(D1(:,1));%Presion->class "char"
[D]=(ALL.data(:,1))/10; %Den
[E]=(ALL.data(:,2))/100; %Vol
[F]=ALL.data(:,3); %DP
[G]=ALL.data(:,4); %DdPc/filtro
[H]=ALL.data(:,5); %DdPc/filtro
[I]=ALL.data(:,6); %DdPc/filtroM
[J]=ALL.data(:,7); %v-presionSF21
[K]=ALL.data(:,8); %v-ADCFilterM1
[L]=ALL.data(:,9); %v-presionCF21
[M]=ALL.data(:,10); %v-S21
[T]=ALL.data(:,11); %Tiempo
[O]=ALL.data(:,12);% pwm
[O2]=(ALL.data(:,12))/45;% pwm
[P]=ALL.data(:,13);%parada
T=T/1000;
% 
% %plot(T,O2,'b:',T,K,'g')
% %ylim([0 15]);


%%%%%%%%INICIO ESTIMACIÓN DE PLANTA
% %%2º orden estándar con retardo.
% %%https://rua.ua.es/dspace/bitstream/10045/18965/1/Identificacion%20experimental%20de%20sistemas.pdf
% %%pág14
DQ=0.023;%  sobreoscilacion
tpQ=3.7; % tiempo pico
Dy=1.62; %
Du=121; % 
TQ=0.22; %retardo puro
% DQ=input('Ingresa sobreoscilacion ej 0.023: ');%0.023;%  sobreoscilacion
% tpQ=input('Ingresa tiempo pico ej 3,7: ');%3,7; % tiempo pico
% Dy=input('Ingresa Dy ej 1.62: ');%1.62; %
% Du=input('Ingresa Du ej 121: ');%121; %
% TQ=input('Ingresa Retardo ej0.22: ');%0.22
kQ=Dy/Du;
syms eQ wQ;
ecA=((-eQ*pi)/sqrt(1-eQ^2))-log(DQ)== 0;
eQ= vpa(solve(ecA,eQ)); %valor epsilon
e1=double(eQ);
ecB=(pi/(wQ*(sqrt(1-eQ^2))))-tpQ==0;
wQ= vpa(solve(ecB,wQ)); %valor ohmega

w1=double(wQ);
s=tf('s');
Q=tf((kQ*(w1)^2)/(s^2+2*e1*s+(w1)^2)*exp(-TQ*s));
Q_apro=pade(Q,1); %muestra la tf en forma de polinomio
[nQ,dQ] = tfdata(Q_apro,'v');


%%%%%Parámetros de Strejc con retardo
%%%%%(https://rua.ua.es/dspace/bitstream/10045/18965/1/Identificacion%20experimental%20de%20sistemas.pdf)
%%%%%pag 9.
%tu=input('Ingresa tu (Strejc) ej 1.19: ');%1.19; %modificar
%ta=input('Ingresa ta (Strejc) ej 1.89: ');%1.89; %modificar
tu=1.19; %modificar
ta=1.89; %modificar
tu1=tu/2;
TS=tu1;
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
%%%%%%%%FIN ESTIMACIÓN DE PLANTA


%PROBAR ESTO DE SIMULINK

open_system('D1_simuprueba');
set_param(gcs,'SimulationMode','normal');
set_param(gcs,'SimulationCommand','start');
pause(1.5);

%me falta ver que onda esto
a1=408;
for i=a1:1:2500+a1;
    A11(i-407,1)=K(i,1);
    T11(i-407,1)=T(i,1);
    O22(i-407,1)=O2(i,1);
end

%esto es para tomar los valores del simulink!
[A1]=ScopeData1.time;
[B1]=ScopeData1.signals(:,1).values; %S1
[C1]=ScopeData1.signals(:,2).values; %Q
[D1]=ScopeData1.signals(:,3).values; %PWM
figure(3)
plot(A1,B1,A1,C1,A1,D1,T11,A11-5)