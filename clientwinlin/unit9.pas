unit Unit9; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DbCtrls, DBGrids, IniPropStorage, db, unit2;

type

  { TStandaardBestelschema }

  TStandaardBestelschema = class(TForm)
    Datasource1: TDatasource;
    Datasource2: TDatasource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    SBestelschemaPropStorage: TIniPropStorage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    procedure Datasource2StateChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBestelschemaPropStorageRestoreProperties(Sender: TObject);
    procedure SBestelschemaPropStorageRestoringProperties(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  StandaardBestelschema: TStandaardBestelschema;

implementation

{ TStandaardBestelschema }

procedure TStandaardBestelschema.DBGrid2CellClick(Column: TColumn);
begin
end;

procedure TStandaardBestelschema.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
   if DM.ZSBestelSchema_SBestelSchemaTable.State in [dsedit,dsinsert] then
     DM.ZSBestelSchema_SBestelSchemaTable.post;
   if DM.ZSBestelSchema_BestelgroepTable.State in [dsedit,dsinsert] then
     DM.ZSBestelSchema_BestelgroepTable.post;
end;

procedure TStandaardBestelschema.FormCreate(Sender: TObject);
begin
  sbestelschemapropstorage.IniFileName:=getappconfigfile(false);
end;

procedure TStandaardBestelschema.FormShow(Sender: TObject);
begin
  if DM.ZSBestelSchema_BestelgroepTable.Active then
    DM.ZSBestelSchema_BestelgroepTable.Refresh
  else
    DM.ZSBestelSchema_BestelGroepTable.Open;
  if DM.ZSBestelSchema_SBestelSchemaTable.Active then
    DM.ZSBestelSchema_SBestelSchemaTable.refresh
  else
    DM.ZSBestelSchema_SBestelSchemaTable.Open;
end;

procedure TStandaardBestelschema.SBestelschemaPropStorageRestoreProperties(
  Sender: TObject);
begin
end;

procedure TStandaardBestelschema.DBGrid1DblClick(Sender: TObject);
begin
end;

procedure TStandaardBestelschema.Datasource2StateChange(Sender: TObject);
begin

end;

procedure TStandaardBestelschema.SBestelschemaPropStorageRestoringProperties(
  Sender: TObject);
begin
end;

initialization
  {$I unit9.lrs}

end.

