/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     5/05/2017 6:05:56 p. m.                      */
/*==============================================================*/


/*==============================================================*/
/* Schema divsalud-bd                                           */
/*==============================================================*/
CREATE SCHEMA IF NOT EXISTS `divsalud-bd` DEFAULT CHARACTER SET utf8 ;
USE `divsalud-bd` ;
/*==============================================================*/
/* Schema divsalud-bd                                           */
/*==============================================================*/



/*==============================================================*/
/* User divsalud-bd                                             */
/*==============================================================*/
drop user userdivsalud@localhost;
create user userdivsalud@localhost identified by 'divsalud';
grant all privileges on *.* to userdivsalud@localhost;
flush privileges;
/*==============================================================*/
/* User divsalud-bd                                             */
/*==============================================================*/



drop table if exists Diagnosticos;

drop table if exists Tipo_habito;

drop table if exists acompaniante_med;

drop table if exists actualizacion_odo;

drop table if exists alergeno_med;

drop table if exists ant_familiar_consulta_med;

drop table if exists ant_familiares_med;

drop table if exists ant_odo;

drop table if exists categoria_afiliado;

drop table if exists categoria_usuario;

drop table if exists cita_medica_med;

drop table if exists consulta_alergeno_med;

drop table if exists consulta_medica_med;

drop table if exists consulta_sistemas_cuerpo_med;

drop table if exists depto;

drop table if exists diagnostico_odo;

drop table if exists diagnosticocie10_odo;

drop table if exists enfermedades_cie10_med;

drop table if exists eps;

drop table if exists escolaridad;

drop table if exists estado_civil;

drop table if exists estrato;

drop table if exists facultad;

drop table if exists ginecostetricos_med;

drop table if exists grupo_usuario_tipo;

drop table if exists habitos_med;

drop table if exists historico_ginecostetricos;

drop table if exists listado_ant_odon;

drop table if exists medicamento_consulta_med;

drop table if exists medicamento_med;

drop table if exists municipio;

drop table if exists obs_odontograma;

drop table if exists paciente;

drop table if exists parentesco;

drop table if exists patologico_consulta_med;

drop table if exists patologicos_med;

drop table if exists presentacion_medicamento_med;

drop table if exists procedimientos_cups_med;

drop table if exists programas;

drop table if exists quirurgico_med;

drop table if exists raza;

drop table if exists sistema_cuerpo_med;

drop table if exists tipo_afiliado;

drop table if exists tipo_alergeno_med;

drop table if exists tipo_cita_med;

drop table if exists tipo_identificacion;

drop table if exists tipo_regimen;

drop table if exists tipo_usuario;

drop table if exists tipodiagnostico;

drop table if exists user;

drop table if exists usuarios_sistema;

drop table if exists via_administracion_med;

/*==============================================================*/
/* Table: Diagnosticos                                          */
/*==============================================================*/
create table Diagnosticos
(
   CODIGO_CIE10         varchar(20) not null,
   IDX_CONSULTA         int not null,
   IMPRESION            varchar(20),
   primary key (CODIGO_CIE10, IDX_CONSULTA)
);

