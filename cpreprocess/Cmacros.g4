grammar Cmacros;

/* Process #define statements in a C file.
   TODO : develop token_sequence
*/

compilationUnit : translation_unit ;

translation_unit
@init {System.out.println("Cmacros last update 1436");}
    :   ( '#' preprocessor
    |     ignore
    |     NL
        )+
    ;

preprocessor
    :   pp_define
    |	pp_include
    |   pp_ignore
    ;

pp_define
    :   'define' ID '(' ID ( ',' ID )* ')' token_sequence
    |   'define' ID token_sequence
    ;

pp_include
	:	'include' (STRING|STRING2)
	;

pp_ignore
    :   ignore
    ;

token_sequence
    :   ignore
    ;

ignore
    :   ~NL+ NL
    ;

CHAR
    :   '\'' ( '\\'? . )+? '\'' ;

COMMENT
    :    '/*' .*? '*/' -> channel(HIDDEN)
    ;

HEXADECIMAL
    :   '0' [xX] [0-9a-fA-F]+
    ;

ID  :   ( ID_FIRST (ID_FIRST | DIGIT)* )
    ;

INT :   DIGIT+ ;

//NL  :   '\r'? '\n' -> channel(WHITESPACE) ;  // channel(1)
//NL  :   '\n' -> channel(HIDDEN) ;
NL  :   '\n' ;

SL_COMMENT
    :   '//' .*? '\n' -> channel(HIDDEN)
    ;

SPECIAL
    :   '+' | '-' | '*' | '/' | '%' | '&' | '|' | '(' | ')' | '{' | '}' |
'[' | ']'
    |   '^' | '!' | '<' | '>' | '=' | ',' | '.' | ';' | ':' | '?'
    ;

STRING
    :   '"' ( '\\'? . )*? '"' ;

STRING2
    :   '<' ( '\\'? . )*? '>' ;

WS  :   ([ \t] | '\\' NL)+ -> channel(HIDDEN) ;

fragment DIGIT  : [0-9] ;

fragment ID_FIRST : LETTER | '_' ;

fragment LETTER : [a-zA-Z] ;
 
