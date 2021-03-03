%{
#include "scanner.h"//se importa el header del analisis sintactico
#include <QString>
#include <string>
#include <cstring>
#include <stdlib.h>
#include "qdebug.h"
#include <iostream>
#include <vector>
#include <dirent.h>
#include <stdio.h>
#include "Objetos/mkdisk.h"
#include "Objetos/rmdisk.h"
#include "Objetos/exec.h"
#include "CommandFDISK/fdisk.h"
#include "comandoMOUNT/mount.h"
#include "libreria/funciones.h"
#include "Estructuras/structs.h"
//#include "obmkdisk.h"
using namespace std;
extern int yylineno; //linea actual donde se encuentra el parser (analisis lexico) lo maneja BISON
extern int columna; //columna actual donde se encuentra el parser (analisis lexico) lo maneja BISON
extern char *yytext; //lexema actual donde esta el parser (analisis lexico) lo maneja BISON


/*vectores para los parametros de cada comando*/
vector<string> parametrosMkdisk;
string mkdiskParametros[4];
string rmdiskParametros;
string execParametro;
string fdiskParametros[8];
string mountParametros[2];
int indice = 0;
vector<montajeDisco> discos;
int numeroDisco = 0;


int yyerror(const char* mens)
{
std::cout << mens <<" "<<yytext<< std::endl;
return 0;
}
%}
//error-verbose si se especifica la opcion los errores sintacticos son especificados por BISON
%defines "parser.h"
%output "parser.cpp"
//%error-verbose
%locations
%union{
//se especifican los tipo de valores para los no terminales y lo terminales
//char TEXT [256];
//QString TEXT;
char TEXT[256];
/*objetos para cada comando*/
//class mkdisk *mkdisk;
}

//TERMINALES DE TIPO TEXT, SON STRINGS

%token<TEXT> tk_mkdisk;
%token<TEXT> tk_rmdisk;
%token<TEXT> tk_fdisk;
%token<TEXT> tk_exec;
%token<TEXT> tk_mount;

%token<TEXT> tk_size;
%token<TEXT> tk_path;
%token<TEXT> tk_f;
%token<TEXT> tk_u;
%token<TEXT> tk_name;
%token<TEXT> tk_add;
%token<TEXT> tk_delete;
%token<TEXT> tk_type;

%token<TEXT> guion;
%token<TEXT> igual;
%token<TEXT> interrogacion;
%token<TEXT> por;
%token<TEXT> punto;


%token<TEXT> entero;
%token<TEXT> cadena;
%token<TEXT> identificador;
%token<TEXT> tk_ruta;
%token<TEXT> comentario;

//%type<int> PARAMETROS_MKDISK;
//%type<mkdisk> MKDISK;


%start INICIO
%%

INICIO: LISTADO_COMANDOS ;


LISTADO_COMANDOS: LISTADO_COMANDOS COMANDO
                | COMANDO ;


COMANDO : MKDISK        {mkdisk disco; disco.crearDisco(mkdiskParametros);for(int i=0;i<sizeof(mkdiskParametros)/sizeof(mkdiskParametros[0]);i++){mkdiskParametros[i]="";}}
        | RMDSIK        {rmdisk eliminacion; eliminacion.eliminarDisco(rmdiskParametros);}
        | FDISK         {fdisk manejoParticiones;manejoParticiones.ejecutarFdisk(fdiskParametros);for(int i=0;i<sizeof(fdiskParametros)/sizeof(fdiskParametros[0]);i++){fdiskParametros[i]="";}}
        | EXEC          {exec read; read.leerArchivo(execParametro);}
        | MOUNT         {mount montaje;montaje.montarDisco(mountParametros,discos,numeroDisco);for(int i=0;i<sizeof(mountParametros)/sizeof(mountParametros[0]);i++){mountParametros[i]="";}}
        | COMENTARIO    {}
        ;


COMENTARIO : comentario {} ;


MKDISK : tk_mkdisk LIST_PARAMETROS_MKDISK ;


LIST_PARAMETROS_MKDISK  : LIST_PARAMETROS_MKDISK PARAMETROS_MKDISK
                        | PARAMETROS_MKDISK ;


PARAMETROS_MKDISK : guion tk_size igual entero      {mkdiskParametros[0]=$4;}
                  | guion tk_path igual cadena      {mkdiskParametros[1]=$4;}
                  | guion tk_path igual tk_ruta     {mkdiskParametros[1]=$4;}
                  | guion tk_u igual identificador  {mkdiskParametros[2]=$4;}
                  | guion tk_f igual identificador  {mkdiskParametros[3]=$4;}
                  ;

RMDSIK : tk_rmdisk guion tk_path igual cadena  {rmdiskParametros=$5;}
       | tk_rmdisk guion tk_path igual tk_ruta {rmdiskParametros=$5;}
       ;



FDISK : tk_fdisk LIST_PARAMETROS_FDISK {}
      ;

LIST_PARAMETROS_FDISK   : LIST_PARAMETROS_FDISK PARAMETROS_FDISK
                        | PARAMETROS_FDISK
                        ;

PARAMETROS_FDISK        : guion tk_path igual cadena            {fdiskParametros[0]=$4;}
                        | guion tk_path igual tk_ruta           {fdiskParametros[0]=$4;}
                        | guion tk_add igual entero             {fdiskParametros[1]=$4;}
                        | guion tk_delete igual identificador   {fdiskParametros[2]=$4;}
                        | guion tk_size igual entero            {fdiskParametros[3]=$4;}
                        | guion tk_name igual identificador     {fdiskParametros[4]=$4;}
                        | guion tk_name igual cadena            {fdiskParametros[4]=$4;}
                        | guion tk_type igual identificador     {fdiskParametros[5]=$4;}
                        | guion tk_f igual identificador        {fdiskParametros[6]=$4;}
                        | guion tk_u igual identificador        {fdiskParametros[7]=$4;}
                        ;



MOUNT : tk_mount LIST_PARAMETROS_MOUNT
      ;

LIST_PARAMETROS_MOUNT   : LIST_PARAMETROS_MOUNT PARAMETROS_MOUNT
                        | PARAMETROS_MOUNT
                        ;

PARAMETROS_MOUNT  :     guion tk_path igual tk_ruta         {mountParametros[0]=$4;}
                  |     guion tk_path igual cadena          {mountParametros[0]=$4;}
                  |     guion tk_name igual identificador   {mountParametros[1]=$4;}
                  |     guion tk_name igual cadena          {mountParametros[1]=$4;}
                  ;


EXEC : tk_exec guion tk_path igual cadena     {execParametro=$5;}
     | tk_exec guion tk_path igual tk_ruta    {execParametro=$5;}
     ;
