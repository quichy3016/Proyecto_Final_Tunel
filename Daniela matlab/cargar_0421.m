function cargar_0421
%%para leer despues los valores
[C]=importdata('Temp1.dat'); %%T-SHT21
[D]=importdata('Humi1.dat'); %%H-SHT21

[G]=importdata('Pres2.dat'); %%P-BME280

%%%%%%% Presion diferencial %%%%%%
[H1]=importdata('VolADC.dat'); %%ADC Voltaje
[I1]=importdata('DifP1.dat'); %%ADC Diferencia de presion

[IIIIb1ADC]=importdata('DifPcFMv1ADC.dat'); %%ADC DdP fM     %TIENE EL MISMO ARCHIVOOO


%%Velocidad
[JJJADC]=importdata('VelADC.dat'); %% ADC v sFiltro

[T]=importdata('Tiempo.dat'); %%vector de tiempo
[PWM]=importdata('PWM.dat'); %%vector de tiempo
[Den]=importdata('Den.dat'); %%vector de tiempo
[M]=importdata('Valoresmuestras.dat'); %%valor de muestras

[ALL]=[C,D,G,H1,I1,IIIIb1ADC,JJJADC,T,PWM,Den,M]; %ESTE ESTÁ MODIFICADO
csvwrite('nombreeee',ALL);

    figure(1)
    subplot(311)
    plot(T,C,'r-^');%SHT21
    ylim([15 35]);
    title('Temperatura [°C]-SHT21');
    
    subplot(312)
    plot(T,D,'r-^'); %SHT21
    ylim([10 60]);
    title('Humedad [%]-SHT21');

    subplot(313)
    plot(T,G,'k-x');
    ylim([85000 110000]);%BME280
    title('Presion [kPa]-BME280');

    figure (3)
    plot(T,I1,'^-g',T,IIIIb1ADC,'r-*'); 
    ylim([-300 300]);
    title('Dif Presion [Pa]- gADC - r(median)');

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