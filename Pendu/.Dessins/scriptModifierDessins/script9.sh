#!/bin/bash

# @author Matthieu - 20 janvier 16
#
# script9.sh

rm ../9.txt

vert="\\033[32m"
rouge="\\033[31m"
bleu="\\033[34m"
jaune="\\033[33m"
default="\\033[0m"
rose="\\033[95m"

fVert="\\033[42;30m"
fJaune="\\033[103;30m"
fBleu="\\033[106;30m"
fRouge="\\033[41;30m"
fGris="\\033[47;30m"
fDefault="\\033[49;39m"

echo -e "$fBleu \\033[4;30m$fBleu   $fGris   $fBleu       $default$fBleu                    $fJaune   $fDefault" >> ../9.txt
echo -e "$fBleu | $fGris     $fBleu  |                        $fJaune  $fDefault" >> ../9.txt
echo -e "$fBleu |  $fGris   $fBleu   0      ah mes bras         $fDefault" >> ../9.txt
echo -e "$fBleu |      / | \     aussi ? wtf..      $fDefault" >> ../9.txt
echo -e "$fBleu |     /  |  \                       $fDefault" >> ../9.txt
echo -e "$fVert |       / \                         $fDefault" >> ../9.txt
echo -e "$fVert |   .                $rose*          $rouge*   $fDefault" >> ../9.txt
echo -e "$fVert/|\         $jaune*$fVert        \|/        \|/  $fDefault" >> ../9.txt
echo -e "$fVert.. .. .. ..\|/ .. .. .. .. .. .. ..  $fDefault" >> ../9.txt
