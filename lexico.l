%option case-insensitive
%option yylineno

%{
#include <iostream>
//#include <QString>
#include "parser.h"
#include <string>
//#include <QList>
int yylex();
void yyerror(const char *s);
int linea = 0;
int columna = 1;
int anterior = 0;
%}
%option noyywrap
%option nounput


/*Expresion Regulares*/
entero [0-9]+
letra [a-zA-Z]

identificador {letra}({letra}|{entero}|"_")*
ruta ([/]([^\n' '])*)
cadena [\"][^\"\n]*[\"\n]
comentario #.*


%x COM

/*palabras reservadas*/
/*
"mount" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_mount;}
"unmount" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_unmount;}
"mkfs" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_mkfs;}
"login" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_login;}
"mkgrp" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_mkgrp;}
"rmgrp" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_rmgrp;}
"mkusr" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_mkusr;}
"rmusr" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_rmusr;}
"chmod" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_chmod;}
"mkfile" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_mkfile;}
"cat" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_cat;}
"rem" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_rem;}
"edit" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_edit;}
"ren" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_ren;}
"mkdir" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_mkdir;}
"cp" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_cp;}
"mv" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_mv;}
"find" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_find;}
"chown" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_chown;}
"chgrp" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_chgrp;}
"logout" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_logout;}
"pause" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_pause;}
"recovery" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_recovery;}
"loss" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_loss;}

"rep" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_rep;}
"f" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_f;}
"u" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_u;}
"delete" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_delete;}
"name" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_name;}
"add" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_add;}
"id" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_id;}
"fs" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_fs;}
"usr" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_usr;}
"pwd" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_pwd;}
"grp" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_grp;}
"ugo" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_ugo;}
"cont" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_cont;}
"file" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_file;}
"p" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_p;}
"dest" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_dest;}
"r" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_r;}
"ruta" {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_ruta;}
*/
%%

"mkdisk"    {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return tk_mkdisk;}
"rmdisk"    {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return tk_rmdisk;}
"fdisk"     {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return tk_fdisk;}
"exec"      {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_exec;}
"mount"     {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_mount;}

"size"      {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return tk_size;}
"path"      {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return tk_path;}
"f"         {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return tk_f;}
"u"         {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return tk_u;}
"name"      {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_name;}
"add"       {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_add;}
"delete"    {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_delete;}
"type"      {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_type;}

{entero}        {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return entero;}
{cadena}        {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return cadena;}
{identificador} {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return identificador;}
{ruta}          {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return tk_ruta;}
{comentario}    {columna=columna+ anterior;  anterior = strlen(yytext);strcpy(yylval.TEXT, yytext);return comentario;}


"-" {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return guion;}
"=" {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return igual;}
"?" {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return interrogacion;}
"*" {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return por;}
"." {columna=columna+ anterior;  anterior = strlen(yytext); strcpy(yylval.TEXT, yytext);return punto;}


"\n" {linea++; columna=0; anterior=0;}
[[:blank:]] { columna++; }



.   {

std::cout<<"Error Lexico: "<<linea<<"\n";
//printf("Error lexico en linea %d",linea);
}
