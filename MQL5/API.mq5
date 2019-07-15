#include "MQL5Socket/Client.mqh"
#include "Parse.mqh"

input string Host = "127.0.0.1";
input ushort Port = 1235;

SocketClient *MySocket = new SocketClient();

string respRecv = "";

int OnInit(){
   
   EventSetMillisecondTimer(50);
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason){  
   MySocket.Close();
   delete MySocket;
   EventKillTimer();
}

void OnTimer(){
   if(MySocket.client == INVALID_SOCKET64)
      MySocket.Start(Host, Port);   
   else{ 
      string msg = MySocket.Recv();
      if(msg != "")
         MySocket.Send(Parse(msg));
   }   
}