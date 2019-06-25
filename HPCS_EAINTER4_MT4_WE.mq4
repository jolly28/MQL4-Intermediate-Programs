//+------------------------------------------------------------------+
//|                                         HPCS_EAINTER3_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
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
//---
    double ld_sl=NormalizeDouble(Bid-(gd_sl*Point),Digits);
    double ld_tp=NormalizeDouble(Bid+(gd_tp*Point),Digits);
    if(ld_sl<Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point)
   {}
   else
   {
    ld_sl=Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point;}
    gi_ticket=OrderSend(Symbol(),OP_BUY,gd_nol,Ask,10,ld_sl,ld_tp,"Demo",gi_mn,0,clrAqua);
   if(gi_ticket<0)
     {
      Print("OrderSend failed with error #",GetLastError());
     }
   else
      {Print("OrderSend placed successfully");}
    ld_sl=NormalizeDouble(Bid-((gd_sl+10)*Point),Digits);
    ld_tp=NormalizeDouble(Bid+((gd_tp+10)*Point),Digits);
    if(ld_sl<Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point)
   {}
   else
   {ld_sl=Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point;}
   if (OrderModify(gi_ticket,OrderOpenPrice(),ld_sl,ld_tp,0,Blue))
   {
      Print("Order Modification successfull");  
   }
   else
      Print("Order Modification Failed",GetLastError());  
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
  if(OrderSelect(gi_ticket,SELECT_BY_TICKET))
   {
   if (TimeCurrent()-OrderOpenTime()>=(60))
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