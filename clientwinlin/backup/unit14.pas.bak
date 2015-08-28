unit Unit14; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, DbCtrls, IniPropStorage, db,unit2;

type

  { TScripts }

  TScripts = class(TForm)
    Datasource1: TDatasource;
    Datasource2: TDatasource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    ScriptsPropStorage: TIniPropStorage;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Scripts: TScripts;

implementation

{ TScripts }

procedure TScripts.FormShow(Sender: TObject);
begin
  if dm.ZScripts_BestelgroepQuery.active then
    DM.ZScripts_BestelgroepQuery.refresh
  else
    DM.ZScripts_BestelgroepQuery.open;
  dm.ZScripts_BestelSchemaQuery.Params[0].AsInteger :=
  dm.ZScripts_BestelgroepQuery.FieldByName('id').asinteger;

  if dm.ZScripts_BestelSchemaQuery.Active then
    dm.ZScripts_BestelSchemaQuery.Refresh
  else
    dm.ZScripts_BestelSchemaQuery.Open;;
end;

procedure TScripts.DBGrid2DblClick(Sender: TObject);
begin
  dm.zscripts_levering_update.ParamByName('id').AsInteger :=
    dm.ZScripts_BestelSchemaQuery.FieldByName('id').asinteger;
    dm.zscripts_levering_update.Execute;
  showmessage('De volgende bestelling is geselecteerd ' + inttostr(dm.zscripts_levering_update.parambyname('id').asinteger));

  close;

end;

initialization
  {$I unit14.lrs}

end.

