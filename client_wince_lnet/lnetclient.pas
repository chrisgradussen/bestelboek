unit lnetclient;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, lNet, Dialogs, levents, strutils, fpjson, jsonparser;

const buflen = 1024;


type

  sstatus = (ok,error);


  { TLTCPClient }

  TLTCPClient = class
   private
    FTerminated : boolean;
    FReceiveStatus  : boolean;
    FCycles     : dword;
    FTimeOut    : dword;
    FCon: TLTcp;
    FOnError: TLSocketErrorEvent;
    FOnReceive: TLSocketEvent;
    FOnConnect : TLSocketEvent;
    FOnCanSend : TLSocketEvent;
    FOnSend    : TLSocketEvent;
    FOnDisconnect : TLSocketEvent;
    FStr : TStringlist;
    FMemoryStream : TMemoryStream;
    FJSo : TJSonData;
    procedure OnRe(aSocket: TLSocket);
    procedure OnErr(const msg: string; aSocket: TLSocket);
    procedure OnCo(aSocket: TLSocket);
    procedure OnDi(aSocket: TLSocket);
    procedure OnSe(aSocket : TLSocket);
    procedure onCanSe(aSocket : TLSocket);
    function ReadHost: string;
    procedure WriteHost(const aHost : string);
    function ReadPort: Word;
    procedure WritePort(const aPort : Word);
  public
    constructor Create;
    destructor Destroy; override;
    function Connect : boolean;
    function Connect(const Address: string; const aPort: Word): Boolean;
    function Connect(const Address: string; const aPort: Word; const aTimeOut : Word): Boolean;
    function Connected : boolean;
    function SendMessage(const msg: string): Boolean;
    property Terminated : boolean read fTerminated;
    property ReceiveStatus : boolean read fReceiveStatus;
    property OnError: TLSocketErrorEvent read FOnError write FOnError;
    property OnReceive: TLSocketEvent read FOnReceive write FOnReceive;
    property OnConnect: TLSocketEvent read FOnConnect write FOnConnect;
    property OnCanSend: TLSocketEvent read FOnCanSend write FOnCanSend;
    property OnDisConnect: TLSocketEvent read FOnDisconnect write FOnDisconnect;
    property Str: Tstringlist read FStr write FStr;
    property Cycles : dword read FCycles write FCycles;
    property TimeOut : dword read FTimeout write FTimeout;
    property Host : string read ReadHost write WriteHost;
    property Port : word read ReadPort  write WritePort;
    property JSo : TJsonData read FJSO write FJSO;
    property Memorystream : TMemoryStream read FMemoryStream write FMemoryStream;
    end;

 implementation

 function TLTcpClient.ReadHost: string;
 begin
   result := FCon.Host;
 end;

 procedure TLTcpClient.WriteHost(const aHost : string);
 begin
   FCon.Host:= aHost;
 end;

  function TLTcpClient.ReadPort: Word;
 begin
   result := FCon.Port;
 end;

 procedure TLTcpClient.WritePort(const aPort : Word);
 begin
   FCon.Port:= aPort;
 end;

 function TLTcpClient.connect : boolean;
 begin
   FCycles :=0;
   fterminated := false;
   str.Clear;
   if Assigned(fcon) then
   begin
     fcon.IterReset;
     result := fcon.Connect;
     if result then
     begin
       repeat
         fcon.CallAction;
         if FCycles > timeout then
         begin
            OnErr('CONNECTION TIME OUT', Fcon.Socks[0]);
         end;
         inc(FCycles);
       until fcon.Connected or terminated;
       if terminated then
       begin
         result := false;
       end;
     end
     else
     begin
       result := false;
     end;
   end
   else
   begin
     result := false;
   end;
 end;

 function TLTCPClient.Connect(const Address: string; const aPort: Word): Boolean;
 begin
   FCon.Host:= Address;
   FCon.Port:= aPort;
   result := self.connect;
 end;

 function TLTCPClient.Connect(const Address: string; const aPort: Word; const aTimeOut : Word): Boolean;
 begin
   FCon.Host:= Address;
   FCon.Port:= aPort;
   TimeOut := aTimeOut;
   result := self.connect;

 end;


 function TLTCPClient.connected : boolean;
 begin
   result := FCon.Connected;
 end;

 function TLTCPClient.SendMessage(const msg: string): Boolean;
 begin
   FCycles := 0;
   fReceiveStatus := False;
   FMemoryStream.Clear;
   if  FCon.SendMessage(msg)  > 0 then
   begin
     repeat
       fcon.CallAction;
       if FCycles >timeout then
       begin
         OnErr('SEND ERROR', Fcon.Iterator);
       end;
       inc(FCycles);
     until Terminated;
   end
   else FTerminated := True;
   result := FReceiveStatus;
 end;

 procedure TLTCPClient.OnCo(aSocket: TLSocket);
 begin
   if assigned(FOnConnect) then
     FOnConnect(aSocket);
 end;

 procedure TLTCPClient.OnDi(aSocket: TLSocket);
 begin
   FTerminated := True;
   FJSo.Clear;
   FmemoryStream.Position:= 0;
   try
     FJso := TJsonParser.Create(FMemoryStream.ReadAnsiString).Parse;
     FReceiveStatus := True;
   except
   end;
    if assigned(FOnDisConnect) then
     FOnDisConnect(aSocket);
 end;

procedure TLTCPClient.OnRe(aSocket: TLSocket);
var
  s     : string;
  ch    : char;
  size : word;
  buf : array[0..buflen-1] of byte;
begin
  size := aSocket.Get(buf,buflen);
  if size > 0 then
  begin
    Cycles := 0;
   // showmessage('voor memorystream.write');
    FMemorystream.Write(buf,size);
   // showmessage('na memorystream.write');
    if assigned(FOnReceive) then
      FOnReceive(aSocket);
  end
  else
  begin
    Fterminated := true;
  end;
end;

procedure TLTCPClient.OnErr(const msg: string; aSocket: TLSocket);
begin
  FTerminated := true;
  if assigned(FOnerror) then
    FOnError(msg,aSocket);
end;


procedure TLTCPCLient.OnSe(aSocket : TLSocket);
begin
  if assigned(FonSend) then
    FOnSend(aSocket);
end;

procedure TLTCPCLient.onCanSe(aSocket : TLSocket);
begin
  if assigned(FonCanSend) then
    FOnCanSend(aSocket);
end;

constructor TLTCPClient.Create;
begin
  FCon := TLTCP.Create(nil); // create new TCP connection with no parent component
  FCon.OnError := @OnErr; // assign callbacks
  FCon.OnReceive := @OnRe;
  FCon.OnConnect:= @OnCo;
  FCOn.OnCanSend := @onCanSe;
  FCon.OnDisconnect := @onDi;
  FCon.Timeout := 100; // responsive enough, but won't hog cpu
  FTimeOut := 1000; //times for callaction-> loop
  FOnError := nil;
  FOnReceive := nil;
  FOnConnect := nil;
  FOnCanSend := nil;
  FOnDisConnect := nil;
  FJSO := TJSonObject.Create;
  FMemoryStream := TMemorystream.Create;
  FStr := TStringlist.create;
  Fstr.NameValueSeparator := '=';
  Fstr.Delimiter:=';';
  Fstr.QuoteChar:='|';
end;

destructor TLTCPClient.Destroy;
begin
  FCon.Free; // free the connection
  Fstr.Free;
  FJSo.Free;
  FMemoryStream.Free;
  inherited Destroy;
end;


end.

