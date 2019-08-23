function Cargar_val
    %%para leer despues los valores
[A]=importdata('Temp.dat'); %%SHT31

[B]=importdata('Humi.dat'); %%SHT31

[C]=importdata('Temp1.dat'); %%SHT21

[D]=importdata('Humi1.dat'); %%SHT21

[E]=importdata('Temp2.dat'); %%BME280

[F]=importdata('Humi2.dat'); %%BME280

[G]=importdata('Pres2.dat'); %%BME280


%%%%%%% Presion diferencial %%%%%%

[H]=importdata('Voltage.dat'); %%INA Voltaje
[I]=importdata('DifP.dat'); %%INA Diferencia de presion

[IIa1INA]=importdata('DifPcFAv1INA.dat'); %%INA DdP FiltroA valor1
[IIa2INA]=importdata('DifPcFAv2INA.dat'); %%INA DdP FiltroA valor2
[IIa3INA]=importdata('DifPcFAv3INA.dat'); %%INA DdP FiltroA valor3
[IIIb1INA]=importdata('DifPcFBv1INA.dat'); %%INA DdP FiltroB valor1
[IIIb2INA]=importdata('DifPcFBv2INA.dat'); %%INA DdP FiltroB valor2
[IIIb3INA]=importdata('DifPcFBv3INA.dat'); %%INA DdP FiltroB valor3


[H1]=importdata('Voltage1.dat'); %%ADC Voltaje
[I1]=importdata('DifP1.dat'); %%ADC Diferencia de presion

[IIa1ADC]=importdata('DifPcFAv1ADC.dat'); %%ADC DdP FiltroA valor1
[IIa2ADC]=importdata('DifPcFAv2ADC.dat'); %%ADC DdP FiltroA valor2
[IIa3ADC]=importdata('DifPcFAv3ADC.dat'); %%ADC DdP FiltroA valor3
[IIIb1ADC]=importdata('DifPcFBv1ADC.dat'); %%ADC DdP FiltroB valor1
[IIIb2ADC]=importdata('DifPcFBv2ADC.dat'); %%ADC DdP FiltroB valor2
[IIIb3ADC]=importdata('DifPcFBv3ADC.dat'); %%ADC DdP FiltroB valor3


%%VELOCIDADES
[JINAa1]=importdata('VelINAa1.dat'); %%Valor v INA fA1
[JINAa2]=importdata('VelINAa2.dat'); %%Valor v INA fA2
[JINAa3]=importdata('VelINAa3.dat'); %%Valor v INA fA3
[JJINAb1]=importdata('VelINAb1.dat'); %%Valor v INA fB1
[JJINAb2]=importdata('VelINAb2.dat'); %%Valor v INA fB2
[JJINAb3]=importdata('VelINAb3.dat'); %%Valor v INA fB3


[JJJADCa1]=importdata('VelADCa1.dat'); %%Valor v ADC fA1
[JJJADCa2]=importdata('VelADCa2.dat'); %%Valor v ADC fA2
[JJJADCa3]=importdata('VelADCa3.dat'); %%Valor v ADC fA3
[JJJADCb1]=importdata('VelADCb1.dat'); %%Valor v ADC fB1
[JJJADCb2]=importdata('VelADCb2.dat'); %%Valor v ADC fB2
[JJJADCb3]=importdata('VelADCb3.dat'); %%Valor v ADC fB3

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