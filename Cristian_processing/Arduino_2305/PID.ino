void PIDS() {
  In = inputString1;
  if (In>18){
    In=18;
  }
  if (BOT2==1){
    if (In<4.5){
      In=4.5;
    }
  }
  //In=analogRead(A0);
  VelRef = In*Cte ; ///Cte;      ///Para a (m/s)
  
  Error1 = VelRef - velocidadB * Cte;
  if (paro == 0 & BOT == 0) {
    time1 = millis();
    BOT = 1;
  }
  if (paro == 0 & BOT == 1 ) {
    time2 = millis();
    if ((time2 - time1) > 2000) {
      BOT2 = !BOT2;
      BOT = 0;
      time3 = millis();
    }
  } else {
    BOT = 0;
  }

  if (BOT2 == 1) {
    if (step1 == 0) {
      pid.Initialize();
      step1 = 1;
      
  }
    
    output = pid.Update(Error1, 55);
//    if (In<4.5){
//        In=4.55;
//        VelRef=In*Cte;
  }
  else {
    output = VelRef;
    step1 = 0;
  }
  pw = output;
  Timer1.pwm(9, pw);
}
