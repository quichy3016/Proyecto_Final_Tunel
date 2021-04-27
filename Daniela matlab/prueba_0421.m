function prueba_0421(muestras)
delete(instrfind({'Port'},{'COM4'})); %%Modificar puerto
a=serial('com4');
set(a,'BaudRate',115200);
fopen(a);%%Inicializa puerto
A=fscanf(a,'%f');
s=0;

for i=1:(muestras)

    A=fscanf(a,'%f');
    Temp1(i)=A(1,1); %%SHT21
    Humi1(i)=A(2,1);%%SHT21
    Pres2(i)=A(3,1);  %BME280
    Den(i)=A(4,1);
    H1(i)= A(5,1); %ADC Voltaje 
    I1(i)= A(6,1); %ADC DdP SF
    %QUE HAY QUE CAMBIAR EN EL ARDUINO O AC¡ A(XXXXX,1)
    IIIIb1ADC(i)=A(9,1); %DdP ADC median filter
    JJJADC(i)=A(10,1); %ADC v sF
    %QUE HAY QUE CAMBIAR EN EL ARDUINO O AC¡ A(XXXXX,1)
    tiempo(i)=A(12,1);
    PWM(i)=A(13,1);
    paro(i)=A(14,1);
    muestra(i)=i;

    if (paro(i) == 0)
        break
    end 
    %I1(i)
        if (rem(i,5)==0)
            figure(1)
            title('Diferencia de Presion d(sF)- +(a2)');
            ylim([-300 300]);
            xlim([0 muestras]);
            plot((i),I1(i),'g-*');
            hold on;
            drawnow limitrate;
        end
%     subplot(211)
%     plot(i,I(i),'^g',i,IIa1INA(i),'b+',i,IIa2INA(i),'k+',i,IIa3INA(i),'r+',i,IIIb1INA(i),'b*',i,IIIb2INA(i),'k*',i,IIIb3INA(i),'r*');
%     ylim([-300 300]);
%     xlim([0 muestras]);
%     title('Dif Presion [Pa]- INA 219// +bkr(fA123) *bkr(fB123)');
%     hold on; %Esto va siempre?
%     drawnow;
%     
%     subplot(212)
%     plot(i,I1(i),'dg');%,i,IIa1ADC(i),'b+');%,i,IIa2ADC(i),'k+',i,IIa3ADC(i),'r+',i,IIIb1ADC(i),'b*',i,IIIb2ADC(i),'k*',i,IIIb3ADC(i),'r*');
%     ylim([-300 300]);
%     xlim([0 muestras]);
%     title('Dif Presion [Pa]- ADC// +bkr(fA123)  *bkr(fB123)');
%     hold on; %Esto va siempre?
%     drawnow;

%      figure(2) %Solo muestra sin filtros
%      subplot(211)
%      title('Diferencia de Presi√≥n sin filtros');
%      ylim([-300 300]);
%      xlim([0 muestras]);
%      plot(i,I(i),'*',i,I1(i),'x');
%      hold on;
%      drawnow;
% 
%      subplot(212)
%      title('Velocidad estimada');
%      ylim([-20 20]); %velocidades en valor absoluto????????????????
%      xlim([0 muestras]);
%      plot(i,JJJADC(i));
%      hold on;
%      drawnow;
%I1(i);
end

fclose(a);
delete(a);

%%Genero los archivos .dat
dlmwrite('Temp1.dat', Temp1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Humi1.dat', Humi1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Pres2.dat', Pres2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Den.dat', Den, 'delimiter', '\n', 'precision', '%.5f')
dlmwrite('VolADC.dat', H1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifP1.dat', I1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFMv1ADC.dat', IIIIb1ADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VelADC.dat', JJJADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Tiempo.dat', tiempo, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('PWM.dat', PWM, 'delimiter', '\n', 'precision', '%.1f')
dlmwrite('Valoresmuestras.dat', muestra, 'delimiter', '\n', 'precision', '%.3f')

%[A]=importdata('Temp.dat'); %%para leer despues los valores (En otro archivo)
fin = 1;
end