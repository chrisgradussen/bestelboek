unit reclameaanpassendlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, rxdbgrid, LResources, Forms,
  Controls, Graphics, Dialogs, DbCtrls, ExtCtrls, StdCtrls;

type

  { TFormReclameDlg }

  TFormReclameDlg = class(TForm)
    DataSource1: TDataSource;
    DBCalendar1: TDBCalendar;
    DBCalendar2: TDBCalendar;
    DBEdit1: TDBEdit;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBGrid1: TRxDBGrid;
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

procedure TFormReclameDlg.DBCalendar2Change(Sender: TObject);
begin
    datasource1.Edit;
  datasource1.DataSet.FieldByName('EINDDATUM').AsDateTime:=
  dbcalendar2.DateTime;
end;

procedure TFormReclameDlg.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if (datasource1.DataSet.FieldByName('VOORDEEL').IsNull = true )

  or (datasource1.DataSet.FieldByName('VOORDEEL').AsString = '') then
  begin
    if datasource1.state in [dsinsert] then
    begin
      datasource1.DataSet.Cancel
    end
    else
    begin
      datasource1.dataset.Delete;
    end;
  end;
  if datasource1.State in [dsedit,dsinsert] then datasource1.DataSet.Post;
end;

initialization
  {$I reclameaanpassendlg.lrs}

end.

