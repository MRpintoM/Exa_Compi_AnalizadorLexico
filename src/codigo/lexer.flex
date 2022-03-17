package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
DN=-[0-9]+
DP=[0-9]+ | [+][0-9]+
FP=[0-9][.][0-9]+  | [+][0-9][.][0-9]+
FN=[-][0-9][.][0-9]+
espacio=[ ,\t,\r,\n]+
Ag=[{,},(,)]+
%{
    public String lexeme;
%}
%%
int |
float |
string |
boolean |
long |
break |
default |
void |
byte |
short |
import |
char |
if |
else |
do | 
for |
switch |
case |
class |
public | 
private |
while {lexeme=yytext(); return Reservadas;}
{espacio} {/*Ignore*/}
"//".* {/*Ignore*/}
"=" {lexeme=yytext();return Igual;}
"==" {lexeme=yytext();return Comparador;}
"!=" {lexeme=yytext();return Distinto;}
"<" {lexeme=yytext();return Menor;}
"<=" {lexeme=yytext();return Menor_Igual;}
">" {lexeme=yytext();return Mayor;}
">=" {lexeme=yytext();return Mayor_Igual;}
"&" {lexeme=yytext();return And;}
"|" {lexeme=yytext();return Or;}
"!" {lexeme=yytext();return Not;}
"+" {lexeme=yytext();return Suma;}
"-" {lexeme=yytext();return Resta;}
"*" {lexeme=yytext();return Multiplicacion;}
"/" {lexeme=yytext();return Division;}
";" {lexeme=yytext();return Delimitador;}
{L}({L}|{DP})* {lexeme=yytext(); return Identificador;}
("(-"{DP}+")")|{DP}+ | ("(-"{FP}+")")|{FP}+  {lexeme=yytext(); return Positivo;}
("(-"{DN}+")")|{DN}+ | ("(-"{FN}+")")|{FN}+  {lexeme=yytext(); return Negativo;}
({Ag}+ {DP}+ {Ag}|{Ag}+ {L}+ {Ag}+) + {lexeme=yytext(); return Agrupacion;}
"." {return ERROR;}
