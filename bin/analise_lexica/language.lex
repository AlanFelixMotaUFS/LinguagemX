package analise_lexica;

%%

%{

private void imprimir(String descricao, String lexema) {
    System.out.println(lexema + " - " + descricao);
}

%}


%class Lexico
%type void



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

<YYINITIAL> "real"								{ imprimir("Palavra reservada real", yytext()); }
<YYINITIAL> "int"                      			{ imprimir("Palavra reservada int", yytext()); }
<YYINITIAL> "bool"                      		{ imprimir("Palavra reservada bool", yytext()); }
<YYINITIAL> "true"                      		{ imprimir("Palavra reservada true", yytext()); }
<YYINITIAL> "false"                      		{ imprimir("Palavra reservada false", yytext()); }
<YYINITIAL> "if"                         		{ imprimir("Palavra reservada if", yytext()); }
<YYINITIAL> "then"                       		{ imprimir("Palavra reservada then", yytext()); }
<YYINITIAL> "else"                      		{ imprimir("Palavra reservada else", yytext()); }
<YYINITIAL> "while"                      		{ imprimir("Palavra reservada while", yytext()); }
<YYINITIAL> "procedure"                      	{ imprimir("Palavra reservada procedure", yytext()); }
<YYINITIAL> "function"                      	{ imprimir("Palavra reservada function", yytext()); }
<YYINITIAL> "cons"                      		{ imprimir("Palavra reservada cons", yytext()); }
<YYINITIAL> "var"                      			{ imprimir("Palavra reservada var", yytext()); }
<YYINITIAL> "and"								{ imprimir("Operador And", yytext()); }
<YYINITIAL> "or"								{ imprimir("Operador Or", yytext()); }



<YYINITIAL> {BRANCO}                     		{  }
<YYINITIAL> {ID}                         		{ imprimir("Identificador", yytext()); }
<YYINITIAL> {SOM}                         		{ imprimir("Operador de soma", yytext()); }
<YYINITIAL> {SUB}                         		{ imprimir("Operador de subtração", yytext()); }
<YYINITIAL> {MULT}                         		{ imprimir("Operador de multiplicação", yytext()); }
<YYINITIAL> {DIV}                         		{ imprimir("Operador de divisão", yytext()); }
<YYINITIAL> {EQ}                         		{ imprimir("Igualdade", yytext()); }
<YYINITIAL> {ATTRIB}                         	{ imprimir("Atribuição", yytext()); }
<YYINITIAL> {GTHAN}                         	{ imprimir("Operador Maior que", yytext()); }
<YYINITIAL> {LTHAN}                         	{ imprimir("Operador Menor que", yytext()); }
<YYINITIAL> {NOT}                         		{ imprimir("Operador Not", yytext()); }
<YYINITIAL> {MOD}                         		{ imprimir("Operador Mod", yytext()); }
<YYINITIAL> {LPAREN}                         	{ imprimir("Abre Parenteses", yytext()); }
<YYINITIAL> {RPAREN}                         	{ imprimir("Fecha Parenteses", yytext()); }
<YYINITIAL> {LBRACE}                         	{ imprimir("Abre chaves", yytext()); }
<YYINITIAL> {RBRACE}                         	{ imprimir("Fecha chaves", yytext()); }
<YYINITIAL> {LBRACK}                         	{ imprimir("Abre colchetes", yytext()); }
<YYINITIAL> {RBRACK}                         	{ imprimir("Fecha colchetes", yytext()); }
<YYINITIAL> {SEMICOLON}                         { imprimir("Ponto e vírgula", yytext()); }
<YYINITIAL> {COMMA}                         	{ imprimir("Vírgula", yytext()); }
<YYINITIAL> {DOT}                         		{ imprimir("Ponto", yytext()); }

<YYINITIAL> {INTEIRO}                         	{ imprimir("Número Inteiro", yytext()); }
<YYINITIAL> {FLOAT}								{ imprimir("Número real", yytext()); }


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


. 									{ throw new RuntimeException("Caractere inválido "+yytext()); }