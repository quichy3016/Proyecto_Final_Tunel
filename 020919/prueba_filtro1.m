%%%prueba_filtro
H=csvread('csvlist1.csv');
A=H(:,17);
B=H(:,27);
A1=H(:,18);

b0=0.3;
a1=-0.3;
a2=-0.4;
a3=-0.1;
in1=0;

y03=0;
y02=0;
y01=0;

d1=0;
d2=0;
d3=0;d4=0;d5=0;d6=0;d7=0;d8=0;d9=0;d10=0;d11=0;

C=0;
for i=1:2000
    C(i)=b0*A(i)-in1*0.1-a1*y01-a2*y02-a3*y03;
    in1=C(i);
    y03=y02;
    y02=y01;
    y01=A(i);
end
D=0;
v=0;
for i=1:2000
    %%D(i)=(A(i)+d1+d2)/11;
    if (abs(A(i)-d1)>=4)
        D(i)=(A(i)+d1+d2+d3+d4+d5+d6)/7;
    else D(i)=A(i);
    end
    d6=d5;
    d5=d4;
    d4=d3;
    d3=d2;
    d2=d1;
    d1=A(i);
end

for i=1:1490
    v(i)=i;
end
% length(D)
% length(v)
figure(1)
plot(B,A)
 figure(2)
 plot(B,A1)
 figure(3)
plot(B,D)


