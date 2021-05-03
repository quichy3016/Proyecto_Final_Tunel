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

%[ALL1]=[B,C,D,E,F,G,H,I,J,K,L,M,T,O,P];
%csvwrite('Corriente7_matlab.csv',ALL1);