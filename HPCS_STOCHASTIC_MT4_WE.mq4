//+------------------------------------------------------------------+
//|                                       HPCS_STOCHASTIC_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 2
extern int gi_kPeriod=5;//Input K Period
extern int gi_dPeriod=3;//Input D Period
extern int gi_slowing=3;//Input Slowing
input  ENUM_MA_METHOD gi_mamethod =MODE_SMA;//Enter Method

double gd_drawArrow_up[];
double gd_drawArrow_down[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,gd_drawArrow_up);
   SetIndexStyle(0,DRAW_ARROW,0,2,clrAqua);
   SetIndexArrow(0,217);
   SetIndexBuffer(1,gd_drawArrow_down);
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
   {  double li_stomain1=iStochastic(NULL,0,gi_kPeriod,gi_dPeriod,gi_slowing,gi_mamethod,0,MODE_MAIN,i);
      double li_stomain2=iStochastic(NULL,0,gi_kPeriod,gi_dPeriod,gi_slowing,gi_mamethod,0,MODE_MAIN,i-1);
      double li_stosignal1=iStochastic(NULL,0,gi_kPeriod,gi_dPeriod,gi_slowing,gi_mamethod,0,MODE_SIGNAL,i);
      double li_stosignal2=iStochastic(NULL,0,gi_kPeriod,gi_dPeriod,gi_slowing,gi_mamethod,0,MODE_SIGNAL,i-1);
   
   if(li_stomain1<=li_stosignal1 && li_stomain2>=li_stosignal2)
   {
     gd_drawArrow_up[i]=Close[i]+20*Point;
     
   }
   if(li_stomain1>=li_stosignal1 && li_stomain2<=li_stosignal2)
   {
     gd_drawArrow_down[i]=Open[i]-20*Point;
     
   }}
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
