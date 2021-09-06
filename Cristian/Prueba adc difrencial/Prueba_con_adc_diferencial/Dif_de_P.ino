void difPresion(){
  
 ///////////ADS1115///////////////////////////
  adc1 = ads.readADC_SingleEnded(0)*4.096/32768;
  adc0 = ads.readADC_Differential_0_1()*1.024/32768*1000;
  presionSF2 = (adc0 -offsetdf1-offsetp2)*1000;   ////Presion en PA   res MPX70002dp= 1kPa/V
  ADCFilterM = medianFilter.AddValue(presionSF2);
  
}
