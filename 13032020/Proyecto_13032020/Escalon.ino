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
      pw=100;
    }
  
  if (tiempo>=33000 & tiempo<=40000) {//13+10hz
      pw=200;
    }
    if (tiempo>=40000 & tiempo<=50000){//13+20hz
      pw=50;
    }
     if (tiempo>=50000) {//13+20hz
      pw=0;
    }

  Timer1.pwm(9, pw);
   
  }
  
