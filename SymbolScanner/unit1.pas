unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, windows, messages

  ,symbolscanner

  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Eindebutton: TButton;
    log: TMemo;
    Panel1: TPanel;
    StartButton: TButton;
    StopButton: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EindebuttonClick(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    //procedure checkstatus;
  private
    { private declarations }
  public
    { public declarations }
    activethread : boolean;
    Thr : TSymbolScanner;
    Procedure GetScan(barcode:String; Symbology:String);
    Procedure GetScanError(ErrorMessage:string);
    Procedure GetLog(LogMessage:string);
  end;

var
  Form1: TForm1;


//    PrevWndProc:windows.WNDPROC;

implementation

{$R *.lfm}



{ TForm1 }

procedure TForm1.GetScan(Barcode:String; Symbology:String);
var i:integer;
    c:char;
Begin
  log.Lines.Add('SCAN SUCCESS : ' + Barcode);;
 // barcode:=barcode+#9;
  //for i:=1 to length(Barcode) do
  begin
//    form1.FormKeyPress(Scan,(Barcode)[i]);
   // form1.KeyPress((Barcode)[i]) ;
  end;
end;

procedure TForm1.GetLog(LogMessage:String);
begin
  //log.lines.add('LOG : ' + LogMessage);
end;

procedure TForm1.GetScanError(Errormessage:String);
begin
  log.Lines.Add('ERROR : ' + Errormessage);
end;


procedure TForm1.StartButtonClick(Sender: TObject);
begin
  log.Lines.Add('start button geklikt');
  if not assigned(thr) then
  begin
     thr := TSymbolScanner.Create(self);
     thr.OnError := @GetScanError;
     thr.OnScan := @GetScan;
     thr.OnLog := @GetLog;
     thr.open;
     thr.startscanner;
  end;
end;

procedure TForm1.EindebuttonClick(Sender: TObject);
begin
  Stopbuttonclick(Sender);
  close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  thr.startscanner;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  thr.disable;
end;

procedure TForm1.StopButtonClick(Sender: TObject);
begin
  if assigned(thr) then
  begin
     thr.free;
     thr := nil;
     log.Lines.add('stopbuttonclick SCANNER GESTOPT');;
   end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin

end;


end.

