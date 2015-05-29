library util_udf;

{$mode objfpc}{$H+}

uses
    {$IFDEF UNIX}
            cthreads, // must be included before anything else for multithreaded apps, hell knows why
    {$ENDIF}
  Classes, math, sysutils,dateutils;

type
    ISC_DATE = LongInt;
    PISC_DATE = ^ISC_DATE;

    TCTimeStructure = record
    tm_sec:        Integer;   { Seconds }
    tm_min:        Integer;   { Minutes }
    tm_hour:       Integer;   { Hour (0--23) }
    tm_mday:       Integer;   { Day of month (1--31) }
    tm_mon:        Integer;   { Month (0--11) }
    tm_year:       Integer;   { Year (calendar year minus 1900) }
    tm_wday:       Integer;   { Weekday (0--6) Sunday = 0) }
    tm_yday:       Integer;   { Day of year (0--365) }
    tm_isdst:      Integer;   { 0 if daylight savings time is not in effect) }
  end;
  PCTimeStructure = ^TCTimeStructure;

  {$IFDEF WINDOWS}
   const
      fbLIBRARY = 'fbclient.dll';
   {$ENDIF}
   {$IFDEF LINUX }
      const
      fblibrary = 'libfbclient.so';
   {$ENDIF}

   procedure isc_decode_sql_date   (var ib_date: ISC_DATE;
                                   tm_date: PCTimeStructure);
                                stdcall; external fblibrary;




function f_average5(var a,b,c,d,e : double) : double;   cdecl;
begin
   result := (a+b+c+d+e - maxvalue([a,b,c,d,e])-minvalue([a,b,c,d,e]))/3;
end;

function f_average6(var a,b,c,d,e,f : double) : double;  cdecl;
begin
   result := (a+b+c+d+e +f - maxvalue([a,b,c,d,e,f])-minvalue([a,b,c,d,e,f]))/3;
end;

function f_datetoyearweekday(ib_date : PISC_DATE) : longint;  cdecl;
var
  ayear, aweekofyear,adayofweek : word;
  pm : pctimestructure;
  dt : tdatetime;

begin

  getmem(pm,sizeof(tctimestructure));
  isc_decode_sql_date(ib_date^,pm);
  dt := encodedate(pm^.tm_year+1900,pm^.tm_mon+1, pm^.tm_mday);
  aweekofyear := weekoftheyear(dt,aYear);
  result := (1900+pm^.tm_year)*10000+(1+pm^.tm_mon)*100+pm^.tm_mday;
  result := ayear*1000+aweekofyear*10+dayoftheweek(dt);
  freemem(pm);
end;


function f_datetoyearweek(ib_date : PISC_DATE) : longint; cdecl;
var
  ayear, aweekofyear,adayofweek : word;
  pm : pctimestructure;
  dt : tdatetime;

begin

  getmem(pm,sizeof(tctimestructure));
  isc_decode_sql_date(ib_date^,pm);
  dt := encodedate(pm^.tm_year+1900,pm^.tm_mon+1, pm^.tm_mday);
  aweekofyear := weekoftheyear(dt,aYear);
  result := (1900+pm^.tm_year)*10000+(1+pm^.tm_mon)*100+pm^.tm_mday;
  result := ayear*100+aweekofyear;
  freemem(pm);
end;

function f_datetoweek(ib_date : PISC_DATE) : longint; cdecl;
begin
result := f_datetoyearweekday(ib_date);
end;


{
    struct tm c_date;
    char buf[255];
    isc_decode_sql_date(ib_date,&c_date);
    strftime(buf,sizeof(buf)-1,"%G%V%u",&c_date);
    return atol(buf);
}




function fbudf_tijd_seconden(var begintijd,eindtijd,pauzetijd: longint): LongInt; cdecl;
begin
   result := (eindtijd - begintijd- pauzetijd) div 10000;
   if result < 0 then
      result := 0;
end;

function fbudf_tijd_uren(var begintijd,eindtijd,pauzetijd: longint): Longint; cdecl;
begin
   result := (eindtijd - begintijd- pauzetijd);
   if result < 0 then
      result := 0;
end;

function f_substractweek(var jaarweekdag,weken : integer) : integer; cdecl;
var ayear, aweekofyear, adayofweek : integer;
begin
   ayear := jaarweekdag div 1000;
   aweekofyear := jaarweekdag div 10 - ayear*100;
   adayofweek := jaarweekdag - aweekofyear*10 - ayear*1000;
   if (aweekofyear -weken) < 1 then
   begin
     ayear := ayear - 1;
     aweekofyear := WeeksinAYear(ayear)+ (aweekofyear - weken);
   end
   else
   begin
     aweekofyear := aweekofyear - weken;
   end;
   result := ayear*1000+ (aweekofyear)*10 + adayofweek;
end;

exports
  f_average5,
  f_average6,
  f_datetoyearweekday,
  f_datetoyearweek,
  f_datetoweek,
  fbudf_tijd_seconden,
  fbudf_tijd_uren,
  f_substractweek;

begin
  IsMultiThread := True;

end.


