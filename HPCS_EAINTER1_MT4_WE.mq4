//+------------------------------------------------------------------+
//|                                         HPCS_EAINTER1_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   double Op[1],Hi[1],Lo[1],Cl[1];
   int file_handle=FileOpen("OHLC.csv",FILE_READ|FILE_CSV);
   int i=0;
   while(!FileIsEnding(file_handle))
   {
      Op[i]=FileReadNumber(file_handle);
      Hi[i]=FileReadNumber(file_handle);
      Lo[i]=FileReadNumber(file_handle);
      Cl[i]=FileReadNumber(file_handle);
      i++;
      ArrayResize(Op,i+1);
      ArrayResize(Hi,i+1);
      ArrayResize(Lo,i+1);
      ArrayResize(Cl,i+1);}
   
   for(i=0;i<5;i++)
   {Print("Open[",i+1,"] : ",Op[i]);
   Print("High[",i+1,"] : ",Hi[i]);
   Print("Low[",i+1,"] : ",Lo[i]);
   Print("Close[",i+1,"] : ",Cl[i]);}
   FileClose(file_handle);
  
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
