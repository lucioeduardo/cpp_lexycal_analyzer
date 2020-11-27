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
COMMENTS = "//".* | "/*"~"*/"

NON_DIGIT = [a-z|[A-Z]|_]
DIGIT = [0-9]
IDENTIFIER = {NON_DIGIT}+{DIGIT}*

NUMBER = {INTEGER} | {FLOAT}
SINGLECHARACTER = [^\r\n\'\\]   

INTEGER = ("0"|{INT_DEC}|{INT_HEX}|{INT_BIN})({INT_SUFFIX}?)
INT_DEC = [1-9]{DIGIT}*

HEX_DIG = [0-9|a-f|A-F]
INT_HEX = ("0x"|"0X"){HEX_DIG}+

INT_BIN = ("0b"|"0B")[0-1]+

INT_SUFFIX = ({L_SUFFIX}?{U_SUFFIX})|({U_SUFFIX}?{L_SUFFIX})
L_SUFFIX = "l"|"L"|"LL"|"ll"
U_SUFFIX = "u"|"U"

FLOAT = ({FRACTIONAL_CONSTANT}{EXPONENT_PART}?{FLOAT_SUFFIX}?) | {DIGIT_SEQUENCE}{EXPONENT_PART}{FLOAT_SUFFIX}?

DIGIT_SEQUENCE = {DIGIT}+
FRACTIONAL_CONSTANT = {DIGIT_SEQUENCE}?"."{DIGIT_SEQUENCE}
EXPONENT_PART = ("e"|"E")("+"|"-")?{DIGIT_SEQUENCE}
FLOAT_SUFFIX = "f"|"F"|"l"|"L"

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

KEYWORD = "alignas" | "alignof" | "asm" | "auto" | "bool" | "break" | "case" | "catch" | "char" | "char16_t" | "char32_t" | "class" | "const" | "constexpr" | "const_cast" | "2" | "continue" | "decltype" | "default" | "delete" | "do" | "double" | "dynamic_cast" | "else" | "enum" | "explicit" | "export" | "extern" | "false" | "float" | "for" | "friend" |"goto" | "if" | "inline" | "int" | "long" | "mutable" | "namespace" | "new" | "noexcept" | "nullptr" | "operator" | "private" | "protected" | "public" | "register" |"reinterpret_cast" | "return" | "short" | "signed" | "sizeof" | "static" | "static_assert" | "static_cast" | "struct"| "switch" | "template" | "this" | "thread_local" | "throw"| "true" | "try" | "typedef" | "typeid" | "typename" | "union" | "unsigned" | "using" | "virtual" | "void" | "volatile" | "wchar_t" | "while" | "if" | "elif" | "else"| "endif" | "ifdef" | "ifndef" | "define" | "undef" | "include" | "line" | "error" | "pragma" | "final" | "override"

HEADER = "<"~">" | "\"~"\"

%%

{BLANK}                      { }
{NUMBER}                    { return createToken("number", yytext()); }
{COMMENTS}                   { }
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

/* boolean literals */
"true"                         { return createToken("boolean", yytext());}
"false"                        { return createToken("boolean", yytext());}

\'{SINGLECHARACTER}\'           {return createToken("character_literal", yytext());}


{KEYWORD}                         {return createToken("keyword", yytext());}
{HEADER}        {   
                    String str = yytext();
                    str = str.substring(1, str.length()-1);
                    return createToken("header", str);
                }

{IDENTIFIER}                         { return createToken("identifier", yytext()); }

. { throw new RuntimeException("Caractere inválido " + yytext()); }
