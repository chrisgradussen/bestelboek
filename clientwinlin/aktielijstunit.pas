unit aktielijstunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LR_Class, LR_DBSet, ZDataset, rxdbgrid,
  LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls, Calendar, StdCtrls,
  db, DateUtils, strutils;

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
   zreadonlyquery1.Active:=true;
end;

procedure TFormAktielijst.AfdrukkenButtonClick(Sender: TObject);
var
    i : integer;
    s,sql1,sql2 : string;
begin
  sql1 := 'SELECT max(r.VOORDEEL) as aktieomschrijving,a.X_ARTIKELNUMMER,max(a.X_NAAM) as omschrijving ,max(a.X_VERKOOPPRIJS) as reclameprijs,'+
' max(begindatum) startdatum, max(einddatum) as einddatum FROM RECLAME_PROCEDURE(:BEGINDATUM,:STOPDATUM) r join artikel a on r.artikel_eanupc = a.EANUPC where r.begindatum <=  :STOPDATUM and  r.einddatum >= :BEGINDATUM and a.X_SUBGROEP_ID in (SELECT r.SUBGROEP_ID FROM GROEP r where r.BESTELGROEP_ID in :GROEPEN) group by a.X_ARTIKELNUMMER';

  zaktielijstquery.Close;
  zaktielijstquery.ParamByName('BEGINDATUM').AsDate:=  calendarstart.DateTime;
  zaktielijstquery.ParamByName('STOPDATUM').AsDate:=  calendarstop.DateTime;
  if rxdbgrid1.SelectedRows.Count > 0 then
  begin
    s := '(';
    for i := 0 to rxdbgrid1.SelectedRows.Count -1 do
    begin
      rxdbgrid1.DataSource.DataSet.GotoBookmark(rxdbgrid1.selectedrows.Items[i]);
      s := concat(s,(rxdbgrid1.datasource.DataSet.FieldByName('id').asstring));
      if i < rxdbgrid1.selectedrows.count -1 then
        s := concat(s,',');
    end;
    s := concat(s,')');



  sql1 := replacestr(sql1,':GROEPEN',s);

    zaktielijstquery.SQL.Text := sql1;

    zaktielijstquery.Open;
    frreport1.ShowReport;
  end;
end;

procedure TFormAktielijst.SluitenButtonClick(Sender: TObject);
begin
  close;
end;

initialization
  {$I aktielijstunit.lrs}

end.

