//+------------------------------------------------------------------+
//|                                           HPCS_INTER3_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 6
double gd_drawArrow_upa[];
double gd_drawArrow_downa[];
double gd_drawArrow_upc[];
double gd_drawArrow_downc[];
double gd_drawArrow_upd[];
double gd_drawArrow_downd[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,gd_drawArrow_upa);
   SetIndexStyle(0,DRAW_ARROW,0,1,clrAqua);
   SetIndexArrow(0,217);
   SetIndexBuffer(1,gd_drawArrow_downa);
   SetIndexStyle(1,DRAW_ARROW,0,1,clrRed);
   SetIndexArrow(1,218);
   SetIndexBuffer(2,gd_drawArrow_upc);
   SetIndexStyle(2,DRAW_ARROW,0,2,clrAqua);
   SetIndexArrow(2,236);
   SetIndexBuffer(3,gd_drawArrow_downc);
   SetIndexStyle(3,DRAW_ARROW,0,2,clrRed);
   SetIndexArrow(3,237);
   SetIndexBuffer(4,gd_drawArrow_upd);
   SetIndexStyle(4,DRAW_ARROW,0,2,clrAqua);
   SetIndexArrow(4,225);
   SetIndexBuffer(5,gd_drawArrow_downd);
   SetIndexStyle(5,DRAW_ARROW,0,2,clrRed);
   SetIndexArrow(5,226);
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
   for (int i=Bars -1;i>=1;i--)
   {  
   double li_macd=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,i);  
   if(li_macd<0)
   {
     gd_drawArrow_downa[i]=Low[i]-50*Point;
     
   }
   if(li_macd>0)
   {
     gd_drawArrow_upa[i]=High[i]+50*Point;  
   }
   }
   //b
   double lf_closeVal=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,0);
   string ls_closeVal=DoubleToString(lf_closeVal,5);
   ObjectCreate(0,"Obj1", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Obj1","Close Val:"+ls_closeVal,10, "Verdana", Yellow);
   ObjectSet("Obj1", OBJPROP_CORNER, 0);
   ObjectSet("Obj1", OBJPROP_XDISTANCE, 20);
   ObjectSet("Obj1", OBJPROP_YDISTANCE, 10);
    
   //c
   for (int i=Bars-1;i>1;i--)
   {  
   double li_macdmain1=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,i);
   double li_macdmain2=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,i-1);
   double li_macdsignal1=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,i);
   double li_macdsignal2=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,i-1);      
   if(li_macdmain1>li_macdsignal1 && li_macdmain2<li_macdsignal2)
   {
     gd_drawArrow_downc[i-1]=Low[i-1]-100*Point;
   }
   if(li_macdmain1<li_macdsignal1 && li_macdmain2>li_macdsignal2)
   {
     gd_drawArrow_upc[i-1]=High[i-1]+100*Point;  
   }
   }
   //d
   for (int i=Bars-1;i>4;i--)
   {  
   double li_macdmain1=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,i);  
   if(li_macdmain1<0 && Close[i]<Close[i-1] && Close[i-1]<Close[i-2] && Close[i-2]<Close[i-3])
   {
     gd_drawArrow_upd[i]=High[i]+150*Point;
   }
   if(li_macdmain1>0 && Close[i]>Close[i-1] && Close[i-1]>Close[i-2] && Close[i-2]>Close[i-3])
   {
     gd_drawArrow_downd[i]=Low[i]-200*Point; 
   }
   }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+