unit Unit11; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DbCtrls, StdCtrls, db, Unit12, LclType, IniPropStorage, DBGrids,
  rxdbgrid;

type

  { TArtikelBestand }

  TArtikelBestand = class(TForm)
    ArtikelDataSource: TDatasource;
    Label2: TLabel;
    ZReclameDatasource: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    Edit: TEdit;
    ArtikelBestandPropStorage: TIniPropStorage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    EANCODE: TLabel;
    Label20: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ReclameGrid: TRxDBGrid;
    procedure ArtikelDataSourceDataChange(Sender: TObject; Field: TField);
    procedure DBEdit13KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure EditChange(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private
    { private declarations }
    procedure Enabled(enabled : boolean);
  public
    { public declarations }
  end; 

var
  ArtikelBestand: TArtikelBestand;

implementation

uses Unit2;

{ TArtikelBestand }

procedure TArtikelbestand.Enabled(enabled : boolean);
begin
  dbedit1.Enabled := enabled;
  dbedit2.Enabled := enabled;
  dbedit3.Enabled := enabled;
  dbedit4.Enabled := enabled;
  dbedit5.Enabled := enabled;
  dbedit6.Enabled := enabled;
  dbedit7.Enabled := enabled;
  dbedit8.Enabled := enabled;
  dbedit9.Enabled := enabled;
  dbedit10.Enabled := enabled;
  dbedit11.Enabled := enabled;
  dbedit12.Enabled := enabled;
  dbedit13.Enabled := enabled;
  dbedit14.Enabled := enabled;
  dbedit15.Enabled := enabled;
  dbedit16.Enabled := enabled;
  dbedit17.Enabled := enabled;
  dbedit18.Enabled := enabled;
  dbedit19.Enabled := enabled;
 // dbedit20.Enabled := enabled;
  dbedit21.Enabled := enabled;
  dbedit22.Enabled := enabled;
  dbedit23.Enabled := enabled;
  dbedit24.Enabled := enabled;
  dbedit25.Enabled := enabled;
  dbedit26.Enabled := enabled;
  dbedit27.Enabled := enabled;
  ReclameGrid.Enabled:= enabled;

end;


procedure TArtikelBestand.FormShow(Sender: TObject);
begin
 // if DM.ZArtikelTable.Active then
  //  DM.ZArtikelTable.Refresh
  //else
   // DM.ZArtikelTable.Open;
  if dm.ZArtikelQuery.Active then
    dm.ZArtikelQuery.Close;
  if dm.ZReclameQuery.Active then
    dm.ZReclameQuery.Close;
  enabled(false);

  edit.SelectAll;
  edit.SetFocus;
end;

procedure TArtikelBestand.Panel2Click(Sender: TObject);
begin

end;

procedure TArtikelBestand.EditKeyPress(Sender: TObject; var Key: char);
begin
  if (key in [char(vk_return)]) then
  begin
    ZoekArtikel.zoektekst.text := edit.text;
    zoekartikel.zoek(Sender);
    if (ansicomparetext(zoekartikel.zoektekst.text,'') <> 0) then
    begin
 //     dm.ZArtikeltable.Locate('eanupc',zoekartikel.zoektekst.text,[]);
       dm.ZArtikelQuery.ParamByName('eanupc').AsFloat:= strtofloat(zoekartikel.zoektekst.text);
        if dm.ZArtikelQuery.active then
       begin
if dm.ZArtikelQuery.State in [dsedit,dsinsert] then
         dm.ZArtikelQuery.Post;
         dm.ZArtikelQuery.Refresh;
if dm.ZReclameQuery.State in [dsedit,dsinsert] then
         dm.ZReclameQuery.Post;
         dm.ZReclameQuery.close;
         dm.zreclamequery.open;
       end
       else
       begin
         dm.ZArtikelQuery.Open;
         dm.ZReclameQuery.Open;
         enabled(true);
       end;
//      data.artikel.Locate('eanupc',zoekartikel.zoektekst.text,[]);
      edit.text := zoekartikel.edit.text;
    end;
    edit.SetFocus;
    edit.selectall;
  end;
end;

procedure TArtikelBestand.FormCloseQuery(Sender: TObject; var CanClose: boolean
  );
begin
 // if DM.ZArtikelTable.State in [dsedit,dsinsert] then
 //    DM.ZArtikelTable.post;
  if dm.ZArtikelQuery.State in [dsedit,dsinsert] then
    dm.ZArtikelQuery.post;
  if dm.ZReclameQuery.State in [dsedit,dsinsert] then
    dm.ZReclameQuery.post;
end;

procedure TArtikelBestand.FormCreate(Sender: TObject);
begin
  artikelbestandpropstorage.IniFileName:=getappconfigfile(false);
end;

procedure TArtikelBestand.EditChange(Sender: TObject);
begin

end;

procedure TArtikelBestand.DBEdit13KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = word('.') then key := word(',');
end;

procedure TArtikelBestand.ArtikelDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if dm.ZReclameQuery.State in [dsedit,dsinsert] then
  begin
    dm.ZReclameQuery.Post;
  end;
end;

initialization
  {$I unit11.lrs}

end.

