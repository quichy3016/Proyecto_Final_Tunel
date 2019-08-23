#include <Arduino.h>
#include <Wire.h>
///FiltroA 
//https://www.megunolink.com/documentation/arduino-libraries/exponential-filter/
#include "Filter.h" 
#include "MegunoLink.h"
ExponentialFilter<float> ADCFilter0(20,0);
ExponentialFilter<float> ADCFilter1(20,0);
//FiltroB   
//https://www.youtube.com/watch?v=QGDG5v_UnIk
float Y=0.0;
float alpha=0.05;
float S=Y,S1=Y;
///Sensores e INA
#include "Adafruit_SHT31.h"
#include "Adafruit_Si7021.h"
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>
#include <Adafruit_INA219.h>
#include <Adafruit_ADS1015.h>

/////SHT31////////////////////////////
Adafruit_SHT31 sht31 = Adafruit_SHT31();
//////DHT21//////////////////////////
Adafruit_Si7021 sensor = Adafruit_Si7021();
//////BME280//////////////////////////
Adafruit_BME280 bme; // I2C
///////INA-219////////////////////////
Adafruit_INA219 ina219;
////////ADS115////////////////////////
Adafruit_ADS1115 ads;

long tiempo=0;

void setup() {
  Serial.begin(115200);
  //////SHT31////////
  if (! sht31.begin(0x44)) {   // Set to 0x45 for alternate i2c addr
    Serial.println("Couldn't find SHT31");
    while (1) delay(1);
  }
  /////SHT21/////////////////
  if (!sensor.begin()) {
    Serial.println("Did not find Si7021 sensor!");
    while (true);
  }
  /////BME280////////////////////
  if (!bme.begin()) {
    Serial.println("Could not find a valid BME280 sensor, check wiring!");
    while (1);
  }
  //////INA-219///////////////////////
  ina219.begin();
  ina219.setCalibration_16V_400mA();
  /////ADS1115///////////////////////
  ads.setGain(GAIN_ONE);        // 1x gain   +/- 4.096V  1 bit = 2mV      0.125mV
  ads.begin();
  pinMode(7,INPUT_PULLUP);
}

void loop() {
  THP(); 
  difPresion();
  //////////Calculo velocidad////////////////
  float velocidadA = sqrt((2*abs(presionCF))/1.183);
  float velocidadB = sqrt(2*abs(S)/1.183);
  Serial.print(velocidadA,3);Serial.print("\t");  
  Serial.print(velocidadB,3);Serial.print("\t");

  float velocidadA1 = sqrt((2*abs(presionCF2))/1.183);
  float velocidadB1 = sqrt(2*abs(S1)/1.183);
  Serial.print(velocidadA1,3);Serial.print("\t");  
  Serial.print(velocidadB1,3);Serial.print("\t"); 
  
  /////////////////////////////////////////
  tiempo=millis();
  Serial.print(tiempo);Serial.print("\t");
  boolean paro = digitalRead(7);
  Serial.println(paro);
  delay(100);
}
