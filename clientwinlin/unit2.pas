unit unit2;

//{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Dialogs,
  ZConnection, ZDataset, db, ZSqlUpdate, ZSequence, ZIBEventAlerter,
  ZStoredProcedure, ZSqlProcessor, unit10, unit12, IniPropStorage, ZAbstractDataset;

type

  { TDM }

  TDM = class(TDataModule)
    BaklijstDagDataSource: TDatasource;
    BaklijstDataSource: TDatasource;
    BaklijstGeschiedenisDataSource: TDatasource;
    BaklijstDagLookupDataSource: TDatasource;
    Datasource1: TDatasource;
    Afdelingsdatasource: TDataSource;
    feestdagendatasource: TDataSource;
    DBPropStorage: TIniPropStorage;
    ZArtikelOmschrijvingARTIKELNUMMER: TStringField;
    ZArtikelOmschrijvingBESTELEENHEID: TStringField;
    ZArtikelOmschrijvingBESTELINHOUD: TFloatField;
    ZArtikelOmschrijvingEANUPC: TStringField;
    ZArtikelOmschrijvingEENHEID: TStringField;
    ZArtikelOmschrijvingINHOUD: TFloatField;
    ZArtikelOmschrijvingMARGE: TFloatField;
    ZArtikelOmschrijvingNAAM: TStringField;
    ZArtikelOmschrijvingVERKOOPPRIJS: TFloatField;
    ZArtikelOmschrijvingVOORRAAD: TFloatField;
    ZArtikelomzetDIN1: TFloatField;
    ZArtikelomzetDON1: TFloatField;
    ZArtikelomzetJAARWEEK1: TLongintField;
    ZArtikelomzetMAA1: TFloatField;
    ZArtikelOmzetQueryDIN: TFloatField;
    ZArtikelOmzetQueryDON: TFloatField;
    ZArtikelOmzetQueryJAARWEKEN: TLongintField;
    ZArtikelOmzetQueryMAA: TFloatField;
    ZArtikelOmzetQueryOMSCHRIJVING: TStringField;
    ZArtikelOmzetQueryRECLAME: TStringField;
    ZArtikelOmzetQueryTOT: TFloatField;
    ZArtikelOmzetQueryVOORDEEL: TStringField;
    ZArtikelOmzetQueryVRI: TFloatField;
    ZArtikelOmzetQueryWOE: TFloatField;
    ZArtikelOmzetQueryZAT: TFloatField;
    ZArtikelOmzetQueryZON: TFloatField;
    ZArtikelomzetTOT1: TFloatField;
    ZArtikelomzetVOORDEEL1: TStringField;
    ZArtikelomzetVRI1: TFloatField;
    ZArtikelomzetWOE1: TFloatField;
    ZArtikelomzetZAT1: TFloatField;
    ZArtikelomzetZON1: TFloatField;
    ZArtikelQueryEANUPC: TLargeintField;
    ZArtikelQueryL_ARTIKELNUMMER: TStringField;
    ZArtikelQueryL_BESTELEENHEID: TStringField;
    ZArtikelQueryL_BESTELINHOUD: TFloatField;
    ZArtikelQueryL_LEVERANCIER_ID: TLongintField;
    ZArtikelQueryL_MERKNAAM: TStringField;
    ZArtikelQueryL_NAAM: TStringField;
    ZArtikelQueryL_SUBGROEP_ID: TLongintField;
    ZArtikelQueryMINIMALEVOORRAAD: TFloatField;
    ZArtikelQueryVOLGORDE: TFloatField;
    ZArtikelQueryVOORRAAD: TFloatField;
    ZArtikelQueryX_ARTIKELNUMMER: TStringField;
    ZArtikelQueryX_BESTELEENHEID: TStringField;
    ZArtikelQueryX_BESTELINHOUD: TFloatField;
    ZArtikelQueryX_BTWCODE: TLongintField;
    ZArtikelQueryX_EENHEID: TStringField;
    ZArtikelQueryX_INHOUD: TFloatField;
    ZArtikelQueryX_INKOOPPRIJS: TFloatField;
    ZArtikelQueryX_INVOERDATUM: TDateTimeField;
    ZArtikelQueryX_KASSATEKST: TStringField;
    ZArtikelQueryX_LEVERANCIER_ID: TLongintField;
    ZArtikelQueryX_MERKNAAM: TStringField;
    ZArtikelQueryX_NAAM: TStringField;
    ZArtikelQueryX_SUBGROEP_ID: TLongintField;
    ZArtikelQueryX_VERKOOPPRIJS: TFloatField;
    ZArtikelQueryX_WIJZIGINGSDATUM: TDateTimeField;
    ZArtikelTableEANUPC: TLargeintField;
    ZArtikelTableL_ARTIKELNUMMER: TStringField;
    ZArtikelTableL_BESTELEENHEID: TStringField;
    ZArtikelTableL_BESTELINHOUD: TFloatField;
    ZArtikelTableL_LEVERANCIER_ID: TLongintField;
    ZArtikelTableL_MERKNAAM: TStringField;
    ZArtikelTableL_NAAM: TStringField;
    ZArtikelTableL_SUBGROEP_ID: TLongintField;
    ZArtikelTableMINIMALEVOORRAAD: TFloatField;
    ZArtikelTableVOLGORDE: TFloatField;
    ZArtikelTableVOORRAAD: TFloatField;
    ZArtikelTableX_ARTIKELNUMMER: TStringField;
    ZArtikelTableX_BESTELEENHEID: TStringField;
    ZArtikelTableX_BESTELINHOUD: TFloatField;
    ZArtikelTableX_BTWCODE: TLongintField;
    ZArtikelTableX_EENHEID: TStringField;
    ZArtikelTableX_INHOUD: TFloatField;
    ZArtikelTableX_INKOOPPRIJS: TFloatField;
    ZArtikelTableX_INVOERDATUM: TDateTimeField;
    ZArtikelTableX_KASSATEKST: TStringField;
    ZArtikelTableX_LEVERANCIER_ID: TLongintField;
    ZArtikelTableX_MERKNAAM: TStringField;
    ZArtikelTableX_NAAM: TStringField;
    ZArtikelTableX_SUBGROEP_ID: TLongintField;
    ZArtikelTableX_VERKOOPPRIJS: TFloatField;
    ZArtikelTableX_WIJZIGINGSDATUM: TDateTimeField;
    ZArtikelQuery: TZQuery;
    ZBaklijstDagQuery: TZQuery;
    ZBaklijstDagQueryID: TLongintField;
    ZBaklijstDagQueryLEVERDATUM: TDateField;
    ZBaklijstQuery: TZQuery;
    ZBaklijstGeschiedenisQuery: TZQuery;
    ZBaklijstDagLookupQuery: TZReadOnlyQuery;
    ZBestelSchema_BestRegelQueryAANTAL: TFloatField;
    ZBestelSchema_BestRegelQueryADVIES_AANTAL: TFloatField;
    ZBestelSchema_BestRegelQueryARTIKELNUMMER: TStringField;
    ZBestelSchema_BestRegelQueryARTIKEL_EANUPC: TFloatField;
    ZBestelSchema_BestRegelQueryBESTELSCHEMA_ID: TLongintField;
    ZBestelSchema_BestRegelQueryNAAM: TStringField;
    ZBroodUitverkoopDataSoure: TDataSource;
    ZBroodUitverkoopQuery: TZQuery;
    ZBroodUitverkoopQueryBROODGROEP: TStringField;
    ZBroodUitverkoopQueryDRIEUUR: TFloatField;
    ZBroodUitverkoopQueryTIENUUR: TFloatField;
    ZBroodUitverkoopQueryTOTAAL: TFloatField;
    ZBroodUitverkoopQueryTWAALFUUR: TFloatField;
    ZBroodUitverkoopQueryTWEEUUR: TFloatField;
    ZBroodUitverkoopQueryVIERUUR: TFloatField;
    ZBroodUitverkoopQueryVIJFUUR: TFloatField;
    ZBroodUitverkoopQueryZESUUR: TFloatField;
    ZBroodUitverkoopQueryZEVENUUR: TFloatField;
    ZFeestdagenqueryARTIKELNUMMER: TStringField;
    ZFeestdagenqueryDIN: TFloatField;
    ZFeestdagenqueryDON: TFloatField;
    ZFeestdagenqueryJAARWEEK: TLongintField;
    ZFeestdagenqueryMAA: TFloatField;
    ZFeestdagenqueryNAAM: TStringField;
    ZFeestdagenqueryTOT: TFloatField;
    ZFeestdagenqueryVRI: TFloatField;
    ZFeestdagenqueryWOE: TFloatField;
    ZFeestdagenqueryZAT: TFloatField;
    ZFeestdagenqueryZON: TFloatField;
    ZMultiplierTablePERCENTAGE: TFloatField;
    ZArtikelOmzetgegevensAdd: TZSQLProcessor;
    ZQuery1: TZQuery;
    ZQuery1CHARGE_1: TLongintField;
    ZQuery1CHARGE_2: TLongintField;
    ZQuery1CHARGE_3: TLongintField;
    ZQuery1PLU: TLargeintField;
    ZQuery1X_NAAM: TStringField;
    ZeanQuery: TZReadOnlyQuery;
    ZBaklijstvolgordequery: TZQuery;
    ZArtikelomzetReclameQuery: TZQuery;
    ZArtikelOmzetQuery: TZReadOnlyQuery;
    ZGebruikersQuery: TZReadOnlyQuery;
    Afdelingstable: TZTable;
    ZFeestdagenquery: TZReadOnlyQuery;
    ZUpdateReclameSql: TZQuery;
    ZReclameQuery: TZQuery;
    ZReclameQueryARTIKEL_EANUPC: TLargeintField;
    ZReclameQueryBEGINDATUM: TDateField;
    ZReclameQueryEINDDATUM: TDateField;
    ZReclameQueryVOORDEEL: TStringField;
    ZScripts_BestelgroepQuery: TZReadOnlyQuery;
    ZScripts_BestelSchemaQuery: TZQuery;
    ZBestelSchema_BestRegelQuery: TZQuery;
    ZIBEventAlerter1: TZIBEventAlerter;
    ZArtikelOmschrijving: TZReadOnlyQuery;
    ZBestelSchema_BestelSchemaQuery: TZQuery;
    zscripts_levering_update: TZSQLProcessor;
    ZBaklijstUpdateSQL: TZUpdateSQL;
    ZBaklijstVolgordeUpdateSql: TZUpdateSQL;
    ZMultiplierTable: TZTable;
    ZZoekArtikelQuery: TZReadOnlyQuery;
    ZSBestelSchemaDataSource: TDatasource;
    ZConnection: TZConnection;
    ZBestelgroepTable: TZTable;
    ZGroepTableBESTELGROEP_ID: TLongintField;
    ZGroepTableLEVERANCIER_ID: TLongintField;
    ZGroepTableSUBGROEP_ID: TLongintField;
    ZGroep_BestelgroepTableID: TLongintField;
    ZLeverancierTable: TZTable;
    ZBestellingAfdrukkenQuery: TZQuery;
    ZbestellingQuery: TZReadOnlyQuery;
    ZBestelSchema_BestelgroepTable: TZTable;
    ZSequence_bestelschema_standaard_id: TZSequence;
    ZSequence_bestelschema_id: TZSequence;
    zSubgroepTable: TZTable;
    zDagenTable: TZTable;
    ZGroepTable: TZTable;
    ZGroep_SubgroepTable: TZTable;
    ZGroep_LeverancierTable: TZTable;
    ZGroep_BestelgroepTable: TZTable;
    ZSBestelSchema_BestelgroepTable: TZTable;
    ZSBestelSchema_SBestelSchemaTable: TZTable;
    ZArtikelTable: TZTable;
    zupdatestatussql: TZUpdateSQL;
    ZZoekArtikelQueryARTIKELNUMMER: TStringField;
    ZZoekArtikelQueryBESTELEENHEID: TStringField;
    ZZoekArtikelQueryBESTELINHOUD: TFloatField;
    ZZoekArtikelQueryDATUM: TDateTimeField;
    ZZoekArtikelQueryEANUPC: TLargeintField;
    ZZoekArtikelQueryEENHEID: TStringField;
    ZZoekArtikelQueryINHOUD: TFloatField;
    ZZoekArtikelQueryNAAM: TStringField;
    procedure BaklijstDagDataSourceDataChange(Sender: TObject; Field: TField);
    procedure BaklijstDagLookupDataSourceDataChange(Sender: TObject;
      Field: TField);
    procedure BaklijstGeschiedenisDataSourceDataChange(Sender: TObject;
      Field: TField);
    procedure DataModuleCreate(Sender: TObject);
    procedure DBPropStorageRestoringProperties(Sender: TObject);
    procedure ZArtikelQueryAfterOpen(DataSet: TDataSet);
    procedure ZArtikelQueryAfterRefresh(DataSet: TDataSet);
    procedure ZArtikelTableX_INHOUDSetText(Sender: TField; const aText: string);
    procedure ZBaklijstQueryBeforeInsert(DataSet: TDataSet);
    procedure ZBaklijstQueryBeforeRefresh(DataSet: TDataSet);
    procedure ZBestelSchema_BestelgroepTableAfterScroll(DataSet: TDataSet);
    procedure ZBestelSchema_BestelSchemaQueryAfterPost(DataSet: TDataSet);
    procedure ZBestelSchema_BestelSchemaQueryAfterScroll(DataSet: TDataSet);
    procedure ZBestelSchema_BestelSchemaQueryBeforeOpen(DataSet: TDataSet);
    procedure ZBestelSchema_BestelSchemaQueryBeforePost(DataSet: TDataSet);
    procedure ZBestelSchema_BestelSchemaQueryBeforeRefresh(DataSet: TDataSet);
    procedure ZBestelSchema_BestRegelQueryAfterInsert(DataSet: TDataSet);
    procedure ZBestelSchema_BestRegelQueryAfterPost(DataSet: TDataSet);
    procedure ZBestelSchema_BestRegelQueryBeforeOpen(DataSet: TDataSet);
    procedure ZBestelSchema_BestRegelQueryBeforePost(DataSet: TDataSet);
    procedure ZBestelSchema_BestRegelQueryBeforeRefresh(DataSet: TDataSet);
    procedure ZConnectionAfterConnect(Sender: TObject);
    procedure ZConnectionBeforeConnect(Sender: TObject);
    procedure ZFeestdagenqueryZONChange(Sender: TField);
    procedure ZIBEventAlerter1EventAlert(Sender: TObject; EventName: string;
      EventCount: longint; var CancelAlerts: boolean);
    procedure ZArtikelOmzetgegevensAddAfterExecute(Processor: TZSQLProcessor;
      StatementIndex: Integer);
    procedure ZReclameQueryBeforeInsert(DataSet: TDataSet);
    procedure ZReclameQueryBeforePost(DataSet: TDataSet);
    procedure ZSBestelSchema_SBestelSchemaTableBeforePost(DataSet: TDataSet);
    procedure ZScripts_BestelgroepQueryAfterScroll(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  DM: TDM;

implementation

{ TDM }

procedure TDM.ZSBestelSchema_SBestelSchemaTableBeforePost(DataSet: TDataSet);
begin
    if dataset.state in [dsinsert] then
   begin
     self.ZSBestelSchema_SBestelSchemaTable.FieldByName('ID').AsInteger :=
     self.ZSequence_bestelschema_standaard_id.GetNextValue;
   end;
end;

procedure TDM.ZScripts_BestelgroepQueryAfterScroll(DataSet: TDataSet);
begin
  self.ZScripts_BestelSchemaQuery.Params[0].AsInteger :=
     self.ZScripts_BestelgroepQuery.FieldByName('id').asinteger;
  if self.ZScripts_BestelSchemaQuery.Active then
    self.ZScripts_BestelSchemaQuery.Refresh;
end;

procedure TDM.ZBestelSchema_BestRegelQueryAfterInsert(DataSet: TDataSet);
begin
//  showmessage('after insert');
end;

procedure TDM.ZBestelSchema_BestRegelQueryAfterPost(DataSet: TDataSet);
begin
   ZBestelSchema_BestRegelQuery.Refresh;
end;

procedure TDM.ZBestelSchema_BestRegelQueryBeforeOpen(DataSet: TDataSet);
begin
  ZBestelSchema_BestRegelQueryBeforeRefresh(DataSet);
end;

procedure TDM.ZBestelSchema_BestRegelQueryBeforePost(DataSet: TDataSet);
begin
    ZoekArtikel.ZoekTekst.text := dataset.Fieldbyname('artikel_Eanupc').AsString;
    zoekartikel.Zoek(nil);
    if zoekartikel.zoektekst.text = '' then
    begin
      dataset.Cancel;
    end
    else
      dataset.Fieldbyname('artikel_Eanupc').AsString := zoekartikel.zoektekst.text;
    if dataset.State in [dsInsert] then
      dataset.FieldByName('bestelschema_id').AsInteger:= ZBestelSchema_Bestelschemaquery.FieldByName('ID').AsInteger;
end;

procedure TDM.ZBestelSchema_BestRegelQueryBeforeRefresh(DataSet: TDataSet);
begin
  ZBestelSchema_BestRegelQuery.ParamByName('id').AsInteger:=
    ZBestelSchema_BestelSchemaQuery.FieldByName('id').AsInteger;
end;

procedure TDM.ZConnectionAfterConnect(Sender: TObject);
begin

end;

procedure TDM.ZConnectionBeforeConnect(Sender: TObject);
begin
  dbpropstorage.IniFileName:=getappconfigfile(false);
  DBPropStorage.restore;
  ZConnection.HostName:= dbpropstorage.StoredValue['hostname'];
  ZConnection.User:=dbpropstorage.StoredValue['user'];
  ZConnection.Password:= dbpropstorage.StoredValue['password'];
  ZConnection.Database:= dbpropstorage.storedvalue['database'];
  ZConnection.Port:= strtoint(dbpropstorage.StoredValue['port']);
end;

procedure TDM.ZFeestdagenqueryZONChange(Sender: TField);
begin

end;

procedure TDM.ZIBEventAlerter1EventAlert(Sender: TObject; EventName: string;
  EventCount: longint; var CancelAlerts: boolean);
begin
  if unit10.Bestelschema.Visible then
  showmessage('VISIBLE eventalert ' + EventName + ' ' + inttostr(eventcount))
  else
  showmessage('NIET VISIBLE eventalert ' + EventName + ' ' + inttostr(eventcount));
  if unit10.Bestelschema.WindowState = wsminimized then
   showmessage('minimized')
   else
     showmessage('really visible');
end;

procedure TDM.ZArtikelOmzetgegevensAddAfterExecute(Processor: TZSQLProcessor;
  StatementIndex: Integer);
begin

end;

procedure TDM.ZReclameQueryBeforeInsert(DataSet: TDataSet);
begin
  zreclamequery.ParamByName('eanupc').asfloat :=
  zArtikelQuery.FieldByName('eanupc').asfloat;
end;

procedure TDM.ZReclameQueryBeforePost(DataSet: TDataSet);
begin
  if dataset.State in [dsInsert] then
  BEGIN
    zreclamequery.FIELDBYNAME('ARTIKEL_eanupc').asfloat :=
    zArtikelQuery.FieldByName('eanupc').asfloat;
  end;
end;

procedure TDM.ZBestelSchema_BestelgroepTableAfterScroll(DataSet: TDataSet);
begin
  if ZBestelSchema_BestelSchemaQuery.Active then
    ZBestelSchema_BestelSchemaQuery.Refresh
end;

procedure TDM.ZBestelSchema_BestelSchemaQueryAfterPost(DataSet: TDataSet);
begin
  DataSet.Refresh;
end;

procedure TDM.ZBestelSchema_BestelSchemaQueryAfterScroll(DataSet: TDataSet);
begin
  if ZBestelSchema_BestRegelQuery.Active then
    ZBestelSchema_BestRegelQuery.refresh;
end;

procedure TDM.ZBestelSchema_BestelSchemaQueryBeforeOpen(DataSet: TDataSet);
begin
  ZBestelSchema_BestelSchemaQueryBeforeRefresh(DataSet);
end;

procedure TDM.ZBestelSchema_BestelSchemaQueryBeforePost(DataSet: TDataSet);
begin
  if dataset.State in [dsInsert] then
    dataset.FieldByName('BESTELGROEP_ID').AsInteger:= ZBestelSchema_BestelGroepTable.FieldByName('ID').AsInteger;
end;

procedure TDM.ZBestelSchema_BestelSchemaQueryBeforeRefresh(DataSet: TDataSet);
begin
  ZBestelSchema_BestelSchemaQuery.ParamByName('bestelgroep_id').AsInteger:=
    ZBestelSchema_BestelgroepTable.FieldByName('id').AsInteger;
end;

procedure TDM.ZArtikelQueryAfterOpen(DataSet: TDataSet);
begin
  dm.ZReclameQuery.ParamByName('eanupc').AsFloat := dm.ZArtikelQuery.FieldByName('eanupc').asfloat;
end;

procedure TDM.BaklijstDagDataSourceDataChange(Sender: TObject; Field: TField);
begin
  if zbaklijstgeschiedenisquery.Active then
     zbaklijstgeschiedenisquery.Refresh;
end;

procedure TDM.BaklijstDagLookupDataSourceDataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure TDM.BaklijstGeschiedenisDataSourceDataChange(Sender: TObject;
  Field: TField);
begin

end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  dbpropstorage.IniFileName:=getappconfigfile(false);
end;

procedure TDM.DBPropStorageRestoringProperties(Sender: TObject);
begin

end;

procedure TDM.ZArtikelQueryAfterRefresh(DataSet: TDataSet);
begin
  dm.ZReclameQuery.ParamByName('eanupc').AsFloat := dm.ZArtikelQuery.FieldByName('eanupc').asfloat;
end;

procedure TDM.ZArtikelTableX_INHOUDSetText(Sender: TField; const aText: string);
begin
  showmessage('settext');
end;

procedure TDM.ZBaklijstQueryBeforeInsert(DataSet: TDataSet);
begin

end;

procedure TDM.ZBaklijstQueryBeforeRefresh(DataSet: TDataSet);
begin

end;



initialization
  {$I unit2.lrs}

end.

