//+------------------------------------------------------------------+
//|                                         HPCS_EAINTER7_MT4_WE.mq4 |
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

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   double LowerBB=iBands(_Symbol,_Period,20,2,0,PRICE_CLOSE,MODE_LOWER,1);
	double UpperBB=iBands(_Symbol,_Period,20,2,0,PRICE_CLOSE,MODE_UPPER,1);
   
   if (UpperBB<Bid)
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
	  }
	if(LowerBB>Bid)
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
	}
  }
//+------------------------------------------------------------------+