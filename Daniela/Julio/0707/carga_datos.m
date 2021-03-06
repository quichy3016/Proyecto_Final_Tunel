%% CARGA DE DATOS
[ALL]=csvread('Prueba_1.csv'); %%valor de muestras
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
% %plot(K,T,'b',K,I,'r',K,J,'k');%v c/f. + v ref +v s/f.
% plot(K,T,'r',K,J,'b');%v c/f  + v ref. 
% xlim([50 320])
% %xlim([30 120])
% xlabel('tiempo [s]') 
% ylabel('velocidad [m/s]') 
% legend({'velocidad de referencia','velocidad medida'},'Location','southwest')

   plot(K,G,'m',K,H,'k');%,T,IIa2ADC,'k-x');%,T,IIa3ADC,'r-x'); 
  %  ylim([0 100]);
    xlim([100 220]);
    title('Filtro mediana','FontSize',14);
xlabel('tiempo [s]','FontSize',14) 
ylabel('diferencia de presi�n [Pa]','FontSize',14) 
legend({'Sin filtro','Filtro de mediana'},'FontSize',14,'Location','southwest')


grid on
grid minor