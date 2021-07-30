void grafica() {
    
    // set line graph colors
    graphColors[0] = color(131, 255, 20);
    graphColors[1] = color(232, 158, 12);
    graphColors[2] = color(255, 0, 0);
    graphColors[3] = color(62, 12, 232);
  //  graphColors[4] = color(13, 255, 243);
  //  graphColors[5] = color(200, 46, 232);
    
    //settings save file
    topSketchPath = sketchPath();
    plotterConfigJSON = loadJSONObject(topSketchPath + "/plotter_config.json");
    
    //gui
    //////cp5 = new ControlP5(this);
    
    //init charts
    setChartSettings();
    for (int i = 0; i < lineGraphValues.length; i++) {
        for (int k = 0; k < lineGraphValues[0].length; k++) {
            lineGraphValues[i][k] = 0;
           if (i ==  0)
                lineGraphSampleNumbers[k] = k;
        }
}
    
    //start serial communication
    //if (!mockupSerial) {
    //serialPort = new Serial(this, serialPortName, 115200);
// }
    //else
    //serialPort = null;
    
    //build the gui
    int x = 24;
    int y = 105;
    TF3=cp5.addTextfield("lgMaxY").setPosition(475, 575).setLabel("").setText(getPlotterConfigString("lgMaxY")).setWidth(40).setAutoClear(false).setFont(createFont("Arial",15));
    TF4=cp5.addTextfield("lgMinY").setPosition(475, 610).setLabel("").setText(getPlotterConfigString("lgMinY")).setWidth(40).setAutoClear(false).setFont(createFont("Arial",15));
    Tx3=cp5.addTextlabel("yMax3").setText("yMax:").setPosition(415, 570).setColor(#002D5A).setFont(createFont("Arial",20));
    Tx4=cp5.addTextlabel("yMin4").setText("yMin:").setPosition(417, 605).setColor(#002D5A).setFont(createFont("Arial",20));

    TL14=cp5.addTextlabel("variable1").setText("VAR1").setPosition(x = 73, y = 554).setColor(#002D5A).setFont(createFont("Arial",20));
    TL15=cp5.addTextlabel("variable2").setText("VAR2").setPosition(x = x+80, y).setColor(#002D5A).setFont(createFont("Arial",20));
    TL16=cp5.addTextlabel("variable3").setText("VAR3").setPosition(x = x+80, y).setColor(#002D5A).setFont(createFont("Arial",20));
    TL17=cp5.addTextlabel("variable4").setText("VAR4").setPosition(x = x+80, y).setColor(#002D5A).setFont(createFont("Arial",20));

    TL12=cp5.addTextlabel("label").setText("I / O").setPosition(x = 12, y = 580).setColor(#002D5A).setFont(createFont("Arial",20));
    TL13=cp5.addTextlabel("multipliers").setText("Escala").setPosition(x = 7, y = 600).setColor(#002D5A).setFont(createFont("Arial",20));
    TF5=cp5.addTextfield("lgMultiplier1").setPosition(x = 75, y = 605).setLabel("").setText(getPlotterConfigString("lgMultiplier1")).setWidth(40).setAutoClear(false).setFont(createFont("Arial",20));
    TF6=cp5.addTextfield("lgMultiplier2").setPosition(x = x + 80, y).setLabel("").setText(getPlotterConfigString("lgMultiplier2")).setWidth(40).setAutoClear(false).setFont(createFont("Arial",20));
    TF7=cp5.addTextfield("lgMultiplier3").setPosition(x = x + 80, y).setLabel("").setText(getPlotterConfigString("lgMultiplier3")).setWidth(40).setAutoClear(false).setFont(createFont("Arial",20));
    TF8=cp5.addTextfield("lgMultiplier4").setPosition(x = x + 80, y).setLabel("").setText(getPlotterConfigString("lgMultiplier4")).setWidth(40).setAutoClear(false).setFont(createFont("Arial",20));
    TB6=cp5.addToggle("lgVisible1").setPosition(x = 75, y = 582).setLabel("").setValue(int(getPlotterConfigString("lgVisible1"))).setColorActive(graphColors[0]);//.setMode(ControlP5.SWITCH)
    TB7=cp5.addToggle("lgVisible2").setPosition(x = x + 80, y).setLabel("").setValue(int(getPlotterConfigString("lgVisible2"))).setColorActive(graphColors[1]);
    TB8=cp5.addToggle("lgVisible3").setPosition(x = x + 80, y).setLabel("").setValue(int(getPlotterConfigString("lgVisible3"))).setColorActive(graphColors[2]);
    TB9=cp5.addToggle("lgVisible4").setPosition(x = x + 80, y).setLabel("").setValue(int(getPlotterConfigString("lgVisible4"))).setColorActive(graphColors[3]);

    }
   

