void escalon(){
  
  if (tiempo>=5000 & tiempo<=10000 & pw<=200) {
      pw=pw+3;
    }
  
  if (tiempo>=10000 & tiempo<=15000) {
      pw=200;
    }
    if (tiempo>=15000) {
      pw=600;
    }
  Timer1.pwm(9, pw);
   
  }

  void escalon1(){
  
  if (tiempo>=5000 & tiempo<=10000 & pw<=200) {
      pw=pw+3;
    }
  Timer1.pwm(9, pw);

   if(BT.available())    // Si llega un dato por el puerto BT se envía al monitor serial
  {
    Escalon = BT.read();
    if (Escalon == 'A'){
        Escalon1 = 125;
      }
    if (Escalon== 'B'){
      Escalon1 = 350;
    }
    if (Escalon== 'C'){
      Escalon1 = 512;
    }
    if (Escalon== 'D'){
      Escalon1 = 850;
    }
    if (Escalon== 'E'){
      Escalon1 = 950;
    }
    
    pw=Escalon1;
    }
  }

  
