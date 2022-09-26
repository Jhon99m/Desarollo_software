#Drop database consultorio;
create database consultorio;
use consultorio;


create table tbl_rol(
rol_id int (11) not null,
rol_nombre enum("Doctor", "Asesor", "Administrador"),
primary key (rol_id)
);

create table tbl_consultorio(
con_id int (11) auto_increment not null,
con_nombre varchar (100) not null,
con_direccion varchar (250) not null,
con_telefono BIGINT(20) not null,
con_estado  enum ("Activo", "Inactivo"),
primary key (con_id)
);

create table tbl_usuario(
usu_id bigint (20) not null auto_increment,
usu_cedula bigint (20) not null, 
usu_nombre varchar (50) not null,
usu_apellido varchar (50) not null,
usu_telefono bigint (20) not null, 
usu_correo varchar (100) not null,
usu_usuario varchar (50) not null,
usu_password varchar (25) not null,
usu_estado enum("Activo", "Inactivo") not null,
usu_consultorio int (11) not null,
usu_rol int (11) not null,
primary key (usu_id),
foreign key (usu_consultorio) references tbl_consultorio(con_id),
foreign key (usu_rol) references tbl_rol(rol_id)
);


create table tbl_eps(
eps_id int (11) not null auto_increment,
eps_nombre varchar (100) not null,
primary key (eps_id) 
);

create table  tbl_paciente(
cte_id bigint (20) not null auto_increment,
cte_cedula bigint (20) not null ,
cte_nombre varchar (50) not null,
cte_apellido varchar (50) not null,
cte_direccion varchar (100) not null,
cte_correo varchar (100) not null,
cte_eps int(11) not null,
cte_estado enum ("Activo", "Inactivo"),
cte_usuario bigint (20) not null, 
primary key (cte_id),
foreign key (cte_usuario) references tbl_usuario(usu_id),
foreign key (cte_eps) references tbl_eps(eps_id)
);


create table tbl_medicamento(
med_id BIGINT(20) not null auto_increment,
med_codigo varchar (20) not null,
med_nombre varchar (20) not null,
med_precio float not null,
med_cantidad bigint (20) not null,
med_marca varchar (100) not null,
med_estado enum ("Activo", "Inactivo") not null,
med_usuario bigint (20) not null,
primary key (med_id),
foreign key (med_usuario) references tbl_usuario(usu_id)
);

create table tbl_citas(
cit_id BIGINT(20) not null auto_increment,
cit_fecha date not null,
cit_hora_inicio time not null,
cit_hora_fin time not null,
cit_doctor bigint (20) not null,
cit_paciente bigint (20) not null,
cit_consultorio int (11) not null,
cit_estado enum ("Activo", "Cancelado", "Realizado") not null,
cit_medicamento BIGINT(20) not null,
cit_observacion text null,
primary key (cit_id),
foreign key (cit_doctor) references tbl_usuario(usu_id),
foreign key (cit_paciente) references tbl_paciente(cte_id),
foreign key (cit_consultorio) references tbl_consultorio(con_id),
foreign key (cit_medicamento) references tbl_medicamento(med_id)

);

insert into tbl_rol (rol_id, rol_nombre)  values (1,"Administrador"),(2,"Doctor"),(3,"Asesor");

insert into tbl_consultorio (con_id, con_nombre, con_direccion, con_telefono, con_estado) values
(1,"CONSULTORIO NORTE","CALLE 4324",123456789,"Activo"), (2,"CONSULTORIO SUR","CRA 23545",987654321,"Inactivo"),
(3,"CONSULTORIO LAS PALMAS","CALLE 235",123987456,"Activo");

