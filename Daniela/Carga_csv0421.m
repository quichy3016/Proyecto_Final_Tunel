%[ALL]=[C,D,G,H1,I1,IIIIb1ADC,JJJADC,T,PWM,Den,M];

[ALL]=importdata('nombreeee'); %%valor de muestras

[C]=ALL(:,1) %%T-SHT21
[D]=ALL(:,2) %%H-SHT21
[G]=ALL(:,3) %%P-BME280

%%%%%%% Presion diferencial %%%%%%

[H1]=ALL(:,4)
[I1]=ALL(:,5)
%ver datos  [xx]=ALL(:,x)
[IIIIb1ADC]=ALL(:,8)

%%Velocidad
[JJJADC]=ALL(:,9)

[T]=ALL(:,11)
[PWM]=ALL(:,12)
[Den]=ALL(:,13)
[M]=ALL(:,14)

figure(1)
    subplot(311)
    plot(T,C,'k-x');
    ylim([15 35]);
    title('Temperatura [°C]-^(SHT21) x(BME280)');
    
    subplot(312)
    plot(T,D,'k-x');
    ylim([10 60]);
    title('Humedad [%]-  ^(SHT21) x(BME280)');

    subplot(313)
    plot(T,G,'k-x');
    ylim([85000 110000]);
    title('Presion [kPa]- x(BME280)');

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
    title('Densidad del Aire - T (ms)');

   