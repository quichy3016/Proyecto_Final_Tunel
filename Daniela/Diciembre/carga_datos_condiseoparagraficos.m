%% CARGA DE DATOS

clear;
%% Variables para modficiar
%name= "Prueba_1610_1.csv";
name= "Prueba_04.csv";
of=1;  %offset de toma de datos
%% Programa
[ALL]=table2array(readtable(name));
largo=length(ALL)-of+1; %length(ALL)-of+1;
% G=zeros(largo,1);
% k=1;  
% con=0;
[AA]=ALL(of:end,1);%muestras
[A]=ALL(of:end,2); %tiempo
[B]=ALL(of:end,3); %Temperatura
[C]=ALL(of:end,4); %Humedad
[D]=ALL(of:end,5); %Presi�n
[E]=ALL(of:end,6); %densidad
[F]=ALL(of:end,7); %diferencia de presion
[G]=ALL(of:end,8); %Referencia
[H]=ALL(of:end,9); %velocidad
[I]=ALL(of:end,10); %se�al contol (pwm) 
[J]=ALL(of:end,11); %marca si el control est� encendido
[K]=ALL(of:end,12); %error de la se�al
[L]=ALL(of:end,13); %estado del motor, on/off
[M]=ALL(of:end,14); %error variador
[T]=ALL(of:end,15); %tiempo para usar desde 0.
T=A/1000;


figure(1)
plot(T,H,'r',T,G,'k');
%ylim([0 100]);
%xlim([0 220]);
%title('Fluctuaciones Temperatura','FontSize',14);
xlabel('tiempo [s]','FontSize',14) 
%ylabel('Temperatura [�C]','FontSize',14) 
%legend({'Temperatura'},'FontSize',14,'Location','southwest')

grid on
grid minor
   

