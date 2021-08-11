/*
 * Header File 
 */ 
#ifndef __CUSTOM_PID__Tunel_H__ 
#define __CUSTOM_PID_Tunel_H__ 
 
#include "Arduino.h" 
 
class PID {
public: 
  PID(float tempP, float tempI, float tempD); 
  bool Initialize(int a); 
  float Update(float tempError, int tempDelay); 
 
private: 
  float kP, kI, kD; 
  float cP, cI, cD; 
  float currTime, prevTime; 
  float prevError, prevError1;
  float deltaTime, deltaError;
  float output, output_1;
};
 
#endif
