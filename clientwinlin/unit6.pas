unit Unit6; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DbCtrls, DBGrids, db, IniPropStorage, unit2;

type

  { Tdagen }

  Tdagen = class(TForm)
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dagenPropStorage: TIniPropStorage;
    Panel1: TPanel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  dagen: Tdagen;

implementation

{ Tdagen }

procedure Tdagen.FormShow(Sender: TObject);
begin
  if DM.ZDagenTable.Active then
    DM.zDagenTable.Refresh
  else
    DM.zDagenTable.open;
end;

procedure Tdagen.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   if DM.ZDagenTable.State in [dsedit,dsinsert] then
     DM.ZDagenTable.post;
end;

procedure Tdagen.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
end;

initialization
  {$I unit6.lrs}

end.

