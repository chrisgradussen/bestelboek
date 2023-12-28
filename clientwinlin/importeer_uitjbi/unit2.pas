unit unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  IniPropStorage, ComCtrls, ZConnection, fpspreadsheetgrid, fpsallformats,
  fpspreadsheetctrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    dbPropStorage: TIniPropStorage;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    StatusBar1: TStatusBar;
    sWorkbookSource1: TsWorkbookSource;
    sWorksheetGrid1: TsWorksheetGrid;
    ZConnection1: TZConnection;
    procedure Button1Click(Sender: TObject);
    procedure ZConnection1BeforeConnect(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  if opendialog1.Execute then
    sWorkbooksource1.FileName:= opendialog1.FileName;
end;

procedure TForm1.ZConnection1BeforeConnect(Sender: TObject);
begin
    dbpropstorage.IniFileName:=getappconfigfile(false);
  DBPropStorage.restore;
  ZConnection1.HostName:= dbpropstorage.StoredValue['hostname'];
  ZConnection1.User:=dbpropstorage.StoredValue['user'];
  ZConnection1.Password:= dbpropstorage.StoredValue['password'];
  ZConnection1.Database:= dbpropstorage.storedvalue['database'];
  ZConnection1.Port:= strtoint(dbpropstorage.StoredValue['port']);
  statusbar1.Caption:= 'HOSTNAME = '+ zconnection1.hostname + ' database = '+ zconnection1.Database;
end;

end.

