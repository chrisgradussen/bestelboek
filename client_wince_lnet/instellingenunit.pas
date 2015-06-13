unit instellingenunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ValEdit, IniPropStorage,waitdlgunit;

type

  { TFormInstellingen }

  TFormInstellingen = class(TForm)
    Button1: TButton;
    instellingenpropstorage: TIniPropStorage;
    Panel1: TPanel;
    Panel2: TPanel;
    ValueListEditor: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ValueListEditorClick(Sender: TObject);
    function leesschermafmetingen : TRect;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormInstellingen: TFormInstellingen;

implementation

uses mainunit;

{$R *.lfm}

{ TFormInstellingen }

function TFormInstellingen.leesschermafmetingen : TRect;
var
  i : integer;
begin
  if instellingenunit.forminstellingen.ValueListEditor.FindRow('top',i) then
   begin
     result.Top := strtoint(instellingenunit.forminstellingen.ValueListEditor.Values['top']);
   end
   else
   begin
     showmessage('scherminstellingen parameter top niet gevonden neem waarde 0');
     result.Top := 0;

   end;
   if instellingenunit.forminstellingen.ValueListEditor.FindRow('left',i) then
   begin
     result.Left := strtoint(ValueListEditor.Values['left']);

   end
   else
   begin
     showmessage('scherminstellingen parameter left niet gevonden neem waarde 0');
     result.Left:=0;
   end;
   if instellingenunit.forminstellingen.ValueListEditor.FindRow('right',i) then
   begin
     result.Right := strtoint(instellingenunit.forminstellingen.ValueListEditor.Values['right']);
   end
   else
   begin
     showmessage('scherminstellingen parameter right niet gevonden neem waarde 240');
     result.Right:= 240;
   end;

   if instellingenunit.forminstellingen.ValueListEditor.FindRow('bottom',i) then
   begin
     result.Bottom := strtoint(ValueListEditor.Values['bottom']);
   end
   else
   begin
     showmessage('scherminstellingen parameter bottom niet gevonden neem waarde 240');
     result.Bottom:= 240;
   end;
end;

procedure TFormInstellingen.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TFormInstellingen.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  instellingenpropstorage.Save;
end;

procedure TFormInstellingen.FormCreate(Sender: TObject);
begin
  {$IFDEF WINCE}
    instellingenpropstorage.IniFileName:='\Application\StartUpCtl\bestelboek.ini';
  {$ENDIF}
end;

procedure TFormInstellingen.FormShow(Sender: TObject);
begin
  mainunit.removetaskbar(handle,instellingenunit.FormInstellingen.leesschermafmetingen);
  waitdlg.showwait(hoofdscherm);
  waitdlg.tag :=1;
end;

procedure TFormInstellingen.ValueListEditorClick(Sender: TObject);
begin

end;

end.

