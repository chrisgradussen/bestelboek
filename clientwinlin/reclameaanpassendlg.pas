unit reclameaanpassendlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbExtCtrls, rxdbgrid, rxpickdate,LResources, Forms,
  Controls, Graphics, Dialogs, DbCtrls, ExtCtrls, StdCtrls;

type

  { TFormReclameDlg }

  TFormReclameDlg = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DBCalendar1: TDBCalendar;
    DBCalendar2: TDBCalendar;
    DBEdit1: TDBEdit;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure DBCalendar1Change(Sender: TObject);
    procedure DBCalendar2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormReclameDlg: TFormReclameDlg;

implementation

{ TFormReclameDlg }

procedure TFormReclameDlg.DBCalendar1Change(Sender: TObject);
begin

  datasource1.Edit;
  datasource1.DataSet.FieldByName('BEGINDATUM').AsDateTime:=
  dbcalendar1.DateTime;
end;

procedure TFormReclameDlg.Button1Click(Sender: TObject);
begin
  self.close;
end;

procedure TFormReclameDlg.DBCalendar2Change(Sender: TObject);
begin
    datasource1.Edit;
  datasource1.DataSet.FieldByName('EINDDATUM').AsDateTime:=
  dbcalendar2.DateTime;
end;

procedure TFormReclameDlg.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
var
   begindatum, einddatum : Tdatetime;
   voordeel  : string;
begin
  if datasource1.State in [dsedit,dsinsert] then datasource1.DataSet.Post;
  begindatum := datasource1.DataSet.FieldByName('BEGINDATUM').AsDateTime;
  einddatum := datasource1.DataSet.FieldByName('EINDDATUM').AsDateTime;
  voordeel := datasource1.DataSet.FieldByName('VOORDEEL').AsString;
  datasource1.DataSet.First;
  while not datasource1.dataset.EOF do
  begin
    datasource1.Edit;
    datasource1.DataSet.FieldByName('BEGINDATUM').AsDateTime := begindatum;
    datasource1.DataSet.FieldByName('EINDDATUM').AsDateTime := einddatum;
    datasource1.DataSet.FieldByName('VOORDEEL').AsString := voordeel;
    datasource1.DataSet.Post;
    datasource1.dataset.next;
  end;
  if (datasource1.DataSet.FieldByName('VOORDEEL').IsNull = true )
    or (datasource1.DataSet.FieldByName('VOORDEEL').AsString = '') then
  begin
    datasource1.dataset.first;
    while not datasource1.dataset.EOF do
    begin
      datasource1.dataset.Delete;
    end;
  end;
end;

initialization
  {$I reclameaanpassendlg.lrs}

end.

