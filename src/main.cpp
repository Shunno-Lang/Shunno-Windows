#include <iostream>
#include "shunno_lexer.h"    // Include the lexer header file
#include "shunno_parser.tab.h"  // Include the parser header file

int main() {
    yyparse(); // Start the parsing process
    return 0;
}
