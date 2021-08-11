/*
 * Code File 
 */ 
#include "Arduino.h"
#include "Custom_PID_Tunel.h"
 
PID::PID(float tempP, float tempI, float tempD) {
    kP = tempP; 
    kI = tempI; 
    kD = tempD; 
   } 
 
bool PID::Initialize(int a) {
    currTime = millis(); 
    prevTime = currTime; 
 
    prevError = 0; 
    prevError1 = 0;
	output_1 = a;
     
    cP = 0; 
    cI = 0; 
    cD = 0; 
    
    
 
    return true; 
}
 
float PID::Update(float tempError, int tempDelay) {
  //delay(tempDelay); 
	
  currTime = millis(); 
  deltaTime = (currTime - prevTime)/1000; 
  
  
 
  if (deltaTime > 0.0001) {
  	cP = kP + (kD/deltaTime); 
  	cI = kI*deltaTime-kP-2*(kD/deltaTime);
    cD = (kD/deltaTime); 
   } else {
   	cP = 0;
   	cI = 0;
    cD = 0; 
   } 	
	
  output=output_1+cP*tempError+cI*prevError+cD*prevError1;
  
  if (output>=1023){
  	output = 1023;
  }
  
  if (output<=0){
  	output = 0;
  }
  		
  
 
  deltaError = tempError - prevError; 
 
  
 
  prevTime = currTime; 
  prevError = tempError;
  prevError1 = prevError; 
  output_1 = output;

  return output; 
}
