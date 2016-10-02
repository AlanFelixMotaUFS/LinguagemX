package analise_lexica;
import java_cup.runtime.Symbol;

%%



%cup
%public
%class Lexico
%type java_cup.runtime.Symbol
%line
%column


BRANCO = [\n| |\t|\r]
LETRA = [a-z|A-Z]
DIGITO = [0-9]
INTEIRO = [-]?{DIGITO}+
FLOAT = {DIGITO}+ "." {DIGITO}* | {DIGITO}* "." {DIGITO}+


ID = {LETRA}({LETRA}|{DIGITO})*

/* Operadores */
SOM = "+"
SUB = "-"
MULT = "*"
DIV = "/"
EQ = "="
ATTRIB = ":="
GTHAN = ">"
LTHAN = "<"
NOT = "!"

MOD = "%"   

/* Separadores */
LPAREN = "("
RPAREN = ")"
LBRACE = "{"
RBRACE = "}"
LBRACK = "["
RBRACK = "]"
SEMICOLON = ";"
COMMA = ","
DOT = "."

%state COMENTARIO


%%

<YYINITIAL> "real"								{ return new Symbol(Simbolo.REAL); }
<YYINITIAL> "int"                      			{ return new Symbol(Simbolo.INT); }
<YYINITIAL> "bool"                      		{ return new Symbol(Simbolo.BOOL); }
<YYINITIAL> "true"                      		{ return new Symbol(Simbolo.TRUE); }
<YYINITIAL> "false"                      		{ return new Symbol(Simbolo.FALSE); }
<YYINITIAL> "if"                         		{ return new Symbol(Simbolo.IF); }
<YYINITIAL> "then"                       		{ return new Symbol(Simbolo.THEN); }
<YYINITIAL> "else"                      		{ return new Symbol(Simbolo.ELSE); }
<YYINITIAL> "while"                      		{ return new Symbol(Simbolo.WHILE); }
<YYINITIAL> "procedure"                      	{ return new Symbol(Simbolo.PROCEDURE); }
<YYINITIAL> "function"                      	{ return new Symbol(Simbolo.FUNCTION); }
<YYINITIAL> "cons"                      		{ return new Symbol(Simbolo.CONS); }
<YYINITIAL> "var"                      			{ return new Symbol(Simbolo.VAR); }
<YYINITIAL> "and"								{ return new Symbol(Simbolo.AND); }
<YYINITIAL> "or"								{ return new Symbol(Simbolo.OR); }



<YYINITIAL> {BRANCO}                     		{ /**/ }
<YYINITIAL> {ID}                         		{ return new Symbol(Simbolo.IDENTIFIER); }
<YYINITIAL> {SOM}                         		{ return new Symbol(Simbolo.SOM); }
<YYINITIAL> {SUB}                         		{ return new Symbol(Simbolo.SUB); }
<YYINITIAL> {MULT}                         		{ return new Symbol(Simbolo.MULT); }
<YYINITIAL> {DIV}                         		{ return new Symbol(Simbolo.DIV); }
<YYINITIAL> {EQ}                         		{ return new Symbol(Simbolo.EQ); }
<YYINITIAL> {ATTRIB}                         	{ return new Symbol(Simbolo.ATTRIB); }
<YYINITIAL> {GTHAN}                         	{ return new Symbol(Simbolo.GTHAN); }
<YYINITIAL> {LTHAN}                         	{ return new Symbol(Simbolo.LTHAN); }
<YYINITIAL> {NOT}                         		{ return new Symbol(Simbolo.NOT); }
<YYINITIAL> {MOD}                         		{ return new Symbol(Simbolo.MOD); }
<YYINITIAL> {LPAREN}                         	{ return new Symbol(Simbolo.LPAREN); }
<YYINITIAL> {RPAREN}                         	{ return new Symbol(Simbolo.RPAREN); }
<YYINITIAL> {LBRACE}                         	{ return new Symbol(Simbolo.LBRACE); }
<YYINITIAL> {RBRACE}                         	{ return new Symbol(Simbolo.RBRACE); }
<YYINITIAL> {LBRACK}                         	{ return new Symbol(Simbolo.LBRACK); }
<YYINITIAL> {RBRACK}                         	{ return new Symbol(Simbolo.RBRACK); }
<YYINITIAL> {SEMICOLON}                         { return new Symbol(Simbolo.SEMICOLON); }
<YYINITIAL> {COMMA}                         	{ return new Symbol(Simbolo.COMMA); }
<YYINITIAL> {DOT}                         		{ return new Symbol(Simbolo.DOT); }

<YYINITIAL> {INTEIRO}                         	{ return new Symbol(Simbolo.INTEGER_NUM); }
<YYINITIAL> {FLOAT}								{ return new Symbol(Simbolo.FLOAT_NUM); }


<YYINITIAL> "//"		{yybegin(COMENTARIO);
						 /* Ignora */;
						}
<COMENTARIO> [^[\n]]	{}
<COMENTARIO> [\n]		{yybegin(YYINITIAL);
						
						}


<YYINITIAL> "/*"		{yybegin(COMENTARIO);
						 /* Ignora */;
						}
<COMENTARIO> [\n]		{}
<COMENTARIO> "*"		{}
<COMENTARIO> [^"*/"]	{}
<COMENTARIO> "*/"		{yybegin(YYINITIAL);
						/* Ignora */;
						}

<<EOF>> { return new Symbol( Simbolo.EOF ); }

[^] 									{ throw new RuntimeException("Caractere inválido \""+yytext()+
                                                              "\" at line "+yyline+", column "+yycolumn); }