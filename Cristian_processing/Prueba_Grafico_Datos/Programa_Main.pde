void Main(){

  String inString = puertoArduino.readStringUntil('\n'); 
  
  if (millis()>2200){
  if (inString != null){
      
      algo = float(split(inString,';'));
      t=algo[0];
      h=algo[1];
      p=algo[2];
      d=algo[3];
      v=algo[4];
      dp=algo[5];
      dp1=algo[6];
      dp2=algo[7];
      dp3=algo[8];
      v1=algo[9];
      v2=algo[10];
      v3=algo[11];
      v4=algo[12];
      tiempo=algo[13];
      pwm=algo[14];
      paro=algo[15];
      h2=algo[16];
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
      rect(450,20,500,45);//Borra lectura anterior 
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
       rect(450,5,500,25);//Borra lectura anterior
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
