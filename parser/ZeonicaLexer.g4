lexer grammar ZeonicaLexer;

// Keywords
PE  : 'PE';
LOOP : 'Loop';
ONCE : 'Once';
ENTRY_BLOCK : 'Entry';

ADD      : 'ADD';
ADDI     : 'ADDI';
SUB      : 'SUB';
SUBI     : 'SUBI';
MUL      : 'MUL';
DIV      : 'DIV';
MAC      : 'MAC';
INC      : 'INC';
LLS      : 'LLS';
LRS      : 'LRS';
OR       : 'OR';
AND      : 'AND';
XOR      : 'XOR';
NOT      : 'NOT';
FADD     : 'FADD';
FSUB     : 'FSUB';
FMUL     : 'FMUL';
FDIV     : 'FDIV';
FMAC     : 'FMAC';
MOV      : 'MOV';
MUL_CONST_ADD : 'MUL_CONST_ADD';
NOP      : 'NOP';
CBR      : 'CBR';
CMOV     : 'CMOV';
SGE      : 'SGE';
LOAD     : 'LOAD';
STORE    : 'STORE';

ENTRY_ARROW : '=>';
RIGHT_ARROW : '->';
IMM         : 'IMM';
MEM         : 'MEM';

// Literals
DECIMAL_LITERAL : ('0' | [1-9] (Digits? | '_'+ Digits)) [lL]?;
HEX_LITERAL     : '0' [xX] [0-9a-fA-F] ([0-9a-fA-F_]* [0-9a-fA-F])? [lL]?;
OCT_LITERAL     : '0' '_'* [0-7] ([0-7_]* [0-7])? [lL]?;
BINARY_LITERAL  : '0' [bB] [01] ([01_]* [01])? [lL]?;

FLOAT_LITERAL:
    (Digits '.' Digits? | '.' Digits) ExponentPart? [fFdD]?
    | Digits (ExponentPart [fFdD]? | [fFdD])
;

HEX_FLOAT_LITERAL: '0' [xX] (HexDigits '.'? | HexDigits? '.' HexDigits) [pP] [+-]? Digits [fFdD]?;

BOOL_LITERAL: 'true' | 'false';

CHAR_LITERAL: '\'' (~['\\\r\n] | EscapeSequence) '\'';
STRING_LITERAL: '"' (~["\\\r\n] | EscapeSequence)* '"';
TEXT_BLOCK: '"""' [ \t]* [\r\n] (. | EscapeSequence)*? '"""';
NULL_LITERAL: 'null';

// Separators
LPAREN : '(';
RPAREN : ')';
LBRACE : '{';
RBRACE : '}';
LBRACK : '[';
RBRACK : ']';
SEMI   : ';';
COMMA  : ',';
DOT    : '.';
COLON  : ':';
AND_PRED : '!';
OR_PRED  : '^';

// Whitespace and comments
WS           : [ \t\r\n\u000C]+ -> channel(HIDDEN);
COMMENT      : '/*' .*? '*/'    -> channel(HIDDEN);
LINE_COMMENT : '//' ~[\r\n]*    -> channel(HIDDEN);

// Identifiers
IDENTIFIER: Letter LetterOrDigit*;

// Fragment rules
fragment ExponentPart: [eE] [+-]? Digits;
fragment EscapeSequence:
    '\\' 'u005c'? [btnfr"'\\]
    | '\\' 'u005c'? ([0-3]? [0-7])? [0-7]
    | '\\' 'u'+ HexDigit HexDigit HexDigit HexDigit
;
fragment HexDigits: HexDigit ((HexDigit | '_')* HexDigit)?;
fragment HexDigit: [0-9a-fA-F];
fragment Digits: [0-9] ([0-9_]* [0-9])?;
fragment LetterOrDigit: Letter | [0-9];
fragment Letter:
    [a-zA-Z$_]
    | ~[\u0000-\u007F\uD800-\uDBFF]
    | [\uD800-\uDBFF] [\uDC00-\uDFFF]
;