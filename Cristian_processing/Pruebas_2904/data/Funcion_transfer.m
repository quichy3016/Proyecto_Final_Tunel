%usar solo con datos generados por PUTTY
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
%plot(T,O);
plot(T,O2,'b:',T,K,'g')
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
figure(2)
step(h3);

k3=0.01322314;
ta=2;
tu=0.7;
T3=0.21;
tao3=0.448430493;


H4= (k3/(1+tao3*s)^4)*exp(-T3*s);

k4=0.0133;
tao4=0.42;
T4=0.6;


H5= (k4/(1+tao4*s)^4)*exp(-T4*s)

a1=408;
for i=a1:1:2500+a1;
    A11(i-407,1)=K(i,1);
    T11(i-407,1)=T(i,1);
    O22(i-407,1)=O2(i,1);
end



[A1]=ScopeData1.time;
[B1]=ScopeData1.signals(:,1).values;
[C1]=ScopeData1.signals(:,2).values;
figure(3)
plot(A1,B1,A1,C1+2,T11,A11,T11,O22+1.5)
