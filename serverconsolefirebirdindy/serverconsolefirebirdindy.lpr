program serverconsolefirebirdindy;

{$mode objfpc}{$H+}

uses
  {$define UseCThreads}
  {$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp
  { you can add units after this },crt,
  IdTCPServer,
   IdContext, fpjson, jsonparser, db, ZConnection, ZDataset;

const
    DebugInfo = 2;
    DebugError = 4;
    DebugParameter = 8;
    DebugReceive = 16;
    DebugSend = 32;
    DebugFirebird = 64;

type

  { TServerConsole }

  TServerConsole = class(TCustomApplication)
  protected
    fDatabase     : string;
    fHost         : string;
    fUser         : string;
    fpassword     : string;
    fip           : string;
    fport         : qword;
    fDebugoptions : integer;
    idTcpServer   : TIdTcpServer;
    procedure DoRun; override;
    procedure Schrijf(S : string);
    procedure Log(aDebugInfo : Integer;S : string);
    procedure ExecuteHandler(AContext: TIdContext);

  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
    function SendStream(AContext: TIdContext; AStream: TStream): Boolean;
    property database : string read fdatabase write fdatabase;
    property host     : string read fhost     write fhost;
    property user     : string read fuser     write fuser;
    property password : string read fpassword write fpassword;
    property debugoptions : integer read fdebugoptions write fdebugoptions;
    property ip       : string read fip       write fip;
    property port : qword read fport write fport;
  end;

{ TServerConsole }

function TServerConsole.SendStream(AContext: TIdContext; AStream: TStream): Boolean;
begin
   Result := False;
   try
    // AContext.Connection.IOHandler.Write(LongInt(SizeOf(AStream)));
     log(DebugSend,'Lengte astream '+ inttostr(AStream.Size));
     AContext.Connection.IOHandler.write(longint(Astream.Size));
     AContext.Connection.IOHandler.WriteBufferOpen;
     AContext.Connection.IOHandler.Write(AStream, AStream.Size);
     AContext.Connection.IOHandler.WriteBufferFlush;
   finally
     AContext.Connection.IOHandler.WriteBufferClose;
   end;
   Result := True;
end;

procedure TServerConsole.ExecuteHandler(AContext: TIdContext);
var
  zquery : TZQuery;
s : string;
i : integer;
JD : TJSonOBject;
JA : TJsonArray;
FMemStr : TMemoryStream;
FJO : TJSonOBject;
   FJD : TJSonObject;
zlconnection : TZConnection;

begin
FMemStr := TMemoryStream.Create;
FJO := TJSonOBject.create;
FJD := TJSonObject.create;
zlconnection := tzconnection.Create(nil);
zlconnection.User:= user ;
zlconnection.Password:= password;
zlconnection.HostName:= host;
zlconnection.Database:= database;
zlconnection.Protocol:= 'firebird-2.5';

zquery := TZQuery.Create(nil);
zquery.Connection := zlconnection;
s := AContext.Connection.IOHandler.ReadLn();
try
  try
    if not ZlConnection.Connected then
    begin
      ZlConnection.Connected:= true;
    end;
    log(DebugReceive,'Request ontvangen : '+ s);
      ZQuery.SQL.Clear;
      ZQuery.SQL.Add(s);
      Fjo.Clear;
      ja := TJsonArray.Create;
      FMemStr.Clear;
      if UpperCase(Leftstr(s,6)) =  'SELECT' then
      begin
        try
          try
            log(DebugFirebird,'SELECT statement : '+zQuery.SQL.Text);
            zquery.Active:= true;
            while not zquery.EOF do
            begin
              JD := TJSonObject.Create;
              for i := 0 to zquery.FieldCount -1 do
              begin
                TJsonObject(jd).Add(zquery.fields[i].FieldName,zquery.Fields[i].asstring);
              end;
              ja.Add(jd);
              log(DebugFirebird,jd.AsJSON);
              zquery.Next;
            end;
          except
            on E: EDatabaseError do
              log(DebugError,' DATABASE ERROR ' + E.Message);
            on E: EXception do
              log(DebugError,E.Message);
          end;
        finally
          zQuery.Active:= False;
        end;
        Fjo.Clear;
        fjo.Add('data',ja);
      end;
      if UpperCase(Leftstr(s,6)) = 'UPDATE' then
      begin
        log(DebugFirebird,'UPDATE statement : '+zQuery.SQL.Text);
        try
          zquery.ExecSQL;
          fjo.Add('STATUS','OK');
        except
          on E: Exception do
          begin
            fjo.Add('STATUS','ERROR');
            log(DebugError,E.Message);
          end;
        end;
      end;
      FMemStr.WriteAnsiString(FJo.AsJSON);
      FMemStr.Position:= 0;
      sendstream(aContext,TStream(FMemStr));
  except
    log(DebugSend,'SEND ERROR???');
    AContext.Connection.IOHandler.close;
  end;
finally
  if zlConnection.Connected then
  begin
    zlConnection.Connected:= false;
  end;
   FJD.Free;
  FJO.free;
  FMemStr.Free;
  zquery.free;
  zlconnection.free;
end;

end;

procedure TServerConsole.Schrijf(S : string);
begin
  writeln(s);
end;

procedure TServerConsole.Log(aDebugInfo : Integer;S : string);
begin
  if aDebugInfo AND DebugOptions = DebugInfo then
    schrijf('INFO      ' + datetimetostr(now) + ' : ' + S);
  if aDebugInfo AND DebugOptions = DebugError then
    schrijf('ERROR     ' + datetimetostr(now) + ' : ' + S);
  if aDebugInfo AND DebugOptions = DebugParameter then
    schrijf('PARAMETER ' + datetimetostr(now) + ' : ' + S);
  if aDebugInfo AND DebugOptions = DebugReceive then
    schrijf('RECEIVE   ' + datetimetostr(now) + ' : ' + S);
  if aDebugInfo AND DebugOptions = DebugSend then
    schrijf('SEND      ' + datetimetostr(now) + ' : ' + S);
  if aDebugInfo AND DebugOptions = DebugFirebird then
    schrijf('FIREBIRD  ' + datetimetostr(now) + ' : ' + S);
end;

procedure TServerConsole.DoRun;
var
  ErrorMsg: String;
begin
  ErrorMsg:=CheckOptions('h','help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if (HasOption('h','help') or (paramcount <> 7)) then
  begin
    WriteHelp;
    readkey;
    Terminate;
    Exit;
  end;
  if ParamCount >= 7 then
  begin
    try
      DebugOptions := StrToInt(ParamStr(7)); // try to parse debuginfo from argument
      log(DebugParameter,'DebugInfo : '+ IntToStr(DebugOptions));
      Host      := ParamStr(1);
      log(DebugParameter,'FB Host      : '+ Host);
      Database  := ParamStr(2);
      log(DebugParameter,'FB Database  : '+ Database);
      User      := ParamStr(3);
      log(DebugParameter,'FB User      : '+ User);
      Password  := ParamStr(4);
      log(DebugParameter,'FB Password  : '+ Password);
      IP        := ParamStr(5);
      log(DebugParameter,'IP           : '+ IP);
      Port      := Word(StrToInt(ParamStr(6))); // try to parse port from argument
      log(DebugParameter,'Port         : '+ IntToStr(Port));
      try

        idTCPServer.Bindings.Add.IP :=IP;
        idTCPServer.Bindings.Add.Port := Port;

        finally
        end;
        idTCPServer.OnExecute := @ExecuteHandler;
        try
          idTCPServer.Active := True;
        except
          on E: Exception do
            log(DebugSend,e.Message);
        end;
        while not Terminated do
        begin
          Sleep(1000);
          if Keypressed then // if user provided input
          case readkey of
            #27: Terminate; // if he pressed "escape" then quit
           'r': begin       // if he pressed 'r' then restart the server
                  log(DebugInfo,'Restarting...');
                  idtcpserver.Active:= false;
                  idtcpserver.active := true;
                end;
          end;
        end;
        idtcpserver.Active:= false;
    except
      on e: Exception do
      begin
        log(DebugError,e.Message);
        Terminate;
        exit;
      end;
    end;
  end;
  Terminate;
end;

constructor TServerConsole.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  idtcpserver := tidtcpserver.Create(TheOwner);
  StopOnException:=True;
end;

destructor TServerConsole.Destroy;
begin
  idtcpserver.Free;
  inherited Destroy;
end;

procedure TServerConsole.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
   Writeln('Usage: ', ParamStr(0), ' <firebird_host> <firebird_database> <firebird_username> <firebird_password> <host_ip> <port> <loginfo>');
    Writeln('Loginfo: Add all desired options together');
    Writeln('Loginfo: for example info and errors 2 + 4 = 6');
    Writeln('Loginfo: 2 info {info}');
    Writeln('Loginfo: 4 errors {errors}');
    Writeln('Loginfo: 8 parameters {parameters}');
    Writeln('Loginfo: 16 receive communication with client {client}');
    Writeln('Loginfo: 32 send communication to client {server}');
    Writeln('Loginfo: 64 communication with firebird server {firebird}');
end;

var
  Application: TServerConsole;
begin
  Application:=TServerConsole.Create(nil);
  Application.Title:='ServerConsoleFirebirdIndy';
  Application.Run;
  Application.Free;
end.
