unit bestellingenunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, indyclient, waitdlgunit, fpjson;

type

  { TFormBestellen }

  TFormBestellen = class(TForm)
    BestellenButton: TButton;
    AfsluitenButton: TButton;
    BestellingverwerkenButton: TButton;
    BestellingladenButton: TButton;
    BestellingenListbox: TListBox;
    Nieuwebestellingenlistbox: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    WIFILabel: TLabel;
    procedure AfsluitenButtonClick(Sender: TObject);
    procedure BestellenButtonClick(Sender: TObject);
    procedure BestellingenListboxClick(Sender: TObject);
    procedure BestellingladenButtonClick(Sender: TObject);
    procedure BestellingverwerkenButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NieuwebestellingenlistboxClick(Sender: TObject);
    procedure NieuwebestellingenlistboxContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure Panel2Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
   // procedure LTCPCLientError(const msg: string; aSocket: TLSocket);
  private
    { private declarations }
  public
    { public declarations }
    terminal : string;
    ltcp : TLTCPClient;
    procedure laadbestellingen;
  end;

var
  FormBestellen: TFormBestellen;

implementation

{$R *.lfm}

uses instellingenunit, mainunit, artikelunit;

{ TFormBestellen }

procedure TFormBestellen.laadbestellingen;
var
   i  : integer;
   Ja  : TJSonArray;
begin
  if ltcp.SendMessage('select id,bestelgroep_id, naam  from pda_Bestelschema(0,0,'''+terminal+''');') then
  begin
    ja := TJSonObject(ltcp.JSo).Arrays['data'];
    nieuwebestellingenlistbox.Items.Clear;
    for i := 0 to ja.Count -1 do
    begin
      nieuwebestellingenlistbox.Items.Append(TJsonOBject(ja.Items[i]).Find('ID').AsString + ' ' + TJsonObject(ja.Items[i]).Find('NAAM').AsString);
    end;
    if ltcp.SendMessage('select id,bestelgroep_id,naam  from pda_Bestelschema(0,10,'''+terminal+''');') then
    begin
      ja := TJSonObject(ltcp.JSo).Arrays['data'];
      bestellingenlistbox.Items.Clear;
      for i := 0 to ja.Count -1 do
      begin
        bestellingenlistbox.Items.Append(TJsonOBject(ja.Items[i]).Find('ID').AsString +' '+ TJSonObject(ja.Items[i]).Find('NAAM').AsString);
      end;
    end
    else
    begin
      showmessage('laden van onderste bestellingen mislukt');
      close;
    end;
  end
  else
  begin
    showmessage('laden van bovenste bestellingen mislukt');
    close;
  end;
  BestellenButton.Enabled:= bestellingenlistbox.Count > 0;
  BestellingVerwerkenButton.Enabled:= bestellingenlistbox.SelCount > 0;
  BestellingladenButton.Enabled:=nieuwebestellingenlistbox.Selcount > 0;
end;

{procedure TFormBestellen.LTCPCLientError(const msg: string; aSocket: TLSocket);
begin
   showmessage(msg+ ' '+ aSocket.LocalAddress + ' '+ inttostr(aSocket.LocalPort));
   close;
end; }

procedure TFormBestellen.Panel4Click(Sender: TObject);
begin

end;

procedure TFormBestellen.AfsluitenButtonClick(Sender: TObject);
begin
  close;
end;

procedure TFormBestellen.BestellenButtonClick(Sender: TObject);
begin
  artikelunit.ArtikelForm.ShowModal;
end;

procedure TFormBestellen.BestellingenListboxClick(Sender: TObject);
begin
  BestellingVerwerkenButton.Enabled:=bestellingenlistbox.Selcount > 0;
end;

procedure TFormBestellen.BestellingladenButtonClick(Sender: TObject);
var
  i : integer;
  sl : tstringlist;
begin
  sl := tstringlist.create;
  sl.Delimiter:= ' ';
  waitdlg.showwait(self);
  if nieuwebestellingenlistbox.Selcount > 0 then
  begin
    for i := 0 to nieuwebestellingenlistbox.Count - 1 do
    begin
      if nieuwebestellingenlistbox.Selected[i] then
      begin
//        if ltcp.Connect then
        begin
          sl.DelimitedText:= nieuwebestellingenlistbox.Items[i];
          if ltcp.SendMessage('select id||'' ''|| bestelgroep_id||'' ''|| naam  from pda_Bestelschema('+ sl[0]+',0,'''+terminal+''');') then
          begin

          end;
        end;
      end;
    end;
    laadbestellingen;
  end;
  sl.Free;
  waitdlg.Tag := 1;
end;

procedure TFormBestellen.BestellingverwerkenButtonClick(Sender: TObject);
var
  i : integer;
  sl : tstringlist;
begin
  sl := tstringlist.create;
  sl.Delimiter:= ' ';;
  waitdlg.showwait(self);
  if bestellingenlistbox.Selcount > 0 then
  begin
    for i := 0 to bestellingenlistbox.Count - 1 do
    begin
      if bestellingenlistbox.Selected[i] then
      begin
        //if ltcp.Connect then
        begin
          sl.DelimitedText:= bestellingenlistbox.Items[i];
          if ltcp.SendMessage('select id||'' ''|| bestelgroep_id||'' ''|| naam  from pda_Bestelschema('+ sl[0]+',10,'''+terminal+''');') then
          begin

          end;
        end;
      end;
    end;
    laadbestellingen;
  end;
  sl.Free;
  waitdlg.Tag := 1;
end;

procedure TFormBestellen.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  WaitDlg.Tag :=1;
end;

procedure TFormBestellen.FormCreate(Sender: TObject);
begin
  ltcp := TLTCPClient.create;
end;

procedure TFormBestellen.FormDestroy(Sender: TObject);
begin
  ltcp.free;
end;

procedure TFormBestellen.FormShow(Sender: TObject);
var
  i : integer;
begin
   mainunit.removetaskbar(handle,instellingenunit.FormInstellingen.leesschermafmetingen);
   waitdlg.showwait(hoofdscherm);
   if instellingenunit.forminstellingen.ValueListEditor.FindRow('timeout',i) then
   begin
     ltcp.TimeOut := strtoint(instellingenunit.forminstellingen.ValueListEditor.Values['timeout']);
   end
   else
   begin
     showmessage('timeout niet gevonden');
     close;
   end;
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
   laadbestellingen;
   WaitDlg.Tag :=1;
end;

procedure TFormBestellen.NieuwebestellingenlistboxClick(Sender: TObject);
begin
  BestellingladenButton.Enabled:=nieuwebestellingenlistbox.Selcount > 0;
end;

procedure TFormBestellen.NieuwebestellingenlistboxContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TFormBestellen.Panel2Click(Sender: TObject);
begin

end;

end.

