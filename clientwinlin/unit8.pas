unit Unit8; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, db, IniPropStorage, rxdbgrid, DbCtrls, DBGrids, LR_Class,
  LR_BarC, LR_Desgn, LR_DBSet, unit2, LR_DSet;

type

  { Tbestellingafdrukken }

  Tbestellingafdrukken = class(TForm)
    Datasource1: TDatasource;
    Datasource2: TDatasource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    bestellingafdrukkenPropStorage: TIniPropStorage;
    frBarCodeObject1: TfrBarCodeObject;
    frDBDataSet1: TfrDBDataSet;
    frDesigner1: TfrDesigner;
    frReport1: TfrReport;
    Panel1: TPanel;
    procedure bestellingafdrukkenPropStorageRestoreProperties(Sender: TObject);
    procedure Datasource1DataChange(Sender: TObject; Field: TField);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBNavigator1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frDBDataSet1CheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frDesigner1LoadReport(Report: TfrReport; var ReportName: String);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  bestellingafdrukken: Tbestellingafdrukken;

implementation

{ Tbestellingafdrukken }

procedure Tbestellingafdrukken.DBGrid1DblClick(Sender: TObject);
begin
  if dm.zBestellingAfdrukkenQuery.RecordCount > 0 then
  begin
      unit2.dm.zbestellingquery.close;
      unit2.dm.zbestellingquery.Params[0].AsInteger:=
      unit2.dm.ZBestellingAfdrukkenQuery.FieldByName('ID').AsInteger;
      unit2.DM.ZbestellingQuery.Open;

    frreport1.ShowReport;
    unit2.dm.zBestellingAfdrukkenQuery.Edit;
    unit2.dm.zBestellingAfdrukkenQuery.FieldByName('Status').asinteger := 40;
    unit2.dm.zBestellingAfdrukkenQuery.Post;
    unit2.dm.zBestellingAfdrukkenQuery.Refresh;
    unit2.dm.ZBestellingQuery.Close;
    Close;
  end;

end;

procedure Tbestellingafdrukken.DBNavigator1DblClick(Sender: TObject);
begin
end;

procedure Tbestellingafdrukken.FormCreate(Sender: TObject);
begin
  bestellingafdrukkenpropstorage.IniFileName:=getappconfigfile(false);
end;

procedure Tbestellingafdrukken.FormShow(Sender: TObject);
begin
  if dm.ZBestellingAfdrukkenQuery.Active then
    dm.zBestellingAfdrukkenQuery.Refresh
  else
    dm.zBestellingAfdrukkenQuery.open;
end;

procedure Tbestellingafdrukken.frDBDataSet1CheckEOF(Sender: TObject;
  var Eof: Boolean);
begin

end;

procedure Tbestellingafdrukken.frDesigner1LoadReport(Report: TfrReport;
  var ReportName: String);
begin

end;

procedure Tbestellingafdrukken.DBGrid1CellClick(Column: TColumn);
begin

end;

procedure Tbestellingafdrukken.bestellingafdrukkenPropStorageRestoreProperties(
  Sender: TObject);
begin

end;

procedure Tbestellingafdrukken.Datasource1DataChange(Sender: TObject;
  Field: TField);
begin

end;

initialization
  {$I unit8.lrs}

end.

