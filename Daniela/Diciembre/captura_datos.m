clear;
%% Variables para modficiar
name= "Prueba_1610_5.csv";
%name= "Prueba_05.csv";
[ALL]=table2array(readtable(name));
of=1500;  %offset de toma de datos
fin=2000;%length(ALL);%length(ALL);
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

for k=1:fin-of+1
    if (ALL(k,11)==1)
        if con<3
        G(k,1)=0.4*G(k,1)-0.8;
        con=con+1;
        else
        G(k,1)=ALL(k,8); %vel Ref
        end
    else
        G(k,1)=0.4*G(k,1)-0.8;
     end
end
 
% for k=1:largo
%     if (ALL(k,11)==1)
%         G(k,1)=ALL(k,8); %vel Ref
%     else
%         G(k,1)=0.4*G(k,1)-0.8;
%     end
% end



%% Gráfico
figure(1)
plot(T,G,'k',T,H,'b',T,J,'--r');%v ref + velocidad
title("Velocidad");
xlabel('tiempo [s]','FontSize',14) 
ylabel('velocidad [m/s]','FontSize',14) 
dim = [0.15 0 0.1 0.2];
str = {'Si el control está apagado:','    se estima la v de ref'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');
legend({'velocidad ref','velocidad','control'},'Location','northwest','FontSize',12)