%% fluctuación promediada en tiempo
%%ver teoría del libro **libro.png**

clear
pause(1);

archivo='Prueba_5.csv';
[P3]=table2array(readtable(archivo));
con=0;con1=0;
%6- 7.5- 8.5- 7.5- 7- 6 
vel1=7; vel2=8.5;
%si los valores fueran 6 o 7.5 el promeido es mayor al tener picos donde
%estos escalones estan dos veces cada uno.
%% primer valor
for i=1:size(P3)
    ref= P3(i,15);
    if  ref==vel1
        v=P3(i,11);
        con=con+1;
        K(con,1)=con;
        K(con,2)=v;
    end
end
P=mean(K(100:con,2));
for j=1:con
    Y(j,1)=P;
end    
dif(:,1)=K(100:con,2)-Y(100:con,1);
T=mean(dif(:,1));
%% segundo valor
for i=1:size(P3)
    ref2= P3(i,15);
    if  ref2==vel2
        v2=P3(i,11);
        con1=con1+1;
        K1(con1,1)=con1;
        K1(con1,2)=v2;
    end
end
P2=mean(K1(100:con1,2));
for f=1:con1
    Y2(f,1)=P2;
end    
dif2(:,1)=K1(100:con1,2)-Y2(100:con1,1);
T2=mean(dif2(:,1));
%% Graficos

figure(1)
plot(K(100:con,1),K(100:con,2),'b',K(100:con,1),Y(100:con,1),'r',K1(100:con1,1),K1(100:con1,2),'b',K1(100:con1,1),Y2(100:con1,1),'r')
xlim([100 600]);
txt1 = ['El promedio de las fluctuaciones es= ' num2str(T)];
txt2 = ['El promedio de las fluctuaciones es= ' num2str(T2)];
text(200,vel1-0.3,txt1,'FontSize',14)
text(110,vel1+(vel2-vel1)/2,archivo,'FontSize',14)
text(200,vel2-0.3,txt2,'FontSize',14)

xlabel('muestras','FontSize',14) 
ylabel('velocidad [m/s]','FontSize',14) 