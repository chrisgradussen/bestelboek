unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ZConnection, ZDataset, ZSqlProcessor, ZStoredProcedure, lazutf8,
  fpspreadsheetgrid, fpspreadsheetctrls, fpsallformats, fpspreadsheet, fpstypes,
  dateutils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    sWorkbookSource1: TsWorkbookSource;
    sWorksheetGrid1: TsWorksheetGrid;
    ToggleBox1: TToggleBox;
    ZConnection1: TZConnection;
    ZStoredProc1: TZStoredProc;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure ToggleBox1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);

begin
  if opendialog1.Execute then
  begin
     sworkbooksource1.FileName:= opendialog1.filename;
   //  sworkbooksource.Active := true;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  MyWorksheet: TsWorksheet;
  col, row, interval: Cardinal;
  cell: PCell;
  s,ean,datum,aantal, transactie : string;
  starttijd, eindtijd : tdatetime;
  eancolumn, datumcolumn, aantalcolumn, Winkelassortimentsgroepcolumn, Beheersafdelingcolumn, Presentatiegroepcolumn,artikelnummercolumn,artikelnaamcolumn : integer;
begin
  eancolumn := -1;
  datumcolumn := -1;
  aantalcolumn := -1;
  Beheersafdelingcolumn := -1;
  artikelnummercolumn := -1;
  artikelnaamcolumn := -1;
  Presentatiegroepcolumn := -1;
  Winkelassortimentsgroepcolumn := -1;
  starttijd := now();

  interval := 1;
  memo1.clear;

  myworksheet := sworkbooksource1.Worksheet;
  for col := 0 to MyWorksheet.GetLastColIndex do
  begin
     cell := myworksheet.findcell(2,col);
     if assigned(cell) then
     begin
       case cell^.ContentType of  // variant part must be at the end
          cctEmpty      : memo1.Append('lege cel');      // has no data at all
