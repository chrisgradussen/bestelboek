unit symbolscanner;

{$mode objfpc}{$H+}

//{$DEFINE WINCE}


interface

uses
  Classes, SysUtils, Messages, Windows, Forms, Dialogs
  {$IFDEF WINCE}
  {$IFNDEF EMULATOR}
  ,symscanapi
  {$ENDIF}
  {$ENDIF}
  ;

const WM_SCAN = WM_USER+1000;

Type
   TScanEvent = procedure(Barcode,Symbology:String) of object;
   TScanError = procedure(ErrorMessage:String) of object;
   TLogEvent = procedure(LogMessage:String) of object;
   TSymbolScanner = class
   private
     Form : TForm;
     {$IFDEF WINCE}
     {$IFNDEF EMULATOR}
     sbp:lpScan_Buffer;
     sb:SCAN_BUFFER;
     psi:LPSCAN_FINDINFO;
     ssp: lpScan_status;
     {$ENDIF}
     {$ENDIF}
     sa: ^Char;

     h:lphandle;
     h2:lphandle;
     e:dword;
     s:string;
     Barcode:string;
     Active:Boolean;
     ScanReceived:TScanEvent;
     ScanError:TScanError;
     ScanLog :TLogEvent;
     procedure Close;
     procedure SendScan;
     procedure SendError(Errorstring:string);
     procedure Log(logstring:string);
     procedure wmscan;
   public
     Symbology:string;
     destructor destroy; override;
     constructor create(aForm : TForm);
     procedure Open;
     procedure startscanner;
     procedure disable;
     property OnScan:TScanEvent read ScanReceived write ScanReceived;
     property OnError:TScanError read ScanError write ScanError;
     property OnLog:TLogEvent read ScanLog write ScanLog;
   end;

implementation

var
 MotorolaScanner : TSymbolScanner = nil;
 PrevWndProc: WNDPROC = nil;

function WndCallback(Ahwnd: HWND; uMsg: UINT; wParam: WParam;
  lParam: LParam): LRESULT; stdcall;
begin
  if uMsg = WM_SCAN then
  begin
    if assigned(Motorolascanner) then
    begin
      if assigned(motorolascanner.OnLog) then
      motorolascanner.log('In wndCallback wParam = : '+ inttostr(WParam));
    end;
    {$IFDEF WINCE}
     {$IFNDEF EMULATOR}
      if wParam = E_SCN_SUCCESS  then
     {$ELSE}
       if WParam = 0 then
     {$ENDIF}
    {$ELSE}
    if wParam = 0  then
    {$ENDIF}
    begin
      if assigned(MotorolaScanner) then
      begin
        MotorolaScanner.wmscan;
      end;
      Exit;
    end;
    if wParam = 2684354590  then
    begin
      if assigned(MotorolaScanner)  then
      begin
        if assigned(motorolascanner.OnLog) then
        MotorolaScanner.log('Timeout');
        motorolascanner.startscanner;
      end;
      exit;
    end;
  end;
  Result := CallWindowProc(PrevWndProc, Ahwnd, uMsg, WParam, LParam);
end;

{ SymbolScanner }


procedure tsymbolscanner.disable;
var
   result :  longword;
begin
  {$IFDEF WINCE}
  {$IFNDEF EMULATOR}
  if assigned(h2) then
  begin
    log('voor flush');
    result := SymScanApi.SCAN_Flush(h2^);
    log('na flush resultaat : '+ inttostr(result));
    if result = 0 then
    begin
       log('voor assigend sbp');
       if assigned(sbp) then
       begin
         log('voor scan_getscanstatus');
         result := symscanapi.SCAN_GetScanStatus(h2^, ssp);
         log('na scan_Getscanstatus : returncode : '+ inttostr(result));
         if result = E_SCN_READPENDING then
         begin
           log('voor cancelread');
           symscanapi.SCAN_CancelRead(h2^,sbp^.dwRequestID);
         end;
       end;
    end;
  end;
  {$ENDIF}
  {$ENDIF}
end;

procedure TSymbolScanner.startscanner;
var
  w : lpdword;
begin
  new(w);
  log('Voor scan_readlabelmsg');
  {$IFDEF WINCE}
  {$IFNDEF EMULATOR}
  SCAN_ReadLabelMsg(h2^, sbp,Form.handle,WM_SCAN, 50000,w);
  {$ENDIF}
  {$ENDIF}
  log('na scan_readlabelmsg');
  dispose(w);
end;

procedure TSymbolScanner.Open;
var
  w : lpdword;
