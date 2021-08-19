%% CARGA DE DATOS
[ALL]=csvread('Prueba_1.csv'); %%valor de muestras
[A]=ALL(:,2); %temp
[B]=ALL(:,3); %hum1
[C]=ALL(:,4); %hum
[D]=ALL(:,5); %pres
[E]=ALL(:,6); %densidad
[F]=ALL(:,7); %lec DdP (V)  
[G]=ALL(:,8); %DdP (P)
[H]=ALL(:,9); %DdP c/filtro  
[I]=ALL(:,10); %v s/filtro
[J]=ALL(:,11); %v c/filtro
[K]=ALL(:,12); %tiempo
K=K/1000;
[L]=ALL(:,13);  %pwm 
[M]=ALL(:,14);  %control
[T]=ALL(:,15); %v ref
[O]=ALL(:,16); %error


figure(1)
plot(K,J,'b',K,T,'k');%v c/f. + v ref
xlim([110 135]);
grid on
grid minor

figure(2)
plot(K,J,'b',K,T+1.2,'k');%v c/f. + v ref
x = [118.5 118.5];
x1 = [120.1 120.1];
x2 = [122.5 122.5];
x3 = [125.6 125.6];
x4 = [117 118.8];
x5 = [117 122.3];
y = [8.5 10];
y1 = [9.7 9.7];
y2 = [9.85 9.85];
line(x,y,'Color','red','LineStyle','--')
line(x1,y,'Color','red','LineStyle','--')
line(x2,y,'Color','red','LineStyle','--')
line(x3,y,'Color','red','LineStyle','--')
line(x4,y1,'Color','red','LineStyle','--')
line(x5,y2,'Color','red','LineStyle','--')
xlim([110 135]);
txt3 = ['T'];
txt4 = ['$$t_p$$'];
txt5 = ['$$T_{osc}/2$$'];
txt6 = ['$$\Delta Y_{max} $$'];
txt7 = ['$$\Delta Y(\infty) $$'];

text(119.2,9.9,txt3,'Color','k','FontSize',15,'Interpreter','latex')
text(121,9.9,txt4,'Color','k','FontSize',15,'Interpreter','latex')
text(123.4,9.9,txt5,'Color','k','FontSize',15,'Interpreter','latex')
text(115,9.85,txt6,'Color','k','FontSize',15,'Interpreter','latex')
text(115,9.7,txt7,'Color','k','FontSize',15,'Interpreter','latex')
xlabel('tiempo [s]','FontSize',14) 
ylabel('velocidad [m/s]','FontSize',14) 
legend({'Datos Experimentales','Escalon'},'Location','southeast','FontSize',14)
grid on
grid minor


%%%calculo planta S
%%valores
dy=2.75;
du=170;
n=5;
kS=dy/du;
kQ=kS;
tS1=0.55;
%%cuentas
s=tf('s');
S1=(kS/(tS1*s+1)^n)
S1_apro=pade(S1,1); %hace la funcion con nom/den polinomios
[nS1,dS1] = tfdata(S1_apro,'v');%num y den para utilizar en Simulink

%%%datos de segundo orden
DQ=0.03;%  sobreoscilacion- 2º orden estándar con retardo
tpQ=3.8; %3.8 tiempo pico-2º orden estándar con retardo
TQ=1.2;%1.2; %retardo puro- 2º orden estándar con retardo
TQQ=2; %2
%--

syms eQ wQ;
ecA=((-eQ*pi)/sqrt(1-eQ^2))-log(DQ)== 0;
eQ= vpa(solve(ecA,eQ)); %valor epsilon
e1=double(eQ);
ecB=(pi/(wQ*(sqrt(1-eQ^2))))-tpQ==0;
wQ= vpa(solve(ecB,wQ)); %valor ohmega
w1=double(wQ);
Q=tf((kQ*(w1)^2)/(s^2+2*e1*w1*s+(w1)^2));
Q_apro=pade(Q,1); %muestra la tf en forma de polinomio
[nQ,dQ] = tfdata(Q_apro,'v');



%%graficos

[A1]=ScopeData.time;
[B1]=ScopeData.signals(:,1).values; %S1
[D1]=ScopeData.signals(:,3).values; %vref- set point
figure(3)
subplot(2,1,1)
plot(A1,D1,'k',K,J,'r')
xlim([70 250]);
xlabel('tiempo [s]') 
ylabel('velocidad [m/s]') 
legend({'Escalon','v medida' },'Location','northwest')
subplot(2,1,2)
plot(A1,D1,'k',A1,B1,'b')
xlim([70 250]);
xlabel('tiempo [s]') 
ylabel('velocidad [m/s]') 
legend({'Escalon','Planta estimada'},'Location','northwest')