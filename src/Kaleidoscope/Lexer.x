{
-- this turns off warnings for the alex generated code
{-# OPTIONS_GHC -w #-}

module Haskaleidoscope.Lexer (
    alexScanTokens,
    Token(..)) where

import Haskaleidoscope.Token
}

%wrapper "basic"

$digit = 0-9        -- digits
$alpha = [a-zA-Z]   -- alphabetic characters
$op = [\+ \- \* \< \> \~ \$ \% \^ \& \+ \= \? \|]

tokens :-
    -- ignore comments, white space and semi colons
    $white+ ;
    \#.*$   ;
    \;      ;
    
    -- keywords
    def       { \_ -> TokDef }
    extern    { \_ -> TokExtern }
    if        { \_ -> TokIf }
    then      { \_ -> TokThen }
    else      { \_ -> TokElse }
    for       { \_ -> TokFor }
    in        { \_ -> TokIn }
    binary    { \_ -> TokBinary }
    unary     { \_ -> TokUnary }
    var       { \_ -> TokVar }
    
    -- punctuation (note '=' must come before op rule because of overlap)
    \(  { \_ -> TokOpenParen }
    \)  { \_ -> TokCloseParen }
    \,  { \_ -> TokComma }
    =   { \_ -> TokEq }
    
    -- numbers, identifiers and operators
    ($digit+ \. $digit+ | $digit+)  { \s -> TokNumber (read s) }
    $alpha [$alpha $digit \_]*      { \s -> TokIdentifier s }
    $op+                            { \s -> TokBinaryOp s }
