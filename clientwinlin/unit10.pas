unit Unit10; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DbCtrls, DBGrids, IniPropStorage, Menus, db;

type

  { TBestelschema }

  TBestelschema = class(TForm)
    Datasource1: TDatasource;
    Datasource2: TDatasource;
    Datasource3: TDatasource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBNavigator3: TDBNavigator;
    bestelschemaPropStorage: TIniPropStorage;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PopupMenu1: TPopupMenu;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure Datasource3StateChange(Sender: TObject);
    procedure DBNavigator3BeforeAction(Sender: TObject; Button: TDBNavButtonType
      );
    procedure DBNavigator3Click(Sender: TObject; Button: TDBNavButtonType);
    procedure DBNavigator3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Bestelschema: TBestelschema;

implementation

uses unit2;

{ TBestelschema }

procedure TBestelschema.FormShow(Sender: TObject);
begin
  if DM.ZBestelSchema_BestelgroepTable.active then
    DM.ZBestelSchema_BestelgroepTable.refresh
  else
    DM.ZBestelSchema_BestelgroepTable.open;
  if not DM.ZBestelSchema_BestelSchemaQuery.active then
//    DM.ZBestelSchema_BestelSchemaQuery.Refresh
//  else
    DM.ZBestelSchema_BestelSchemaQuery.open;
  if not DM.ZBestelSchema_BestRegelQuery.active then
//    DM.ZBestelSchema_BestRegelQuery.refresh
//  else
    DM.ZBestelSchema_BestRegelQuery.open;
end;

procedure TBestelschema.MenuItem1Click(Sender: TObject);
begin
  with dbGrid3.DataSource.DataSet do
   begin
     DisableControls;
     dbgrid3.selectedrows.Clear;
     First;
     try
       while not EOF do
       begin
         dbgrid3.SelectedRows.CurrentRowSelected := True;
         Next;
       end;
     finally
       EnableControls;
     end;
   end;
end;

procedure TBestelschema.MenuItem2Click(Sender: TObject);
var
  i : longint;
begin
  begin
    if dbgrid3.SelectedRows.Count>0 then
    with DBGrid3.DataSource.DataSet do
    begin
      for i:=0 to DBGrid3.SelectedRows.Count-1 do
      begin
        GotoBookmark(DBGrid3.SelectedRows.Items[i]);
       // showmessage(fields.fields[1].AsString);
        dbgrid3.DataSource.DataSet.Delete;
      end;
      dbgrid3.SelectedRows.Clear;
    end;

  end;

end;

procedure TBestelschema.PopupMenu1Popup(Sender: TObject);
begin
  if dbgrid3.DataSource.DataSet.RecordCount>0 then
  begin
     menuitem1.Enabled:= true;
  end
  else
  begin
    menuitem1.Enabled:= false;
  end;

  if dbgrid3.SelectedRows.Count>0 then
  begin
     menuitem2.Enabled:= true;
  end
  else
  begin
    menuitem2.Enabled:= false;
  end;
end;

procedure TBestelschema.Datasource3StateChange(Sender: TObject);
begin

end;

procedure TBestelschema.DBNavigator3BeforeAction(Sender: TObject;
  Button: TDBNavButtonType);
begin
end;

procedure TBestelschema.DBNavigator3Click(Sender: TObject;
  Button: TDBNavButtonType);
begin

end;

procedure TBestelschema.DBNavigator3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TBestelschema.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   if DM.ZBestelSchema_BestRegelQuery.State in [dsedit,dsinsert] then
     DM.ZBestelSchema_BestRegelQuery.post;
   if DM.ZBestelSchema_BestelSchemaQuery.State in [dsedit,dsinsert] then
     DM.ZBestelSchema_BestelSchemaQuery.post;
   if DM.ZBestelSchema_BestelgroepTable.State in [dsedit,dsinsert] then
     DM.ZBestelSchema_BestelgroepTable.Post;

end;

procedure TBestelschema.FormCreate(Sender: TObject);
begin
  bestelschemapropstorage.IniFileName:=getappconfigfile(false);
end;

initialization
  {$I unit10.lrs}

end.

