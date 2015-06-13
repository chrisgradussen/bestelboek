unit WaitDlgUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;
type

  { TWaitDlg }

  TWaitDlg = class(TForm)
    Label1: TLabel;
    Timer: TTimer;
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure TimerStartTimer(Sender: TObject);
    procedure TimerStopTimer(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    private
    { private declarations }
  public
    { public declarations }
    parentform : TForm;
    procedure showwait(lparentform : TForm);
  end;

var
  WaitDlg: TWaitDlg;

implementation

{$R *.lfm}
uses artikelunit ;

{ TWaitDlg }

procedure TWaitDlg.showwait(lparentform : TForm);
begin
  tag := 0;
  lparentform.Enabled:= false;
  application.ProcessMessages;
  parentform := lparentform;
  application.ProcessMessages;
  WaitDlg.Show;
  application.ProcessMessages;
end;

procedure TWaitDlg.FormShow(Sender: TObject);
begin
  timer.Enabled:= true;
  waitdlg.ShowOnTop;
  application.ProcessMessages;
end;

procedure TWaitDlg.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key = 's' then
    tag := 1;
end;

procedure TWaitDlg.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  application.ProcessMessages;
  parentform.Enabled:= true;
  if (parentform.ClassName = 'TArtikelForm') then
  begin
    artikelunit.artikelform.zetfocus;
  end;
end;

procedure TWaitDlg.TimerStartTimer(Sender: TObject);
begin

end;

procedure TWaitDlg.TimerStopTimer(Sender: TObject);
begin
//  sleep(2000);
  application.ProcessMessages;
  waitdlg.Close;
  application.ProcessMessages;
end;

procedure TWaitDlg.TimerTimer(Sender: TObject);
begin
  if tag <> 0 then
  begin
    timer.Enabled:= false;
  end;
end;
{ TWaitDlg }


end.

