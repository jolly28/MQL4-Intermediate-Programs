//+------------------------------------------------------------------+
//|                                            HPCS_INDI2_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 8
input ENUM_APPLIED_PRICE price =PRICE_CLOSE;//Enter Price
double gd_drawArrow_upa[];
double gd_drawArrow_downa[];
double gd_drawArrow_upc[];
double gd_drawArrow_downc[];
double gd_drawBull_1[];
double gd_drawBull_2[];
double gd_drawBear_3[];
double gd_drawBear_4[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,gd_drawArrow_upa);
   SetIndexStyle(0,DRAW_ARROW,0,2,clrAqua);
   SetIndexArrow(0,217);
   SetIndexBuffer(1,gd_drawArrow_downa);
   SetIndexStyle(1,DRAW_ARROW,0,2,clrRed);
   SetIndexArrow(1,218);
   SetIndexBuffer(2,gd_drawArrow_upc);
   SetIndexStyle(2,DRAW_ARROW,0,1,clrAqua);
   SetIndexArrow(2,236);
   SetIndexBuffer(3,gd_drawArrow_downc);
   SetIndexStyle(3,DRAW_ARROW,0,1,clrRed);
   SetIndexArrow(3,237);
   SetIndexBuffer(4,gd_drawBull_1);
   SetIndexStyle(4,DRAW_HISTOGRAM,1,12,clrAqua);
   SetIndexBuffer(5,gd_drawBull_2);
   SetIndexStyle(5,DRAW_HISTOGRAM,1,12,clrAqua); 
   SetIndexBuffer(6,gd_drawBear_3);
   SetIndexStyle(6,DRAW_HISTOGRAM,1,12,clrRed);
   SetIndexBuffer(7,gd_drawBear_4);
   SetIndexStyle(7,DRAW_HISTOGRAM,1,12,clrRed);  
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   //a
   for (int i=Bars;i>=1;i--)
   {  double li_rsi1d=iRSI(NULL,0,14,price,i);
      double li_rsi2d=iRSI(NULL,0,14,price,i-1);
   
   if(li_rsi1d<70 && li_rsi2d>70)
   {
     gd_drawArrow_downa[i]=Close[i]-50*Point;
     MessageBox("SELL","OverBought",0);
     
   }
   if(li_rsi1d>30 && li_rsi2d<30)
   {
     gd_drawArrow_upa[i]=Open[i]+50*Point;
     MessageBox("Buy","OverSold",0);
     
   }
   }
   
   //b
   double lf_closeVal=iRSI(NULL,0,14,PRICE_CLOSE,0);
      string ls_closeVal=DoubleToString(lf_closeVal,5);
      ObjectCreate(0,"Obj1", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Obj1","Close Val:"+ls_closeVal,10, "Verdana", Yellow);
      ObjectSet("Obj1", OBJPROP_CORNER, 0);
      ObjectSet("Obj1", OBJPROP_XDISTANCE, 20);
      ObjectSet("Obj1", OBJPROP_YDISTANCE, 10);
      
   double lf_openVal=iRSI(NULL,0,14,PRICE_OPEN,0);
   string ls_openVal=DoubleToString(lf_openVal,5);
   ObjectCreate(0,"Obj2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Obj2","Open Val:"+ls_openVal,10, "Verdana", Yellow);
   ObjectSet("Obj2", OBJPROP_CORNER, 0);
   ObjectSet("Obj2", OBJPROP_XDISTANCE, 20);
   ObjectSet("Obj2", OBJPROP_YDISTANCE, 25);
   
   double lf_highVal=iRSI(NULL,0,14,PRICE_HIGH,0);
      string ls_highVal=DoubleToString(lf_highVal,5);
      ObjectCreate(0,"Obj3", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Obj3","High Val:"+ls_highVal,10, "Verdana", Yellow);
      ObjectSet("Obj3", OBJPROP_CORNER, 0);
      ObjectSet("Obj3", OBJPROP_XDISTANCE, 20);
      ObjectSet("Obj3", OBJPROP_YDISTANCE, 40);
      
      double lf_lowVal=iRSI(NULL,0,14,PRICE_LOW,0);
      string ls_lowVal=DoubleToString(lf_lowVal,5);
      ObjectCreate(0,"Obj4", OBJ_LABEL, 0, 0, 0);
      ObjectSetText("Obj4","Low Val:"+ls_lowVal,10, "Verdana", Yellow);
      ObjectSet("Obj4", OBJPROP_CORNER, 0);
      ObjectSet("Obj4", OBJPROP_XDISTANCE, 20);
      ObjectSet("Obj4", OBJPROP_YDISTANCE, 55);
      
    //c
   for (int li_bars=Bars-1;li_bars>1;li_bars--)
   {
   double lf_rsio1=iRSI(NULL,0,14,price,li_bars+1);
   double lf_rsio2=iRSI(NULL,0,14,price,li_bars);
   double lf_rsio3=iRSI(NULL,0,14,price,li_bars-1);
   if(lf_rsio2>lf_rsio1 && lf_rsio2>lf_rsio3)
   {
     gd_drawArrow_downc[li_bars]=Low[li_bars]-30*Point;
     SendMail("SELL","close Order");
   }
   if(lf_rsio2<lf_rsio1 && lf_rsio2<lf_rsio3)
   {
     gd_drawArrow_upc[li_bars]=High[li_bars]+30*Point;
     SendMail("BUY","open Order");
   }}
  //d
  
  for (int i=rates_total-1;i>=prev_calculated;i--)
   {
   double lf_closeval=iRSI(NULL,0,14,PRICE_CLOSE,i);
   if(lf_closeval>=70)
   {
     gd_drawBear_3[i]=Close[i];
     gd_drawBear_4[i]=Open[i];
     
   }
   if(lf_closeval<=30)
   {
     gd_drawBull_1[i]=Close[i];
     gd_drawBull_2[i]=Open[i];
   }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
