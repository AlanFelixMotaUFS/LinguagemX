package analise_lexica;

import java.io.IOException;
import java.io.StringReader;

public class Main {

    public static void main(String[] args) throws IOException {

        String expr = "Ola 2 + 1.124124 * [(2*3) + 2] // 123 asdasd \n as1 + 2.0 /* and or !*/";

        Lexico lexical = new Lexico(new StringReader(expr));
        lexical.yylex();

    }
}