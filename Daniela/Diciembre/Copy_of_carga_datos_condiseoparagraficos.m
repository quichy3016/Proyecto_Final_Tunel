%% CARGA DE DATOS

clear;
%% Variables para modficiar
name= "csvlist1.csv";
of=10;  %offset de toma de datos
fin=150;
%% Programa
[ALL]=table2array(readtable(name));
largo=length(ALL)-of+1; %length(ALL)-of+1;
G=zeros(largo,1);
k=1;  
con=0;
[AA]=ALL(of:fin,1);%muestras
[A]=ALL(of:fin,2); %tiempo
[B]=ALL(of:fin,3); %Temperatura
[C]=ALL(of:fin,4); %Humedad

[D]=ALL(of:fin,5); %Presión
[E]=ALL(of:fin,6); %densidad
[F]=ALL(of:fin,7); %diferencia de presion
    %%[G]=ALL(of:end,8); %diferencia de presion
[H]=ALL(of:fin,9); %velocidad
[I]=ALL(of:fin,10); 
[J]=ALL(of:fin,27);
AA=AA+11.2;
B=B+11.2;
D=D+11.2;

figure(1)
 %  plot(J,AA,'r-x',J,B,'b-x',J,D,'k-x',J,A,'r-o',J,E,'b-o',J,C,'k-o');%,T,IIa2ADC,'k-x');%,T,IIa3ADC,'r-x'); 
 plot(J,D,'r-x',J,C,'r-o');%,T,IIa2ADC,'k-x');%,T,IIa3ADC,'r-x'); 

   %ylim([0 100]);
  %  xlim([0 220]);
    title('Distintos sensores','FontSize',14);
xlabel('muestras','FontSize',14) 
%ylabel('visible','off');
%ylabel('Temperatura [°C]','FontSize',14) 
legend({'T.SHT21','H.SHT21'},'FontSize',12,'Location','southwest')


grid on
grid minor

% [ALL]=csvread('Prueba_011.csv'); %%valor de muestras
% [A]=ALL(:,2); %temp
% [B]=ALL(:,3); %hum1
% [C]=ALL(:,4); %hum
% [D]=ALL(:,5); %pres
% [E]=ALL(:,6); %densidad
% [F]=ALL(:,7); %lec DdP (V)  
% [G]=ALL(:,8); %DdP (P)
% [H]=ALL(:,9); %DdP c/filtro  
% [I]=ALL(:,10); %v s/filtro
% [J]=ALL(:,11); %v c/filtro
% [K]=ALL(:,12); %tiempo
% K=K/1000;
% [L]=ALL(:,13);  %pwm f
% [M]=ALL(:,14);  %control
% [T]=ALL(:,15); %v ref
% [O]=ALL(:,16); %error
% 
% 
% figure(1)
% % %plot(K,T,'b',K,I,'r',K,J,'k');%v c/f. + v ref +v s/f.
% % plot(K,T,'r',K,J,'b');%v c/f  + v ref. 
% % xlim([50 320])
% % %xlim([30 120])
% % xlabel('tiempo [s]') 
% % ylabel('velocidad [m/s]') 
% % legend({'velocidad de referencia','velocidad medida'},'Location','southwest')
% 
%    plot(K,B,'m');%,T,IIa2ADC,'k-x');%,T,IIa3ADC,'r-x'); 
%    %ylim([0 100]);
%   %  xlim([0 220]);
%     title('Fluctuaciones Temperatura','FontSize',14);
% xlabel('tiempo [s]','FontSize',14) 
% ylabel('Temperatura [C]','FontSize',14) 
% legend({'Sin filtro'},'FontSize',14,'Location','southwest')
% 
% 
% grid on
% grid minor