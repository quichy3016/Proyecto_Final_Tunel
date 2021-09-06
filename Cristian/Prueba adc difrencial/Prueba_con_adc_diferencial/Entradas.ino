void entradas(){

  ////FISICAS///
  Estado = !digitalRead(2);
  Errorvar= !digitalRead(7);

  if (Errorvar == 1){

      entrada[0] = 0; //RUNSTOP = 0;     //Apago Motor
      entrada[3] = 0; //Encendido = 0;   //Deshabilito Ai1
      entrada[2] = 0;
      terminoautoma = 0;
      cambio = 0;
      ControlAutomatico = 0;
  }

  /////Serial/////
  RUNSTOP=entrada[0];       //Variable Marcha- Parada
  Inref=entrada[1];         //Variable referencia velocidad o frecuencia aprox.
  Control=entrada[2];       //Control activado/desacivado
  Encendido=entrada[3];     //ON - OFF . Habilitacion Ai1
  Resetfalla=entrada[4];    //Reset falla
  FallaExterna=entrada[Fallaext];  //Falla externa
}
