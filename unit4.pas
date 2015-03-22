unit Unit4; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DbCtrls, DBGrids, db, IniPropStorage, unit2;

type

  { Tleverancier }

  Tleverancier = class(TForm)
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    leverancierpropstorage: TIniPropStorage;
    Panel1: TPanel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  leverancier: Tleverancier;

implementation

{ Tleverancier }

procedure Tleverancier.FormShow(Sender: TObject);
begin
  if DM.ZleverancierTable.Active then
    DM.ZLeverancierTable.Refresh
  else
    DM.ZLeverancierTable.Open;
end;

procedure Tleverancier.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   if DM.ZLeverancierTable.State in [dsedit,dsinsert] then
     DM.ZLeverancierTable.post;
end;

initialization
  {$I unit4.lrs}

end.

