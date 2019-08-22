function prueba_ard_2208(muestras)
%close all;
%clc;
delete(instrfind({'Port'},{'COM5'}));
a=serial('com5');
set(a,'BaudRate',115200);
fopen(a);
A=fscanf(a,'%f');
s=0;

for i=1:(muestras)
%    if(i==1)
%      out=fscanf(a);
%    end

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
    VelA(i)=A(12,1);
    VelB(i)=A(13,1);
    tiempo(i)=A(14,1);
    paro(i)=A(15,1);
    muestra(i)=i;

    if (paro(i) == 0)
        break
    end 
    
     figure(1)
     title('Diferencia de Presión');
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
%[B]=importdata('Humi.dat'); %%para leer despues los valores
dlmwrite('Temp1.dat', Temp1, 'delimiter', '\n', 'precision', '%.3f')
%[C]=importdata('Temp.dat'); %%para leer despues los valores
dlmwrite('Humi1.dat', Humi1, 'delimiter', '\n', 'precision', '%.3f')
%[D]=importdata('Humi2.dat'); %%para leer despues los valores
dlmwrite('Temp2.dat', Temp2, 'delimiter', '\n', 'precision', '%.3f')
%[E]=importdata('Temp.dat'); %%para leer despues los valores
dlmwrite('Humi2.dat', Humi2, 'delimiter', '\n', 'precision', '%.3f')
%[F]=importdata('Humi2.dat'); %%para leer despues los valores
dlmwrite('Pres2.dat', Pres2, 'delimiter', '\n', 'precision', '%.3f')
%[G]=importdata('Pres2.dat'); %%para leer despues los valores
dlmwrite('Voltage.dat', Voltage, 'delimiter', '\n', 'precision', '%.3f')
%[H]=importdata('Voltage.dat'); %%para leer despues los valores
dlmwrite('DifP.dat', DifP, 'delimiter', '\n', 'precision', '%.3f')
%[I]=importdata('DifP.dat'); %%para leer despues los valores
dlmwrite('DifPcF.dat', DifPcFA, 'delimiter', '\n', 'precision', '%.3f')
%[II]=importdata('DifPcFA.dat'); %%para leer despues los valores
dlmwrite('DifPcF.dat', DifPcFB, 'delimiter', '\n', 'precision', '%.3f')
%[III]=importdata('DifPcFB.dat'); %%para leer despues los valores
dlmwrite('VelA.dat', VelA, 'delimiter', '\n', 'precision', '%.3f')
%[J]=importdata('VelA.dat'); %%para leer despues los valores
dlmwrite('VelB.dat', VelB, 'delimiter', '\n', 'precision', '%.3f')
%[JJ]=importdata('VelB.dat'); %%para leer despues los valores
dlmwrite('Tiempo.dat', tiempo, 'delimiter', '\n', 'precision', '%.3f')
%[T]=importdata('Tiempo.dat'); %%para leer despues los valores
dlmwrite('Valoresmuestras.dat', muestra, 'delimiter', '\n', 'precision', '%.2f')
%[M]=importdata('Valoresmuestras.dat'); %%para leer despues los valores
end