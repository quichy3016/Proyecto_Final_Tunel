function prueba_1303(muestras)
delete(instrfind({'Port'},{'COM4'})); %%Modificar puerto
a=serial('com4');
set(a,'BaudRate',250000);
fopen(a);%%Inicializa puerto
A=fscanf(a,'%f');
s=0;

for i=1:(muestras)

    A=fscanf(a,'%f');
    Temp2(i)=A(1,1); %BME280
    Humi2(i)=A(2,1);
    Pres2(i)=A(3,1);
    H1(i)=A(4,1); %ADC Voltaje 
    I1(i)=A(5,1); %ADC DdP
    IIa1ADC(i)=A(6,1); %DdP ADC fA1
    IIIb1ADC(i)=A(7,1); %DdP ADC fB1
    JJJADC(i)=A(8,1); %ADC v sF
    JJJADCb2(i)=A(9,1); %ADC v fB2
    tiempo(i)=A(10,1);
    paro(i)=A(11,1);
    muestra(i)=i;

    if (paro(i) == 0)
        break
    end 
    %I1(i)
        if (rem(i,4)==0)
            figure(1)
            title('Diferencia de Presion d(sF)- +(a2)');
            ylim([-300 300]);
            xlim([0 muestras]);
            %plot((i),I(i),'*');%,i,I1(i),'x');
            plot((i),I1(i),'g-*');
            hold on;
            %I(i)
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
%I1(i);
end

fclose(a);
delete(a);

%%Genero los archivos .dat
dlmwrite('Temp2.dat', Temp2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Humi2.dat', Humi2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Pres2.dat', Pres2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VolADC.dat', H1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifP1.dat', I1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFAv1ADC.dat', IIa1ADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFBv1ADC.dat', IIIb1ADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VelADC.dat', JJJADC, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VelADCb2.dat', JJJADCb2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Tiempo.dat', tiempo, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Valoresmuestras.dat', muestra, 'delimiter', '\n', 'precision', '%.3f')

%[A]=importdata('Temp.dat'); %%para leer despues los valores (En otro archivo)
fin = 1;
end