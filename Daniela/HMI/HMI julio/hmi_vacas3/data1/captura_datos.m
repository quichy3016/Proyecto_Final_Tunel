clear;
name= "123131243.csv";
[ALL]=table2array(readtable(name));
of=20;  %offset de toma de datos
largo=length(ALL)-of+1; %length(ALL)-of+1;
G=zeros(largo,1);
k=1;  
con=0;

[AA]=ALL(of:end,1);%muestras
[A]=ALL(of:end,2); %tiempo
[B]=ALL(of:end,3); %Temperatura
[C]=ALL(of:end,4); %Humedad
[D]=ALL(of:end,5); %Presi�n
[E]=ALL(of:end,6); %densidad
[F]=ALL(of:end,7); %diferencia de presion
[H]=ALL(of:end,9); %velocidad
[I]=ALL(of:end,10); %se�al contol (pwm) 
[J]=ALL(of:end,11); %marca si el control est� encendido
[K]=ALL(of:end,12); %error de la se�al
[L]=ALL(of:end,13); %estado del motor, on/off
[M]=ALL(of:end,14); %error variador
[T]=ALL(of:end,15); %tiempo para usar desde 0.
T=T/1000;


for k=1:largo
    if (ALL(k,11)==1 && k>20)
        if con==0
             G(k,1)=0;
             con=1;
       
        else
        G(k,1)=ALL(k,8); %vel Ref
        end      
    else 
        G(k,1)=0;%si esta descativado y tengo valor de f
    end
   
 end




figure(1)
plot(T,G,'k',T,H,'b');%v ref (control prendido) + velocidad
%%xlim([0 50]);  %%ver si puedo ingresar por aca el tiempo
title("PUEDO AGREGARLO?");
xlabel('xlabel [x]') 
ylabel('ylabel [y]') 
legend({'v ref (control prendido)','velocidad'},'Location','northwest')