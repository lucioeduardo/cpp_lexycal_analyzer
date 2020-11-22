package br.ufal.compiladores;

import java.io.File;
import java.nio.file.Paths;

public class Generator {
	public static void main(String[] args) {
		String rootPath = Paths.get("").toAbsolutePath(). toString();
        String subPath = "/src/br/ufal/compiladores/";

        String file = rootPath + subPath + "cpp.flex";

        File sourceCode = new File(file);

        jflex.Main.generate(sourceCode);
	}
}
