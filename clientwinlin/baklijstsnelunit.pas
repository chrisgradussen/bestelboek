unit baklijstsnelunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil,  LResources, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, pickdate, rxdbgrid, dbdateedit, unit2, EditBtn, Calendar;

type

  { TForm2 }

  TForm2 = class(TForm)
    Calendar: TCalendar;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBGrid1: TRxDBGrid;
    procedure CalendarDayChanged(Sender: TObject);
    procedure DBDateEditAcceptDate(Sender: TObject; var ADate: TDateTime;
      var AcceptDate: Boolean);
    procedure DBDateEditEditingDone(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TICalendarEditingDone(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

{ TForm2 }

procedure TForm2.FormShow(Sender: TObject);
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

procedure TForm2.TICalendarEditingDone(Sender: TObject);
begin

end;

procedure TForm2.DBDateEditAcceptDate(Sender: TObject; var ADate: TDateTime;
  var AcceptDate: Boolean);
begin

end;

procedure TForm2.CalendarDayChanged(Sender: TObject);
begin
   dm.ZBaklijstquery.close;
  dm.ZBaklijstQuery.ParamByName('datum').AsDateTime:= calendar.DateTime;

  dm.ZBaklijstQuery.open;
end;

procedure TForm2.DBDateEditEditingDone(Sender: TObject);
begin

end;

initialization
  {$I baklijstsnelunit.lrs}

end.

