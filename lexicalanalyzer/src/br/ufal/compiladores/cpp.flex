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


BLANK = [\n| |\t|\r]
ID = [_|a-z|A-Z][a-z|A-Z|0-9|_]*
INTEGER = 0|[1-9][0-9]*


BRACES_LEFT = "<%" | "{"
BRACES_RIGHT = "%>" | "}"
BRACKETS_LEFT = "<:" | ":>"
BRACKETS_RIGHT = ":>" | "]"
PRE_PROCESSOR = "%:" | "#"
MACRO = "%:%:":"##"

AND = "and" | "&&"
OR = "or" | "||"
XOR = "^" | "xor"
BIT_NOT = "~" | "compl"
NOT = "not" | "!"
BIT_OR = "bitor" | "|"
BIT_AND =  "&" | "bitand"

AND_EQ = "&=" | "and_eq"
OR_EQ = "!=" | "or_eq"
XOR_EQ = "^=" | "xor_eq"
NOT_EQ = "!=" | "not_eq"

%%

"if"                         { return createToken("if", yytext()); }
{BLANK}                      { return createToken("blank", ""); }
{INTEGER}                    { return createToken("integer", yytext()); }

/* Simbolos especiais */
{BRACES_LEFT} 	    {return createToken("bracesLeft", "");}
{BRACES_RIGHT}	    {return createToken("bracesRight", "");}
"(" 		        {return createToken("parenthesesLeft", "");}
")"			        {return createToken("parenthesesRight", "");}
{BRACKETS_LEFT} 	{return createToken("bracketsLeft", "");}
{BRACKETS_RIGHT}	{return createToken("bracketsRight", "");}
","			        {return createToken("comma", "");}
":"		        	{return createToken("colon", "");}
";"     			{return createToken("semiColon", "");}
"*"			        {return createToken("asterisk", "");}
{PRE_PROCESSOR}		{return createToken("preProcessor", "");}
{MACRO}		        {return createToken("macro", "");}
"..."		        {return createToken("ellipsis", "");}


/* Operadores Aritméticos */
"+"			{return createToken("addition", "");}
"-"			{return createToken("subtraction", "");}
"/"			{return createToken("division", "");}
"%"			{return createToken("modulus", "");}
"++"		{return createToken("increment", "");}
"--"		{return createToken("decrement", "");}

/* Operadores Relacionais */
"=="		{return createToken("equalsTo", "");}
{NOT_EQ}	{return createToken("notEqualsTo", "");}
">="		{return createToken("lessEqTo", "");}
"<="		{return createToken("greaterEqTo", "");}
"<"			{return createToken("lessThan", "");}
">"			{return createToken("greaterThan", "");}

/* Operadores lógicos */
{AND}      {return createToken("and", "");}
{OR}       {return createToken("or", "");}
{NOT}      {return createToken("not", "");}

/* Operadores bitwise */

{BIT_AND}	{return createToken("bitAnd", "");}
{BIT_OR}	{return createToken("bitOr", "");}
{BIT_NOT}   {return createToken("bitNot", "");}
{XOR}	    {return createToken("xor", "");}
">>"		{return createToken("rightShift", "");}
"<<"		{return createToken("leftShift", "");}

/* Operadores de atribuição */
"="			        {return createToken("assignment", "");}
"+="			    {return createToken("addAssign", "");}
"*="			    {return createToken("multAssign", "");}
"/="			    {return createToken("divAssign", "");}
"-="			    {return createToken("subAssign", "");}
"%="			    {return createToken("modAssign", "");}
{AND_EQ}			{return createToken("andAssign", "");}
{XOR_EQ}			{return createToken("xorAssign", "");}
{OR_EQ}			    {return createToken("orAssign", "");}
"<<="			    {return createToken("leftShiftAssign", "");}
">>="			    {return createToken("rightShiftAssign", "");}


{ID}                         { return createToken("id", yytext()); }

. { throw new RuntimeException("Caractere inválido " + yytext()); }