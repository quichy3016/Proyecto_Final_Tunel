function cargar_1303
%%para leer despues los valores
[A]=importdata('Temp.dat'); %%SHT31
[B]=importdata('Humi.dat'); %%SHT31

[C]=importdata('Temp1.dat'); %%SHT21
[D]=importdata('Humi1.dat'); %%SHT21

[E]=importdata('Temp2.dat'); %%BME280
[F]=importdata('Humi2.dat'); %%BME280
[G]=importdata('Pres2.dat'); %%BME280

%%%%%%% Presion diferencial %%%%%%

[H1]=importdata('VolADC.dat'); %%ADC Voltaje
[I1]=importdata('DifP1.dat'); %%ADC Diferencia de presion

[IIa1ADC]=importdata('DifPcFAv1ADC.dat'); %%ADC DdP fA1
[IIIb1ADC]=importdata('DifPcFBv1ADC.dat'); %%ADC DdP fB1


%%Velocidad
[JJJADC]=importdata('VelADC.dat'); %% ADC v sFiltro
[JJJADCb2]=importdata('VelADCb2.dat'); %%V ADC v fB2

[T]=importdata('Tiempo.dat'); %%vector de tiempo
[M]=importdata('Valoresmuestras.dat'); %%valor de muestras

[ALL]=[A,B,C,D,E,F,G,H1,I1,IIa1ADC,IIIb1ADC,JJJADC,JJJADCb2,T,M];

csvwrite('csvlist1.csv',ALL);


    figure(1)
    subplot(311)
    plot(T,A,'b-o',T,C,'r-^',T,E,'k-x');
    ylim([15 35]);
    title('Temperatura [°C]- o(SHT31) ^(SHT21) x(BME280)');
    
    subplot(312)
    plot(T,B,'b-o',T,D,'r-^',T,F,'k-x');
    ylim([10 60]);
    title('Humedad [%]- o(SHT31) ^(SHT21) x(BME280)');

    subplot(313)
    plot(T,G,'k-x');
    ylim([85000 110000]);
    title('Presion [kPa]- x(BME280)');

%     figure(2)
%     subplot(211)
%     plot(T,I,'^-g',T,IIa1INA,'b-x',T,IIa2INA,'k-x',T,IIa3INA,'r-x');
%     ylim([-300 300]);
%     title('Dif Presion [Pa]- INA 219// xbkr(fA123)');
% 
%     subplot(212)
%     plot(T,I,'^-g',T,IIIb1INA,'b-*',T,IIIb2INA,'k-*',T,IIIb3INA,'r-*');
%     ylim([-300 300]);
%     title('Dif Presion [Pa]- INA 219// *bkr(fB123)');

    figure (3)
    subplot(211)
    plot(T,I1,'^-g',T,IIa1ADC,'b-x');%,T,IIa2ADC,'k-x');%,T,IIa3ADC,'r-x'); 
    ylim([-300 300]);
    title('Dif Presion [Pa]- ADC// xbkr(fA123)');

    subplot(212)
    plot(T,I1,'^-g',T,IIIb1ADC,'b-*');%,T,IIIb2ADC,'k-*');%,T,IIIb3ADC),'r-*'); 
    ylim([-300 300]);
    title('Dif Presion [Pa]- ADC// *bkr(fB123)');

    figure(4)
    plot(T,JJJADC,'o',T,JJJADCb2,'x');
    ylim([0 25]);
    title('Velocidad de aire [m/s] o(sF) x(fB2ADC)');

    figure(5)
    plot(T,I1,'^-g',T,I,'*-b');
     ylim([-300 300]);
    title('Dif Presion [Pa]- ADC ^g -INA b*');


end