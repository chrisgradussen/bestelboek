program project1;

{$mode objfpc}{$H+}

uses

  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this }, Unit1, Unit2, zcomponent, Unit3, Unit4,
  Unit5, Unit6, Unit7, rxnew, Unit8, lazreport, Unit9, Unit10, Unit11, Unit12,
  Unit13, Unit14, BaklijstUnit, baklijstsnelunit, baklijstvolgordeunit,
  multiplierunit, reclameaanpassendlg, brooduitverkoopunit, aktielijstunit,
  gebruikersunit, feestdagenunit;

//{$IFDEF WINDOWS}{$R project1.rc}{$ENDIF}

 {$R *.res}



begin
  Application.Initialize;
  Application.CreateForm(Thoofdmenu, hoofdmenu);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(Tbestelgroep, bestelgroep);
  Application.CreateForm(Tleverancier, leverancier);
  Application.CreateForm(Tsubgroep, subgroep);
  Application.CreateForm(Tdagen, dagen);
  Application.CreateForm(TGroep, Groep);
  Application.CreateForm(Tbestellingafdrukken, bestellingafdrukken);
  Application.CreateForm(TStandaardBestelschema, StandaardBestelschema);
  Application.CreateForm(TBestelschema, Bestelschema);
  Application.CreateForm(TArtikelBestand, ArtikelBestand);
  Application.CreateForm(TZoekArtikel, ZoekArtikel);
  Application.CreateForm(TArtikelOmzet, ArtikelOmzet);
  Application.CreateForm(TScripts, Scripts);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmBaklijstBroodjes, frmBaklijstBroodjes);
  Application.CreateForm(TBaklijstvolgordeform, Baklijstvolgordeform);
  Application.CreateForm(TFormMultiplier, FormMultiplier);
  Application.CreateForm(TFormReclameDlg, FormReclameDlg);
  Application.CreateForm(TFormBroodUitverkoop, FormBroodUitverkoop);
  Application.CreateForm(TFormAktielijst, FormAktielijst);
  Application.CreateForm(TGebruikersForm, GebruikersForm);
  Application.CreateForm(TFeestdagenform, Feestdagenform);
  Application.Run;
end.

