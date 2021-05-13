void PIDS(){

  In=analogRead(A0);
  VelRef=In/Cte;
  Error1=In-velocidadB*Cte;
  if (paro==0 & BOT==0){
    time1=millis();
    BOT=1;
  }
  if (paro==0 & BOT==1 ){
    time2=millis();
    if ((time2-time1)>2000){
    BOT2=!BOT2;  
    BOT=0;
    time3=millis();
    }
  } else {BOT=0;
         }

   if (BOT2==1){
    if (step1==0){
    pid.Initialize();
    step1=1;}
    /////////Inicializo PID///////////
   //VelRef=map(In,0,1023,0,18);
   //VelRef=In*0.01757;
   //VelRef=VelRef*56.83;
   
   //myPID.Setpoint(VelRef);
  //output=myPID.GetSetpoint();
  //output = myPID.Run(velocidadB);
  
  output = pid.Update(Error1, 55);
  
  //myPID.Compute();
   }else output=In;

   pw=output;
   Timer1.pwm(9, pw);
  }
