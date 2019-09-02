function promedio()
C=csvread('prueba 1 sin promedio.csv');
T=C(:,26);
muestra=length(T);
DifPant=0;
for i=10:1:muestra
    DifP(i-9)=C(i,21);%creo q es con el filtro 
    T1(i-9)=C(i,26);
end
for i=1:muestra-10
    DifP1=DifP(i)+DifPant;
    if rem(i,30)==0
        DifP2(i)=DifP1/30;
        plot(i,DifP2(i),'*');
        hold on; 
        drawnow;
        DifPant=0;
    end
    DifPant=DifP(i);
end
length(DifP2)
mues=length(T1)

end 

