function Cargar_val
[A]=importdata('Temp.dat'); %%para leer despues los valores

[B]=importdata('Humi.dat'); %%para leer despues los valores

[C]=importdata('Temp1.dat'); %%para leer despues los valores

[D]=importdata('Humi1.dat'); %%para leer despues los valores

[E]=importdata('Temp2.dat'); %%para leer despues los valores

[F]=importdata('Humi2.dat'); %%para leer despues los valores

[G]=importdata('Pres2.dat'); %%para leer despues los valores

[H]=importdata('Voltage.dat'); %%para leer despues los valores

[I]=importdata('DifP.dat'); %%para leer despues los valores

[II]=importdata('DifPcFA.dat'); %%para leer despues los valores

[III]=importdata('DifPcFB.dat'); %%para leer despues los valores

[H1]=importdata('Voltage1.dat'); %%para leer despues los valores

[I1]=importdata('DifP1.dat'); %%para leer despues los valores

[II1]=importdata('DifPcFB1.dat'); %%para leer despues los valores

[J]=importdata('VelA.dat'); %%para leer despues los valores

[JJ]=importdata('VelB.dat'); %%para leer despues los valores

// hola ACA ESTOY EDITANDOOOOOO;
// hola ACA ESTOY EDITANDOOOOOO;
// hola ACA ESTOY EDITANDOOOOOO;


[JJJ]=importdata('VelB1.dat'); %%para leer despues los valores

[T]=importdata('Tiempo.dat'); %%para leer despues los valores

[M]=importdata('Valoresmuestras.dat'); %%para leer despues los valores

[ALL]=[A,B,C,D,E,F,G,H,I,II,III,H1,I1,II1,J,JJ,JJJ,T,M];
csvwrite('csvlist1.csv',ALL);

    figure(1)
    subplot(211) 
    plot(T,A,'o');
    ylim([10 35]);
    title('Temperatura [�C]- SHT-31');
    
    subplot(212)
    plot(T,B,'o');
    ylim([0 65]);
    title('Humedad [%] - SHT-31');
    
    figure(2)
    subplot(211) 
    plot(T,C,'o');
    ylim([10 35]);
    title('Temperatura [�C]- SHT-21');
    
    subplot(212)
    plot(T,D,'o');
    ylim([0 65]);
    title('Humedad [%]- SHT-21');
    
    figure(3)
    subplot(311) 
    plot(T,E,'o');
    ylim([10 35]);
    title('Temperatura [�C]- BME 280');
    
    subplot(312)
    plot(T,F,'o');
    ylim([0 65]);
    title('Humedad [%] - BME 280');
    
    subplot(313)
    plot(T,G,'o');
    ylim([90000 110000]);
    title('Presion [Kpa] - BME 280');
    
    figure(4)
    subplot(211) 
    plot(T,H,'o');
    ylim([0 5]);
    title('Voltaje [V]- INA 219');
    
    subplot(212)
    plot(T,I,'o',T,II,'+',T,III,'*');
    ylim([-300 300]);
    title('Dif Presion [Pa]- INA 219');
    
    figure(5)
    subplot(111)
    plot(T,J,'o',T,JJ,'x');
    ylim([0 25]);
    title('Velocidad de aire');
    

end