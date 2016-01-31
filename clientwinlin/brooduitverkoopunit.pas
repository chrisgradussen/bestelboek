unit brooduitverkoopunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxdbgrid, LResources, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, Calendar, unit2,db;

type

  { TFormBroodUitverkoop }

  TFormBroodUitverkoop = class(TForm)
    Calendar: TCalendar;
    DataSource2: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBGrid1: TRxDBGrid;
    procedure CalendarDayChanged(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure RxDBGrid1AfterQuickSearch(Sender: TObject; Field: TField;
      var AValue: string);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormBroodUitverkoop: TFormBroodUitverkoop;

implementation

{ TFormBroodUitverkoop }

procedure TFormBroodUitverkoop.CalendarDayChanged(Sender: TObject);
begin
   dm.ZBroodUitverkoopquery.close;
  dm.ZBrooduitverkoopQuery.ParamByName('datum').AsDateTime:= calendar.DateTime;

  dm.ZBrooduitverkoopQuery.open;
end;

procedure TFormBroodUitverkoop.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure TFormBroodUitverkoop.FormShow(Sender: TObject);
begin
  datasource2.DataSet := dm.ZBroodUitverkoopQuery;
  if dm.ZBroodUitverkoopQuery.Active then
  begin
    dm.ZBroodUitverkoopQuery.Refresh;
  end
  else
  begin
    Calendar.Datetime:= now;
    dm.ZBroodUitverkoopQuery.ParamByName('datum').AsDateTime:= now;
    dm.ZBroodUitverkoopQuery.Open;
  end;
end;

procedure TFormBroodUitverkoop.RxDBGrid1AfterQuickSearch(Sender: TObject;
  Field: TField; var AValue: string);
begin

end;

initialization
  {$I brooduitverkoopunit.lrs}

end.

