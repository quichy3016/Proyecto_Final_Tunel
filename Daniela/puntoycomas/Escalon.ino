void escalon(){
  //HOLA//
  if (tiempo>=20000 & tiempo<=40000 & pw<=250) {
      pw=pw+2;
    }
  
  if (tiempo>=40000 & tiempo<=50000) {//13+10hz
      pw=250;
    }
    if (tiempo>=50000) {//13+20hz
      pw=500;
    }

    if (tiempo>=60000) {//13+24hz
      pw=600;
    }
    if (tiempo>=70000) {//13+22hz
      pw=550;
    }
    if (tiempo>=80000) {//13+18hz
      pw=450;
    }
    if (tiempo>=90000) {//13+14hz
      pw=350;
    }
    if (tiempo>=100000) {//13hz
      pw=0;
    }
  Timer1.pwm(9, pw);
   
  }


  void escalon2(){
  
  pw=analogRead(A0);
  Timer1.pwm(9, pw);
   
  }

void escalon3(){
  
  if (tiempo>=20000 & tiempo<=33000 ) {
      pw=220;     //// supongo 18,33 Hz
    }
  
  if (tiempo>=33000 & tiempo<=45000) {//
      pw=270;    /////Supongo 25 HZ
    }
    if (tiempo>=45000 & tiempo<=55000){//
      pw=220;  ////Supongo 18.33 Hz
    }
     if (tiempo>=55000) {//
      pw=0;
    }

  Timer1.pwm(9, pw);
   
  }



  void escalon4(){
  
  if (tiempo>=20000 & tiempo<=35000 ) {
      pw=325;     //// supongo 23 Hz
    }
  
  if (tiempo>=35000 & tiempo<=50000) {//
      pw=595;    /////Supongo 35 HZ
    }
    if (tiempo>=50000 & tiempo<=65000){//
      pw=325;  ////Supongo 23 Hz
    }
     if (tiempo>=55000) {//
      pw=0;
    }

  Timer1.pwm(9, pw);
   
  }
  
