%usar solo con datos generados por processing

[ALL]=csvread('Corriente_escalon3.csv'); %%valor de muestras
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

plot(T,O2,'b:',T,M,'r',T,K,'g',T,L,'y')
ylim([0 15]);
