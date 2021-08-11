void PIDS() {
  if (terminoautoma==0){
    In=Inref;
  }else In=Inref1;
  if (Control==1){
   // In=Inref;      //En (m/s)
    In=map(In,0,32767,9059,32767);   
//    if (In>17.5){
//      In=17;
//    }
//    if (In<4.7){
//      In=4.7;
//    }
    VelRef=In/1927.47;
  }
  else if (Control==0){
    //In=Inref;      //En (hz) aproximados
    In=map(In,0,32767,9175,32767);
//    if (In>=50){
//      In=50;
//    }
//    if (In<=14){
//      In=14;
//    }
    VelRef=In/655.34;
    step1=0;
  }else VelRef=0;
  
  Error1 = Cte*(VelRef - velocidadB);

  if (Control == 1) {
    if (step1 == 0) {
      pid.Initialize(output);
      step1 = 1;   
  }
    
    output = pid.Update(Error1, 55);            //Calcula PID con el Error (el 55 esta deshabilitado por libreria) - Salida PID
  }
  else {
    output = VelRef*19.3;                            // La salida esta determinada por la frecuencia aproximada
    step1 = 0;
  }
  pw = output;
  Timer1.pwm(9, pw);
}
