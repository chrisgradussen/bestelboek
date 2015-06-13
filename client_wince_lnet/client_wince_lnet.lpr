program client_wince_lnet;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, runtimetypeinfocontrols, mainunit, instellingenunit, bestellingenunit,
  lnetclient, waitdlgunit, artikelunit, zoekbestellingunit, triggersunit,
indyclient, vinfo
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(THoofdScherm, HoofdScherm);
  Application.CreateForm(TFormInstellingen, FormInstellingen);
  Application.CreateForm(TFormBestellen, FormBestellen);
  Application.CreateForm(TWaitDlg, WaitDlg);
  Application.CreateForm(TArtikelForm, ArtikelForm);
  Application.CreateForm(TZoekBestellingForm, ZoekBestellingForm);
  Application.Run;
end.

