unit gebruikersunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, DBGrids, unit2;

type

  { TGebruikersForm }

  TGebruikersForm = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  GebruikersForm: TGebruikersForm;

implementation

{ TGebruikersForm }

procedure TGebruikersForm.Panel2Click(Sender: TObject);
begin

end;

procedure TGebruikersForm.Button1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TGebruikersForm.FormShow(Sender: TObject);
begin
   unit2.DM.ZGebruikersQuery.Open;
end;

initialization
   {$I gebruikersunit.lrs}

end.

