unit multiplierunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  DbCtrls, unit2,db;

type

  { TFormMultiplier }

  TFormMultiplier = class(TForm)
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormMultiplier: TFormMultiplier;

implementation

{ TFormMultiplier }

procedure TFormMultiplier.FormShow(Sender: TObject);
begin
   if DM.ZMultiplierTable.Active then
    DM.ZMultiplierTable.Refresh
  else
    DM.ZMultiplierTable.Open;
end;

procedure TFormMultiplier.FormCloseQuery(Sender: TObject; var CanClose: boolean
  );
begin
   if DM.ZMultiplierTable.State in [dsedit,dsinsert] then
     DM.ZMultiplierTable.post;
end;

initialization
  {$I multiplierunit.lrs}

end.

