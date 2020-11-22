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
{BLANK}                      { }
{INTEGER}                    { return createToken("integer", yytext()); }

/* Simbolos especiais */
{BRACES_LEFT} 	    {return createToken("operator", "bracesLeft");}
{BRACES_RIGHT}	    {return createToken("operator", "bracesRight");}
"(" 		        {return createToken("operator", "parenthesesLeft");}
")"			        {return createToken("operator", "parenthesesRight");}
{BRACKETS_LEFT} 	{return createToken("operator", "bracketsLeft");}
{BRACKETS_RIGHT}	{return createToken("operator", "bracketsRight");}
","			        {return createToken("operator", "comma");}
":"		        	{return createToken("operator", "colon");}
";"     			{return createToken("operator", "semiColon");}
"*"			        {return createToken("operator", "asterisk");}
{PRE_PROCESSOR}		{return createToken("operator", "preProcessor");}
{MACRO}		        {return createToken("operator", "macro");}
"..."		        {return createToken("operator", "ellipsis");}


/* Operadores Aritméticos */
"+"			{return createToken("operator","addition");}
"-"			{return createToken("operator","subtraction");}
"/"			{return createToken("operator","division");}
"%"			{return createToken("operator","modulus");}
"++"		{return createToken("operator","increment");}
"--"		{return createToken("operator","decrement");}

/* Operadores Relacionais */
"=="		{return createToken("operator","equalsTo");}
{NOT_EQ}	{return createToken("operator","notEqualsTo");}
">="		{return createToken("operator","lessEqTo");}
"<="		{return createToken("operator","greaterEqTo");}
"<"			{return createToken("operator","lessThan");}
">"			{return createToken("operator","greaterThan");}

/* Operadores lógicos */
{AND}      {return createToken("operator","and");}
{OR}       {return createToken("operator","or");}
{NOT}      {return createToken("operator","not");}

/* Operadores bitwise */

{BIT_AND}	{return createToken("operator","bitAnd");}
{BIT_OR}	{return createToken("operator","bitOr");}
{BIT_NOT}   {return createToken("operator","bitNot");}
{XOR}	    {return createToken("operator","xor");}
">>"		{return createToken("operator","rightShift");}
"<<"		{return createToken("operator","leftShift");}

/* Operadores de atribuição */
"="			        {return createToken("operator","assignment");}
"+="			    {return createToken("operator","addAssign");}
"*="			    {return createToken("operator","multAssign");}
"/="			    {return createToken("operator","divAssign");}
"-="			    {return createToken("operator","subAssign");}
"%="			    {return createToken("operator","modAssign");}
{AND_EQ}			{return createToken("operator","andAssign");}
{XOR_EQ}			{return createToken("operator","xorAssign");}
{OR_EQ}			    {return createToken("operator","orAssign");}
"<<="			    {return createToken("operator","leftShiftAssign");}
">>="			    {return createToken("operator","rightShiftAssign");}


{ID}                         { return createToken("id", yytext()); }

. { throw new RuntimeException("Caractere inválido " + yytext()); }