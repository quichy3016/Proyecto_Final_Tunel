void entradas(){

  ////FISICAS///
  Estado = !digitalRead(2);
  Errorvar= !digitalRead(7);
  

  /////Serial/////
  RUNSTOP=entrada[0];       //Variable Marcha- Parada
  Inref=entrada[1];         //Variable referencia velocidad o frecuencia aprox.
  Control=entrada[2];       //Control activado/desacivado
  Encendido=entrada[3];     //ON - OFF . Habilitacion Ai1
  Resetfalla=entrada[4];    //Reset falla
  FallaExterna=entrada[5];  //Falla externa
}
