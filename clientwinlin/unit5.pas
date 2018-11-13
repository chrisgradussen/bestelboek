unit Unit5; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DbCtrls, DBGrids, IniPropStorage, db, unit2;

type

  { Tsubgroep }

  Tsubgroep = class(TForm)
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    subgroepPropStorage: TIniPropStorage;
    Panel1: TPanel;
    procedure Datasource1StateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  subgroep: Tsubgroep;

implementation

{ Tsubgroep }

procedure Tsubgroep.Datasource1StateChange(Sender: TObject);
begin

end;

procedure Tsubgroep.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   if DM.ZSubgroepTable.State in [dsedit,dsinsert] then
     DM.ZSubgroepTable.post;
end;

procedure Tsubgroep.FormCreate(Sender: TObject);
begin
  subgroeppropstorage.IniFileName:=getappconfigfile(false);
end;

procedure Tsubgroep.FormShow(Sender: TObject);
begin
  if DM.zSubgroepTable.Active then
    DM.zSubgroepTable.Refresh
  else
    DM.zSubgroepTable.open;
end;

initialization
  {$I unit5.lrs}

end.

