package br.ufal.compiladores;

public class CppToken {
    public String name;
    public String value;
    public Integer line;
    public Integer column;

    public CppToken(String name, String value, Integer line, Integer column) {
        this.name = name;
        this.value = value;
        this.line = line;
        this.column = column;
    }
}
