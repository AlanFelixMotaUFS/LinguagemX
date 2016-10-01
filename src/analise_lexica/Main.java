package analise_lexica;

import java.io.IOException;
import java.io.StringReader;

public class Main {

	public static void main(String[] args) throws IOException {

//		Testando o programa:
//			Programa
//			var int a := 10;
//			cons bool b := true;
//			procedure TEST1(int a1)
//			{
//				var int r = a1/a;
//				if(r>10)
//					r:=-r;
//				else
//					TEST1(r);
//			}
//			funcion int QUADRADO(int num)
//				num*num;
//		 
//		 */

		
		
		String program = "Programa /n var int a := 10; /n cons bool b := true; /n procedure TEST1(int a1)/n { /n var int r = a1/a; /n	if(r>10) /n r:=-r; /n else /n TEST1(r); /n }funcion /n int QUADRADO(int num) /n num*num; /n */";
		
		Lexico lexical = new Lexico(new StringReader(program));
		// lexical.yylex();

		Token token;
		while ((token = lexical.yylex()) != null) {
			System.out.println("<" + token.name + ", " + token.value + "> (" + token.line + " - " + token.column + ")");
		}
	}
}