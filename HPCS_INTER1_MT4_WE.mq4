//+------------------------------------------------------------------+
//|                                           HPCS_INTER1_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property show_inputs

extern datetime gdt_starts=D'2019.06.12 12:10';//Start Time
extern datetime gdt_finishs=D'2019.06.12 14:10';//End Time

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{ double hi=0;
  int hindex=0,loindex=0;
  double lo=2000;
  Print(Time[17]);
  for (int i=Bars-1;i>1;i--)
  {  if (Time[i]>gdt_starts && Time[i]<=gdt_finishs)
  {
  if(High[i]>hi)
         {
            hi=High[i];
            hindex=i;
         }
   if(Low[i]<lo)
         {
            lo=Low[i];
            loindex=i;
         }
   }
   }
     Print(hi);
     Print(lo);
     Print(hindex);
     Print(loindex);
     ObjectCreate(ChartID(),"obj1",OBJ_ARROW_UP,0,Time[hindex],Close[hindex]);
     ObjectSetInteger(ChartID(),"obj1",OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"obj1",OBJPROP_COLOR,clrAqua);
     ObjectCreate(ChartID(),"obj2",OBJ_ARROW_DOWN,0,Time[loindex],Open[loindex]);
     ObjectSetInteger(ChartID(),"obj2",OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"obj2",OBJPROP_COLOR,clrRed);
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
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
