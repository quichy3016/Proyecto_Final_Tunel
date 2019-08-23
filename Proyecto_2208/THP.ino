void THP(){
    ////////SHT31////////////////////////
  float t = sht31.readTemperature()+0.77;//t
  float h = sht31.readHumidity()-3.35;//h
  Serial.print(t,3); Serial.print("\t");
  Serial.print(h,3); Serial.print("\t");

  ////////SHT21/////////////////////////
  float t1=sensor.readTemperature()+0.564;
  float h1=sensor.readHumidity()+4.07;
  Serial.print(t1,3); Serial.print("\t");
  Serial.print(h1,3);Serial.print("\t");
  
  /////////BME280///////////////////////
  float t2=bme.readTemperature()-0.56;
  float h2=bme.readHumidity()+3.49;
  float p2=bme.readPressure();  
  Serial.print(t2,3);Serial.print("\t");
  Serial.print(h2,3);Serial.print("\t");
  Serial.print(p2,3);Serial.print("\t");
}
