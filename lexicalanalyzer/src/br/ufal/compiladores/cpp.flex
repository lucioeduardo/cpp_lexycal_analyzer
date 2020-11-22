package br.ufal.compiladores;

%%

%{

private CppToken createToken(String name, String value) {
    return new CppToken(name, value, yyline, yycolumn);
}

%}


%public
%class LexicalAnalyzer
%type CppToken
%line
%column


BRANCO = [\n| |\t|\r]
ID = [_|a-z|A-Z][a-z|A-Z|0-9|_]*
INTEIRO = 0|[1-9][0-9]*

%%

"if"                         { return createToken("if", yytext()); }
{BRANCO}                     { return createToken("bs", ""); }
{ID}                         { return createToken("id", yytext()); }
{INTEIRO}                     { return createToken("inteiro", yytext()); }

/* operators */

"{" 		{return createToken("bracesLeft", yytext());}
"}"			{return createToken("bracesRight", yytext());}
"(" 		{return createToken("parenthesesLeft", yytext());}
")"			{return createToken("parenthesesRight", yytext());}
"#"			{return createToken("preProcessor", yytext());}
">>"		{return createToken("rightShift", yytext());}
"<<"		{return createToken("leftShift", yytext());}
"+"			{return createToken("plus", yytext());}
"<"			{return createToken("lowerThan", yytext());}
">"			{return createToken("greaterThan", yytext());}
";"			{return createToken("semiColon", yytext());}
","			{return createToken("comma", yytext());}


. { throw new RuntimeException("Caractere inválido " + yytext()); }