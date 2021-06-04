%%[ALL]=csvread('Prueba_5_serial.csv'); %%valor de 
[ALL]=csvread('Prueba_1_serial.csv'); %%valor de 
[ALL1]=csvread('Prueba_10_Casa1.csv'); %%valor de muestras
[A]=ALL(:,11); %temp
[T]=ALL(:,15); %temp
[B]=ALL1(:,1); %temp
[C]=ALL1(:,2); %temp
[D]=ALL1(:,3); %temp
[E]=ALL1(:,4); %temp
%%[U]=ALL(:,19);

T=T/1000;

figure(1)
subplot(2,1,1)
plot(T,C,'g',T,D,'r',T,E,'b')
ylim([-3 20]);
subplot(2,1,2)
plot(T,A,'r')