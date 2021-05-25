[ALL]=csvread('Prueba_8_PID.csv'); %%valor de muestras
[A]=ALL(:,11); %temp
[T]=ALL(:,15); %temp
T=T/1000;

csvwrite('vector.csv',A);