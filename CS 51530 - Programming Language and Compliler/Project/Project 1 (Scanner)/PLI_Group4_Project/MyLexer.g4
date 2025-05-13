lexer grammar MyLexer;

// Keywords
KEYWORD_DOUBLE : 'double' ;
KEYWORD_INT : 'int' ;
KEYWORD_LONG : 'long' ;
KEYWORD_CHAR : 'char' ;
KEYWORD_BOOL : 'bool' ;
KEYWORD_FUN : 'fun' ;
KEYWORD_IF : 'if' ;
KEYWORD_THEN : 'then' ;
KEYWORD_ELSE : 'else' ;
KEYWORD_TRUE : 'true' ;
KEYWORD_FALSE : 'false' ;
KEYWORD_ORELSE : 'orelse' ;
KEYWORD_ANDALSO : 'andalso' ;

// Operators
ASSIGN : '=' ;
PLUS_ASSIGN : '+=' ;
MINUS_ASSIGN : '-=' ;
MULT_ASSIGN : '*=' ;
DIV_ASSIGN : '/=' ;
PLUS : '+' ;
MINUS : '-' ;
MULT : '*' ;
DIV : '/' ;
INT_DIV : '//' ;
GT : '>' ;
LT : '<' ;
EQ : '==' ;
NEQ : '!=' ;
NOT : '!' ;

// Separators
SEMICOLON : ';' ;
COMMA : ',' ;
LPAREN : '(' ;
RPAREN : ')' ;
LBRACE : '{' ;
RBRACE : '}' ;

// Valid Integer Literals
INTEGER_LITERAL : '0' 
                | [1-9] ('_'* [0-9])* 
                | [0-9] ('_'* [0-9])* [lL]
                ;

// Valid Double Literals
DOUBLE_LITERAL : [0-9]+ '.' [0-9]+ 
               | '.' [0-9]+
               ;

// Invalid Integer Literals
INVALID_INTEGER_LITERAL : '0' [0-9_]+ // Leading zero
                        | '_' [0-9_]+ // Starting with underscore
                        | [0-9] ('_'* [0-9])* '_' // Ending with underscore
                        ;

// Invalid Double Literals
INVALID_DOUBLE_LITERAL : '0' [0-9]* '.' [0-9]* // Leading zero for non-zero
                       | [0-9]+ '.' // No digits after decimal
                       ;

// Char Literal
CHAR_LITERAL : '"' . '"' ;

// Identifier
IDENTIFIER : [a-zA-Z] [a-zA-Z0-9]* ;

// Invalid Identifier starting with a number
INVALID_IDENTIFIER : [0-9]+ [a-zA-Z] [a-zA-Z0-9]* ;

// Comments - skip
COMMENT : '(*' .*? '*)' -> skip ;

// Whitespace - skip
WS : [ \t\r\n]+ -> skip ;

// Error catch-all
ERROR : . ;