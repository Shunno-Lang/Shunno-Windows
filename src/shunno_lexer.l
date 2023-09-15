%{
#include <iostream>
#include <string>
using namespace std;

// Define the yylval union to match your token attributes
union YYSTYPE {
    int integer_value;
    char* string_value;
};

YYSTYPE yylval; // Declare a variable of the YYSTYPE type

extern int yylex();
extern int yylineno;
extern int yyparse();

// Include headers for atoi and strdup
#include <cstdlib>   // For atoi
#include <cstring>   // For strdup

// Define strdup explicitly
extern "C" char* strdup(const char*);

%}


%option noyywrap
%option yylineno
%option case-insensitive

%%

"\\u09B8\\u09BE\\u09B0\\u09BF"                              { return T_ARRAY; } // "সারি"
"\\u09B2\\u09C7\\u0996\\u09BE"                              { return T_STRING; } // "লেখা"
"\\u09B8\\u0982\\u0996\\u09CD\\u09AF\\u09BE"                { return T_INTEGER; } // "সংখ্যা"
"\\u09AC\\u09C1\\u09B2"                                     { return T_BOOLEAN; } // "বুল"
"\\u09AB\\u09BE\\u0982\\u0997\\u09B6\\u09A8"                { return T_FUNCTION; } // "ফাংশন"
"\\u09A6\\u09C7\\u0996\\u09BE\\u0989"                       { return T_PRINT; } // "দেখাও"
"\\u09AA\\u09CD\\u09B0\\u09A5\\u09B0"                       { return T_ARGUMENT1; } // "প্রথম"
"\\u09A6\\u09CD\\u09AC\\u09BF\\u099F\\u09BF\\u09AF\\u09BC"  { return T_ARGUMENT2; } // "দ্বিতীয়"
"\\u09B8\\u0982\\u0996\\u09CD\\u09AF\\u09BE"                { return T_DATATYPE; } // "সংখ্যা"
"\\u09AA\\u09BE\\u09A0\\u09BE\\u0987"                       { return T_RETURN; } // "পাঠাও"
"\\u09B8\\u09BE\\u099F\\u09CD\\u09AF"                       { return T_TRUE; } // "সত্য"
"\\u09AE\\u09BF\\u09A5\\u09CD\\u09AF\\u09BE"                { return T_FALSE; } // "মিথ্যা"

[0-9]+                  { yylval.integer_value = atoi(yytext); return T_BENGALI_INTEGER; }
\"[^\"]*\"              { yylval.string_value = strdup(yytext); return T_STRING_LITERAL; }

"\\u09A8\\u09BE\\u09AE" { return T_IDENTIFIER; } // "নাম"

"="                     { return T_ASSIGN; }
";"                     { return T_SEMICOLON; }
"("                     { return T_LPAREN; }
")"                     { return T_RPAREN; }
"{"                     { return T_LBRACE; }
"}"                     { return T_RBRACE; }
"+"                     { return T_PLUS; }

[ \t\n]                 ;  // Ignore whitespace and newline characters.
.                       ;  // Ignore any other character.

%%

int main() {
    // Initialize the lexer.
    yylex();
    return 0;
}
