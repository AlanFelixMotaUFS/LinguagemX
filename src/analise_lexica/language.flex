package analise_lexica;
import java_cup.runtime.*;

%%
%public
%class Lexico
%cup
%implements Simbolo
%type Token
%line
%column

%{
    StringBuilder string = new StringBuilder();

    private Token token(int tipo) {
        return new Token(tipo, yyline+1, yycolumn+1, null);
    }

    private Token token(int tipo, Object valor) {
        return new Token(tipo, yyline+1, yycolumn+1, valor);
    }
%}

BRANCO = [\n| |\t|\r]
DIGITO = [0-9]
INTEIRO = [-]?{DIGITO}+
FLOAT = {DIGITO}+ "." {DIGITO}* | {DIGITO}* "." {DIGITO}+


ID = [:jletter:][:jletterdigit:]*

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

<YYINITIAL> "real"								{ return token(REAL); }
<YYINITIAL> "int"                      			{ return token(INT); }
<YYINITIAL> "bool"                      		{ return token(BOOL); }
<YYINITIAL> "true"                      		{ return token(TRUE); }
<YYINITIAL> "false"                      		{ return token(FALSE); }
<YYINITIAL> "if"                         		{ return token(IF); }
<YYINITIAL> "then"                       		{ return token(THEN); }
<YYINITIAL> "else"                      		{ return token(ELSE); }
<YYINITIAL> "while"                      		{ return token(WHILE); }
<YYINITIAL> "procedure"                      	{ return token(PROCEDURE); }
<YYINITIAL> "function"                      	{ return token(FUNCTION); }
<YYINITIAL> "cons"                      		{ return token(CONS); }
<YYINITIAL> "var"                      			{ return token(VAR); }
<YYINITIAL> "and"								{ return token(AND); }
<YYINITIAL> "or"								{ return token(OR); }



<YYINITIAL> {BRANCO}                     		{ /**/ }
<YYINITIAL> {ID}                         		{ return token(IDENTIFIER, yytext()); }
<YYINITIAL> {SOM}                         		{ return token(SOM); }
<YYINITIAL> {SUB}                         		{ return token(SUB); }
<YYINITIAL> {MULT}                         		{ return token(MULT); }
<YYINITIAL> {DIV}                         		{ return token(DIV); }
<YYINITIAL> {EQ}                         		{ return token(EQ); }
<YYINITIAL> {ATTRIB}                         	{ return token(ATTRIB); }
<YYINITIAL> {GTHAN}                         	{ return token(GTHAN); }
<YYINITIAL> {LTHAN}                         	{ return token(LTHAN); }
<YYINITIAL> {NOT}                         		{ return token(NOT); }
<YYINITIAL> {MOD}                         		{ return token(MOD); }
<YYINITIAL> {LPAREN}                         	{ return token(LPAREN); }
<YYINITIAL> {RPAREN}                         	{ return token(RPAREN); }
<YYINITIAL> {LBRACE}                         	{ return token(LBRACE); }
<YYINITIAL> {RBRACE}                         	{ return token(RBRACE); }
<YYINITIAL> {LBRACK}                         	{ return token(LBRACK); }
<YYINITIAL> {RBRACK}                         	{ return token(RBRACK); }
<YYINITIAL> {SEMICOLON}                         { return token(SEMICOLON); }
<YYINITIAL> {COMMA}                         	{ return token(COMMA); }
<YYINITIAL> {DOT}                         		{ return token(DOT); }

<YYINITIAL> {INTEIRO}                         	{ return token(INTEGER_NUM, new Integer(yytext())); }
<YYINITIAL> {FLOAT}								{ return token(FLOAT_NUM, new Double(yytext())); }


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



[^] 									{ throw new RuntimeException("Caractere inválido \""+yytext()+
                                                              "\" at line "+yyline+", column "+yycolumn); }
<<EOF>> { return token( EOF ); }