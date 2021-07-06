void Main(){

  String inString = puertoArduino.readStringUntil('\n'); 
  
  if (millis()>2200){
  if (inString != null){
      
      algo = float(split(inString,';'));
      t=algo[0];
      h=algo[1];
      h2=algo[2];
      
      p=algo[3];
      d=algo[4];
      
      v=algo[5];
      dp=algo[6];
      dp1=algo[7];
      
      v1=algo[8];
      v2=algo[9];
      
      tiempo=algo[10];
      pwm=algo[11];
      paro=algo[12];
      VelRef=algo[13];
      error=algo[14];
      
      tabla();
      fill (0,255,255);
      text(h, 140, 40);
      if (v1 >= 0 && v1 <= 100){
        
        g.puntosv1(x, v1);
        
        
       }
     //inString = trim(inString);
     if (flagTemp == false){
      fill(255,255,255);
      noStroke();
      rectMode(CORNERS); 
      rect(140,20,200,45);//Borra lectura anterior
      rect(270,20,330,45);//Borra lectura anterior 
      rect(400,560,460,590);//Borra lectura anterior 
      rect(580,20,670,45);//Borra lectura anterior 
      rect(140,45,180,70);//Borra lectura anterior 
      //h = float(inString);
      datos.print(pwm +" "+ TAB); 
      flagTemp = true;
      fill (0,0,255);
      text(h, 140, 40);
      //println("PWM (%) :", pwm);
      if (pwm >= 0 && pwm <= 1023){
        
        g.puntosH(x, pwm, pH);
        
        
       }
       pH = false;
     }
     else{
       fill(255,255,255);
       noStroke();
       rectMode(CORNERS);
       rect(140,5,200,25); //borra lectura anterior 
       rect(270,5,330,25);//Borra lectura anterior
       rect(400,5,460,25);//Borra lectura anterior
       rect(580,5,670,25);//Borra lectura anterior
       rect(580,45,670,70);//Borra lectura anterior
       rect(130,560,190,610);//Borra lectura anterior
       //t = float(inString);
       
       datos.println(t);
       flagTemp = false;
       fill (255,0,0);
       text(t, 140, 20);
       //println("Diferencia de Presion (PA) : ", dp);
      
       //if (dp >= 0.0 && dp <= 1023){
         if (dp <= 1023){
          
         g.puntosT(x, dp, pT);
          
        }
         pT = false;  
     }
     
     x = x + 5;
     
     }
                
     if (x > ancho - 60) {
        x = 60;
        pT = true;
        pH = true;
        g.borra();
        g.cuadricula1();
        g.cuadricula2();
              
     }
        Mostrar(); 
  
  
}}
