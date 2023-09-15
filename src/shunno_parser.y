%{
#include <iostream>
#include <string>
using namespace std;

extern int yylex();
extern char* yytext;
extern int yyparse();

void yyerror(const char* msg) {
    cerr << "Error: " << msg << " at line " << endl;
}

// Define data structures to represent language constructs (e.g., variables, functions).
// You'll need to create proper data structures to store these constructs.
struct Variable {
    string name;
    string type;
};

struct Function {
    string name;
    string returnType;
    // Add parameters and function body as needed.
};

// You can define symbol tables or other data structures to manage variables and functions.
%}

%union {
    int integer_value;
    char* string_value;
}

%token T_ARRAY
%token T_STRING
%token T_INTEGER
%token T_BOOLEAN
%token T_FUNCTION
%token T_PRINT
%token T_ARGUMENT1
%token T_ARGUMENT2
%token T_DATATYPE
%token T_RETURN
%token T_TRUE
%token T_FALSE
%token T_BENGALI_INTEGER
%token T_STRING_LITERAL
%token T_IDENTIFIER
%token T_ASSIGN
%token T_SEMICOLON
%token T_LPAREN
%token T_RPAREN
%token T_LBRACE
%token T_RBRACE
%token T_PLUS

%left '+'   // Define operator precedence and associativity here

%%

program : /* empty */ 
        | program statement
        ;

statement : variable_declaration
          | function_definition
          | print_statement
          ;

variable_declaration : T_DATATYPE T_IDENTIFIER T_ASSIGN expression T_SEMICOLON
                    ;

function_definition : T_FUNCTION T_IDENTIFIER T_LPAREN parameter_list T_RPAREN T_LBRACE /* function body */ T_RBRACE
                    ;

parameter_list : /* empty */
               | T_ARGUMENT1 T_DATATYPE T_IDENTIFIER
               | parameter_list T_ARGUMENT1 T_DATATYPE T_IDENTIFIER
               ;

expression : T_BENGALI_INTEGER
           | T_STRING_LITERAL
           | T_TRUE
           | T_FALSE
           | expression T_PLUS expression
           ;

print_statement : T_PRINT T_STRING_LITERAL T_SEMICOLON
               ;

%%

int main() {
    yyparse();
    return 0;
}
