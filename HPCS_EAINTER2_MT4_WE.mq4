//+------------------------------------------------------------------+
//|                                         HPCS_EAINTER2_MT4_WE.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
  int count=0;
  int i,hstTotal=OrdersHistoryTotal();
  for(i=0;i<hstTotal;i++)
    {
     if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
     {
     OrderPrint();
     if(OrderProfit()>0)
     {
     count+=1;
     }
     }
    }
    Print(count," Trades were in profit");
    //b
   if(OrderSelect(0,SELECT_BY_POS,MODE_OPEN) || OrderSelect(gi_tno,SELECT_BY_TICKET,MODE_TRADES))
   {
   Print("Ticket Number:",OrderTicket());
   Print("Order Type:",OrderType());
   Print("Order Symbol:",OrderSymbol());
   Print("Order Lots:",OrderLots());
   Print("Order Open Price:",OrderOpenPrice());
   Print("Order Open Time:",OrderOpenTime());
   Print("Order Close Price:",OrderClosePrice());
   Print("Order Close Time:",OrderCloseTime());
   Print("Order Stop Loss:",OrderStopLoss());
   Print("Order Take Profit:",OrderTakeProfit());
   Print("Order Swap:",OrderSwap());
   Print("Order Profit:",OrderProfit());
   }
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
   
  }
//+------------------------------------------------------------------+
