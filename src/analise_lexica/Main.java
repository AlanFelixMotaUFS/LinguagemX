package analise_lexica;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringReader;

import java_cup.runtime.Symbol;

public class Main {

	public static void main(String[] args) {

		// Testando o programa:
		// Programa
		// var int a := 10;
		// cons bool b := true;
		// procedure TEST1(int a1)
		// {
		// var int r = a1/a;
		// if(r>10)
		// r:=-r;
		// else
		// TEST1(r);
		// }
		// funcion int QUADRADO(int num)
		// num*num;
		//
		// */

		// String program = "Programa /n var int a := 10; /n cons bool b :=
		// true; /n procedure TEST1(int a1)/n { /n var int r = a1/a; /n if(r>10)
		// /n r:=-r; /n else /n TEST1(r); /n }funcion /n int QUADRADO(int num)
		// /n num*num; /n */";

		// Lexico lexical = new Lexico(new StringReader(program));

		// try {
		// Parser p = new Parser(new Lexico(new
		// FileReader("../LinguagemX/src/analise_lexica/program.txt")));
		// Object result = p.debug_parse();
		//
		// //System.out.println(result.toString());
		// } catch (Exception e) {
		// // System.out.println(e.getMessage());
		// }

		try {
			Lexico l = new Lexico(new FileReader("../LinguagemX/src/analise_lexica/program.txt"));
			while (true) {
				try {
					Symbol t = l.next_token();
					if (t == null || t.sym == 0) {
						System.out.println("EOF");
						break;
					}
					System.out.println(t.toString());
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
			}
		} catch (FileNotFoundException e1) {
			System.out.println(e1.getMessage());
		}
	}
}
