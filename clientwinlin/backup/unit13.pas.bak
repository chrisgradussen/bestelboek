unit Unit13; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, StdCtrls, db, lcltype, lclintf,lmessages,unit2, unit12, DbCtrls,
  IniPropStorage, rxdbgrid;

type

  { TArtikelOmzet }

  TArtikelOmzet = class(TForm)
    eanupcdatasource: TDatasource;
    DBText8: TDBText;
    ArtikelOmzetPropStorage: TIniPropStorage;
    OmzetDataSource: TDatasource;
    OmchrijvingDataSource: TDatasource;
    DBGrid1: TDBGrid;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    Edit: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RxDBGrid1: TRxDBGrid;
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBText1Click(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditKeyPress(Sender: TObject; var Key: char);
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RxDBGrid1AfterQuickSearch(Sender: TObject; Field: TField;
      var AValue: string);
    procedure RxDBGrid1CellClick(Column: TColumn);
    procedure RxDBGrid1ColEnter(Sender: TObject);
    procedure RxDBGrid1DblClick(Sender: TObject);
    procedure RxDBGrid1TitleClick(Column: TColumn);
  private
    { private declarations }
  public
    { public declarations }
    function geefenkeleplu : string;
    function geefalleplus : string;
    procedure omzet(alle : boolean);
  end; 

var
  ArtikelOmzet: TArtikelOmzet;

implementation

{ TArtikelOmzet }

procedure TArtikelOmzet.EditKeyPress(Sender: TObject; var Key: char);
var i : integer;
    s : string;
begin
  if (key in [char(vk_return)]) then
  begin
    ZoekArtikel.zoektekst.text := edit.text;
    zoekartikel.zoek(Sender);
    if (ansicomparetext(ZoekArtikel.zoektekst.text,'') <> 0) then
    begin
        dm.Zartikelomschrijving.params[0].asfloat := strtofloat(zoekartikel.zoektekst.text);
        dm.ZeanQuery.Params[0].AsFloat:= strtofloat(zoekartikel.zoektekst.text);
      omzet(true);
      edit.text := zoekartikel.edit.text;

    end;
    key := char(0);
    postmessage(edit.Handle,CN_KEYUP,word(vk_return),0);
  end
end;

procedure TArtikelOmzet.EditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key in [(vk_return)]) then
  begin
    edit.SelectAll;
    edit.SetFocus;
  end;
end;

procedure TArtikelOmzet.DBText1Click(Sender: TObject);
begin
   edit.SelectAll;
   edit.SetFocus;
end;

procedure TArtikelOmzet.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if word(key) in [vk_up,vk_down, vk_next,vk_prior] then
      sendmessage(DbGrid1.Handle,CN_KEYDOWN,word(key),0);
  if word(key) in [vk_up,vk_down] then
     key := 0;
end;

procedure TArtikelOmzet.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if word(key) in [vk_0,vk_1,vk_2,vk_3,vk_4,vk_5,vk_6,vk_7,vk_8,vk_9,
                   VK_NUMPAD0,vk_numpad1,vk_numpad2,vk_numpad3,vk_numpad4,
                   vk_numpad5,vk_numpad6,vk_numpad7,vk_numpad8,vk_numpad9] then
  begin
    edit.SelectAll;
    edit.setfocus;
    postmessage(edit.Handle,CN_KEYUP,word(key),0);
  end;
end;

procedure TArtikelOmzet.FormShow(Sender: TObject);
begin
  edit.SelectAll;
  edit.SetFocus;
end;

procedure TArtikelOmzet.RxDBGrid1AfterQuickSearch(Sender: TObject;
  Field: TField; var AValue: string);
begin

end;

procedure TArtikelOmzet.RxDBGrid1CellClick(Column: TColumn);
begin
  omzet(false);
end;

procedure TArtikelOmzet.RxDBGrid1ColEnter(Sender: TObject);
begin
  omzet(False);
end;

procedure TArtikelOmzet.RxDBGrid1DblClick(Sender: TObject);
begin
  omzet(false);
end;

procedure TArtikelOmzet.RxDBGrid1TitleClick(Column: TColumn);
begin
  omzet(true);
end;

function Tartikelomzet.geefenkeleplu :string;
begin
  result := dm.ZeanQuery.Fields[0].AsString;
end;

function TArtikelOmzet.geefalleplus : string;
var
   s: string;
begin
   s := '';
   dm.ZeanQuery.first;
   while not dm.ZeanQuery.EOF do
   begin
     s := s + dm.zeanquery.Fields[0].AsString;
       if dm.zeanquery.RecNo > 100 then
     break;
     if dm.ZeanQuery.RecNo < dm.ZeanQuery.RecordCount   then
       s := s + ',';
     dm.ZeanQuery.next;

     end;
     result := s;
end;

procedure TArtikelOmzet.OMZET(alle : boolean);
 var
     s2,s3,s4 : string;

begin
      s2 := 'select max(o.jaarweek) as JAARWEKEN,sum(o.maa)+sum(o.din)+sum(o.woe)+sum(o.don)+sum(o.vri)+sum(o.zat)+sum(o.zon) as TOT, sum(o.maa) as MAA,sum(o.din) as DIN,sum(o.woe) as WOE ,sum(o.don) as DON ,sum(o.vri) as VRI,sum(o.zat) as ZAT,sum(o.zon) as ZON , max(r.voordeel) as VOORDEEL from omzetweek o  left join reclame r on r.artikel_eanupc in (';
      s3 := ') and f_datetoyearweek(r.begindatum)  = o.jaarweek where o.EANUPC in  (';
      s4 := ') group by jaarweek order by jaarweek desc;';
      if not dm.ZeanQuery.active then
        dm.ZeanQuery.active := true
      else
        dm.zeanQuery.refresh;
      if alle then
      dm.ZArtikelomzet.SQL.Text := s2 + geefalleplus + s3 +geefalleplus +s4
      else
        dm.ZArtikelomzet.SQL.text := s2 + geefenkeleplu + s3 + geefenkeleplu + s4;;

      if not dm.zartikelomzet.active then
        dm.zartikelomzet.active := true
      else
        dm.zartikelomzet.refresh;
           dm.Zartikelomschrijving.params[0].asfloat :=
                   dm.ZeanQuery.Fields[0].AsFloat;

      if dm.zartikelomschrijving.Active then
        dm.zartikelomschrijving.Refresh
      else
        dm.zartikelomschrijving.Active := true;
      edit.text := zoekartikel.edit.text;

end;

initialization
  {$I unit13.lrs}

end.

