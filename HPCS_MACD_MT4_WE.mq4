//+------------------------------------------------------------------+
//|                                             HPCS_MACD_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 2
extern int fast_ema_period=12;// Fast EMA period
extern int slow_ema_period=26;// Slow EMA period
extern int signal_period=9;//Signal line period
input ENUM_APPLIED_PRICE price =PRICE_CLOSE;//Enter Price
double gd_drawArrow_1[];
double gd_drawArrow_2[];
enum months  // enumeration of named constants
   {
    ONEH=PERIOD_H1,
    FOURH=PERIOD_H4
   };
input int mn=months;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,gd_drawArrow_1);
   SetIndexStyle(0,DRAW_ARROW,0,2,clrAqua);
   SetIndexArrow(0,217);
   SetIndexBuffer(1,gd_drawArrow_2);
   SetIndexStyle(1,DRAW_ARROW,0,2,clrRed);
   SetIndexArrow(1,218);
   
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
   {  double li_macd1=iMACD(NULL,0,fast_ema_period,slow_ema_period,signal_period,price,MODE_MAIN,i);
      double li_macd2=iMACD(NULL,0,fast_ema_period,slow_ema_period,signal_period,price,MODE_MAIN,i-1);
   
   if(li_macd1>0 && li_macd2<0)
   {
     gd_drawArrow_1[i]=Close[i]+50*Point;
     
   }
   if(li_macd1<0 && li_macd2>0)
   {
     gd_drawArrow_2[i]=Open[i]-50*Point;
     
   }
   }
   
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
