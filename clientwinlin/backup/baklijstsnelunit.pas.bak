unit baklijstsnelunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LR_Class, LR_DBSet, LResources, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, pickdate, rxdbgrid, dbdateedit, unit2, db,
  EditBtn, Calendar, StdCtrls;

type

  { TfrmBaklijstBroodjes }

  TfrmBaklijstBroodjes = class(TForm)
    Btn_legebaklijst: TButton;
    Calendar: TCalendar;
    DataSource1: TDataSource;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBGrid1: TRxDBGrid;
    procedure Btn_legebaklijstClick(Sender: TObject);
    procedure CalendarDayChanged(Sender: TObject);
    procedure DBDateEditAcceptDate(Sender: TObject; var ADate: TDateTime;
      var AcceptDate: Boolean);
    procedure DBDateEditEditingDone(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RxDBGrid1AfterQuickSearch(Sender: TObject; Field: TField;
      var AValue: string);
    procedure TICalendarEditingDone(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmBaklijstBroodjes: TfrmBaklijstBroodjes;

implementation

{ TfrmBaklijstBroodjes }

procedure TfrmBaklijstBroodjes.FormShow(Sender: TObject);
begin
  if dm.ZBaklijstQuery.Active then
  begin
    dm.ZBaklijstQuery.Refresh;
  end
  else
  begin
    Calendar.Datetime:= now;
    dm.ZBaklijstQuery.ParamByName('datum').AsDateTime:= now;
    dm.ZBaklijstQuery.Open;
  end;
end;

procedure TfrmBaklijstBroodjes.RxDBGrid1AfterQuickSearch(Sender: TObject;
  Field: TField; var AValue: string);
begin

end;

procedure TfrmBaklijstBroodjes.TICalendarEditingDone(Sender: TObject);
begin

end;

procedure TfrmBaklijstBroodjes.DBDateEditAcceptDate(Sender: TObject; var ADate: TDateTime;
  var AcceptDate: Boolean);
begin

end;

procedure TfrmBaklijstBroodjes.CalendarDayChanged(Sender: TObject);
begin
   dm.ZBaklijstquery.close;
  dm.ZBaklijstQuery.ParamByName('datum').AsDateTime:= calendar.DateTime;

  dm.ZBaklijstQuery.open;
end;

procedure TfrmBaklijstBroodjes.Btn_legebaklijstClick(Sender: TObject);
begin
  if datasource1.DataSet.Active then
  begin
    datasource1.dataset.Refresh;
  end
  else
  begin
    datasource1.DataSet.Open;
  end;
  if datasource1.DataSet.RecordCount > 0 then
  begin

    frreport1.CanRebuild:= true;
    frreport1.PrepareReport;
    frreport1.ShowPreparedReport;
    //frreport1.Clear;
  end;
end;

procedure TfrmBaklijstBroodjes.DBDateEditEditingDone(Sender: TObject);
begin

end;

initialization
  {$I baklijstsnelunit.lrs}

end.
