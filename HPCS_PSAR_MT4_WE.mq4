//+------------------------------------------------------------------+
//|                                             HPCS_PSAR_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 2
extern float gi_step=0.02;//Input Step
extern float gi_maximum=0.2;//Input Maximum
double gd_drawArrow_1[];
double gd_drawArrow_2[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,gd_drawArrow_1);
   SetIndexStyle(0,DRAW_ARROW,0,2,clrAqua);
   SetIndexArrow(0,159);
   SetIndexBuffer(1,gd_drawArrow_2);
   SetIndexStyle(1,DRAW_ARROW,0,2,clrRed);
   SetIndexArrow(1,159);
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
   int i;
   for (i=Bars -1;i>=1;i--)
   {  double li_psar1=iSAR(NULL,0,gi_step,gi_maximum,i);
      double li_psar2=iSAR(NULL,0,gi_step,gi_maximum,i-1);
   
   if(li_psar1>Close[i] && li_psar2<Close[i-1])
   {
     gd_drawArrow_1[i]=Close[i]+100*Point;
     
   }
   if(li_psar1<Close[i] && li_psar2>Close[i-1])
   {
     gd_drawArrow_2[i]=Open[i]-100*Point;
     
   }}
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