//        cctFormula    : ();      // FormulaValue is outside the variant record
          cctNumber     :  memo1.append('doubel/number');//;(Numbervalue: Double);
          cctUTF8String :
            begin
              memo1.append('string');
              case cell^.UTF8StringValue of
                'EAN' :
                begin memo1.append('ean = '+ inttostr(col));
                   eancolumn := col;
                end;
                'Datum' :
                begin memo1.append('Datum = '+ inttostr(col));
                   Datumcolumn := col;
                end;
                'Afzet CVE' :
                begin memo1.append('aantal = '+ inttostr(col));
                   aantalcolumn := col;
                end;
                'Presentatiegroep' :
                begin memo1.append('Presentatiegroep = '+ inttostr(col));
                   Presentatiegroepcolumn := col;
                end;
                 'Winkelassortimentsgroep' :
                begin memo1.append('Winkelassortimentsgroep = '+ inttostr(col));
                   Winkelassortimentsgroepcolumn := col;
                end;
                'Beheersafdeling' :
                begin memo1.append('Beheersafdeling = '+ inttostr(col));
                   Beheersafdelingcolumn := col;
                end;
                'Artikel' :
                begin memo1.append('Artikelnummer = '+ inttostr(col));
                   Artikelnummercolumn := col;
                   Artikelnaamcolumn := artikelnummercolumn+1;
                   memo1.append('Artikelnaam = '+ inttostr(artikelnaamcolumn));
                end;
                'artikelnaam' :
                begin memo1.append('Artikelnaam = '+ inttostr(col));

                end;
              end;
            end;
          cctDateTime   : memo1.append('datumtijd');
          cctBool       : memo1.append('boolean');
          cctError      : memo1.append('foutmelding');
       end;
     end;
  end;
  ///omzetten inlezen geen beheerafdeling/presentatiegroep
  ///wel datum,ean en aantal
  if ((aantalcolumn <> -1) and (eancolumn <> -1) and (datumcolumn <> -1) and (winkelassortimentsgroepcolumn = -1) and (beheersafdelingcolumn = -1) and (Presentatiegroepcolumn = -1)) then
  begin
    showmessage('bestand geschikt om omzetten in te lezen');
    memo1.Append('starttijd : ' + datetimetostr(starttijd));
    zstoredproc1.ParamByName('LFLAG').Asinteger := 0;
    zstoredproc1.ParamByName('LPRIJS').Asinteger:= 0;
    zconnection1.AutoCommit:= false;
    for row:=3 to MyWorksheet.GetLastRowIndex do
    begin
     if  (pos('Totaal' ,myworksheet.findcell(row,0)^.UTF8StringValue)= 1) then
      begin
        break;
      end;
      s := '';

      //ean
      cell := MyWorksheet.FindCell(row, eancolumn);
      ean :=  MyWorksheet.ReadAsUTF8Text(cell);
      zstoredproc1.ParamByName('LEANUPC').Asfloat:= strtofloat(ean);
      //datum
      cell := MyWorksheet.FindCell(row, datumcolumn);
      datum :=  concat(MyWorksheet.ReadAsUTF8Text(cell),' 11:59');
       zstoredproc1.ParamByName('ldatumtijd').asdatetime := strtodatetime(datum);
      //transactie
      transactie:=   inttostr(datetimetounix(strtodatetime(datum)));
      zstoredproc1.ParamByName('ltransactie').AsInteger := datetimetounix(strtodatetime(datum));
       datum := stringreplace(datum,'-','.',[rfReplaceAll]);

      //aantal
      cell := MyWorksheet.FindCell(row, aantalcolumn);
      aantal :=  MyWorksheet.ReadAsUTF8Text(cell);
      aantal := stringreplace(aantal,'.','',[rfReplaceAll]);
      zstoredproc1.ParamByName('laantal').AsFloat:= strtofloat(aantal);

      aantal := stringreplace(aantal,',','.',[rfReplaceAll]);






      zstoredproc1.ExecSQL;
      if row mod interval = 0 then
      begin
         memo1.append(inttostr(interval) + 'regels verwerken in database');
         memo1.append(inttostr(row) + 'regels van '+  inttostr(MyWorksheet.GetLastRowIndex) + ' verwerkt');
         s := 'execute procedure OMZET_UPDATE_R10('+ transactie + ','''+ datum + ''','+ ean + ', '+ aantal +',0,0);';
         memo1.append(s);
          memo1.Append('eindtijd : ' + datetimetostr(eindtijd));
          memo1.Append('tijdverschil is : '+inttostr(datetimetounixtime(eindtijd-starttijd)));

      end;
      //  if row = 10 then break;
  end;
  if row mod interval <> 0 then
  begin
  end;
  zstoredproc1.Active:= false;
  zconnection1.Commit;
  zconnection1.AutoCommit:=true;
  eindtijd := now();
  memo1.Append('eindtijd : ' + datetimetostr(eindtijd));
  memo1.Append('tijdverschil is : '+datetimetostr(eindtijd-starttijd));
  showmessage('klaar');
  end;
  if ((beheersafdelingcolumn <> -1) and (Presentatiegroepcolumn <> -1) and (eancolumn <> -1) and (artikelnummercolumn <> -1) and (artikelnaamcolumn <> -1)) then
  begin
    showmessage('bestand geschik om artikelbestand in te lezen');
  end;
  if ((beheersafdelingcolumn <> -1) and (Presentatiegroepcolumn <> -1)) then
  begin
    showmessage('bestand geschik om koppeling beheersafdeling presentatiegroep bestand in te lezen');
  end;


end;

procedure TForm1.Panel2Click(Sender: TObject);
begin

end;

procedure TForm1.ToggleBox1Click(Sender: TObject);
begin
  zconnection1.Disconnect;
  if zconnection1.database = 'bestelhulp1_eilandplein' then
   begin
     zconnection1.Database:= 'bestelhulp1_pastoriestraat';
     togglebox1.caption := 'pastoriestraat';
   end
  else
  begin
     zconnection1.database := 'bestelhulp1_eilandplein';
     togglebox1.caption := 'eilandplein';
  end;
  zconnection1.Connect;
  showmessage(zconnection1.Database);

end;




end.

