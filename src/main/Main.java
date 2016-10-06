package main;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringReader;

import analise_lexica.Lexico;
import analise_sintatica.Parser;
import java_cup.runtime.Symbol;
import jflex.sym;

public class Main {

	public static void main(String[] args) {
		//Lexico();
		Parser();

	}

	public static void Lexico() {
		try {
			Lexico l = new Lexico(new FileReader("../LinguagemX/src/main/program.txt"));
			while (true) {
				try {
					Symbol t = l.next_token();
					if (t == null || t.sym == 0) {
						System.out.println("EOF");
						break;
					}

					System.out.println("Token: " + l.yytext() + " | Symbol: " + t.sym);
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
			}
		} catch (FileNotFoundException e1) {
			System.out.println(e1.getMessage());
		}

	}

	public static void Parser() {
		try {
			Parser p = new Parser(new Lexico(new FileReader("../LinguagemX/src/main/program.txt")));
			
			System.out.println("Análise sintática ..........");

			p.debug_parse();

			System.out.println("Análise sintática realizada com sucesso!");
		} catch (Exception e) {
			// System.out.println(e.getMessage());
		}
	}

}
