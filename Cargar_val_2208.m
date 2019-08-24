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

[IIa1INA]=importdata('DifPcFAv1INA.dat'); %%INA DdP fA1
[IIa2INA]=importdata('DifPcFAv2INA.dat'); %%INA DdP fA2
[IIa3INA]=importdata('DifPcFAv3INA.dat'); %%INA DdP fA3
[IIIb1INA]=importdata('DifPcFBv1INA.dat'); %%INA DdP fB1
[IIIb2INA]=importdata('DifPcFBv2INA.dat'); %%INA DdP fB2
[IIIb3INA]=importdata('DifPcFBv3INA.dat'); %%INA DdP fB3


[H1]=importdata('Voltage1.dat'); %%ADC Voltaje
[I1]=importdata('DifP1.dat'); %%ADC Diferencia de presion

[IIa1ADC]=importdata('DifPcFAv1ADC.dat'); %%ADC DdP fA1
[IIa2ADC]=importdata('DifPcFAv2ADC.dat'); %%ADC DdP fA2
[IIa3ADC]=importdata('DifPcFAv3ADC.dat'); %%ADC DdP fA3
[IIIb1ADC]=importdata('DifPcFBv1ADC.dat'); %%ADC DdP fB1
[IIIb2ADC]=importdata('DifPcFBv2ADC.dat'); %%ADC DdP fB2
[IIIb3ADC]=importdata('DifPcFBv3ADC.dat'); %%ADC DdP fB3


%%Velocidad
[JJJADC]=importdata('VelADC.dat'); %% ADC v sFiltro
[JJJADCb2]=importdata('VelADCb2.dat'); %%V ADC v fB2

[T]=importdata('Tiempo.dat'); %%vector de tiempo
[M]=importdata('Valoresmuestras.dat'); %%valor de muestras

[ALL]=[A,B,C,D,E,F,G,H,I,IIa1INA,IIa2INA,IIa3INA,IIIb1INA,IIIb2INA,IIIb3INA,H1,I1,IIa1ADC,IIa2ADC,IIa3ADC,IIIb1ADC,IIIb2ADC,IIIb3ADC,JJJADC,JJJADCb2,T,M];
csvwrite('csvlist1.csv',ALL);

    figure(1)
    subplot(311)
    plot(T,A,'bo',T,C,'r^',T,E,'k+');
    ylim([15 35]);
    title('Temperatura [°C]- o(SHT31) ^(SHT21) +(BME280)');
    
    %%figure(2)
    subplot(312)
    plot(T,B,'bo',T,D,'r^',T,F,'k+');
    ylim([10 60]);
    title('Humedad [%]- o(SHT31) ^(SHT21) +(BME280)');

    %%figure(3)
    subplot(313)
    plot(T,F,'k+');
    ylim([85000 110000]);
    title('Presion [kPa]- +(BME280)');

    figure(2)
    %%figure(4)
    subplot(221)
    plot(T,I,'^g',T,IIa1INA,'b+',T,IIa2INA,'k+',T,IIa3INA,'r+');
    ylim([-300 300]);
    title('Dif Presion [Pa]- INA 219// +bkr(fA123)');

    subplot(222)
    plot(T,I,'^g',T,IIIb1INA,'b*',T,IIIb2INA,'k*',T,IIIb3INA,'r*');
    ylim([-300 300]);
    title('Dif Presion [Pa]- INA 219// *bkr(fB123)');

    subplot(223)
    plot(T,I,'^g',T,IIa1ADC,'b+',T,IIa2ADC,'k+',T,IIa3ADC,'r+');
    ylim([-300 300]);
    title('Dif Presion [Pa]- ADC// +bkr(fA123)');

    subplot(224)
    plot(T,I,'^g',T,IIIb1ADC,'b*',T,IIIb2ADC,'k*',T,IIIb3ADC,'r*');
    ylim([-300 300]);
    title('Dif Presion [Pa]- ADC// *bkr(fB123)');

    figure(3)
    %%figure(5)
    plot(T,JJJADC,'o',T,JJJADCb2,'x');
    ylim([0 25]);
    title('Velocidad de aire [m/s] o(sF) x(fB2ADC)');
    

end