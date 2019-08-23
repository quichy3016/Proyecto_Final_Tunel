function prueba_ard_2208(muestras)
%close all;
%clc;
delete(instrfind({'Port'},{'COM27'}));
a=serial('com27');
set(a,'BaudRate',115200);
fopen(a);
A=fscanf(a,'%f');
s=0;

for i=1:(muestras)

    A=fscanf(a,'%f');
    Temp(i)=A(1,1);
    Humi(i)=A(2,1);
    Temp1(i)=A(3,1);
    Humi1(i)=A(4,1);
    Temp2(i)=A(5,1);
    Humi2(i)=A(6,1);
    Pres2(i)=A(7,1);
    Voltage(i)=A(8,1);
    DifP(i)=A(9,1);
    DifPcFA(i)=A(10,1);
    DifPcFB(i)=A(11,1);
    Voltage1(i)=A(12,1);
    DifP1(i)=A(13,1);
    DifPcFB1(i)=A(14,1);
    VelA(i)=A(15,1);
    VelB(i)=A(16,1);
    VelB1(i)=A(17,1);
    tiempo(i)=A(18,1);
    paro(i)=A(19,1);
    muestra(i)=i;

    if (paro(i) == 0)
        break
    end 
    
     figure(1)
     title('Diferencia de Presi�n');
     ylim([-300 300]);
     xlim([0 muestras]);
     plot(i,DifP(i),'*',i,DifPcFA(i),'x',i,DifPcFB(i),'+');
     hold on;
     drawnow
   
end

fclose(a);
delete(a);

dlmwrite('Temp.dat', Temp, 'delimiter', '\n', 'precision', '%.3f')
%[A]=importdata('Temp.dat'); %%para leer despues los valores
dlmwrite('Humi.dat', Humi, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Temp1.dat', Temp1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Humi1.dat', Humi1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Temp2.dat', Temp2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Humi2.dat', Humi2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Pres2.dat', Pres2, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Voltage.dat', Voltage, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifP.dat', DifP, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFA.dat', DifPcFA, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFB.dat', DifPcFB, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Voltage1.dat', Voltage1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifP1.dat', DifP1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('DifPcFB1.dat', DifPcFB1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VelA.dat', VelA, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VelB.dat', VelB, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('VelB1.dat', VelB1, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Tiempo.dat', tiempo, 'delimiter', '\n', 'precision', '%.3f')
dlmwrite('Valoresmuestras.dat', muestra, 'delimiter', '\n', 'precision', '%.2f')

end