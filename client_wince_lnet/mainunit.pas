unit mainunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, instellingenunit, bestellingenunit, windows, {$IFDEF WINCE} aygshell, notify, {$ENDIF}
  triggersunit, versiontypes,vinfo;

const
    frmBestellen = 2;
    frmArtikel = 4;
    frmVolgorde = 8;
    frmInstellingen = 16;


type

  { THoofdScherm }

  THoofdScherm = class(TForm)
    ArtikelbestandButton: TButton;
    ArtikelVolgordeButton: TButton;
    BestellenButton: TButton;
    EindeButton: TButton;
    InstellingenButton: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    WIFILabel: TLabel;
    procedure ArtikelbestandButtonClick(Sender: TObject);
    procedure ArtikelVolgordeButtonClick(Sender: TObject);
    procedure BestellenButtonClick(Sender: TObject);
    procedure EindeButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InstellingenButtonClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    fFormOptions : integer;
    { private declarations }
  public
    { public declarations }
    property FormOptions : integer read  fFormOptions write fFormOptions;
  end;

  procedure Removetaskbar(aHandle : Hwnd;rc : TRect);

var
  HoofdScherm: THoofdScherm;


implementation

uses artikelunit;

{$ifdef wince}
function AllKeys(bAllkeys : WINBOOL): WINBOOL;
 stdcall; external 'coredll.dll' name 'AllKeys';
{$endif}

{$R *.lfm}

procedure Removetaskbar(aHandle : Hwnd;rc : TRect);
begin
  {$IFDEF WINCE}
    SHFullScreen(aHandle, SHFS_HIDETASKBAR);
  {$ENDIF}
  MoveWindow(aHandle,rc.Top,rc.Left,rc.Right,rc.Bottom, TRUE);
end;





{ THoofdScherm }

procedure THoofdScherm.EindeButtonClick(Sender: TObject);
begin

    close;
end;

procedure THoofdScherm.FormActivate(Sender: TObject);
begin
  removetaskbar(handle,instellingenunit.FormInstellingen.leesschermafmetingen);
end;

procedure THoofdScherm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   if (inputbox('WachtwoordDialoog','Geef het wachtwoord om af te sluiten','') = '11') then
   canclose := true
  else
   canclose := false;
end;

procedure THoofdScherm.FormCreate(Sender: TObject);
begin
  CurrencyString:='€';
  decimalseparator := ',';
  {$ifdef wince}
  allkeys(true);
  if not assigned(FNetConnectNotifyThread) then
    FNetConnectNotifyThread := ClearSetRun(lzApplicationname_connect,NOTIFICATION_EVENT_NET_CONNECT);
  if not assigned(FNetDisConnectNotifyThread) then
    FNetConnectNotifyThread := ClearSetRun(lzApplicationname_disconnect, NOTIFICATION_EVENT_NET_DISCONNECT);
  {$endif}
end;

procedure THoofdScherm.FormDestroy(Sender: TObject);
begin
  {$ifdef wince}
    allkeys(false);
  {$endif}
end;

procedure THoofdScherm.FormShow(Sender: TObject);
var
  Info: TVersionInfo;
  Version: string;
begin
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  label1.Caption := Format('Versie %d.%d.%d build %d', [Info.FixedInfo.FileVersion[0],Info.FixedInfo.FileVersion[1],Info.FixedInfo.FileVersion[2],Info.FixedInfo.FileVersion[3]]);
  Info.Free;
end;

procedure THoofdScherm.BestellenButtonClick(Sender: TObject);
begin
  formoptions := frmbestellen;
  bestellingenunit.FormBestellen.ShowModal;
end;

procedure THoofdScherm.ArtikelbestandButtonClick(Sender: TObject);
begin
  formoptions := frmartikel;
  artikelunit.ArtikelForm.ShowModal;
end;

procedure THoofdScherm.ArtikelVolgordeButtonClick(Sender: TObject);
begin
  formoptions := frmartikel+frmvolgorde;
  artikelunit.ArtikelForm.ShowModal;
end;

procedure THoofdScherm.InstellingenButtonClick(Sender: TObject);
begin
  formoptions := frminstellingen;
  instellingenunit.FormInstellingen.ShowModal;
  removetaskbar(handle,instellingenunit.FormInstellingen.leesschermafmetingen);
end;

procedure THoofdScherm.Label1Click(Sender: TObject);
begin

end;

end.

