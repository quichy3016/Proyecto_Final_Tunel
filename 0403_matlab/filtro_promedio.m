[A]=importdata('VelADC.dat'); 
[T]=importdata('Tiempo.dat'); 
[M]=importdata('Valoresmuestras.dat'); 
%A=[2;5;8;11;8;2;7;5];


global c l k m Pant P F T M  N A
N = length(A);
P=0;
Pant=0;
c=1;
l=1;
k=1;
m=28;
F=0;
for i=1:1:(N-m)
    T1(i)=T(i+m);
end
T1(N-m+1)=T(N);
vuelta()
T=T/1000;
T1=T1/1000;
plot(T,A,'r-o',T1,F,'g-x')


function vuelta
global c l k m Pant P N A F T M
if c>=N+1
    return
    %%FIN
else
    if k>m
        k=1;
        P=P/m;
        F(l,1)=P;
        Pant=0;
        l=l+1;
        c=c-m+1;
        vuelta();
    else
        P=A(c)+Pant;
        Pant=P;
        k=k+1;
        c=c+1;
        if c==N+1
            F(l,1)=P/m;
        end
        vuelta();
    end
end
end

