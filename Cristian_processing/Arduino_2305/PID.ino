void PIDS() {
  In = inputString1;
  //In=analogRead(A0);
  VelRef = In / Cte; ///Cte;      ///Para a (m/s)
  Error1 = In - velocidadB * Cte;
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
  }
  else {
    output = In;
    step1 = 0;
  }
  pw = output;
  Timer1.pwm(9, pw);
}
