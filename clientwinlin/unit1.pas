unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
   brooduitverkoopunit,baklijstvolgordeunit,Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  IniPropStorage, StdCtrls, Unit3, Unit4,unit5, unit6, unit7, unit8, unit9,
  Unit10, Unit2, Unit11, unit12, Unit13, Menus, Unit14,ZConnection,
  ZDataset, db, ZSqlUpdate, ZSequence,baklijstunit,baklijstsnelunit,versiontypes,vinfo, multiplierunit;

type

  { Thoofdmenu }

  Thoofdmenu = class(TForm)
    BestelgroepButton: TButton;
    ButtonBaklijst: TButton;
    ButtonBroodUitverkoop: TButton;
    DagenButton: TButton;
    LeverancierButton: TButton;
    GroepButton: TButton;
    HfdMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Menu_baklijstvolgorde: TMenuItem;
    van10naar0: TMenuItem;
    van30naar10: TMenuItem;
    Van40naar30: TMenuItem;
    van40naar50: TMenuItem;
    van50naar40: TMenuItem;
    Noodprocedures: TMenuItem;
    subgroepbutton: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    bestellingafdrukkenbutton: TButton;
    Button9: TButton;
    HoofdmenuPropStorage: TIniPropStorage;
    procedure BestelgroepButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ButtonBaklijstClick(Sender: TObject);
    procedure ButtonBroodUitverkoopClick(Sender: TObject);
    procedure DagenButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GroepButtonClick(Sender: TObject);
    procedure HoofdmenuPropStorageSaveProperties(Sender: TObject);
    procedure HoofdmenuPropStorageSavingProperties(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Menu_baklijstvolgordeClick(Sender: TObject);
    procedure NoodproceduresClick(Sender: TObject);
    procedure LeverancierButtonClick(Sender: TObject);
    procedure bestellingafdrukkenbuttonClick(Sender: TObject);
    procedure subgroepbuttonClick(Sender: TObject);
    procedure van10naar0Click(Sender: TObject);
    procedure van30naar10Click(Sender: TObject);
    procedure Van40naar30Click(Sender: TObject);
    procedure van40naar50Click(Sender: TObject);
    procedure van50naar40Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  hoofdmenu: Thoofdmenu;

implementation

{ Thoofdmenu }

procedure Thoofdmenu.BestelgroepButtonClick(Sender: TObject);
begin
  bestelgroep.show;
end;

procedure Thoofdmenu.Button1Click(Sender: TObject);
begin
  baklijstvolgordeunit.Baklijstvolgordeform.show;
end;

procedure Thoofdmenu.Button5Click(Sender: TObject);
begin
  bestelschema.show;
end;

procedure Thoofdmenu.Button6Click(Sender: TObject);
begin
  standaardbestelschema.show;
end;

procedure Thoofdmenu.Button7Click(Sender: TObject);
begin
  ArtikelBestand.Show;
end;

procedure Thoofdmenu.Button9Click(Sender: TObject);
begin
  artikelomzet.show;
end;

procedure Thoofdmenu.ButtonBaklijstClick(Sender: TObject);
begin
  baklijstsnelunit.frmBaklijstBroodjes.Show;

end;

procedure Thoofdmenu.ButtonBroodUitverkoopClick(Sender: TObject);
begin
  FormBroodUitverkoop.ShowModal;
end;

procedure Thoofdmenu.DagenButtonClick(Sender: TObject);
begin
  dagen.show;
end;

procedure Thoofdmenu.FormActivate(Sender: TObject);
begin

end;

procedure Thoofdmenu.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

  {leverancier.leverancierpropstorage.Save;
  subgroep.subgroepPropStorage.save;
  dagen.dagenPropStorage.save;
  bestelgroep.bestelgroepPropStorage.save;
  groep.groeppropstorage.save;
  standaardbestelschema.SBestelschemaPropStorage.save;
  bestelschema.bestelschemapropstorage.save;
  artikelbestand.ArtikelBestandPropStorage.save;
  zoekartikel.ZoekArtikelPropStorage.Save;
  scripts.ScriptsPropStorage.save;
  artikelomzet.ArtikelOmzetPropStorage.Save;
  baklijstunit.Form1.BaklijstPropStorage.save; }
  dm.DBPropStorage.save;
  //dm.ZConnection.Connect;
end;

procedure Thoofdmenu.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if Dagen.visible then
    Dagen.FormCloseQuery(Sender,CanClose);
  if Bestelgroep.visible then
    Bestelgroep.FormCloseQuery(Sender,CanClose);
  if Groep.Visible then
    Groep.FormCloseQuery(Sender,CanClose);
  if Subgroep.Visible then
    SubGroep.FormCloseQuery(Sender, CanClose);
  if BestelSchema.Visible then
    BestelSchema.FormCloseQuery(Sender, CanClose);
  if Artikelbestand.Visible then
    ArtikelBestand.FormCloseQuery(Sender, CanClose);
  if Leverancier.Visible then
    Leverancier.FormCloseQuery(Sender, CanClose);
  if StandaardBestelschema.Visible then
    StandaardBestelSchema.FormCloseQuery(Sender, CanClose);
  if FormMultiplier.Visible then
    FormMultiplier.FormCloseQuery(Sender, CanClose);
end;

procedure Thoofdmenu.FormCreate(Sender: TObject);
var
  Info: TVersionInfo;
  Version: string;
begin
  decimalseparator := '.';
  thousandseparator := ',';
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  self.Caption := Format('Bestelboek Versie %d.%d.%d build %d Hoofdmenu', [Info.FixedInfo.FileVersion[0],Info.FixedInfo.FileVersion[1],Info.FixedInfo.FileVersion[2],Info.FixedInfo.FileVersion[3]]);
  Info.Free;

end;

procedure Thoofdmenu.FormShow(Sender: TObject);
begin
  dm.DBPropStorage.restore;
 { leverancier.leverancierpropstorage.Restore;
  subgroep.subgroepPropStorage.Restore;
  dagen.dagenPropStorage.Restore;
  bestelgroep.bestelgroepPropStorage.Restore;
  groep.groepPropstorage.Restore;
  standaardbestelschema.SBestelschemaPropStorage.Restore;
  artikelbestand.ArtikelBestandPropStorage.Restore;
  zoekartikel.ZoekArtikelPropStorage.Restore;
  bestelschema.bestelschemapropstorage.restore;
  scripts.ScriptsPropStorage.restore;
  artikelomzet.ArtikelOmzetPropStorage.restore;
  bestellingafdrukken.bestellingafdrukkenPropStorage.Restore;
  baklijstunit.Form1.BaklijstPropStorage.Restore;}
  baklijstunit.form1.RxDBGrid2.ColumnByFieldName('CHARGE_1').ReadOnly:= false;
end;

procedure Thoofdmenu.GroepButtonClick(Sender: TObject);
begin
  Groep.show;
end;

procedure Thoofdmenu.HoofdmenuPropStorageSaveProperties(Sender: TObject);
begin
  //showmessage('onsave');
end;

procedure Thoofdmenu.HoofdmenuPropStorageSavingProperties(Sender: TObject);
begin
  //showmessage('on saving');
end;

procedure Thoofdmenu.MenuItem1Click(Sender: TObject);
begin
  dm.ZScripts_BestelgroepQuery.ParamByName('status').AsInteger := 30;
  dm.ZScripts_BestelSchemaQuery.ParamByName('status').AsInteger := 30;
  dm.zscripts_levering_update.script.Clear;
  dm.zscripts_levering_update.script.Add('EXECUTE PROCEDURE LEVERING_VAN_30_NAAR_40(:ID)');
  unit14.Scripts.Caption:= 'BESTELBOEK VAN BESTELD NAAR ONDERWEG';
  unit14.Scripts.showmodal;
end;

procedure Thoofdmenu.MenuItem2Click(Sender: TObject);
begin
  multiplierunit.FormMultiplier.ShowModal;
end;

procedure Thoofdmenu.Menu_baklijstvolgordeClick(Sender: TObject);
begin
  baklijstvolgordeunit.Baklijstvolgordeform.Show;
end;

procedure Thoofdmenu.NoodproceduresClick(Sender: TObject);
begin

end;

procedure Thoofdmenu.LeverancierButtonClick(Sender: TObject);
begin
  leverancier.show;
end;

procedure Thoofdmenu.bestellingafdrukkenbuttonClick(Sender: TObject);
begin
  unit8.bestellingafdrukken.showmodal;
end;

procedure Thoofdmenu.subgroepbuttonClick(Sender: TObject);
begin
  subgroep.show;
end;

procedure Thoofdmenu.van10naar0Click(Sender: TObject);
begin
  dm.ZScripts_BestelgroepQuery.ParamByName('status').AsInteger := 10;
  dm.ZScripts_BestelSchemaQuery.ParamByName('status').AsInteger := 10;
  dm.zscripts_levering_update.script.Clear;
  dm.zscripts_levering_update.script.Add('EXECUTE PROCEDURE LEVERING_VAN_10_NAAR_0(:ID)');
  unit14.Scripts.Caption:= 'BESTELBOEK VAN BESTELLEN NAAR NIEUW';
  unit14.scripts.showmodal
end;

procedure Thoofdmenu.van30naar10Click(Sender: TObject);
begin
  showmessage('in van 30 naar 10; ');
  dm.ZScripts_BestelgroepQuery.ParamByName('status').AsInteger := 30;
  dm.ZScripts_BestelSchemaQuery.ParamByName('status').AsInteger := 30;
  dm.zscripts_levering_update.script.Clear;
  showmessage('voor createparams');
  dm.zscripts_levering_update.Params.CreateParam(ftunknown,'user',ptunknown);
  showmessage('voor addstring in script' );
  dm.zscripts_levering_update.script.Add('EXECUTE PROCEDURE LEVERING_VAN_30_NAAR_10(:ID,:luser)');
  unit14.Scripts.Caption:= 'BESTELBOEK VAN BESTELD NAAR BESTELLEN';

  dm.zscripts_levering_update.ParamByName('luser').AsString :=  dialogs.InputBox('USERNAME','GEEF DE JUISTE USERNAME OP', 'ipaq');
  if dm.zscripts_levering_update.ParamByName('luser').AsString <> '' then
    unit14.scripts.showmodal
end;

procedure Thoofdmenu.Van40naar30Click(Sender: TObject);
begin
  dm.ZScripts_BestelgroepQuery.ParamByName('status').AsInteger := 40;
  dm.ZScripts_BestelSchemaQuery.ParamByName('status').AsInteger := 40;
  dm.zscripts_levering_update.script.Clear;
  dm.zscripts_levering_update.script.Add('EXECUTE PROCEDURE LEVERING_VAN_40_NAAR_30(:ID)');
  unit14.Scripts.Caption:= 'BESTELBOEK VAN ONDERWEG NAAR BESTELD';
  unit14.scripts.showmodal
end;

procedure Thoofdmenu.van40naar50Click(Sender: TObject);
begin
  dm.ZScripts_BestelgroepQuery.ParamByName('status').AsInteger := 40;
  dm.ZScripts_BestelSchemaQuery.ParamByName('status').AsInteger := 40;
  dm.zscripts_levering_update.script.Clear;
  dm.zscripts_levering_update.script.Add('execute procedure levering_update(:id)');
  unit14.Scripts.Caption:= 'BESTELBOEK VAN IN BESTELLING NAAR GELEVERD';
  unit14.Scripts.showmodal;
end;

procedure Thoofdmenu.van50naar40Click(Sender: TObject);
begin
  dm.ZScripts_BestelgroepQuery.ParamByName('status').AsInteger := 50;
  dm.ZScripts_BestelSchemaQuery.ParamByName('status').AsInteger := 50;
  dm.zscripts_levering_update.script.Clear;
  dm.zscripts_levering_update.script.Add('EXECUTE PROCEDURE LEVERING_VAN_50_NAAR_40(:ID)');
  unit14.Scripts.Caption:= 'BESTELBOEK VAN GELEVERD NAAR IN BESTELLING';
  unit14.scripts.showmodal
end;

initialization
  {$I unit1.lrs}

end.
