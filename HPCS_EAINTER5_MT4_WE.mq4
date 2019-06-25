//+------------------------------------------------------------------+
//|                                         HPCS_EAINTER5_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
extern double gd_nol=0.01;//No. of Lots
extern double gd_sl=50;//Enter SL
extern double gd_tp=50;//Enter TP
extern int gi_mn=0;//Enter Magic Number
int gi_ticket;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   double ld_sl=NormalizeDouble(Bid-(gd_sl*Point),Digits);
   double ld_tp=NormalizeDouble(Bid+(gd_tp*Point),Digits);
   if(ld_sl<Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point)
   {}
   else
   {ld_sl=Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point;}
   if(Close[5]>Close[1])
   {
      gi_ticket=OrderSend(Symbol(),OP_BUY,gd_nol,Ask,3,ld_sl,ld_tp,"Demo",gi_mn,0,clrAqua);
   if(gi_ticket<0)
     {
      Print("OrderSend failed with error #",GetLastError());
     }
   else
      {Print("OrderSend placed successfully");}
   }
//--- create timer
   EventSetTimer(60);
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   if(OrderSelect(gi_ticket,SELECT_BY_TICKET))
   {
   if (TimeCurrent()-OrderOpenTime()>=(30))
   {
      if(OrderClose(OrderTicket(),OrderLots(),Bid,3,clrRed))
      {Print("Order Closed After 1 min");}
   }
   }
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
