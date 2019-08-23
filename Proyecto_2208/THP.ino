void THP(){
    ////////SHT31////////////////////////
  t = sht31.readTemperature()-offsett;//t
  h = sht31.readHumidity()-offseth;//h
  Serial.print(t,3); Serial.print("\t");
  Serial.print(h,3); Serial.print("\t");

  ////////SHT21/////////////////////////
  t1=sensor.readTemperature()-offsett1;
  h1=sensor.readHumidity()-offseth1;
  Serial.print(t1,3); Serial.print("\t");
  Serial.print(h1,3);Serial.print("\t");
  
  /////////BME280///////////////////////
  t2=bme.readTemperature()-offsett2;
  h2=bme.readHumidity()-offseth2;
  p2=bme.readPressure()-offsetp2;  
  Serial.print(t2,3);Serial.print("\t");
  Serial.print(h2,3);Serial.print("\t");
  Serial.print(p2,3);Serial.print("\t");
}