begin
  log('Start van open recompiled');
  log('na log');
  Barcode:='';
  log('na barcode = '' voor new h');
  new(h);
  log('na new h voor new h2');
  new(h2);
  log('na nwe h2 voor ifdef wince');
  {$IFDEF WINCE}
  {$IFNDEF EMULATOR}
  log('in $IFDEF voor sbp');
  new(sbp);
  log('na sbp voor psi');
  getmem(psi, 2048);
  log('na psi voor psi^structinfo');
  //psi^.StructInfo.dwAllocated := sizeof(psi^);
  psi^.StructInfo.dwAllocated := 2048;
  log('na psi^.structinfo voor finding scanner. Grootte buffer is ' +inttostr(sizeof(psi^)));
 new(ssp);

  e:=SCAN_Findfirst(psi,h);
  if e <> E_SCN_SUCCESS then
  begin
    senderror('Error finding scanner' + #10+#13 + 'Code = '+inttostr(e));
    exit;
  end
  else
  begin
    log('Scanner gevonden');
  end;
  e:=SCAN_FindClose(h^);
  if e <> E_SCN_SUCCESS then
  begin
    senderror('Error close finding scanner' + #10+#13 + 'Code = '+inttostr(e));
    exit;
  end
  else
  begin
    log('Scanner gesloten');
  end;
  sbp:=SCAN_AllocateBuffer(0,sizeof(scan_buffer)+200);
  if sbp = nil then
  begin
    senderror('Error allocating scan buffer');
    exit;
  end
  else
  begin
    log('scanbuffer gereserveerd');
  end;
  s:=psi^.szDeviceName ;
  e:=SCAN_Open(psi^.szDeviceName,h2);
  if e <> E_SCN_SUCCESS then
  begin
    senderror('Error opening scanner handle' + #10+#13 + 'Code = '+inttostr(e));
    exit;
  end
  else
  begin
    log('Scanner geopend');
  end;
  e:=SCAN_Enable(h2^);
  if (e <> E_SCN_SUCCESS) and (e <> E_SCN_ALREADYENABLED) then
  begin
    senderror('Error enabling scanner' + #10+#13 + 'Code = '+inttostr(e));
    exit;
  end
  else
  begin
    log('Scanner enabled');
  end;
  if SCAN_RegisterScanMessage(h2^,Form.Handle, WM_SCAN) <> 0 then
  begin
    senderror('Cannot register scanner message');
    exit;
  end
  else
  begin
    log('Scanner Message geregistreerd');
  end;
  {$ENDIF}
  {$ENDIF}
end;

Procedure TSymbolScanner.Close;
begin
  log('CLOSE in close');
  Active:=false;
  {$IFDEF WINCE}
  {$IFNDEF EMULATOR}
  disable;
  e:= SCAN_DeregisterScanMessage(h2^);
  if e <> E_SCN_SUCCESS then
  begin
   senderror('fout in deregisterScanMessage');
  end;

  e := symscanapi.SCAN_Disable(h2^);
   if e <> E_SCN_SUCCESS then begin
    senderror('Error disabling scanner handle' + #10+#13 + 'Code = '+inttostr(e));

   end;
  e:=SCAN_Close(h2^);
  if e <> E_SCN_SUCCESS then begin
    senderror('Error closing scanner handle' + #10+#13 + 'Code = '+inttostr(e));
//    exit;
    end;
  e:=SCAN_DeallocateBuffer(sbp);
  if e <> E_SCN_SUCCESS then begin
    senderror('Error deallocating scan buffer' + #10+#13 + 'Code = '+inttostr(e));
//    exit;
    end;
  dispose(ssp);
  dispose(sbp);
  freemem(psi);
  {$ENDIF}
  {$ENDIF}
  dispose(h);
  dispose(h2);
end;

destructor TSymbolScanner.destroy;
begin
  log('Start van Destroy');
  close;
  inherited destroy;
  MotorolaScanner := nil;
end;

constructor TSymbolScanner.create(aForm : TForm);
begin
  inherited create;
  Form := aForm;
  motorolascanner := self;
  onScan:= nil;
  onError:=nil;
  onLog :=nil;
  if PrevWndProc = nil then
  begin
    PrevWndProc := Windows.WNDPROC(SetWindowLong(Form.Handle, GWL_WNDPROC, PtrInt(@WndCallback)));
    LOG('WNDPROC created');
  end
  else
  begin
    sleep(100);
    //showmessage('WNDPROC ALREADY CREATED');
    Log('WNDPROC alreade created nothing to do')
  end;
  Log('Einde van TSymbolScanner.Create');
end;

procedure TSymbolScanner.SendScan;
begin
  log('SENDSCAN in SendScan');
  if assigned(OnScan) then OnScan(barcode,Symbology);
  barcode:='';
  startscanner;
end;

procedure TSymbolScanner.Log(logstring:string);
begin
  if assigned (Onlog) then OnLog(logstring);
end;

procedure TSymbolScanner.SendError(errorstring : string);
begin
  if assigned (OnError) then OnError(Errorstring);
end;

procedure TSymbolScanner.wmscan;
var i:integer;
begin
  try
    {$IFDEF WINCE}
    {$IFNDEF EMULATOR}
    sa := @(sbp^);
    sa:=sa+sbp^.dwOffsetDataBuff;
    s:='';
    for i:= 0 to sbp^.dwdatalength - 1 do
      s:=s+sa[i];
    Barcode := s;
    case sbp^.dwLabelType of
      LABELTYPE_UPCE0 : Symbology:= 'UPCE0';
      LABELTYPE_UPCE1 : Symbology:= 'UPCE1';
      LABELTYPE_UPCA : Symbology:= 'UPCA';
      LABELTYPE_MSI : Symbology:= 'MSI';
      LABELTYPE_EAN8 : Symbology:= 'EAN8';
      LABELTYPE_EAN13 : Symbology:= 'EAN13';
      LABELTYPE_CODABAR : Symbology:= 'CODABAR';
      LABELTYPE_CODE39 : Symbology:= 'CODE39';
      LABELTYPE_D2OF5 : Symbology:= 'D2OF5';
      LABELTYPE_I2OF5 : Symbology:= 'I2OF5';
      LABELTYPE_CODE11 : Symbology:= 'CODE11';
      LABELTYPE_CODE93 : Symbology:= 'CODE93';
      LABELTYPE_CODE128 : Symbology:= 'CODE128';
      LABELTYPE_EAN128 : Symbology:= 'EAN128';
      LABELTYPE_ISBT128 : Symbology:= 'ISBT128';
      LABELTYPE_CODE32 : Symbology:= 'CODE32';
    else
      Symbology:= 'Unknown';
    end;
    {$ELSE}
    barcode := symbology;
    {$ENDIF}
    {$ENDIF}
    sendscan;
  except
    on e:exception do begin
      senderror('Scan Thread Terminated unexpectedly' +
              #10+#13+e.Message);
    end;
  end;
end;



end.

