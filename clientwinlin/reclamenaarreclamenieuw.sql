select 'update or insert into reclame_nieuw (artikel_artikelnummer,begindatum,einddatum,voordeel) values ('''
|| (select x_artikelnummer from artikel where eanupc = artikel_eanupc) ||''','''||
extract (day from begindatum)||'.'||extract(month from begindatum)|| '.' ||extract(year from begindatum)||''','''||
extract (day from einddatum)||'.'||extract(month from einddatum)|| '.' ||extract(year from einddatum)||
''','''||voordeel||
''') matching(artikel_artikelnummer,begindatum,einddatum,voordeel);' 
from reclame where voordeel is not null