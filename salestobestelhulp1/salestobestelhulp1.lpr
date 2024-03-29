program salestobestelhulp1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp
  { you can add units after this },
  util, strutils;

type

  { TSalestoBestelhulp1 }

  TSalestoBestelhulp1 = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
    function Convert(var data : c) : boolean;
  end;

  Var
    Verkoop : TVerkoop;

{ TSalestoBestelhulp1 }

function TSalestoBestelhulp1.Convert(var data : c) : boolean;
var
   charstr : array[0..datarecordlen-1] of char;
   lregelnummer : integer;
   gewicht      : integer;

begin
  if data.messagetype = '01' then
  begin
    lregelnummer :=  swap(word(strtoint('$'+ data.regelnummer)));
    while lregelnummer > 999 do
      lregelnummer := lregelnummer - 1000;
    Verkoop.transactie := strtoint(data.kassanummer)*10000000+
                        swap(smallint(strtoint('$'+ data.transactie)))*1000
                        + lregelnummer;

    verkoop.datetime:= data.dag+ '.'+
                     data.maand + '.'
                     +inttostr(  1900+ strtoint('$'+ data.jaar[0])*10 + strtoint(data.jaar[1]))
                     + ' ' +data.uur+ ':' + data.minuut + ':'+ data.seconde;

    Verkoop.eanplunummer:= strtofloat(data.eancode);
    verkoop.aantal := reverse(int64(hex2dec(data.aantal)));
    verkoop.prijs := reverse(int64(hex2dec(data.totaalprijs)))/100;
    gewicht := (hex2dec(data.gewicht));
    if (verkoop.eanplunummer >= 210000) and (verkoop.eanplunummer <230000) then
    begin
      verkoop.eanplunummer := verkoop.eanplunummer * 10000000;
      if ((gewicht <> 0) and (gewicht <> 2)) then
         verkoop.aantal := verkoop.aantal/1000;
    end;
    if (verkoop.eanplunummer >= 2300000) and (verkoop.eanplunummer <2400000) then
    begin
      verkoop.eanplunummer := verkoop.eanplunummer * 1000000;
      // klopt dit wel?
      if verkoop.aantal >= 0 then
        verkoop.aantal := 1
      else
        verkoop.aantal := -1;
    end;
   //todo bepalen, wanneer iets afgeprijsd is
    verkoop.flag := 0;
    convert := true;
  end
  else
  begin
    convert := false;
  end
end;

procedure TSalestoBestelhulp1.DoRun;
var
  ErrorMsg, s: String;
  buf : Pchar;
  stoppen : boolean;
  gegevens : ^c;
  y : integer;

begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h','help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h','help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }


  getmem(buf,2138*2);
  stoppen := false;
  repeat
  begin
    readln(s);
    buf := pchar(s);
    pchar(gegevens) := buf;
    if convert(gegevens^) then
    begin
      writeln(Format('execute procedure omzet_update(%d,''%s'',%13.0f,%8.3f, %d,%7.2f);',
        [ verkoop.transactie,
          verkoop.datetime,
          verkoop.eanplunummer,
          verkoop.aantal,
          verkoop.flag,
          verkoop.prijs]));
          writeln('COMMIT;');
          for y := 0 to  300 do
             write(' ');
          writeln;
          writeln;
          writeln;
          writeln;
    end
  end
  until stoppen = true;
{    writeln('CONNECT 192.168.0.5:bestelhulp1 user ''sysdba'' password ''masterkey''; ');
    writeln('SET ECHO;'); }
    // stop program loop
  freemem(buf);
  // stop program loop
  Terminate;
end;

constructor TSalestoBestelhulp1.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TSalestoBestelhulp1.Destroy;
begin
  inherited Destroy;
end;

procedure TSalestoBestelhulp1.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
end;

var
  Application: TSalestoBestelhulp1;

{$R *.res}

begin
  Application:=TSalestoBestelhulp1.Create(nil);
  Application.Title:='Salestobestelhulp1';
  Application.Run;
  Application.Free;
end.

