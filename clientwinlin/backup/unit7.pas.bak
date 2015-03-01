unit Unit7; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, db, DbCtrls, DBGrids, IniPropStorage, rxdbgrid,unit2;

type

  { TGroep }

  TGroep = class(TForm)
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroepPropStorage: TIniPropStorage;
    Panel1: TPanel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure RxDBGrid1GetBtnParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; var SortMarker: TSortMarker;
      IsDown: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Groep: TGroep;

implementation

{ TGroep }

procedure TGroep.RxDBGrid1GetBtnParams(Sender: TObject; Field: TField;
  AFont: TFont; var Background: TColor; var SortMarker: TSortMarker;
  IsDown: Boolean);
begin

end;

procedure TGroep.FormShow(Sender: TObject);
begin
  if DM.ZGroepTable.Active then
    DM.ZGroepTable.refresh
  else
    DM.ZGroepTable.open;
end;

procedure TGroep.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   if DM.ZGroepTable.State in [dsedit,dsinsert] then
     DM.ZGroepTable.post;
end;

initialization
  {$I unit7.lrs}

end.

