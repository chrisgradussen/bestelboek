unit indyclient;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, lNet, Dialogs, levents, strutils, fpjson, jsonparser,
  IdTCPClient, IDException;

const buflen = 1024;


type

  sstatus = (ok,error);


  { IndyClient }

  TLTCPClient = class
   private
    FTerminated : boolean;
    FReceiveStatus  : boolean;
    FCycles     : dword;
    FTimeOut    : dword;
    FIdTCPClient: TIdTCPClient;
    FStr : TStringlist;
    FMemoryStream : TMemoryStream;
    FJSo : TJSonData;
    function ReadHost: string;
    procedure WriteHost(const aHost : string);
    function ReadPort: Word;
    procedure WritePort(const aPort : Word);
  public
    constructor Create;
    destructor Destroy; override;
    function Connect : boolean;
    function Connected : boolean;
    function SendMessage(const msg: string): Boolean;
    property ReceiveStatus : boolean read fReceiveStatus;
    property Str: Tstringlist read FStr write FStr;
    property TimeOut : dword read FTimeout write FTimeout;
    property Host : string read ReadHost write WriteHost;
    property Port : word read ReadPort  write WritePort;
    property JSo : TJsonData read FJSO write FJSO;
    property Memorystream : TMemoryStream read FMemoryStream write FMemoryStream;
    end;

 implementation

 function TLTcpClient.ReadHost: string;
 begin
   result := FIDTcpClient.Host;
 end;

 procedure TLTcpClient.WriteHost(const aHost : string);
 begin
   FIDTcpClient.Host:= aHost;
 end;

  function TLTcpClient.ReadPort: Word;
 begin
   result := FIDTcpClient.Port;
 end;

 procedure TLTcpClient.WritePort(const aPort : Word);
 begin
   FIDTcpClient.Port:= aPort;
 end;

 function TLTCPClient.connected : boolean;
 begin
   result := FIDTcpClient.Connected;
 end;

 function TLTCPClient.connect : boolean;
 begin
   fidtcpclient.Connect;
   result := FIdTcpClient.Connected;
 end;

 function ReceiveStream(AClient: TIdTCPClient; var AStream: TStream):
Boolean; overload;
var
   LSize: LongInt;
begin
   Result := False;
   LSize := AClient.IOHandler.ReadLongInt();
   AClient.IOHandler.ReadStream(AStream, LSize, False);
   Result := True;
end;

 function TLTCPClient.SendMessage(const msg: string): Boolean;
 begin
   try
     try
       if Connect then
       begin
         FIdTCPClient.iohandler.WriteLn(msg);
         FMemoryStream.Clear;
         receivestream(Fidtcpclient,tstream(FMemoryStream));
         FMemoryStream.Position:= 0;
         FJso := TJsonParser.Create(FMemoryStream.ReadAnsiString).Parse;
         result := true;
       end;
     except
       on e: eIDexception do
       begin
         showmessage('fout in verbinding: ' + e.Message);
         result := false;
       end
       else
         result := false;
     end;
   finally
     if fidtcpclient.Connected then
     FIdTCPClient.Disconnect;
   end;
 end;

constructor TLTCPClient.Create;
begin
  FIdTCPClient := TidTcpClient.Create(nil); // create new TCP connection with no parent component
  FJSO := TJSonObject.Create;
  FMemoryStream := TMemorystream.Create;
  FStr := TStringlist.create;
  Fstr.NameValueSeparator := '=';
  Fstr.Delimiter:=';';
  Fstr.QuoteChar:='|';
end;

destructor TLTCPClient.Destroy;
begin
  FIdTCPClient.Free; // free the connection
  Fstr.Free;
  FJSo.Free;
  FMemoryStream.Free;
  inherited Destroy;
end;


end.


