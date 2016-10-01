package analise_lexica;
import java_cup.runtime.*;

%%

%{

private Token createToken(String name, String value) {
    return new Token( name, value, yyline, yycolumn);
}

%}

%public
%class Lexico
%type Token
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

<YYINITIAL> "real"								{ return createToken("REAL", yytext()); }
<YYINITIAL> "int"                      			{ return createToken("INT", yytext()); }
<YYINITIAL> "bool"                      		{ return createToken("BOOL", yytext()); }
<YYINITIAL> "true"                      		{ return createToken("TRUE", yytext()); }
<YYINITIAL> "false"                      		{ return createToken("FALSE", yytext()); }
<YYINITIAL> "if"                         		{ return createToken("IF", yytext()); }
<YYINITIAL> "then"                       		{ return createToken("THEN", yytext()); }
<YYINITIAL> "else"                      		{ return createToken("ELSE", yytext()); }
<YYINITIAL> "while"                      		{ return createToken("WHILE", yytext()); }
<YYINITIAL> "procedure"                      	{ return createToken("PROCEDURE", yytext()); }
<YYINITIAL> "function"                      	{ return createToken("FUNCTION", yytext()); }
<YYINITIAL> "cons"                      		{ return createToken("CONS", yytext()); }
<YYINITIAL> "var"                      			{ return createToken("VAR", yytext()); }
<YYINITIAL> "and"								{ return createToken("AND", yytext()); }
<YYINITIAL> "or"								{ return createToken("OR", yytext()); }



<YYINITIAL> {BRANCO}                     		{ /**/ }
<YYINITIAL> {ID}                         		{ return createToken("IDENTIFIER", yytext()); }
<YYINITIAL> {SOM}                         		{ return createToken("SOM", yytext()); }
<YYINITIAL> {SUB}                         		{ return createToken("SUB", yytext()); }
<YYINITIAL> {MULT}                         		{ return createToken("MULT", yytext()); }
<YYINITIAL> {DIV}                         		{ return createToken("DIV", yytext()); }
<YYINITIAL> {EQ}                         		{ return createToken("EQ", yytext()); }
<YYINITIAL> {ATTRIB}                         	{ return createToken("ATTRIB", yytext()); }
<YYINITIAL> {GTHAN}                         	{ return createToken("GTHAN", yytext()); }
<YYINITIAL> {LTHAN}                         	{ return createToken("LTHAN", yytext()); }
<YYINITIAL> {NOT}                         		{ return createToken("NOT", yytext()); }
<YYINITIAL> {MOD}                         		{ return createToken("MOD", yytext()); }
<YYINITIAL> {LPAREN}                         	{ return createToken("LPAREN", yytext()); }
<YYINITIAL> {RPAREN}                         	{ return createToken("RPAREN", yytext()); }
<YYINITIAL> {LBRACE}                         	{ return createToken("LBRACE", yytext()); }
<YYINITIAL> {RBRACE}                         	{ return createToken("RBRACE", yytext()); }
<YYINITIAL> {LBRACK}                         	{ return createToken("LBRACK", yytext()); }
<YYINITIAL> {RBRACK}                         	{ return createToken("RBRACK", yytext()); }
<YYINITIAL> {SEMICOLON}                         { return createToken("SEMICOLON", yytext()); }
<YYINITIAL> {COMMA}                         	{ return createToken("COMMA", yytext()); }
<YYINITIAL> {DOT}                         		{ return createToken("DOT", yytext()); }

<YYINITIAL> {INTEIRO}                         	{ return createToken("INTEGER_NUM", yytext()); }
<YYINITIAL> {FLOAT}								{ return createToken("FLOAT_NUM", yytext()); }


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


. 									{ throw new RuntimeException("Caractere inválido \""+yytext()+
                                                              "\" at line "+yyline+", column "+yycolumn); }