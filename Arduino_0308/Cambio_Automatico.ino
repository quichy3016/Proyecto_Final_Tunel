void cambio_automatico(){

  if (cambio1==0){
    //Control=1;
    entrada[3] = 1; //Encendido = 1;   //Habilito Ai1
    entrada[0] = 1; //RUNSTOP = 1;     //Doy Marcha
    cambio1 = 1;
    inc=0;
    inc1=1;
  }

 
  if  (inc1<=len-1){
    
  
 if (cambio==1){
  
    Inref1=entrada1[inc];
    vtiempoant=millis();  
    cambio=0;
   
 }


 

 if ((millis()-vtiempoant)>=entrada1[inc1]*1000){
  inc = inc+2;
  inc1 = inc1+2;
  cambio=1;
 }
 }else {
        entrada[0] = 0; //RUNSTOP = 0;     //Apago Motor
        entrada[3] = 0; //Encendido = 0;   //Deshabilito Ai1
        entrada[2]=0;
        Control=0;
        terminoautoma=0;
        cambio1=0;    
        ControlAutomatico = 0; 
       }

// Serial.print(Inref1);Serial.print(" ");
// Serial.print(vtiempoant);Serial.println(" ");


 
}
