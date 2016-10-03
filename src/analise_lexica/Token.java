package analise_lexica;

import java_cup.runtime.Symbol;

public class Token extends Symbol {
    
    public int linha;
    public int coluna;
    
	public Token(int tipo, int linha, int coluna, Object valor) {
		this(tipo, linha, coluna, -1, -1, valor);
	}

	public Token(int tipo, int linha, int coluna, int esq, int dir, Object valor) {
		super(tipo, esq, dir, valor);
		this.linha = linha;
		this.coluna = coluna;
	}
	
	public String toString() {
        return "line "+linha+", column "+coluna+", sym: "+sym+(value == null ? "" : (", value: '"+value+"'"));
    }
}