/*==============================================================*/
/* Table: Tipo_habito                                           */
/*==============================================================*/
create table Tipo_habito
(
   ID                   int not null auto_increment,
   NOMBRE               varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: acompaniante_med                                      */
/*==============================================================*/
create table acompaniante_med
(
   IDX                  int not null auto_increment,
   ID                   int not null,
   NOMBRE               varchar(70) default NULL,
   TELEFONO             varchar(15) default NULL,
   CELULAR              varchar(15) default NULL,
   primary key (IDX)
);

/*==============================================================*/
/* Table: actualizacion_odo                                     */
/*==============================================================*/
create table actualizacion_odo
(
   ID                   int(11) not null auto_increment,
   ID_PACIENTE          int default NULL,
   ACOMPANANTE          varchar(40) default NULL,
   TELEFONO             varchar(40) default NULL,
   CELULAR              varchar(40) default NULL,
   PARENTESCO           varchar(30) default NULL,
   FECHA                date default NULL,
   HORA                 varchar(5) default NULL,
   TIPO                 varchar(40) default NULL,
   ID_USUARIO           int default NULL,
   primary key (ID),
   key AK_FK_ACTUALIZACION_ODO_PACIENTE_IDX (ID_PACIENTE),
   key AK_FK_ACTUALIZACION_ODO_USUARIOSISTEMA_IDX (ID_USUARIO)
);

/*==============================================================*/
/* Table: alergeno_med                                          */
/*==============================================================*/
create table alergeno_med
(
   IDX                  int not null auto_increment,
   IDX_TIPO_ALERGENO    int,
   NOMBRE               varchar(100) default NULL,
   ESTADO               bool not null,
   primary key (IDX),
   unique key AK_NOMBRE_UNIQUE (NOMBRE)
);

/*==============================================================*/
/* Table: ant_familiar_consulta_med                             */
/*==============================================================*/
create table ant_familiar_consulta_med
(
   IDX                  int not null auto_increment,
   OBSERVACIONES        varchar(2000) default NULL,
   PADRE                int default NULL,
   ABUELO_P             int default NULL,
   ABUELA_P             int default NULL,
   MADRE                int default NULL,
   ABUELO_M             int default NULL,
   ABUELA_M             int default NULL,
   HERMANOS             int default NULL,
   CONSULTA_MEDICA_MED_IDX int not null,
   ANT_FAMILIARES_MED_IDX int not null,
   primary key (IDX),
   key AK_FK_ANT_FAMILIAR_CONSULTA_MED_CONSULTA_MEDICA_MED1_IDX (CONSULTA_MEDICA_MED_IDX),
   key AK_FK_ANT_FAMILIAR_CONSULTA_MED_ANT_FAMILIARES_MED1_IDX (ANT_FAMILIARES_MED_IDX)
);

/*==============================================================*/
/* Table: ant_familiares_med                                    */
/*==============================================================*/
create table ant_familiares_med
(
   IDX                  int not null auto_increment,
   NOMBRE               varchar(200) default NULL,
   primary key (IDX)
);

/*==============================================================*/
/* Table: ant_odo                                               */
/*==============================================================*/
create table ant_odo
(
   ID                   int(11) not null auto_increment,
   ID_ACTUALIZACION     int default NULL,
   NOMBRE               varchar(50) default NULL,
   RESULTADO            varchar(2) default NULL,
   TIPO                 varchar(2) default NULL,
   ID_ANT               int default NULL,
   primary key (ID),
   key AK_FK_ANTECEDENTE_ODO_ACTUALIZACION_ODO_IDX (ID_ACTUALIZACION),
   key AK_FK_ANTECEDENTE_ODO_ANTECEDENTE_IDX (ID_ANT)
);

/*==============================================================*/
/* Table: categoria_afiliado                                    */
/*==============================================================*/
create table categoria_afiliado
(
   ID                   int not null,
   NOMBRE               varchar(20) default NULL,
   CUOTA_COT            int default NULL,
   ID_REGIMEN           int default NULL,
   COPAGO_COT           varchar(4) default NULL,
   CUOTA_BEN            int default NULL,
   COPAGO_BEN           varchar(4) default NULL,
   MAX_COPAGO           int default NULL,
   primary key (ID),
   key AK_FK_CATEGORIA_AFILIADO_REGIMEM_IDX (ID_REGIMEN)
);

/*==============================================================*/
/* Table: categoria_usuario                                     */
/*==============================================================*/
create table categoria_usuario
(
   ID                   int not null,
   NOMBRE               varchar(40) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: cita_medica_med                                       */
/*==============================================================*/
create table cita_medica_med
(
   ID                   int(11) not null auto_increment,
   FECHA_PROGRAMADA     datetime default NULL,
   HORA_INICIO          time default NULL,
   HORA_FIN             time default NULL,
   TIPO_CITA_ID         int not null,
   USUARIOS_SISTEMA_ID  int not null,
   PACIENTE_ID          int not null,
   ESTADO               varchar(10) default NULL,
   primary key (ID),
   key AK_FK_CITA_MEDICA_TIPO_CITA1_IDX (TIPO_CITA_ID),
   unique key AK_FECHA_PROGRAMADA_UNIQUE (FECHA_PROGRAMADA)
);

/*==============================================================*/
/* Table: consulta_alergeno_med                                 */
/*==============================================================*/
create table consulta_alergeno_med
(
   CON_IDX              int not null,
   IDX                  int not null,
   OBSERVACIONES        longtext,
   primary key (CON_IDX, IDX)
);

/*==============================================================*/
/* Table: consulta_medica_med                                   */
/*==============================================================*/
create table consulta_medica_med
(
   IDX                  int not null auto_increment,
   FECHA                date default NULL,
   MOTIVO               longtext default NULL,
   ENFERMEDAD_ACTUAL    longtext default NULL,
   PESO                 decimal(4,2) default NULL,
   TALLA                decimal(4,2) default NULL,
   IMC                  decimal(4,2) default NULL,
   TEMPERATURA          decimal(4,2) default NULL,
   FREC_CARDIACA        decimal(4,2) default NULL,
   FREC_RESPIRATORIA    decimal(4,2) default NULL,
   ANALISIS             longtext default NULL,
   DIAGNOSTICO_MED_IDX  int not null,
   ACOMPANIANTE_MED_IDX int,
   PACIENTE_IDX         int,
   primary key (IDX),
   key AK_FK_CONSULTA_MEDICA_MED_ACOMPANIANTE_MED1_IDX (ACOMPANIANTE_MED_IDX),
   key AK_FK_CONSULTA_MEDICA_MED_DIAGNOSTICO_MED1_IDX (DIAGNOSTICO_MED_IDX)
);

/*==============================================================*/
/* Table: consulta_sistemas_cuerpo_med                          */
/*==============================================================*/
create table consulta_sistemas_cuerpo_med
(
   IDX                  int not null auto_increment,
   ESTADO_              int default NULL,
   OBSERVACIONES        varchar(2000) default NULL,
   CONSULTA_MEDICA_MED_IDX int not null,
   SISTEMA_CUERPO_MED_IDX int not null,
   primary key (IDX),
   key AK_FK_CONSULTA_SISTEMAS_CUERPO_MED_CONSULTA_MEDICA_MED1_IDX (CONSULTA_MEDICA_MED_IDX),
   key AK_FK_CONSULTA_SISTEMAS_CUERPO_MED_SISTEMA_CUERPO_MED1_IDX (SISTEMA_CUERPO_MED_IDX)
);

/*==============================================================*/
/* Table: depto                                                 */
/*==============================================================*/
create table depto
(
   ID                   int not null,
   NOMBRE               varchar(40) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: diagnostico_odo                                       */
/*==============================================================*/
create table diagnostico_odo
(
   ID                   int(11) not null auto_increment,
   ID_ACTUALIZACION     int default NULL,
   DX                   varchar(8) default NULL,
   DX1                  varchar(8) default NULL,
   DX2                  varchar(8) default NULL,
   DX3                  varchar(8) default NULL,
   NDX                  text,
   NDX1                 text,
   NDX2                 text,
   NDX3                 text,
   TIPODIAGNOSTICO      int default NULL,
   primary key (ID),
   key AK_FK_DIAGNOSTICO_ODO_ACTUALIZCION_IDX (ID_ACTUALIZACION),
   key AK_FK_DIAGNOSTICO_ODO_TIPO_DIAGNOSTICO_IDX (TIPODIAGNOSTICO)
);

/*==============================================================*/
/* Table: diagnosticocie10_odo                                  */
/*==============================================================*/
create table diagnosticocie10_odo
(
   ID                   varchar(6) not null,
   NOMBRE               text not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: enfermedades_cie10_med                                */
/*==============================================================*/
create table enfermedades_cie10_med
(
   CODIGO               varchar(20) not null,
   DESCRIPCION          varchar(200) default NULL,
   ESTADO               bool not null,
   primary key (CODIGO)
);

/*==============================================================*/
/* Table: eps                                                   */
/*==============================================================*/
create table eps
(
   ID                   int not null auto_increment,
   NOMBRE               varchar(120) not null,
   ESTADO               bool not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: escolaridad                                           */
/*==============================================================*/
create table escolaridad
(
   ID                   int not null,
   NOMBRE               varchar(50) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: estado_civil                                          */
/*==============================================================*/
create table estado_civil
(
   ID                   int not null,
   NOMBRE               varchar(20) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: estrato                                               */
/*==============================================================*/
create table estrato
(
   ID                   int not null,
   NOMBRE               varchar(20) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: facultad                                              */
/*==============================================================*/
create table facultad
(
   ID                   int not null auto_increment,
   NOMBRE               varchar(70) default NULL,
   ESTADO               bool not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: ginecostetricos_med                                   */
/*==============================================================*/
create table ginecostetricos_med
(
   IDX                  int not null auto_increment,
   FECHA_ULTIMA_MESTRUACION date default NULL,
   G                    int default NULL,
   P                    int default NULL,
   A                    int default NULL,
   C                    int default NULL,
   M                    int default NULL,
   FECHA_ULTIMO_PARTO   date default NULL,
   METODO_PLANIFICACION varchar(2000) default NULL,
   CITOLOGIA            varchar(2000) default NULL,
   primary key (IDX)
);

/*==============================================================*/
/* Table: grupo_usuario_tipo                                    */
/*==============================================================*/
create table grupo_usuario_tipo
(
   ID_USUARIO           int not null,
   ID_TIPO              int not null,
   LOGIN                varchar(20) default NULL,
   primary key (ID_USUARIO, ID_TIPO),
   key AK_FK_GRUPO_TIPO_IDX (ID_TIPO)
);

/*==============================================================*/
/* Table: habitos_med                                           */
/*==============================================================*/
create table habitos_med
(
   ID_TIPO_HABITO       int not null,
   IDX_CONSULTA         int not null,
   DESCRIPCION          longtext,
   CONSUME_SI_NO_EX     int,
   primary key (ID_TIPO_HABITO, IDX_CONSULTA)
);

/*==============================================================*/
/* Table: historico_ginecostetricos                             */
/*==============================================================*/
create table historico_ginecostetricos
(
   IDX_CONSULTA         int not null,
   IDX_GINECOSTETRICOS  int not null,
   OBSERVACIONES        longtext,
   primary key (IDX_CONSULTA, IDX_GINECOSTETRICOS)
);

/*==============================================================*/
/* Table: listado_ant_odon                                      */
/*==============================================================*/
create table listado_ant_odon
(
   ID                   int not null,
   NOMBRE               varchar(50) default NULL,
   FAMILIAR             varchar(1) default NULL,
   PERSONAL             varchar(1) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: medicamento_consulta_med                              */
/*==============================================================*/
create table medicamento_consulta_med
(
   IDX                  int not null auto_increment,
   CANTIDAD             int default NULL,
   DOSIS                varchar(200) default NULL,
   CONSULTA_MEDICA_MED_IDX int not null,
   MEDICAMENTO_MED_IDX  varchar(20) not null,
   primary key (IDX),
   key AK_FK_MEDICAMENTO_CONSULTA_MED_CONSULTA_MEDICA_MED1_IDX (CONSULTA_MEDICA_MED_IDX),
   key AK_FK_MEDICAMENTO_CONSULTA_MED_MEDICAMENTO_MED1_IDX (MEDICAMENTO_MED_IDX)
);

/*==============================================================*/
/* Table: medicamento_med                                       */
/*==============================================================*/
create table medicamento_med
(
   CODIGO               varchar(20) not null,
   VIA_IDX              int not null,
   PRE_IDX              int not null,
   NOMBRE               varchar(300) default NULL,
   ESTADO               bool not null,
   CONCENTRACION        varchar(60) default NULL,
   primary key (CODIGO)
);

/*==============================================================*/
/* Table: municipio                                             */
/*==============================================================*/
create table municipio
(
   ID                   varchar(5) not null,
   NOMBRE               varchar(40) default NULL,
   ID_DEPTO             int default NULL,
   primary key (ID),
   key AK_FK_MUNICIPIO_DEPARTAMENTO_IDX (ID_DEPTO)
);

/*==============================================================*/
/* Table: obs_odontograma                                       */
/*==============================================================*/
create table obs_odontograma
(
   ID                   int(11) not null auto_increment,
   ID_ACTUALIZACION     int default NULL,
   OCLUSION             varchar(7) default NULL,
   CARIES               varchar(2) default NULL,
   PERDIDOS             varchar(2) default NULL,
   OBTURADOS            varchar(2) default NULL,
   OBS                  text,
   primary key (ID),
   key AK_FK_OBS_ODONTOGRAMA_ACTUALIZACION_IDX (ID_ACTUALIZACION)
);

/*==============================================================*/
/* Table: paciente                                              */
/*==============================================================*/
create table paciente
(
   ID                   int(11) not null auto_increment,
   FECHA_APERTURA       date default NULL,
   NOMBRE1              varchar(20) default NULL,
   NOMBRE2              varchar(20) default NULL,
   APELLIDO1            varchar(30) default NULL,
   APELLIDO2            varchar(30) default NULL,
   TIPO_IDENTIFICACION  varchar(2) not null,
   IDENTIFICACION       varchar(20) default NULL,
   SEXO                 char(1) default NULL,
   FECHA_NACIMIENTO     date default NULL,
   DEPTO_NACIMIENTO     int default NULL,
   MUNICIPIO_NACIMIENTO varchar(3) default NULL,
   DIRECCION            varchar(60) default NULL,
   TELEFONO             varchar(30) default NULL,
   DEPTO_RESIDENCIA     int default NULL,
   MUNICIPIO_RESIDENCIA varchar(3) default NULL,
   ZONA_RESIDENCIA      char(1) default NULL,
   EPS                  int default NULL,
   TIPO_REGIMEN         int default NULL,
   TIPO_AFILIADO        int default NULL,
   CATEGORIA_AFILIADO   int default NULL,
   ESTRATO              int default NULL,
   PERSONA_RESPONSABLE  varchar(60) default NULL,
   PARENTESCO           int default NULL,
   DIRECCION_PRESPONSABLE varchar(60) default NULL,
   TELEFONO_PRESPONSABLE varchar(30) default NULL,
   RAZA                 int default NULL,
   ESCOLARIDAD          int default NULL,
   ESTADO_CIVIL         int default NULL,
   OCUPACION            varchar(30) default NULL,
   ESTADO               varchar(1) default NULL,
   CARPETA              varchar(20) default NULL,
   FACULTAD             int default NULL,
   PROGRAMA             int default NULL,
   primary key (ID),
   key AK_FK_PACIENTE_TIPO_IDENTIFICACION_IDX (TIPO_IDENTIFICACION),
   key AK_FK_PACIENTE_DEP_NACIMIENTO_IDX (DEPTO_NACIMIENTO),
   key AK_FK_PACIENTE_MUNICIPIO_NACIMIENTO_IDX (MUNICIPIO_NACIMIENTO),
   key AK_FK_PACIENTE_DEP_RESIDENCIA_IDX (DEPTO_RESIDENCIA),
   key AK_FK_PACIENTE_MUNICIPIO_RESIDENCIA_IDX (MUNICIPIO_RESIDENCIA),
   key AK_FK_PACIENTE_EPS_IDX (EPS),
   key AK_FK_PACIENTE_TIPO_REGIMEN_IDX (TIPO_REGIMEN),
   key AK_FK_PACIENTE_TIPO_AFILIADO_IDX (TIPO_AFILIADO),
   key AK_FK_PACIENTE_CATEGORIA_AFILIADO_IDX (CATEGORIA_AFILIADO),
   key AK_FK_PACIENTE_ESTRATO_IDX (ESTRATO),
   key AK_FK_PACIENTE_PARENTESCO_IDX (PARENTESCO),
   key AK_FK_PACIENTE_RAZA_IDX (RAZA),
   key AK_FK_PACIENTE_ESCOLARIDAD_IDX (ESCOLARIDAD),
   key AK_FK_PACIENTE_ESTADO_CIVIL_IDX (ESTADO_CIVIL),
   key AK_FK_PACIENTE_FACULTAD_IDX (FACULTAD),
   key AK_FK_PACIENTE_PROGRAMA_IDX (PROGRAMA)
);

/*==============================================================*/
/* Table: parentesco                                            */
/*==============================================================*/
create table parentesco
(
   ID                   int not null,
   NOMBRE               varchar(40) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: patologico_consulta_med                               */
/*==============================================================*/
create table patologico_consulta_med
(
   IDX                  int not null auto_increment,
   ESTADO_SI_NO         int default NULL,
   DESCRIPCION          varchar(1000) default NULL,
   CONSULTA_MEDICA_MED_IDX int not null,
   PATOLOGICOS_MED_IDX  int not null,
   primary key (IDX),
   key AK_FK_PATOLOGICO_CONSULTA_MED_CONSULTA_MEDICA_MED1_IDX (CONSULTA_MEDICA_MED_IDX),
   key AK_FK_PATOLOGICO_CONSULTA_MED_PATOLOGICOS_MED1_IDX (PATOLOGICOS_MED_IDX)
);

/*==============================================================*/
/* Table: patologicos_med                                       */
/*==============================================================*/
create table patologicos_med
(
   IDX                  int not null auto_increment,
   NOMBRE               varchar(100) default NULL,
   primary key (IDX),
   unique key AK_NOMBRE_UNIQUE (NOMBRE)
);

/*==============================================================*/
/* Table: presentacion_medicamento_med                          */
/*==============================================================*/
create table presentacion_medicamento_med
(
   IDX                  int not null auto_increment,
   NOMBRE_PRESEN        varchar(45) default NULL,
   primary key (IDX),
   unique key AK_NOMBRE_UNIQUE (NOMBRE_PRESEN)
);

/*==============================================================*/
/* Table: procedimientos_cups_med                               */
/*==============================================================*/
create table procedimientos_cups_med
(
   CODIGO               varchar(20) not null,
   DESCRIPCION          varchar(1000) default NULL,
   ESTADO               bool not null,
   primary key (CODIGO)
);

/*==============================================================*/
/* Table: programas                                             */
/*==============================================================*/
create table programas
(
   ID                   int not null auto_increment,
   NOMBRE               varchar(100) default NULL,
   FACULTAD             int default NULL,
   ESTADO               bool not null,
   primary key (ID),
   key AK_FK_PROGRAMAS_FACULTAD_IDX (FACULTAD)
);

/*==============================================================*/
/* Table: quirurgico_med                                        */
/*==============================================================*/
create table quirurgico_med
(
   IDX                  int not null auto_increment,
   CONSULTA_MEDICA_MED_IDX int not null,
   PROCEDIMIENTOS_CUPS_MED_CODIGO varchar(20) not null,
   OBSERVACIONES        longtext,
   primary key (IDX),
   key AK_FK_QUIRURGICO_MED_CONSULTA_MEDICA_MED1_IDX (CONSULTA_MEDICA_MED_IDX),
   key AK_FK_QUIRURGICO_MED_PROCEDIMIENTOS_CUPS_MED1_IDX (PROCEDIMIENTOS_CUPS_MED_CODIGO)
);

/*==============================================================*/
/* Table: raza                                                  */
/*==============================================================*/
create table raza
(
   ID                   int not null,
   NOMBRE               varchar(20) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: sistema_cuerpo_med                                    */
/*==============================================================*/
create table sistema_cuerpo_med
(
   IDX                  int not null auto_increment,
   NOMBRE               varchar(45) default NULL,
   primary key (IDX),
   unique key AK_NOMBRE_UNIQUE (NOMBRE)
);

/*==============================================================*/
/* Table: tipo_afiliado                                         */
/*==============================================================*/
create table tipo_afiliado
(
   ID                   int not null,
   NOMBRE               varchar(20) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: tipo_alergeno_med                                     */
/*==============================================================*/
create table tipo_alergeno_med
(
   IDX                  int not null auto_increment,
   NOMBRE               varchar(100) default NULL,
   primary key (IDX),
   unique key AK_NOMBRE_UNIQUE (NOMBRE)
);

/*==============================================================*/
/* Table: tipo_cita_med                                         */
/*==============================================================*/
create table tipo_cita_med
(
   ID                   int(11) not null auto_increment,
   NOMBRE               varchar(20) not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: tipo_identificacion                                   */
/*==============================================================*/
create table tipo_identificacion
(
   ID                   varchar(2) not null,
   NOMBRE               varchar(40) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: tipo_regimen                                          */
/*==============================================================*/
create table tipo_regimen
(
   ID                   int not null,
   NOMBRE               varchar(20) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: tipo_usuario                                          */
/*==============================================================*/
create table tipo_usuario
(
   ID                   int not null,
   NOMBRE               varchar(40) default NULL,
   ID_CATEGORIA_USUARIO int not null,
   primary key (ID),
   key AK_FK_TIPO_USUARIO_CATEGORIA_USUARIO_IDX (ID_CATEGORIA_USUARIO)
);

/*==============================================================*/
/* Table: tipodiagnostico                                       */
/*==============================================================*/
create table tipodiagnostico
(
   ID                   int not null,
   NOMBRE               varchar(25) not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   ID_USER              int(11) not null auto_increment,
   USERNAME             varchar(16) not null,
   EMAIL                varchar(255) not null,
   PASSWORD             varchar(32) not null,
   CREATE_TIME          datetime default CURRENT_TIMESTAMP,
   primary key (ID_USER),
   unique key AK_EMAIL_UNIQUE (EMAIL)
);

/*==============================================================*/
/* Table: usuarios_sistema                                      */
/*==============================================================*/
create table usuarios_sistema
(
   ID                   int(11) not null auto_increment,
   IDENTIFICACION       varchar(20) not null,
   NOMBRES              varchar(60) not null,
   APELLIDOS            varchar(60) not null,
   LOGIN                varchar(20) not null,
   CONTRASENA           varchar(250) not null,
   REGISTRO             varchar(30) default NULL,
   ACTIVO               int default NULL,
   CARGO                varchar(50) default NULL,
   CELULAR              varchar(10) default NULL,
   TELEFONO             varchar(8) default NULL,
   EXTENSION            varchar(5) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: via_administracion_med                                */
/*==============================================================*/
create table via_administracion_med
(
   IDX                  int not null auto_increment,
   NOMBRE_ADMINIS       varchar(45) default NULL,
   primary key (IDX),
   unique key AK_NOMBRE_UNIQUE (NOMBRE_ADMINIS)
);

alter table Diagnosticos add constraint FK_Relationship_52 foreign key (IDX_CONSULTA)
      references consulta_medica_med (IDX) on delete restrict on update restrict;

alter table Diagnosticos add constraint FK_Relationship_55 foreign key (CODIGO_CIE10)
      references enfermedades_cie10_med (CODIGO) on delete restrict on update restrict;

alter table acompaniante_med add constraint FK_Relationship_56 foreign key (ID)
      references parentesco (ID) on delete restrict on update restrict;

alter table actualizacion_odo add constraint FK_fk_actualizacion_odo_paciente foreign key (ID_PACIENTE)
      references paciente (ID) on delete restrict on update restrict;

alter table actualizacion_odo add constraint FK_fk_actualizacion_odo_usuariosistema foreign key (ID_USUARIO)
      references usuarios_sistema (ID) on delete restrict on update restrict;

alter table alergeno_med add constraint FK_Relationship_61 foreign key (IDX_TIPO_ALERGENO)
      references tipo_alergeno_med (IDX) on delete restrict on update restrict;

alter table ant_familiar_consulta_med add constraint FK_fk_ant_familiar_consulta_med_ant_familiares_med1 foreign key (ANT_FAMILIARES_MED_IDX)
      references ant_familiares_med (IDX) on delete restrict on update restrict;

alter table ant_familiar_consulta_med add constraint FK_fk_ant_familiar_consulta_med_consulta_medica_med1 foreign key (CONSULTA_MEDICA_MED_IDX)
      references consulta_medica_med (IDX) on delete restrict on update restrict;

alter table ant_odo add constraint FK_fk_antecedente_odo_actualizacion_odo foreign key (ID_ACTUALIZACION)
      references actualizacion_odo (ID) on delete restrict on update restrict;

alter table ant_odo add constraint FK_fk_antecedente_odo_antecedente foreign key (ID_ANT)
      references listado_ant_odon (ID) on delete restrict on update restrict;

alter table categoria_afiliado add constraint FK_fk_categoria_afiliado_regimem foreign key (ID_REGIMEN)
      references tipo_regimen (ID) on delete restrict on update restrict;

alter table cita_medica_med add constraint FK_Relationship_58 foreign key (USUARIOS_SISTEMA_ID)
      references usuarios_sistema (ID) on delete restrict on update restrict;

alter table cita_medica_med add constraint FK_Relationship_64 foreign key (PACIENTE_ID)
      references paciente (ID) on delete restrict on update restrict;

alter table cita_medica_med add constraint FK_fk_cita_medica_tipo_cita1 foreign key (TIPO_CITA_ID)
      references tipo_cita_med (ID) on delete restrict on update restrict;

alter table consulta_alergeno_med add constraint FK_Relationship_53 foreign key (IDX)
      references alergeno_med (IDX) on delete restrict on update restrict;

alter table consulta_alergeno_med add constraint FK_Relationship_54 foreign key (CON_IDX)
      references consulta_medica_med (IDX) on delete restrict on update restrict;

alter table consulta_medica_med add constraint FK_Relationship_57 foreign key (PACIENTE_IDX)
      references paciente (ID) on delete restrict on update restrict;

alter table consulta_medica_med add constraint FK_fk_consulta_medica_med_acompaniante_med1 foreign key (ACOMPANIANTE_MED_IDX)
      references acompaniante_med (IDX) on delete restrict on update restrict;

alter table consulta_sistemas_cuerpo_med add constraint FK_fk_consulta_sistemas_cuerpo_med_consulta_medica_med1 foreign key (CONSULTA_MEDICA_MED_IDX)
      references consulta_medica_med (IDX) on delete restrict on update restrict;

alter table consulta_sistemas_cuerpo_med add constraint FK_fk_consulta_sistemas_cuerpo_med_sistema_cuerpo_med1 foreign key (SISTEMA_CUERPO_MED_IDX)
      references sistema_cuerpo_med (IDX) on delete restrict on update restrict;

alter table diagnostico_odo add constraint FK_fk_diagnostico_odo_actualizcion foreign key (ID_ACTUALIZACION)
      references actualizacion_odo (ID) on delete restrict on update restrict;

alter table diagnostico_odo add constraint FK_fk_diagnostico_odo_tipo_diagnostico foreign key (TIPODIAGNOSTICO)
      references tipodiagnostico (ID) on delete restrict on update restrict;

alter table grupo_usuario_tipo add constraint FK_fk_grupo_tipo foreign key (ID_TIPO)
      references tipo_usuario (ID) on delete restrict on update restrict;

alter table grupo_usuario_tipo add constraint FK_fk_grupo_usuario foreign key (ID_USUARIO)
      references usuarios_sistema (ID) on delete restrict on update restrict;

alter table habitos_med add constraint FK_Relationship_62 foreign key (IDX_CONSULTA)
      references consulta_medica_med (IDX) on delete restrict on update restrict;

alter table habitos_med add constraint FK_Relationship_63 foreign key (ID_TIPO_HABITO)
      references Tipo_habito (ID) on delete restrict on update restrict;

alter table historico_ginecostetricos add constraint FK_Relationship_65 foreign key (IDX_GINECOSTETRICOS)
      references ginecostetricos_med (IDX) on delete restrict on update restrict;

alter table historico_ginecostetricos add constraint FK_Relationship_66 foreign key (IDX_CONSULTA)
      references consulta_medica_med (IDX) on delete restrict on update restrict;

alter table medicamento_consulta_med add constraint FK_fk_medicamento_consulta_med_consulta_medica_med1 foreign key (CONSULTA_MEDICA_MED_IDX)
      references consulta_medica_med (IDX) on delete restrict on update restrict;

alter table medicamento_consulta_med add constraint FK_fk_medicamento_consulta_med_medicamento_med1 foreign key (MEDICAMENTO_MED_IDX)
      references medicamento_med (CODIGO) on delete restrict on update restrict;

alter table medicamento_med add constraint FK_Relationship_59 foreign key (VIA_IDX)
      references via_administracion_med (IDX) on delete restrict on update restrict;

alter table medicamento_med add constraint FK_Relationship_60 foreign key (PRE_IDX)
      references presentacion_medicamento_med (IDX) on delete restrict on update restrict;

alter table municipio add constraint FK_fk_municipio_departamento foreign key (ID_DEPTO)
      references depto (ID) on delete restrict on update restrict;

alter table obs_odontograma add constraint FK_fk_obs_odontograma_actualizacion foreign key (ID_ACTUALIZACION)
      references actualizacion_odo (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_categoria_afiliado foreign key (CATEGORIA_AFILIADO)
      references categoria_afiliado (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_dep_nacimiento foreign key (DEPTO_NACIMIENTO)
      references depto (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_dep_residencia foreign key (DEPTO_RESIDENCIA)
      references depto (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_eps foreign key (EPS)
      references eps (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_escolaridad foreign key (ESCOLARIDAD)
      references escolaridad (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_estado_civil foreign key (ESTADO_CIVIL)
      references estado_civil (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_estrato foreign key (ESTRATO)
      references estrato (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_facultad foreign key (FACULTAD)
      references facultad (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_municipio_nacimiento foreign key (MUNICIPIO_NACIMIENTO)
      references municipio (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_municipio_residencia foreign key (MUNICIPIO_RESIDENCIA)
      references municipio (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_parentesco foreign key (PARENTESCO)
      references parentesco (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_programa foreign key (PROGRAMA)
      references programas (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_raza foreign key (RAZA)
      references raza (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_tipo_afiliado foreign key (TIPO_AFILIADO)
      references tipo_afiliado (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_tipo_identificacion foreign key (TIPO_IDENTIFICACION)
      references tipo_identificacion (ID) on delete restrict on update restrict;

alter table paciente add constraint FK_fk_paciente_tipo_regimen foreign key (TIPO_REGIMEN)
      references tipo_regimen (ID) on delete restrict on update restrict;

alter table patologico_consulta_med add constraint FK_fk_patologico_consulta_med_consulta_medica_med1 foreign key (CONSULTA_MEDICA_MED_IDX)
      references consulta_medica_med (IDX) on delete restrict on update restrict;

alter table patologico_consulta_med add constraint FK_fk_patologico_consulta_med_patologicos_med1 foreign key (PATOLOGICOS_MED_IDX)
      references patologicos_med (IDX) on delete restrict on update restrict;

alter table programas add constraint FK_fk_programas_facultad foreign key (FACULTAD)
      references facultad (ID) on delete restrict on update restrict;

alter table quirurgico_med add constraint FK_fk_quirurgico_med_consulta_medica_med1 foreign key (CONSULTA_MEDICA_MED_IDX)
      references consulta_medica_med (IDX) on delete restrict on update restrict;

alter table quirurgico_med add constraint FK_fk_quirurgico_med_procedimientos_cups_med1 foreign key (PROCEDIMIENTOS_CUPS_MED_CODIGO)
      references procedimientos_cups_med (CODIGO) on delete restrict on update restrict;

alter table tipo_usuario add constraint FK_fk_tipo_usuario_categoria_usuario foreign key (ID_CATEGORIA_USUARIO)
      references categoria_usuario (ID) on delete restrict on update restrict;

