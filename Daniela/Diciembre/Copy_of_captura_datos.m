clear;
%% Variables para modficiar
%name= "Ejemplo1.csv";
name= "Prueba_04.csv";
[ALL]=table2array(readtable(name));
of=1000;  %offset de toma de datos
fin=length(ALL);%length(ALL);
%% Programa
con=0;


[AA]=ALL(of:fin,1);%muestras
[A]=ALL(of:fin,2); %tiempo
[B]=ALL(of:fin,3); %Temperatura
[C]=ALL(of:fin,4); %Humedad
[D]=ALL(of:fin,5); %Presión
[E]=ALL(of:fin,6); %densidad del aire
[F]=ALL(of:fin,7); %diferencia de presion
[G]=ALL(of:fin,8); %velocidad de ref/f de ref
[H]=ALL(of:fin,9); %velocidad
[I]=ALL(of:fin,10); %señal contol (pwm) 
[J]=ALL(of:fin,11); %marca si el control está encendido
[K]=ALL(of:fin,12); %error de la señal
[L]=ALL(of:fin,13); %estado del motor, on/off
[M]=ALL(of:fin,14); %error variador
[T]=ALL(of:fin,15); %tiempo para usar desde 0.
T=T/1000; %Tiempo en segundos
disp('HOLA')
x=length(AA);


% for k=of:x-of
%     if L(k,1)==1    %motor encendido
%         if J(k,1)==1 %Control encendido
%             if con<1 %valor previo al cambio de valor del control
%              G(k,1)=ALL(k+1,8); %vel Ref
%              con=con+1;
%              disp('estoy1')
%             else
%             G(k,1)=ALL(k,8); %vel Ref
%             disp('estoy2')
%             end
%         else %control apagado
%             %G(k,1)=10
%            G(k,1)=0.4*G(k,1)-0.8;
%            disp('estoy3')
%         end
%     else %motor apagado y control apagado
%     G(k,1)=0;    
%     end
% 
% end
%  k=k+1;

%% Gráfico
figure(1)
plot(T,G,'k',T,H,'b',T,J,'--r');%v ref + velocidad
%plot(T,G,'k',T,H,'b',T,J,'--r',T,F,':r');%v ref + velocidad+ control + dif
%de presión
title("Velocidad");
xlabel('tiempo [s]','FontSize',14) 
ylabel('velocidad [m/s]','FontSize',14) 

%ylim([0 100]);
%xlim([0 220]);

dim = [0.15 0.5 0.1 0.2];
str = {'Si el control está apagado:','    se estima la v de ref'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
legend({'velocidad ref','velocidad','control'},'Location','northwest','FontSize',12)