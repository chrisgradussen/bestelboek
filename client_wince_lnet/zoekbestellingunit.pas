unit zoekbestellingunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, RTTICtrls, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Buttons, fpjson, indyclient,instellingenunit;

type

  { TZoekBestellingForm }

  TZoekBestellingForm = class(TForm)
    afbrekenbutton: TBitBtn;
    afsluitenbutton: TBitBtn;
    ZoekBestellingListbox: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    ZoekButton: TButton;
    ZoekEdit: TEdit;
    procedure afbrekenbuttonClick(Sender: TObject);
    procedure afsluitenbuttonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure ZoekBestellingListboxDblClick(Sender: TObject);
    procedure ZoekBestellingListboxSelectionChange(Sender: TObject;
      User: boolean);
    procedure ZoekButtonClick(Sender: TObject);
    procedure ZoekEditChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    zoekbuttonpressed : boolean;
    ltcp : TLTCPClient;
    terminal : string;
    procedure Zoeken(Sender: TObject);
    procedure laadparameters;
  end;

var
  ZoekBestellingForm: TZoekBestellingForm;

implementation

uses mainunit, artikelunit;

{$R *.lfm}

{ TZoekBestellingForm }

procedure TZoekBestellingForm.afbrekenbuttonClick(Sender: TObject);
begin
 // modalresult := mrcancel;
 // close;
end;

procedure TZoekBestellingForm.afsluitenbuttonClick(Sender: TObject);
begin
 // modalresult := mrOk;
 // close;
end;

procedure TZoekBestellingForm.FormCreate(Sender: TObject);
begin
  ltcp := TLTCPClient.create;
end;

procedure TZoekBestellingForm.FormDestroy(Sender: TObject);
begin
  ltcp.free;
end;

procedure tzoekbestellingform.laadparameters;
var
  i : integer;
begin
    if instellingenunit.forminstellingen.ValueListEditor.FindRow('host',i) then
  begin
    ltcp.host := instellingenunit.forminstellingen.ValueListEditor.Values['host'];
  end
  else
  begin
    showmessage('host niet gevonden');
    close;
  end;
  if instellingenunit.forminstellingen.ValueListEditor.FindRow('port',i) then
  begin
    ltcp.port := strtoint(instellingenunit.forminstellingen.ValueListEditor.Values['port']);
  end
  else
  begin
    showmessage('port niet gevonden');
    close;
  end;
  if instellingenunit.forminstellingen.ValueListEditor.FindRow('terminal',i) then
  begin
    terminal := instellingenunit.forminstellingen.ValueListEditor.Values['terminal'];
  end
  else
  begin
    showmessage('terminal niet gevonden');
    close;
  end;

end;

procedure TZoekBestellingForm.FormShow(Sender: TObject);
var
  i  : integer;
begin
  mainunit.removetaskbar(handle,instellingenunit.FormInstellingen.leesschermafmetingen);
  afsluitenbutton.Enabled := zoekbestellinglistbox.SelCount > 0;
  laadparameters;
  zoekedit.SelectAll;
  zoekedit.SetFocus;
end;

procedure TZoekBestellingForm.Label1DblClick(Sender: TObject);
begin

end;

procedure TZoekBestellingForm.ZoekBestellingListboxDblClick(Sender: TObject);
begin
  showmessage(zoekbestellinglistbox.GetSelectedText);
end;

procedure TZoekBestellingForm.ZoekBestellingListboxSelectionChange(
  Sender: TObject; User: boolean);
begin
  afsluitenbutton.Enabled := zoekbestellinglistbox.SelCount > 0;
end;

procedure TZoekBestellingForm.Zoeken(Sender: TObject);
var
  i : integer;
  JA : TJSonArray;
  query : string;
begin
  zoekbestellinglistbox.Items.Clear;

  if hoofdscherm.FormOptions and frmbestellen = frmbestellen then
  begin
    query := 'select a.EANUPC as EANUPC , a.X_NAAM as NAAM from artikel_zoek_nieuw('''+ ZoekEdit.Text +
    ''',0) z join artikel a on z.EANUPC = a.EANUPC join bestelling b on a.eanupc = b.eanupc where b.luser = '''+terminal+''' order by a.X_NAAM;'
  end;
  if zoekbuttonpressed then
  begin
    query := 'select a.EANUPC as EANUPC , a.X_NAAM as NAAM from artikel_zoek_nieuw('''+ ZoekEdit.Text + ''',0) z join artikel a on z.EANUPC = a.EANUPC order by a.X_NAAM;'
  end;
  if ltcp.sendmessage(query) then
  begin
    ja := TJSonObject(ltcp.JSo).Arrays['data'];
    for i := 0 to ja.Count -1 do
    begin
      zoekbestellinglistbox.Items.Append(TJsonOBject(ja.Items[i]).Find('EANUPC').AsString + ' ' + TJsonObject(ja.Items[i]).Find('NAAM').AsString);
    end;
  end;
  afsluitenbutton.Enabled := zoekbestellinglistbox.SelCount > 0;
end;

procedure TZoekBestellingForm.ZoekButtonClick(Sender: TObject);
begin
  zoeken(sender);
end;

procedure TZoekBestellingForm.ZoekEditChange(Sender: TObject);
begin
  if length(zoekedit.text) > 0 then
  begin
    zoekbutton.Enabled:= true;
  end
  else
  begin
    zoekbutton.enabled := false;
  end;
end;

end.

