%[ALL]=[C,D,E,F,G,H1,I1,IIa1ADC,IIIb1ADC,IIIIb1ADC,JJJADC,JJJADCb2,T,PWM,Den,M];

[ALL]=importdata('Prueba_6.csv'); %%valor de muestras

[C]=ALL(:,1)
[D]=ALL(:,2)

%[E]=ALL(:,3)
%[F]=ALL(:,4)
[G]=ALL(:,3)

%%%%%%% Presion diferencial %%%%%%

[H1]=ALL(:,4)
[I1]=ALL(:,5)

[IIa1ADC]=ALL(:,6)
[IIIb1ADC]=ALL(:,7)
[IIIIb1ADC]=ALL(:,8)


%%Velocidad
[JJJADC]=ALL(:,9)
[JJJADCb2]=ALL(:,10)

[T]=ALL(:,11)
[PWM]=ALL(:,12)
[Den]=ALL(:,13)
[M]=ALL(:,14)

figure(1)
    subplot(311)
    %%plot(T,A,'b-o',T,C,'r-^',T,E,'k-x');
    plot(T,C,'k-x');
    ylim([15 35]);
    title('Temperatura [°C]-^(SHT21) x(BME280)');
    
    subplot(312)
    %%plot(T,B,'b-o',T,D,'r-^',T,F,'k-x');
    plot(T,D,'k-x');
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

    figure(8)
    plot(T,JJJADC,'o',T,JJJADCb2,'x',T,PWM/10,'c',T,I1/3,'b');
    ylim([0 25]);
    title('Velocidad de aire [m/s] o(sF) x(fMedian)');