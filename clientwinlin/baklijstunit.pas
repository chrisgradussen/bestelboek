unit BaklijstUnit;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DbCtrls, IniPropStorage, DbExtCtrls, rxlookup,
  rxdbcomb, rxdbgrid, unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BaklijstPropStorage: TIniPropStorage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    RxDBLookupCombo1: TRxDBLookupCombo;
    Splitter1: TSplitter;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

{ TForm1 }

procedure TForm1.FormShow(Sender: TObject);
begin
  if DM.ZBaklijstDagQuery.Active then
    dm.ZBaklijstDagQuery.refresh
  else
  begin
    dm.ZBaklijstDagQuery.open;
    dm.ZBaklijstDagQuery.First;
  end;
   if DM.ZBaklijstDagLookupQuery.Active then
    dm.ZBaklijstDagLookupQuery.refresh
  else
  begin
    dm.ZBaklijstDagLookupQuery.open;
    dm.ZBaklijstDagLookupQuery.First;
  end;
  if dm.ZBaklijstQuery.active then
    dm.zbaklijstquery.refresh
  else  dm.zbaklijstquery.open;
  if dm.ZBaklijstGeschiedenisQuery.Active then
    dm.ZBaklijstGeschiedenisQuery.refresh
  else dm.ZBaklijstGeschiedenisQuery.open;
  if dm.ZQuery1.active then
    dm.zquery1.refresh
    else
  dm.zquery1.open;
end;

initialization
  {$I baklijstunit.lrs}

end.

