function prueba_ard_2208(muestras)
delete(instrfind({'Port'},{'COM27'})); %%Modificar puerto
a=serial('com27');
set(a,'BaudRate',250000);
fopen(a);%%Inicializa puerto
A=fscanf(a,'%f');
s=0;

for i=1:(muestras)

    A=fscanf(a,'%f');
    Temp(i)=A(1,1); %SHT31
    Humi(i)=A(2,1);
    Temp1(i)=A(3,1); %SHT21
    Humi1(i)=A(4,1);
    Temp2(i)=A(5,1); %BME280
    Humi2(i)=A(6,1);
    Pres2(i)=A(7,1);
    H(i)=A(8,1); %INA Voltaje 
    I(i)=A(9,1); %INA DdP
    IIa1INA(i)=A(10,1); %DdP INA fA1
    IIa2INA(i)=A(11,1); %DdP INA fA2
    IIa3INA(i)=A(12,1); %DdP INA fA3
    IIIb1INA(i)=A(13,1); %DdP INA fB1
    IIIb2INA(i)=A(14,1); %DdP INA fB2
    IIIb3INA(i)=A(15,1); %DdP INA fB3
    H1(i)=A(16,1); %ADC Voltaje 
    I1(i)=A(17,1); %ADC DdP
    IIa1ADC(i)=A(18,1); %DdP ADC fA1
    IIa2ADC(i)=A(19,1); %DdP ADC fA2
    IIa3ADC(i)=A(20,1); %DdP ADC fA3
    IIIb1ADC(i)=A(21,1); %DdP ADC fB1
    IIIb2ADC(i)=A(22,1); %DdP ADC fB2
    IIIb3ADC(i)=A(23,1); %DdP ADC fB3
    JJJADC(i)=A(24,1); %ADC v sF
    JJJADCb2(i)=A(25,1); %ADC v fB2
    tiempo(i)=A(26,1);
    paro(i)=A(27,1);
    muestra(i)=i;

    if (paro(i) == 0)
        break
    end 
    %I1(i)
        if (rem(i,4)==0)
            figure(1)
            title('Diferencia de Presión sin filtros');
            ylim([-300 300]);
            xlim([0 muestras]);
            %plot((i),I(i),'*');%,i,I1(i),'x');
            plot(i,I1(i),'dg',i,IIa1ADC(i),'b+',i,IIa2ADC(i),'k+',i,IIa3ADC(i),'r+',i,IIIb1ADC(i),'b*',i,IIIb2ADC(i),'k*',i,IIIb3ADC(i),'r*');
            hold on;
            %I(i)
            drawnow;
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
%      title('Diferencia de Presión sin filtros');
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
end

fclose(a);
delete(a);

%%Genero los archivos .dat
dlmwrite('Temp.dat', Temp, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Humi.dat', Humi, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Temp1.dat', Temp1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Humi1.dat', Humi1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Temp2.dat', Temp2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Humi2.dat', Humi2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Pres2.dat', Pres2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VolINA.dat', H, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPINA.dat', I, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFAv1INA.dat', IIa1INA, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFAv2INA.dat', IIa2INA, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFAv3INA.dat', IIa3INA, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFBv1INA.dat', IIIb1INA, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFBv2INA.dat', IIIb2INA, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFBv3INA.dat', IIIb3INA, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VolADC.dat', H1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifP1.dat', I1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFAv1ADC.dat', IIa1ADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFAv2ADC.dat', IIa2ADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFAv3ADC.dat', IIa3ADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFBv1ADC.dat', IIIb1ADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFBv2ADC.dat', IIIb2ADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFBv3ADC.dat', IIIb3ADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VelADC.dat', JJJADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VelADCb2.dat', JJJADCb2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Tiempo.dat', tiempo, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Valoresmuestras.dat', muestra, 'delimiter', '\n', 'precision', '%.3f')

%[A]=importdata('Temp.dat'); %%para leer despues los valores (En otro archivo)
fin = 1
end