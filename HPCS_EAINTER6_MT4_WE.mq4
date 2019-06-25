//+------------------------------------------------------------------+
//|                                         HPCS_EAINTER6_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
extern double gd_nolb=0.01;//No. of Buy
extern double gd_slb=50;//Enter SL Buy 
extern double gd_tpb=50;//Enter TP Buy
extern int gi_mnb=0;//Enter Magic Number Buy
extern double gd_nols=0.01;//No. of Lots Sell
extern double gd_sls=50;//Enter SL Sell
extern double gd_tps=50;//Enter TP Sell
extern int gi_mns=0;//Enter Magic Number Sell
int gi_ticketb;
int gi_tickets;
datetime oldtime;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
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
   double ld_rsi1=iRSI(NULL,0,14,PRICE_CLOSE,0);
   double ld_rsi2=iRSI(NULL,0,14,PRICE_CLOSE,1);
   if (ld_rsi2>40 && ld_rsi1<40 && oldtime!=Time[0])
   {
   double ld_slb=NormalizeDouble(Bid-(gd_slb*Point),Digits);
   double ld_tpb=NormalizeDouble(Bid+(gd_tpb*Point),Digits);
   if(ld_slb<Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point)
   {}
   else
   {ld_slb=Bid-MarketInfo(NULL,MODE_STOPLEVEL)*Point;}
   gi_ticketb=OrderSend(Symbol(),OP_BUY,gd_nolb,Ask,10,ld_slb,ld_tpb,"Demo Open Buy",gi_mnb,0,clrAqua);
   if(gi_ticketb<0)
     {
      Print("OrderSend failed with error #",GetLastError());
     }
   else
      {}   
   for(int pos=0;pos<OrdersTotal();pos++)
   {if(OrderSelect(pos,SELECT_BY_POS))
   {if(OrderType()==OP_SELL)
      {if(OrderClose(OrderTicket(),OrderLots(),Ask,10,clrRed))
      {}}}}
      oldtime=Time[0];
    }
   if (ld_rsi2<60 && ld_rsi1>60 && oldtime!=Time[0])
   {
   double ld_sls=NormalizeDouble(Ask+(gd_sls*Point),Digits);
   double ld_tps=NormalizeDouble(Ask-(gd_tps*Point),Digits);
   if(ld_sls>Ask-MarketInfo(NULL,MODE_STOPLEVEL)*Point)
   {}
   else
   {ld_sls=Ask-MarketInfo(NULL,MODE_STOPLEVEL)*Point;}
   gi_tickets=OrderSend(Symbol(),OP_SELL,gd_nols,Bid,10,ld_sls,ld_tps,"Demo Open Sell",gi_mns,0,clrAqua);
   if(gi_tickets<0)
     {
      Print("OrderSend failed with error #",GetLastError());
     }
   else
      {}
       for(int pos=0;pos<OrdersTotal();pos++)
   {if(OrderSelect(pos,SELECT_BY_POS))
   {if(OrderType()==OP_BUY)
      {if(OrderClose(OrderTicket(),OrderLots(),Bid,10,clrRed))
      {}}
   }
  }
  oldtime=Time[0];
  }}
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
