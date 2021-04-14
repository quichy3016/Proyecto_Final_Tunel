function cargar_220321
%%para leer despues los valores
%[A]=importdata('Temp1.dat'); %%SHT31
%[B]=importdata('Humi1.dat'); %%SHT31

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
[IIIIb1ADC]=importdata('DifPcFMv1ADC.dat'); %%ADC DdP fM


%%Velocidad
[JJJADC]=importdata('VelADC.dat'); %% ADC v sFiltro
[JJJADCb2]=importdata('VelADCb2.dat'); %%V ADC v fB2

[T]=importdata('Tiempo.dat'); %%vector de tiempo
[PWM]=importdata('PWM.dat'); %%vector de tiempo
[Den]=importdata('Den.dat'); %%vector de tiempo
[M]=importdata('Valoresmuestras.dat'); %%valor de muestras

%%[ALL]=[C,D,E,F,G,H1,I1,IIa1ADC,IIIb1ADC,IIIIb1ADC,JJJADC,JJJADCb2,T,PWM,Den,M];

%%csvwrite('csvlist1.csv',ALL);


    figure(1)
    subplot(311)
    plot(T,C,'r-^',T,E,'k-x');
    %%plot(T,E,'k-x');
    ylim([15 35]);
    title('Temperatura [°C]-^(SHT21) x(BME280)');
    
    subplot(312)
    plot(T,D,'r-^',T,F,'k-x');
    %%plot(T,F,'k-x');
    ylim([10 60]);
    title('Humedad [%]-  ^(SHT21) x(BME280)');

    subplot(313)
    plot(T,G,'k-x');
    ylim([85000 110000]);
    title('Presion [kPa]- x(BME280)');


    figure (3)
    
    plot(T,I1,'^-g',T,IIa1ADC,'b-x',T,IIIb1ADC,'r-*',T,IIIIb1ADC,'y-*');%,T,IIa2ADC,'k-x');%,T,IIa3ADC,'r-x'); 
    ylim([-300 300]);
    title('Dif Presion [Pa]- ADC// G B R Y (Y median)');

    

    figure(4)
    plot(T,JJJADC,'o',T,JJJADCb2,'x');
    ylim([0 25]);
    title('Velocidad de aire [m/s] o(sF) x(fMedian)');

    figure(5)
    plot(T,I1,'^-g');
     ylim([-300 300]);
    title('Dif Presion [Pa]- ADC ^g ');
    
    figure(6)
    plot(T,PWM,'^-k');
     ylim([0 1025]);
    title('PWM - T*');
    
    figure(7)
    plot(T,Den,'^-b');
     ylim([0 2]);
    title('Densidad del Aire - T (ms)*');


end