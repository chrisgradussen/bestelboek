unit aktielijstunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LR_Class, LR_DBSet, ZDataset, rxdbgrid,
  LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls, Calendar, StdCtrls,
  db, DateUtils;

type

  { TFormAktielijst }

  TFormAktielijst = class(TForm)
    AfdrukkenButton: TButton;
    DataSource1: TDataSource;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    SluitenButton: TButton;
    CalendarStart: TCalendar;
    CalendarStop: TCalendar;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    RxDBGrid1: TRxDBGrid;
    ZReadOnlyQuery1: TZReadOnlyQuery;
    ZAktielijstQuery: TZReadOnlyQuery;
    procedure AfdrukkenButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RxDBGrid1AfterQuickSearch(Sender: TObject; Field: TField;
      var AValue: string);
    procedure SluitenButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormAktielijst: TFormAktielijst;

implementation

{ TFormAktielijst }

procedure TFormAktielijst.RxDBGrid1AfterQuickSearch(Sender: TObject;
  Field: TField; var AValue: string);
begin

end;

procedure TFormAktielijst.FormShow(Sender: TObject);
var
   ayear,amonth,aweekofmonth,adayofweek :word;
begin
   DecodeDateMonthWeek(now,ayear,amonth,aweekofmonth,adayofweek);
   Calendarstart.DateTime := encodedatemonthweek(ayear,amonth,aweekofmonth,daywednesday);
   Calendarstop.DateTime := incday(Calendarstart.DateTime,6);
end;

procedure TFormAktielijst.AfdrukkenButtonClick(Sender: TObject);
begin
  frreport1.ShowReport;
end;

procedure TFormAktielijst.SluitenButtonClick(Sender: TObject);
begin
  close;
end;

initialization
  {$I aktielijstunit.lrs}

end.

