unit Unit13; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, StdCtrls, db, lcltype, lclintf,lmessages,unit2, unit12, DbCtrls,
  IniPropStorage, rxdbgrid, reclameaanpassendlg, dateutils;

type

  { TArtikelOmzet }

  TArtikelOmzet = class(TForm)
    DBText9BLBLBLBLA: TDBText;
    RxArtikelOmzetGrid: TRxDBGrid;
    ZartikelOmzetDataSource: TDataSource;
    eanupcdatasource: TDatasource;
    DBText8: TDBText;
    ArtikelOmzetPropStorage: TIniPropStorage;
    OmzetDataSource: TDatasource;
    OmschrijvingDataSource: TDatasource;
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
    procedure ArtikelOmzetPropStorageRestoreProperties(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RxArtikelOmzetGridDblClick(Sender: TObject);
    procedure RxArtikelOmzetGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
      sendmessage(self.RxArtikelOmzetGrid.Handle,CN_KEYDOWN,word(key),0);
  if word(key) in [vk_up,vk_down] then
     key := 0;
end;

procedure TArtikelOmzet.RxArtikelOmzetGridKeyDown(Sender: TObject; var Key: Word;
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

procedure TArtikelOmzet.rxArtikelOmzetGridDblClick(Sender: TObject);
var
   jaarweken : integer;
   startdatum,einddatum,startdatumweek, einddatumweek : tDateTime;
begin
  // determine if an article has been selected.
   if omzetdatasource.dataset.State in [dsbrowse] then
   begin
     if omzetdatasource.DataSet.RecordCount > 0 then
     begin
       jaarweken := omzetdatasource.dataset.FieldByName('JAARWEKEN' ).Asinteger;
       // change jaarweken in startdatum (wensday) and stopdatum (tuesday next week)
      // dateseparator := '.' ;
       startdatum := encodedateweek(jaarweken div 100,jaarweken mod 100,3);
       einddatum := incday(startdatum,6);
       startdatumweek := encodedateweek(jaarweken div 100,jaarweken mod 100,1);
       einddatumweek := incday(startdatumweek,6);
       if dm.zartikelomzetreclamequery.active then
       begin
         dm.zartikelomzetreclamequery.Close;
       end;
       dm.ZArtikelomzetReclameQuery.ParamByName('startdatum').AsDateTime := startdatumweek;
       dm.ZArtikelomzetReclameQuery.ParamByName('einddatum').asdatetime := einddatumweek;
       dm.ZArtikelomzetReclameQuery.SQL.Text:=
       'select * from reclame r where r.begindatum >= :startdatum and r.begindatum <= :einddatum  and r.artikel_eanupc in (' + geefalleplus + ');';
       dm.ZArtikelomzetReclameQuery.Open;
       if dm.ZArtikelomzetReclameQuery.RecordCount = 0 then
       begin
         eanupcdatasource.dataset.first;
         while not eanupcdatasource.dataset.EOF do
         begin
           dm.ZArtikelomzetReclameQuery.insert;     //(alle plus toevoegen en de rest in reclamedlg doen)
           dm.zartikelomzetreclamequery.FieldByName('BEGINDATUM').AsDateTime:= startdatum;
           dm.zartikelomzetreclamequery.FieldByName('EINDDATUM').AsDateTime:= einddatum;
           dm.zartikelomzetreclamequery.FieldByName('artikel_eanupc').asstring :=
           eanupcdatasource.dataset.fieldbyname('eanupc').asstring;
           dm.ZArtikelomzetReclameQuery.post;
           eanupcdatasource.dataset.next;
         end;
       end;
       reclameaanpassendlg.FormReclameDlg.ShowModal;
       dm.ZArtikelOmzetQuery.refresh;
     end;
   end;
end;

procedure TArtikelOmzet.ArtikelOmzetPropStorageRestoreProperties(Sender: TObject
  );
begin

end;

procedure TArtikelOmzet.FormCreate(Sender: TObject);
begin
  artikelomzetpropstorage.IniFileName:=getappconfigfile(false);
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
      s2 := 'select max(w.voordeel) as reclame, max(o.jaarweek) as JAARWEKEN,sum(o.maa)+sum(o.din)+sum(o.woe)+sum(o.don)+sum(o.vri)+sum(o.zat)+sum(o.zon) as TOT, sum(o.maa) as MAA,sum(o.din) as DIN,sum(o.woe) as WOE ,sum(o.don) as DON ,sum(o.vri) as VRI,sum(o.zat) as ZAT,sum(o.zon) as ZON , max(r.omschrijving) as omschrijving ,max(r.voordeel) as voordeel from omzetweek o  left join reclameview r on o.JAARWEEK = F_DATETOYEARWEEK(r.startdatum) and o.eanupc = r.ean left join reclame w on o.jaarweek = f_datetoyearweek(w.begindatum) and o.EANUPC = w.ARTIKEL_EANUPC where o.eanupc in (';
      s4 := ') group by jaarweek order by jaarweek desc;';
      if not dm.ZeanQuery.active then
        dm.ZeanQuery.active := true
      else
        dm.zeanQuery.refresh;
      if alle then
        dm.ZArtikelomzetQuery.SQL.Text := s2 + geefalleplus + s4
      else
        dm.ZArtikelomzetQuery.SQL.text := s2 + geefenkeleplu + s4;


      if not dm.ZArtikelOmzetQuery.active then
        dm.ZArtikelOmzetQuery.active := true
      else
        dm.ZArtikelOmzetQuery.refresh;
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

