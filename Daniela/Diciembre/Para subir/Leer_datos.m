clear;
%% Variables para modficiar
name= "Ejemplo3.csv"; %"Ejemplo2.csv" "Ejemplo1.csv"
[ALL]=table2array(readtable(name));
of=1;  %N° de muestra dónde se comienza a tomar los datos.
fin=length(ALL); %Defecto: length(ALL); N° de muestra dónde deja de tomar los datos.
%Recordar que cada muestra es tomada cada 50ms, se observa en la columna
%"Tiempo" el tiempo transcurrido en ms desde el comienzo del puerto serie,
%y en "TiempoRel" el relativo luego de guardar cada archivo.
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

for k=1:1:fin-of+1
    if (L(k,1)==1)    
        if (J(k,1)==1) %Control encendido
            if con<1 %valor previo al cambio de valor del control
             G(k,1)=G(k+1,1); %vel Ref
             con=con+1;
            else
            G(k,1)=G(k,1); %vel Ref
            end
        else %control apagado
            G(k,1)=0.4*G(k+1,1)-0.8;
            con=0;
        end
    else %motor apagado y control apagado
    G(k,1)=0; 
    end
    
end
 %% Gráfico
figure(1)
plot(T,G,'k',T,H,'b',T,J,'--r');%v ref + v
%plot(T,G,'k',T,H,'b',T,J,'--r',T,F,':r');%v ref + v+ control + DdP
title("Velocidad",'FontSize',14); %Título
xlabel('tiempo [s]','FontSize',14)  %Título del eje x
ylabel('velocidad [m/s]','FontSize',14) %Título del eje y
%ylim([0 100]); %Límites eje y
%xlim([0 220]); %Límites eje x
dim = [0.15 0.5 0.1 0.2]; %ubicación del texto auxiliar
str = {'Si el control está apagado:','    se estima la v de ref'}; % texto auxiliar
annotation('textbox',dim,'String',str,'FitBoxToText','on'); % texto auxiliar
legend({'velocidad ref','velocidad','control'},'Location','northwest','FontSize',12) %Referencias