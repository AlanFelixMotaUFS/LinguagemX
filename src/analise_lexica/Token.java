package analise_lexica;

public class Token {

	public String name;
	public String value;
	public Integer line;
	public Integer column;

	public Token(String name, String value, Integer line, Integer column) {
		this.name = name;
		this.value = value;
		this.line = line;
		this.column = column;
	}
}