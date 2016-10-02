package analise_lexica;
import java_cup.runtime.*;

%%

%{

	private Token token(int tipo) {
        return new Token(tipo, yyline+1, yycolumn+1, null);
    }

    private Token token(int tipo, Object valor) {
        return new Token(tipo, yyline+1, yycolumn+1, valor);
    }

%}


%public
%class Lexico
%cup
%implements Simbolo
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
TQ = "|"

%state COMENTARIO


%%

<YYINITIAL> "real"								{ return Token("REAL"); }
<YYINITIAL> "int"                      			{ return Token("INT"); }
<YYINITIAL> "bool"                      		{ return Token("BOOL"); }
<YYINITIAL> "true"                      		{ return Token("TRUE"); }
<YYINITIAL> "false"                      		{ return Token("FALSE"); }
<YYINITIAL> "if"                         		{ return Token("IF"); }
<YYINITIAL> "then"                       		{ return Token("THEN"); }
<YYINITIAL> "else"                      		{ return Token("ELSE"); }
<YYINITIAL> "while"                      		{ return Token("WHILE"); }
<YYINITIAL> "procedure"                      	{ return Token("PROCEDURE"); }
<YYINITIAL> "function"                      	{ return Token("FUNCTION"); }
<YYINITIAL> "cons"                      		{ return Token("CONS"); }
<YYINITIAL> "var"                      			{ return Token("VAR"); }
<YYINITIAL> "and"								{ return Token("AND"); }
<YYINITIAL> "or"								{ return Token("OR"); }



<YYINITIAL> {BRANCO}                     		{ /**/ }
<YYINITIAL> {ID}                         		{ return Token("IDENTIFIER"); }
<YYINITIAL> {SOM}                         		{ return Token("SOM"); }
<YYINITIAL> {SUB}                         		{ return Token("SUB"); }
<YYINITIAL> {MULT}                         		{ return Token("MULT"); }
<YYINITIAL> {DIV}                         		{ return Token("DIV"); }
<YYINITIAL> {EQ}                         		{ return Token("EQ"); }
<YYINITIAL> {ATTRIB}                         	{ return Token("ATTRIB"); }
<YYINITIAL> {GTHAN}                         	{ return Token("GTHAN"); }
<YYINITIAL> {LTHAN}                         	{ return Token("LTHAN"); }
<YYINITIAL> {NOT}                         		{ return Token("NOT"); }
<YYINITIAL> {MOD}                         		{ return Token("MOD"); }
<YYINITIAL> {LPAREN}                         	{ return Token("LPAREN"); }
<YYINITIAL> {RPAREN}                         	{ return Token("RPAREN"); }
<YYINITIAL> {LBRACE}                         	{ return Token("LBRACE"); }
<YYINITIAL> {RBRACE}                         	{ return Token("RBRACE"); }
<YYINITIAL> {LBRACK}                         	{ return Token("LBRACK"); }
<YYINITIAL> {RBRACK}                         	{ return Token("RBRACK"); }
<YYINITIAL> {SEMICOLON}                         { return Token("SEMICOLON"); }
<YYINITIAL> {COMMA}                         	{ return Token("COMMA"); }
<YYINITIAL> {DOT}                         		{ return Token("DOT"); }
<YYINITIAL> {TQ}                         		{ return Token("TQ"); }

<YYINITIAL> {INTEIRO}                         	{ return Token("INTEGER_NUM"); }
<YYINITIAL> {FLOAT}								{ return Token("FLOAT_NUM"); }


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