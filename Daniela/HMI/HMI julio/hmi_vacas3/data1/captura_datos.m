clear;
name= "5555555.csv";
[ALL]=table2array(readtable(name));
of=20;  %offset de toma de datos
largo=length(ALL)-of+1; %length(ALL)-of+1;
G=zeros(largo,1);
k=1;  %%ver q falta este error........... no llega hasta el final

[AA]=ALL(of:end,1);%muestras
[A]=ALL(of:end,2); %tiempo
[B]=ALL(of:end,3); %Temperatura
[C]=ALL(of:end,4); %Humedad
[D]=ALL(of:end,5); %Presión
[E]=ALL(of:end,6); %densidad
[F]=ALL(of:end,7); %diferencia de presion
% [G]=ALL(:,8); %vel Ref o frec Referencia
[H]=ALL(of:end,9); %velocidad
[I]=ALL(of:end,10); %señal contol (pwm) 
[J]=ALL(of:end,11); %marca si el control está encendido
[K]=ALL(of:end,12); %error de la señal
[L]=ALL(of:end,13); %estado del motor, on/off
[M]=ALL(of:end,14); %error variador
[T]=ALL(of:end,15); %tiempo para usar desde 0.
T=T/1000;

for i=of: largo
    for k=1:largo
    if (ALL(i,11)==1)
        G(k,1)=ALL(i,8); %vel Ref o frec Referencia
    else 
        G(k,1)=3;
    end
   
    end
end

% 
% 
% figure(1)
% plot(T,G,'k',T,H,'b');%v ref (control prendido) + velocidad
% %%xlim([0 50]);  %%ver si puedo ingresar por aca el tiempo
% title("PUEDO AGREGARLO?");
% xlabel('xlabel [x]') 
% ylabel('ylabel [y]') 
% legend({'v ref (control prendido)','velocidad'},'Location','northwest')