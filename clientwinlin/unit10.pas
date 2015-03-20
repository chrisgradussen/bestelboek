unit Unit10; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DbCtrls, DBGrids, IniPropStorage, db;

type

  { TBestelschema }

  TBestelschema = class(TForm)
    Datasource1: TDatasource;
    Datasource2: TDatasource;
    Datasource3: TDatasource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBNavigator3: TDBNavigator;
    bestelschemaPropStorage: TIniPropStorage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure Datasource3StateChange(Sender: TObject);
    procedure DBNavigator3Click(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Bestelschema: TBestelschema;

implementation

uses unit2;

{ TBestelschema }

procedure TBestelschema.FormShow(Sender: TObject);
begin
  if DM.ZBestelSchema_BestelgroepTable.active then
    DM.ZBestelSchema_BestelgroepTable.refresh
  else
    DM.ZBestelSchema_BestelgroepTable.open;
  if not DM.ZBestelSchema_BestelSchemaQuery.active then
//    DM.ZBestelSchema_BestelSchemaQuery.Refresh
//  else
    DM.ZBestelSchema_BestelSchemaQuery.open;
  if not DM.ZBestelSchema_BestRegelQuery.active then
//    DM.ZBestelSchema_BestRegelQuery.refresh
//  else
    DM.ZBestelSchema_BestRegelQuery.open;
end;

procedure TBestelschema.Datasource3StateChange(Sender: TObject);
begin

end;

procedure TBestelschema.DBNavigator3Click(Sender: TObject;
  Button: TDBNavButtonType);
begin

end;

procedure TBestelschema.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   if DM.ZBestelSchema_BestRegelQuery.State in [dsedit,dsinsert] then
     DM.ZBestelSchema_BestRegelQuery.post;
   if DM.ZBestelSchema_BestelSchemaQuery.State in [dsedit,dsinsert] then
     DM.ZBestelSchema_BestelSchemaQuery.post;
   if DM.ZBestelSchema_BestelgroepTable.State in [dsedit,dsinsert] then
     DM.ZBestelSchema_BestelgroepTable.Post;

end;

initialization
  {$I unit10.lrs}

end.

