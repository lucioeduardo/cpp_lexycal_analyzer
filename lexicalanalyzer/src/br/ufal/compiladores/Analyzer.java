package br.ufal.compiladores;

import java.io.FileReader;
import java.io.IOException;
import java.io.StringReader;
import java.nio.file.Paths;

public class Analyzer {
	public static void main(String[] args) throws IOException {
		String rootPath = Paths.get("").toAbsolutePath(). toString();
        String subPath = "/src/br/ufal/compiladores/";

        String sourceCode = rootPath + subPath + "/main.cpp";

        LexicalAnalyzer lexical = new LexicalAnalyzer(new FileReader(sourceCode));

        CppToken token;

        while ((token = lexical.yylex()) != null) {
            System.out.println("<" + token.name + ", " + token.value + "> (" + token.line + " - " + token.column + ")");
        }
	}
}
