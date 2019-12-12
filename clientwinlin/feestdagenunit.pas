unit feestdagenunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxdbgrid, rxlookup, rxdbcomb,
  RxDBGridExportSpreadSheet, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, db, unit2;

type

  { TFeestdagenform }

  TFeestdagenform = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    haalopknop: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    export: TRxDBGridExportSpreadSheet;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    ToggleBox1: TToggleBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure haalopknopClick(Sender: TObject);
    procedure RxDBGrid1AfterQuickSearch(Sender: TObject; Field: TField;
      var AValue: string);
    procedure RxDBGrid2AfterQuickSearch(Sender: TObject; Field: TField;
      var AValue: string);
  private

  public

  end;

var
  Feestdagenform: TFeestdagenform;

implementation

{ TFeestdagenform }

procedure TFeestdagenform.Edit1Change(Sender: TObject);
begin

end;

procedure TFeestdagenform.Edit2Change(Sender: TObject);
begin

end;

procedure TFeestdagenform.FormCreate(Sender: TObject);
begin
  dm.Afdelingstable.active := false;
  dm.afdelingstable.active := true;
end;

procedure TFeestdagenform.Button1Click(Sender: TObject);
begin
  export.FileName:= edit2.text+ '/' +edit1.Text+'_'+dm.afdelingstable.FieldByName('afdelingsomschrijving').AsString+'.xls';
  export.Execute;
end;

procedure TFeestdagenform.Button2Click(Sender: TObject);
begin
  dm.Afdelingstable.First;
  while not dm.Afdelingstable.EOF do
  begin
     dm.zfeestdagenquery.active := false;
     dm.zfeestdagenquery.parambyname('afdelingsnummer').asinteger := dm.Afdelingstable.FieldByName('afdelingsnummer').AsInteger;
     dm.zfeestdagenquery.parambyname('jaarweek').asinteger :=  strtoint(edit1.text);
     dm.zfeestdagenquery.active := true;
     export.FileName:= edit2.text+ '/' +edit1.Text+'_'+dm.afdelingstable.FieldByName('afdelingsomschrijving').AsString+'.xls';
     export.Execute;
     dm.afdelingstable.next;
  end;
end;

procedure TFeestdagenform.haalopknopClick(Sender: TObject);
begin
 dm.zfeestdagenquery.active := false;
 dm.zfeestdagenquery.parambyname('afdelingsnummer').asinteger := dm.Afdelingstable.FieldByName('afdelingsnummer').AsInteger;
 dm.zfeestdagenquery.parambyname('jaarweek').asinteger :=  strtoint(edit1.text);
 dm.zfeestdagenquery.active := true;
end;

procedure TFeestdagenform.RxDBGrid1AfterQuickSearch(Sender: TObject;
  Field: TField; var AValue: string);
begin

end;

procedure TFeestdagenform.RxDBGrid2AfterQuickSearch(Sender: TObject;
  Field: TField; var AValue: string);
begin

end;

initialization
  {$I feestdagenunit.lrs}

end.

