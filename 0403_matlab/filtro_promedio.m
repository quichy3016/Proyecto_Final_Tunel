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
m=25;
F=0;
for i=1:1:(N-m)
    T1(i)=T(i+m);
end
T1(N-m+1)=T(N);
vuelta()

function vuelta1()
global c l k m Pant P N A
N
c
end
%%j= zeros(n,1);
%%A1=0;
%%j = float('single');
%%a=5.5

% for i=1:1:n
%     if i==1
%         j(i)=A(i);
%         A1=j(i);
%     else
%         j(i)=(A(i)+A1)/2;
%         A1=j(i);
%     end
%    
% end

% m=3;
% for i=1:1:n
%     if i<m
%         j(i)=A(i);
%         A1=j(i); %% revisar
%     else
%         for k=1:1:m
%              g=A(k)+A1;
%              A1=g;
%         end
%         H(i)=g/n;
%     end
% end


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

