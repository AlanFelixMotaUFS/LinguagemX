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
PLUS = "+"
MINUS = "-"
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

%state COMENTARIO2
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
<YYINITIAL> {PLUS}                         		{ return token(PLUS); }
<YYINITIAL> {MINUS}                         	{ return token(MINUS); }
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

<YYINITIAL> {INTEIRO}                         	{ return token(INTEIRO, new Integer(yytext())); }
<YYINITIAL> {FLOAT}								{ return token(FLOAT, new Double(yytext())); }


<YYINITIAL> "//"		{yybegin(COMENTARIO);
						 /* Ignora */;
						}
<COMENTARIO> [^[\n]]	{}
<COMENTARIO> [\n]		{yybegin(YYINITIAL);
						
						}


<YYINITIAL> "/*"		{yybegin(COMENTARIO2);
						 /* Ignora */;
						}
<COMENTARIO2> [\n]		{}
<COMENTARIO2> "*"		{}
<COMENTARIO2> "//"		{}
<COMENTARIO2> [^"*/"]	{}
<COMENTARIO2> "*/"		{yybegin(YYINITIAL);
						/* Ignora */;
						}



[^] 									{ throw new RuntimeException("Caractere inválido \""+yytext()+
                                                              "\" at line "+yyline+", column "+yycolumn); }
<<EOF>> { return token( EOF ); }