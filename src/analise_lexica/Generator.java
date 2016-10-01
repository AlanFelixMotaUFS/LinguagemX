package analise_lexica;

import java.io.File;
import java.nio.file.Paths;

public class Generator {

	public static void main(String[] args) {

		String rootPath = Paths.get("").toAbsolutePath().toString();
		String subPath = "/src//analise_lexica/";

		String file = rootPath + subPath + "language.lex";

		File sourceCode = new File(file);

		jflex.Main.generate(sourceCode);

	}
}