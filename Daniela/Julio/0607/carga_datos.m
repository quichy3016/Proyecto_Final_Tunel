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
[L]=ALL(:,13);  %pwm f
[M]=ALL(:,14);  %control
[T]=ALL(:,15); %v ref
[O]=ALL(:,16); %error


figure(1)
plot(K,J,'k',K,T,'b');%v c/f. + v ref

grid on
grid minor