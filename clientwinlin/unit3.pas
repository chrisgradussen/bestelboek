unit Unit3; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, DbCtrls, db, IniPropStorage, unit2;

type

  { Tbestelgroep }

  Tbestelgroep = class(TForm)
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    bestelgroepPropStorage: TIniPropStorage;
    Panel2: TPanel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  bestelgroep: Tbestelgroep;

implementation

{ Tbestelgroep }

procedure Tbestelgroep.FormShow(Sender: TObject);
begin
  if DM.ZBestelgroepTable.Active then
    DM.ZBestelgroepTable.Refresh
  else
    DM.ZBestelgroepTable.Open;
end;

procedure Tbestelgroep.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   if DM.ZBestelgroepTable.State in [dsedit,dsinsert] then
     DM.ZBestelgroepTable.post;
end;

procedure Tbestelgroep.FormCreate(Sender: TObject);
begin
  bestelgroeppropstorage.IniFileName:=getappconfigfile(false);
end;

initialization
  {$I unit3.lrs}

end.

