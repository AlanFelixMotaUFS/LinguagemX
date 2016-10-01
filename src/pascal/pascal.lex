package pascal;
import java_cup.runtime.*;

%%

%{


private PascalToken createToken(String name, String value) {
    return new PascalToken( name, value, yyline, yycolumn);
}

%}

%public
%class LexicalAnalyzer
%type PascalToken
%line
%column

inteiro = 0|[1-9][0-9]*
brancos = [\n| |\t]

program = "program"

%%

{inteiro} { return createToken("inteiro", yytext()); }
{program} { return createToken(yytext(), "");} 
{brancos} { /**/ }

. { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }