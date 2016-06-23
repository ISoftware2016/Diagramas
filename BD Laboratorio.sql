IF db_id('sw2') IS NOT NULL
	BEGIN
		USE master
		DROP DATABASE sw2
	END
GO	
USE MASTER
CREATE DATABASE sw2
GO
USE sw2
----------------------------------------------------------------------------------
--------------------------------T A B L A S---------------------------------------
----------------------------------------------------------------------------------
CREATE TABLE Empresa
(
	id int identity(1,1) primary key, 
	Nombre VARCHAR(300) NOT NULL,	
	Correo VARCHAR(300) NOT NULL,	
	Pass VARCHAR(300) NOT NULL	
);
----------------------------------------------------------------------------------
CREATE TABLE Persona
(
	idEmpresa INT NOT NULL,
	Ci INT NOT NULL PRIMARY KEY,
	Pass VARCHAR(300) NOT NULL,	
	Nombre varchar(100) NOT NULL,
	Telefono VARCHAR(15),
	Correo VARCHAR(50),
	Sexo CHAR(1) NOT NULL,
	FNacimiento VARCHAR(100) NULL,
	Direccion VARCHAR(100) NOT NULL,
	Estado bit NOT NULL,
	foreign key (idEmpresa) references Empresa(id)
);
----------------------------------------------------------------------------------
CREATE TABLE AnalisisLab (
	idEmpresa INT NOT NULL,
    idAnalisis int  NOT NULL primary key,
    CampoAnalitico varchar(100) NOT NULL,
    Metodo varchar(100) NOT NULL,
    Muestra_Extraccion varchar(100) NOT NULL,
    Nombre varchar(50) NOT NULL,
    observacionFija varchar(255) null,
    observacionDinamica varchar (255) null,
    Estado int NOT NULL,
	foreign key (idEmpresa) references Empresa(id)
);
----------------------------------------------------------------------------------
CREATE TABLE Medico
(
	idEmpresa INT NOT NULL,
	Id_Medico int NOT NULL PRIMARY KEY,
	Nombre varchar(100) NOT NULL,
	Ap_P varchar(100),
	AP_M varchar(100),
	Especialidad varchar(255),
	Email VARCHAR(50),
	Celular VARCHAR(255),
	Fijo VARCHAR(255),
	porcentajeComision int,
	Estado char NOT NULL,
	Log_In VARCHAR(255) NOT NULL,
	foreign key (idEmpresa) references Empresa(id)
);
----------------------------------------------------------------------------------
CREATE TABLE Solicitud_Analisis (
	idEmpresa INT NOT NULL,
    idSolicitudAnalisis INT identity(1,1) PRIMARY KEY,
    idBioquimico INT NOT NULL,
    idMedico INT NOT NULL,
    idPaciente INT NOT NULL,
    idSeguro INT NOT NULL,
    Fecha varchar(50) NULL,
    DatosClinicos varchar(255) NULL,
    Estado bit  NULL,
    Completo INT  NULL,
    idEmpleado INT  NULL, 	
	FOREIGN KEY (idBioquimico) REFERENCES Persona(Ci),		
	FOREIGN KEY (idMedico) REFERENCES Medico(Id_Medico),	
	FOREIGN KEY (idPaciente) REFERENCES Persona(Ci),
	foreign key (idEmpresa) references Empresa(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
----------------------------------------------------------------------------------
CREATE TABLE DetalleAnalisis (
	idEmpresa INT NOT NULL,
	Id_Detalle INT identity(1,1) PRIMARY KEY,
    idSolicitudAnalisis int NOT NULL, 
    idAnalisis int NOT NULL,		
    Costo float  NULL,	
	FOREIGN KEY (idAnalisis) REFERENCES AnalisisLab(idAnalisis),
	FOREIGN KEY (idSolicitudAnalisis) REFERENCES Solicitud_Analisis(idSolicitudAnalisis),
	foreign key (idEmpresa) references Empresa(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE		
);
----------------------------------------------------------------------------------
CREATE TABLE subGrupo(
	idSubGrupo int identity(1,1) not null primary key,
	idEmpresa INT NOT NULL,
	nombre varchar(50) not null,
	analisis int not null,
	foreign key (idEmpresa) references Empresa(id)
);
----------------------------------------------------------------------------------
CREATE TABLE componente(
	idComponente int identity(1,1) not null primary key,
	idEmpresa INT NOT NULL,
	nombre varchar(50) not null,
	unidad varchar(30) not null,
	valorReferencial varchar(200) not null,
	foreign key (idEmpresa) references Empresa(id)
);
----------------------------------------------------------------------------------
CREATE TABLE componente_subGrupo(
	idEmpresa INT NOT NULL,
	idSubGrupo int not null,
	idComponente int not null,
	primary key(idSubGrupo,idComponente),
	foreign key(idSubGrupo) references subGrupo(idSubGrupo),
	foreign key(idComponente) references componente(idComponente),
	foreign key (idEmpresa) references Empresa(id)
);
----------------------------------------------------------------------------------
CREATE TABLE componente_analisislab(
	idEmpresa INT NOT NULL,
	idAnalisisLab int not null,
	idComponente int not null,
	primary key(idAnalisisLab,idComponente),
	foreign key (idAnalisisLab) references AnalisisLab(idAnalisis),
	foreign key (idComponente) references componente(idComponente),
	foreign key (idEmpresa) references Empresa(id)
);