insert into tbl_usuario (usu_id,usu_cedula,usu_nombre,usu_apellido,usu_telefono,usu_correo,usu_usuario,usu_password,usu_estado,usu_consultorio,usu_rol) values 
(1001,100433221,"MARIA","HERNANDEZ",3112002176,"MARIAHERNANDEZ@GMAIL.COM","MARIA 3112002176","3112002176$$","Inactivo",2,1),
(1002,132434556,"FELIPE","GARCIA",87445552,"FELIPEGARCIA@GMAIL.COM","FELIPE87445552","87445552$$","Inactivo",2,2),
(1003,100433221,"XIMENA","VALENCIA",320214758,"XIMENAVALENCIA@GMAIL.COM","XIMENA320214758","320214758$$","Inactivo",2,3),
(1004,188434556,"JUAN","DIAZ",3201478965,"JUANDIAZ@GMAIL.COM","JUAN 3201478965","3201478965$$","Activo",1,2),
(1005,32654645,"ALEIDA","OVALLE",2654174789,"ALEIDAOVALLE@GMAIL.COM","ALEIDA2654174789","2654174789$$","Activo",1,1),
(1006,3526566787,"SANTIAGO","LOPEZ",3258745655,"SANTIAGOLOPEZ@GMAIL.COM","SANTIAGO3258745655","3258745655$$","Activo",3,3);

insert into tbl_eps (eps_id, eps_nombre)  values (1,"COMPENSAR"),(2,"CAJACOPI"),(3,"COMPENSAR"),(4,"CAJACOPI"),(5,"CAPITAL SALUD."),(6,"E.P.S. FAMISANAR LTDA");

insert into tbl_paciente(cte_id,cte_cedula,cte_nombre,cte_apellido,cte_direccion,cte_correo,cte_eps,cte_estado,cte_usuario) values 
(1,1005912740,"DANIEL RICARDO","DIAZ OVALLE","CALLE 123","DDIAZ@SURTILIDER.COM",1,"Activo",1001),
(2,1005918451,"CRISTIAN FELIPE","RUEDA HERNANDEZ","CARR 123","CRISTIANFELIPERUEDAHERNANDEZ@gmail.com",2,"Activo",1002),
(3,1004414512,"CAMILO","PORTACIO","CRA 332 ","CAMILOPORTACIO@gmail.com",3,"Activo",1003),
(4,1054112740,"HERNAN","LOPEZ","CALLE 185","HERNANLOPEZ@gmail.com",4,"Activo",1004),
(5,4141611555,"JAUIDER","FLOREZ","CALLE 200","JAUIDERFLOREZ@gmail.com",2,"Activo",1005),
(6,1847116155,"STIVER","BARRERO","CALLE 8","JSTIVERBARRERO@gmail.com",2,"Activo",1006);

insert into tbl_medicamento(med_id,med_codigo,med_nombre,med_precio,med_cantidad,med_marca,med_estado,med_usuario) values 
(1,1001001,"ACETAMINOFEN",25000,2533,"BAYER",1,1001), (2,1001002,"IBUPROFENO",35000,4564,"ROCHE",1,1002), 
(3,1001003,"VITAMINA C",15000,100,"ABBOTT",1,1003), (4,1001004,"ASPIRINA",18500,65100,"PFIZER",1,1004),
(5,1001005,"DOLEX",98500,951,"BAYER",1,1005), (6,1001006,"AMPICILINA",32500,651441,"PFIZER",1,1006); 

insert into tbl_citas (cit_id,cit_fecha,cit_hora_inicio,cit_hora_fin,cit_doctor,cit_paciente,cit_consultorio,cit_estado,cit_medicamento,cit_observacion) values
(1,"2022-01-01","8:30:00","9:30",1001,1,1,"Activo",1,""), (2,"2022-01-02","9:30:00","10:30",1005,1,3,"Realizado",3,"GUARDAR REPOSO"),
(3,"2022-01-03","10:30:00","11:30",1001,3,1,"Realizado",4,"MEDICAMENTOS 3 VECES AL DIA"),
(4,"2022-01-04","11:30:00","12:30",1005,1,3,"Activo",5,""), (5,"2022-01-05","12:30:00","13:30",1001,5,1,"Cancelado",2,""),
(6,"2022-01-06","13:30:00","14:30",1005,6,3,"Realizado",3,"CON CUIDADOS ESPECIALES");
