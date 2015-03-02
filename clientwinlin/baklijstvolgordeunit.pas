unit baklijstvolgordeunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, LResources, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, DbCtrls, unit2;

type

  { TBaklijstvolgordeform }

  TBaklijstvolgordeform = class(TForm)
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBGrid1: TRxDBGrid;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Baklijstvolgordeform: TBaklijstvolgordeform;

implementation

{ TBaklijstvolgordeform }

procedure TBaklijstvolgordeform.FormShow(Sender: TObject);
begin
  if dm.ZBaklijstvolgordequery.Active then
    dm.zbaklijstvolgordequery.Refresh
  else
    dm.ZBaklijstvolgordequery.Open;
end;

initialization
   {$I baklijstvolgordeunit.lrs}

end.

