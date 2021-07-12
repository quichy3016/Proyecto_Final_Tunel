%% fluctuación promediada en tiempo
%%ver teoría del libro **libro.png**

%clear
%pause(1);

archivo='Prueba_3.csv';
[P3]=table2array(readtable(archivo));
con=0;con1=0;

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
P=mean(K(:,2));
for j=1:con
    Y(j,1)=P;
end    
dif(:,1)=K(:,2)-Y(:,1);
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
P2=mean(K1(:,2));
for f=1:con1
    Y2(f,1)=P2;
end    
dif2(:,1)=K1(:,2)-Y2(:,1);
T2=mean(dif2(:,1));
%% Graficos

figure(1)
plot(K(:,1),K(:,2),'b',K(:,1),Y(:,1),'r',K1(:,1),K1(:,2),'b',K1(:,1),Y2(:,1),'r')
txt1 = ['La fluctuación promedio es= ' num2str(T)];
txt2 = ['La fluctuación promedio es= ' num2str(T2)];
text(200,vel1-0.3,txt1)
text(200,vel1+(vel2-vel1)/2,archivo)
text(200,vel2-0.3,txt2)