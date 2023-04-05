-- --------------------------------------------------------
-- Host:                         us-cdbr-iron-east-01.cleardb.net
-- Server version:               5.6.50-log - MySQL Community Server (GPL)
-- Server OS:                    Linux
-- HeidiSQL Version:             11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for heroku_5f1d7d573c9b3be
CREATE DATABASE IF NOT EXISTS `heroku_5f1d7d573c9b3be` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `heroku_5f1d7d573c9b3be`;

-- Dumping structure for table heroku_5f1d7d573c9b3be.conceptos
CREATE TABLE IF NOT EXISTS `conceptos` (
  `idConcepto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `idPerfilProrrateo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idConcepto`),
  KEY `FK_conceptoperfilprorrateo` (`idPerfilProrrateo`),
  CONSTRAINT `FK_conceptoperfilprorrateo` FOREIGN KEY (`idPerfilProrrateo`) REFERENCES `perfilesprorrateos` (`idPerfilProrrateo`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.conceptos: ~26 rows (approximately)
/*!40000 ALTER TABLE `conceptos` DISABLE KEYS */;
INSERT INTO `conceptos` (`idConcepto`, `nombre`, `idPerfilProrrateo`) VALUES
	(1, 'TRANSPORTE VENTAS Y COBRANZAS', 1),
	(2, 'REPARTO A FARMACIAS', 1),
	(3, 'PAGO SERVICIOS', 1),
	(4, 'ENVIO MERCADERIA', 1),
	(5, 'RECEPCION MERCADERIA', 1),
	(6, 'IMPRESIÓN', 1),
	(7, 'SUELDOS', 1),
	(8, 'AFP', 1),
	(9, 'IMPUESTOS', 1),
	(10, 'CNS', 1),
	(11, 'PROVEEDORES', 1),
	(12, 'AGUINALDOS', 1),
	(13, 'COMPRA EQUIPOS', 1),
	(14, 'FOTOCOPIAS', 1),
	(15, 'MATERIAL DE ESCRITORIO', 1),
	(16, 'REFRIGERIO/ COMEDOR', 1),
	(17, 'LIMPIEZA', 1),
	(18, 'GASTOS DE VIAJE', 1),
	(19, 'BALANCE', 1),
	(20, 'AUDITORIA EXTERNA', 1),
	(21, 'INSCRIPCION ANUAL EMPRESA', 1),
	(22, 'BENEFICIOS SOCIALES', 1),
	(23, 'Pago a Ministerio de Trabajo x planillas y/o aguinaldos', 1),
	(24, 'Pago alquiler vitrina en Oruro', 1),
	(25, 'Pago por despacho de productos a farmacias de Oruro', 1),
	(26, 'Anticipo de sueldo', 1);
/*!40000 ALTER TABLE `conceptos` ENABLE KEYS */;

-- Dumping structure for table heroku_5f1d7d573c9b3be.concepto_opcion
CREATE TABLE IF NOT EXISTS `concepto_opcion` (
  `idConcepto` int(11) NOT NULL,
  `idOpcion` int(11) NOT NULL,
  `idPerfilProrrateo` int(11) NOT NULL,
  `idGrupo` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idConcepto`,`idOpcion`,`idPerfilProrrateo`,`idGrupo`),
  KEY `FK_conop_opcion` (`idOpcion`),
  KEY `FK_conop_perfilprorrateo` (`idPerfilProrrateo`),
  KEY `FK_conop_grupo` (`idGrupo`),
  CONSTRAINT `FK_conop_concepto` FOREIGN KEY (`idConcepto`) REFERENCES `conceptos` (`idConcepto`),
  CONSTRAINT `FK_conop_grupo` FOREIGN KEY (`idGrupo`) REFERENCES `grupos` (`idGrupo`),
  CONSTRAINT `FK_conop_opcion` FOREIGN KEY (`idOpcion`) REFERENCES `opciones` (`idOpcion`),
  CONSTRAINT `FK_conop_perfilprorrateo` FOREIGN KEY (`idPerfilProrrateo`) REFERENCES `perfilesprorrateos` (`idPerfilProrrateo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.concepto_opcion: ~71 rows (approximately)
/*!40000 ALTER TABLE `concepto_opcion` DISABLE KEYS */;
INSERT INTO `concepto_opcion` (`idConcepto`, `idOpcion`, `idPerfilProrrateo`, `idGrupo`) VALUES
	(3, 1, 1, 0),
	(3, 2, 1, 0),
	(3, 3, 1, 0),
	(3, 4, 1, 0),
	(13, 4, 1, 0),
	(3, 5, 1, 0),
	(1, 6, 2, 0),
	(7, 6, 2, 0),
	(8, 6, 2, 1),
	(10, 6, 2, 0),
	(12, 6, 2, 0),
	(22, 6, 2, 3),
	(22, 6, 2, 4),
	(26, 6, 1, 0),
	(1, 7, 2, 0),
	(7, 7, 1, 0),
	(8, 7, 1, 2),
	(10, 7, 1, 0),
	(12, 7, 1, 0),
	(22, 7, 1, 3),
	(22, 7, 1, 4),
	(26, 7, 1, 0),
	(1, 8, 2, 0),
	(7, 8, 1, 0),
	(8, 8, 1, 2),
	(10, 8, 1, 0),
	(12, 8, 1, 0),
	(22, 8, 1, 3),
	(22, 8, 1, 4),
	(26, 8, 1, 0),
	(1, 9, 4, 0),
	(4, 9, 4, 0),
	(5, 9, 4, 0),
	(6, 9, 4, 0),
	(11, 9, 4, 0),
	(18, 9, 4, 0),
	(7, 10, 1, 0),
	(26, 10, 1, 0),
	(7, 11, 1, 0),
	(8, 11, 1, 1),
	(10, 11, 1, 0),
	(12, 11, 1, 0),
	(22, 11, 1, 3),
	(22, 11, 1, 4),
	(26, 11, 1, 0),
	(6, 12, 1, 0),
	(6, 13, 1, 0),
	(6, 14, 1, 0),
	(6, 15, 1, 0),
	(6, 16, 1, 0),
	(7, 16, 1, 0),
	(12, 16, 1, 0),
	(6, 17, 1, 0),
	(13, 17, 1, 0),
	(9, 18, 1, 0),
	(9, 19, 1, 0),
	(9, 20, 1, 0),
	(13, 21, 1, 0),
	(13, 22, 1, 0),
	(4, 23, 3, 0),
	(5, 23, 3, 0),
	(11, 23, 3, 0),
	(4, 24, 5, 0),
	(5, 24, 5, 0),
	(11, 24, 5, 0),
	(7, 25, 1, 0),
	(12, 25, 1, 0),
	(26, 25, 1, 0),
	(18, 26, 2, 0),
	(3, 28, 1, 0),
	(26, 29, 1, 0);
/*!40000 ALTER TABLE `concepto_opcion` ENABLE KEYS */;

-- Dumping structure for table heroku_5f1d7d573c9b3be.gastos
CREATE TABLE IF NOT EXISTS `gastos` (
  `idGasto` int(11) NOT NULL AUTO_INCREMENT,
  `idConcepto` int(11) NOT NULL,
  `idGrupo` int(11) DEFAULT NULL,
  `idOpcion` int(11) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL,
  `glosa` text,
  `factura` varchar(250) DEFAULT NULL,
  `montoTotal` decimal(10,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`idGasto`),
  KEY `FK_gasto_concepto` (`idConcepto`),
  KEY `FK_gasto_usuario` (`idUsuario`),
  KEY `FK_gasto_grupo` (`idGrupo`),
  KEY `FK_gasto_opcion` (`idOpcion`),
  CONSTRAINT `FK_gasto_concepto` FOREIGN KEY (`idConcepto`) REFERENCES `conceptos` (`idConcepto`),
  CONSTRAINT `FK_gasto_grupo` FOREIGN KEY (`idGrupo`) REFERENCES `grupos` (`idGrupo`),
  CONSTRAINT `FK_gasto_opcion` FOREIGN KEY (`idOpcion`) REFERENCES `opciones` (`idOpcion`),
  CONSTRAINT `FK_gasto_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.gastos: ~6 rows (approximately)
/*!40000 ALTER TABLE `gastos` DISABLE KEYS */;
INSERT INTO `gastos` (`idGasto`, `idConcepto`, `idGrupo`, `idOpcion`, `idUsuario`, `glosa`, `factura`, `montoTotal`, `fecha`) VALUES
	(2, 13, NULL, 4, 2, '', '', 33.00, '2023-04-05 14:33:22'),
	(3, 13, NULL, 17, 2, '', '', 33.00, '2023-04-05 14:33:22'),
	(4, 13, NULL, 21, 2, '', '', 33.00, '2023-04-05 14:33:22'),
	(5, 26, NULL, 29, 2, '', '2333', 223.00, '2023-04-05 14:33:22'),
	(6, 6, NULL, 12, 2, 'ninguna', '324234', 300.90, '2023-04-05 14:33:22'),
	(7, 1, NULL, 9, 2, 'Gastos en medicamentos', '14528779', 3000.00, '2023-04-05 14:33:22');
/*!40000 ALTER TABLE `gastos` ENABLE KEYS */;

-- Dumping structure for table heroku_5f1d7d573c9b3be.gasto_prorrateo
CREATE TABLE IF NOT EXISTS `gasto_prorrateo` (
  `idGastoProrrateo` int(11) NOT NULL AUTO_INCREMENT,
  `idGasto` int(11) DEFAULT NULL,
  `idProrrateo` int(11) DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idGastoProrrateo`),
  KEY `FK_GastoP_Prorrateo_idx` (`idProrrateo`),
  KEY `FK_GastoP_Gasto_idx` (`idGasto`),
  CONSTRAINT `FK_GastoP_Gasto` FOREIGN KEY (`idGasto`) REFERENCES `gastos` (`idGasto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_GastoP_Prorrateo` FOREIGN KEY (`idProrrateo`) REFERENCES `prorrateos` (`idProrrateo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.gasto_prorrateo: ~16 rows (approximately)
/*!40000 ALTER TABLE `gasto_prorrateo` DISABLE KEYS */;
INSERT INTO `gasto_prorrateo` (`idGastoProrrateo`, `idGasto`, `idProrrateo`, `monto`) VALUES
	(3, 2, 10, 18.81),
	(4, 2, 11, 13.20),
	(5, 2, 12, 0.99),
	(6, 3, 10, 18.81),
	(7, 3, 11, 13.20),
	(8, 3, 12, 0.99),
	(9, 4, 10, 18.81),
	(10, 4, 11, 13.20),
	(11, 4, 12, 0.99),
	(12, 5, 10, 127.11),
	(13, 5, 11, 89.20),
	(14, 5, 12, 6.69),
	(15, 6, 10, 171.51),
	(16, 6, 11, 120.36),
	(17, 6, 12, 9.03),
	(18, 7, 16, 3000.00);
/*!40000 ALTER TABLE `gasto_prorrateo` ENABLE KEYS */;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.GetBoleta
DELIMITER //
CREATE PROCEDURE `GetBoleta`(
	IN `_fecha` DATE

)
BEGIN
 select @n:=@n+1 as n, g.* from (select distinct DATE(fecha) from gastos) as g,(SELECT @n:=0) r;

END//
DELIMITER ;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.GetCorrelativo
DELIMITER //
CREATE PROCEDURE `GetCorrelativo`(
	IN `_fecha` DATE


,
	OUT `_numero` INT



)
BEGIN
 DECLARE auxFecha DATE Default '2000-01-01';
 DECLARE i int Default 0;
 DECLARE __fecha DATE;
 DECLARE done BOOLEAN DEFAULT FALSE;
 DECLARE micursor CURSOR FOR SELECT fecha FROM gastos;
 DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = TRUE;
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE; 
 DROP TEMPORARY TABLE IF EXISTS correlativo;
 CREATE TEMPORARY TABLE correlativo (num INT, fec DATE) ENGINE=MEMORY;
 OPEN micursor;
 
cursor_loop: LOOP
 
 FETCH micursor INTO __fecha;
	IF `done` THEN LEAVE cursor_loop; END IF; 
	IF MONTH(auxFecha) <>  MONTH(__fecha) THEN
		SET i=1;
		SET auxFecha = __fecha;
	END IF;
	IF DAY(auxFecha) <>  DAY(__fecha) THEN
		SET i=i+1;
		SET auxFecha = __fecha;
	END IF;
	
	INSERT INTO correlativo select i,__fecha;
 
END LOOP cursor_loop;
 
CLOSE micursor;
/*SELECT * from correlativo;*/
 SET _numero= (SELECT num from correlativo where fec=_fecha limit 1);
END//
DELIMITER ;

-- Dumping structure for table heroku_5f1d7d573c9b3be.grupos
CREATE TABLE IF NOT EXISTS `grupos` (
  `idGrupo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idGrupo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.grupos: ~5 rows (approximately)
/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;
INSERT INTO `grupos` (`idGrupo`, `nombre`) VALUES
	(0, 'Sin grupo'),
	(1, 'Futuro'),
	(2, 'Prevision'),
	(3, 'Quinquenios'),
	(4, 'Finiquitos');
/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;

-- Dumping structure for table heroku_5f1d7d573c9b3be.lineas
CREATE TABLE IF NOT EXISTS `lineas` (
  `idLinea` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idLinea`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.lineas: ~3 rows (approximately)
/*!40000 ALTER TABLE `lineas` DISABLE KEYS */;
INSERT INTO `lineas` (`idLinea`, `nombre`) VALUES
	(1, 'SAN FERNANDO'),
	(2, 'EUROFARMA'),
	(3, 'MEDIFARM');
/*!40000 ALTER TABLE `lineas` ENABLE KEYS */;

-- Dumping structure for table heroku_5f1d7d573c9b3be.opciones
CREATE TABLE IF NOT EXISTS `opciones` (
  `idOpcion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL,
  `activo` bit(1) DEFAULT b'1',
  PRIMARY KEY (`idOpcion`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.opciones: ~28 rows (approximately)
/*!40000 ALTER TABLE `opciones` DISABLE KEYS */;
INSERT INTO `opciones` (`idOpcion`, `nombre`, `tipo`, `activo`) VALUES
	(1, 'Cable', NULL, b'1'),
	(2, 'luz', NULL, b'1'),
	(3, 'Agua', NULL, b'1'),
	(4, 'Teléfono', NULL, b'1'),
	(5, 'Celular', NULL, b'1'),
	(6, 'Mariana', 1, b'1'),
	(7, 'MCarmen', 1, b'1'),
	(8, 'Cecilia', 1, b'1'),
	(9, 'Eurofarma', NULL, b'1'),
	(10, 'Leonardo', 1, b'1'),
	(11, 'Ethel', 1, b'1'),
	(12, 'Facturas', NULL, b'1'),
	(13, 'Recibos oficiales', NULL, b'1'),
	(14, 'Lista de precios', NULL, b'1'),
	(15, 'Notas de pedidos', NULL, b'1'),
	(16, 'Kardex', NULL, b'1'),
	(17, 'Otros', NULL, b'1'),
	(18, 'IVA', NULL, b'1'),
	(19, 'IT', NULL, b'1'),
	(20, 'IUE', NULL, b'1'),
	(21, 'Impresora', NULL, b'1'),
	(22, 'Laptop', NULL, b'1'),
	(23, 'San Fernando', NULL, b'1'),
	(24, 'Medifarm', NULL, b'1'),
	(25, 'Valeria', 1, b'1'),
	(26, 'Provincias', NULL, b'1'),
	(28, 'Internet', NULL, b'1'),
	(29, 'Lizeth', 1, b'1');
/*!40000 ALTER TABLE `opciones` ENABLE KEYS */;

-- Dumping structure for table heroku_5f1d7d573c9b3be.perfilesprorrateos
CREATE TABLE IF NOT EXISTS `perfilesprorrateos` (
  `idPerfilProrrateo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT '0',
  `descripcion` text,
  `color` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idPerfilProrrateo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.perfilesprorrateos: ~5 rows (approximately)
/*!40000 ALTER TABLE `perfilesprorrateos` DISABLE KEYS */;
INSERT INTO `perfilesprorrateos` (`idPerfilProrrateo`, `nombre`, `descripcion`, `color`) VALUES
	(1, '1er Prorrateo', '1er Prorrateo', '#00e0f7'),
	(2, '2do Prorrateo', '2do Prorrateo', '#729eff'),
	(3, 'SAN FERNANDO', NULL, '#a5b900'),
	(4, 'EUROFARMA', NULL, '#b97700'),
	(5, 'MEDIFARM', NULL, '#b91900');
/*!40000 ALTER TABLE `perfilesprorrateos` ENABLE KEYS */;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.ProcAsignarConceptoOpcion
DELIMITER //
CREATE PROCEDURE `ProcAsignarConceptoOpcion`(
	IN `idConcepto` INT,
	IN `idOpcion` INT,
	IN `idPerfilProrrateo` INT

)
BEGIN
insert into concepto_opcion (idConcepto,idOpcion,idPerfilProrrateo)
values (idConcepto,idOpcion,idPerfilProrrateo);
select LAST_INSERT_ID() as idConceptoOpcion;
END//
DELIMITER ;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.ProcCrudOpcion
DELIMITER //
CREATE PROCEDURE `ProcCrudOpcion`(
	IN `_idOpcion` INT,
	IN `tipo` INT,
	IN `clase` INT,
	IN `_nombre` VARCHAR(200)
)
BEGIN
declare id INT Default 0;
declare contOpcion INT Default 0;
if tipo=1 then
	if (select count(*) from opciones where nombre=_nombre)>0 then
		SET id = -1;
	else
		insert into opciones (nombre, tipo) values (_nombre, clase);
		SET id = LAST_INSERT_ID();
	end if;
	
end if;
if tipo=2 then
	update opciones set nombre = _nombre where idOpcion=_idOpcion;
	SET id = _idOpcion;
end if;
if tipo=3 then
	set contOpcion = (select count(*) from gastos as g inner join opciones as o on o.idOpcion=g.idopcion where o.idOpcion=_idOpcion);
	if contOpcion > 0 then
		update opciones set activo = 0 where idOpcion=_idOpcion;
	else
		delete from opciones where idOpcion=_idOpcion;
	end if;
	
	SET id = _idOpcion;
end if;
select id;
END//
DELIMITER ;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.ProcEliminarEgreso
DELIMITER //
CREATE PROCEDURE `ProcEliminarEgreso`(
	IN `_idGasto` INT
)
BEGIN
declare salida Int Default 0;
delete from gasto_prorrateo where idGasto=_idGasto;
delete from gastos where idGasto=_idGasto;
set salida = 1;
select salida;
END//
DELIMITER ;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.ProcGetListaEgresos
DELIMITER //
CREATE PROCEDURE `ProcGetListaEgresos`(
	IN `inicio` INT,
	IN `limite` INT




)
BEGIN
 DECLARE auxFecha DATE Default '2000-01-01';
 DECLARE auxMonto INT Default 0;
 DECLARE i int Default 0;
 DECLARE __fecha DATE;
 DECLARE __monto INT Default 0;
 DECLARE __idUsuario INT;
 DECLARE __nombreUsuario VARCHAR(250);
 DECLARE done BOOLEAN DEFAULT FALSE;
 DECLARE micursor CURSOR FOR SELECT g.fecha, g.montoTotal, g.idUsuario, u.nombre FROM gastos as g inner join usuarios as u on u.idUsuario=g.idUsuario;
 DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = TRUE;
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;  
 DROP TEMPORARY TABLE IF EXISTS correlativo;
 CREATE TEMPORARY TABLE correlativo (ncorrelativo INT, fec DATE, total INT, idUsuario INT, nombreUsuario varchar(250)) ENGINE=MEMORY;
 OPEN micursor;
 
cursor_loop: LOOP
 
 FETCH micursor INTO __fecha,__monto,__idUsuario,__nombreUsuario;
	IF `done` THEN LEAVE cursor_loop; END IF; 
	IF MONTH(auxFecha) <>  MONTH(__fecha) THEN
		SET i=1;
		SET auxMonto=0;
		SET auxFecha = __fecha;
	END IF;
	IF DAY(auxFecha) <>  DAY(__fecha) THEN
		SET i=i+1;
		SET auxMonto=0;		
		SET auxFecha = __fecha;
	END IF;
	SET auxMonto = auxMonto + __monto;
	
	INSERT INTO correlativo select i,__fecha, auxMonto, __idUsuario, __nombreUsuario ;
 
END LOOP cursor_loop;
 
CLOSE micursor;
SELECT ncorrelativo, max(total) as total, idUsuario, nombreUsuario,DATE_FORMAT(fec, "%d-%m-%Y") as 'fecha', count(fec) as 'registros'  from correlativo group by fec order by fec desc limit inicio,limite;
/*select  count( distinct(DATE(fec))) as total from correlativo; */
END//
DELIMITER ;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.ProcGetListaOpcionesAsigConcepto
DELIMITER //
CREATE PROCEDURE `ProcGetListaOpcionesAsigConcepto`(
	IN `_idConcepto` INT

)
BEGIN

 
 select co.idConcepto, op.idOpcion, co.idPerfilProrrateo, op.nombre as nombreopcion, op.tipo as opciontipo, c.nombre as nombreconcepto, pp.nombre as nombreperfilprorrateo, pp.color, co.idGrupo  from opciones as op
 left join concepto_opcion as co on co.idOpcion=op.idOpcion and co.idConcepto=_idConcepto
left join conceptos as c on c.idConcepto=co.idConcepto
left join perfilesprorrateos as pp on pp.idPerfilProrrateo= co.idPerfilProrrateo;
 
 
END//
DELIMITER ;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.ProcGetListaResumenGastos
DELIMITER //
CREATE PROCEDURE `ProcGetListaResumenGastos`(
	IN `idConcepto` INT,
	IN `fechaInicio` DATE,
	IN `fechaFin` DATE

,
	IN `_offset` INT,
	IN `tampag` INT

)
BEGIN

select g.idGasto, CONCAT_WS(' ', c.nombre, gru.nombre , op.nombre) as detalle,  g.glosa as observacion, g.montoTotal as monto, g.fecha, g.factura from gastos as g
inner join conceptos as c on c.idConcepto= g.idConcepto
left join opciones as op on op.idOpcion= g.idOpcion
left join grupos as gru on gru.idGrupo=g.idGrupo
where IF(idConcepto != 0, idConcepto, g.idConcepto) = g.idConcepto
and IF(fechaInicio!='0000-00-00' and fechaFin!='0000-00-00', (DATE(g.fecha) BETWEEN fechaInicio and fechaFin), true) 
order by g.fecha desc limit tampag,_offset ;
END//
DELIMITER ;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.ProcGetListaResumenGastosNoLimit
DELIMITER //
CREATE PROCEDURE `ProcGetListaResumenGastosNoLimit`(
	IN `idConcepto` INT,
	IN `fechaInicio` DATE,
	IN `fechaFin` DATE

)
BEGIN
select CONCAT_WS(' ', c.nombre, gru.nombre , op.nombre) as detalle,  g.glosa as observacion, g.montoTotal as monto, g.fecha, g.factura from gastos as g
inner join conceptos as c on c.idConcepto= g.idConcepto
left join opciones as op on op.idOpcion= g.idOpcion
left join grupos as gru on gru.idGrupo=g.idGrupo
where IF(idConcepto != 0, idConcepto, g.idConcepto) = g.idConcepto
and IF(fechaInicio!='0000-00-00' and fechaFin!='0000-00-00', (DATE(g.fecha) BETWEEN fechaInicio and fechaFin), true)
order by g.fecha desc ;
END//
DELIMITER ;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.ProcGetResumen
DELIMITER //
CREATE PROCEDURE `ProcGetResumen`(
	IN `_idConcepto` INT,
	IN `fechaInicio` DATE,
	IN `fechaFin` DATE




)
BEGIN
select sum(gp.monto) as total, li.nombre as linea, li.idLinea from gastos as g
 inner join gasto_prorrateo as gp on g.idGasto=gp.idGasto
 inner join prorrateos as pro on pro.idProrrateo=gp.idProrrateo
 inner join perfilesprorrateos as pp on pp.idPerfilProrrateo= pro.idPerfilProrrateo
 inner join lineas as li on li.idLinea=pro.idLinea
where IF(_idConcepto != 0, _idConcepto, g.idConcepto) = g.idConcepto
and IF(fechaInicio!='0000-00-00' and fechaFin!='0000-00-00', (DATE(g.fecha) BETWEEN fechaInicio and fechaFin), true) 
group by li.nombre order by li.idLinea;

END//
DELIMITER ;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.ProcGuardarGasto
DELIMITER //
CREATE PROCEDURE `ProcGuardarGasto`(
	IN `idUsuario` INT,
	IN `idConcepto` INT,
	IN `idGrupo` INT,
	IN `idOpcion` INT,
	IN `montoTotal` DECIMAL(10,2),
	IN `glosa` TEXT,
	IN `factura` VARCHAR(250),
	IN `fecha` DATETIME



















)
BEGIN
declare idInsGasto Int Default 0;
declare proMonto Decimal(10,2) Default 0; 
declare _idPerfilProrrateo int Default 0;
declare _idProrrateo int;
declare _porcentaje decimal(10,2) Default 0;
declare _monto decimal(10,2) Default 0;
declare _c int Default 0;
DECLARE done BOOLEAN DEFAULT FALSE;

DECLARE micursor CURSOR FOR select p.idProrrateo, p.porcentaje from prorrateos as p
inner join concepto_opcion as co on co.idPerfilProrrateo=p.idPerfilProrrateo
where co.idOpcion=idOpcion and co.idConcepto=idConcepto;
DECLARE micursor2 CURSOR FOR select p.idProrrateo, p.porcentaje from conceptos as co
inner join prorrateos as p on p.idPerfilProrrateo=co.idPerfilProrrateo
 where co.idConcepto=idConcepto;

DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = TRUE;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

Insert into gastos (idConcepto,idUsuario,glosa,factura,montoTotal, fecha,idGrupo,idOpcion) 
values (idConcepto, idUsuario, glosa, factura, montoTotal, fecha, idGrupo,idOpcion);
SET idInsGasto = LAST_INSERT_ID();
/*SET _idPerfilProrrateo = (select idPerfilProrrateo from opciones where idOpcion=idOpcion limit 1);*/

OPEN micursor;
 
cursor_loop: LOOP 
 FETCH micursor INTO _idProrrateo, _porcentaje;
 IF `done` THEN LEAVE cursor_loop; END IF; 
 
	SET _monto= ((_porcentaje*montoTotal)/100);
	Insert into gasto_prorrateo (idGasto, idProrrateo, monto)
	values (idInsGasto,_idProrrateo,_monto);
 	SET _c=_c+1;
END LOOP cursor_loop;
 
CLOSE micursor;

if _c=0 then
SET done=false;
	OPEN micursor2;
 
	cursor_loop2: LOOP 
	 FETCH micursor2 INTO _idProrrateo, _porcentaje;
	 IF `done` THEN LEAVE cursor_loop2; END IF; 
	 
		SET _monto= ((_porcentaje*montoTotal)/100);
		Insert into gasto_prorrateo (idGasto, idProrrateo, monto)
		values (idInsGasto,_idProrrateo,_monto);
	 	SET _c=_c+1;
	END LOOP cursor_loop2;
	 
	CLOSE micursor2;

end if;

select idInsGasto as idGasto, idUsuario, DATE_FORMAT(fecha, "%d-%m-%Y")  as fecha;


END//
DELIMITER ;

-- Dumping structure for table heroku_5f1d7d573c9b3be.prorrateos
CREATE TABLE IF NOT EXISTS `prorrateos` (
  `idProrrateo` int(11) NOT NULL AUTO_INCREMENT,
  `idPerfilProrrateo` int(11) NOT NULL,
  `idLinea` int(11) NOT NULL,
  `porcentaje` double NOT NULL,
  PRIMARY KEY (`idProrrateo`),
  KEY `FK_Prorrateo_PerfilProrrateo` (`idPerfilProrrateo`),
  KEY `FK_Prorrateo_Linea` (`idLinea`),
  CONSTRAINT `FK_Prorrateo_Linea` FOREIGN KEY (`idLinea`) REFERENCES `lineas` (`idLinea`),
  CONSTRAINT `FK_Prorrateo_PerfilProrrateo` FOREIGN KEY (`idPerfilProrrateo`) REFERENCES `perfilesprorrateos` (`idPerfilProrrateo`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.prorrateos: ~8 rows (approximately)
/*!40000 ALTER TABLE `prorrateos` DISABLE KEYS */;
INSERT INTO `prorrateos` (`idProrrateo`, `idPerfilProrrateo`, `idLinea`, `porcentaje`) VALUES
	(10, 1, 1, 57),
	(11, 1, 2, 40),
	(12, 1, 3, 3),
	(13, 2, 1, 97),
	(14, 2, 3, 3),
	(15, 3, 1, 100),
	(16, 4, 2, 100),
	(17, 5, 3, 100);
/*!40000 ALTER TABLE `prorrateos` ENABLE KEYS */;

-- Dumping structure for procedure heroku_5f1d7d573c9b3be.RECREAR_BASE
DELIMITER //
CREATE PROCEDURE `RECREAR_BASE`()
BEGIN

DECLARE _FECHA VARCHAR(64) ;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `prorrateos`;
TRUNCATE TABLE `concepto_opcion`;
TRUNCATE TABLE `gasto_prorrateo`;
TRUNCATE TABLE `gastos`;
TRUNCATE TABLE `usuarios`;

SET _FECHA = SYSDATE();

INSERT INTO `usuarios` (`idUsuario`, `nombre`, `ci`, `idRol`, `usuario`, `password`) VALUES
	(1, 'Usuario Administrador', NULL, 1, 'admin', _binary 0x61363635613435393230343232663964343137653438363765666463346662386130346131663366666631666130376539393865383666376637613237616533),
	(2, 'Usuario Asistente', NULL, 2, 'asistente', _binary 0x61363635613435393230343232663964343137653438363765666463346662386130346131663366666631666130376539393865383666376637613237616533);

INSERT INTO `gastos` (`idGasto`, `idConcepto`, `idGrupo`, `idOpcion`, `idUsuario`, `glosa`, `factura`, `montoTotal`, `fecha`) VALUES
	(2, 13, NULL, 4, 2, '', '', 33.00, _FECHA),
	(3, 13, NULL, 17, 2, '', '', 33.00, _FECHA),
	(4, 13, NULL, 21, 2, '', '', 33.00, _FECHA),
	(5, 26, NULL, 29, 2, '', '2333', 223.00, _FECHA),
	(6, 6, NULL, 12, 2, 'ninguna', '324234', 300.90, _FECHA),
	(7, 1, NULL, 9, 2, 'Gastos en medicamentos', '14528779', 3000.00, _FECHA);

INSERT INTO `gasto_prorrateo` (`idGastoProrrateo`, `idGasto`, `idProrrateo`, `monto`) VALUES
	(3, 2, 10, 18.81),
	(4, 2, 11, 13.20),
	(5, 2, 12, 0.99),
	(6, 3, 10, 18.81),
	(7, 3, 11, 13.20),
	(8, 3, 12, 0.99),
	(9, 4, 10, 18.81),
	(10, 4, 11, 13.20),
	(11, 4, 12, 0.99),
	(12, 5, 10, 127.11),
	(13, 5, 11, 89.20),
	(14, 5, 12, 6.69),
	(15, 6, 10, 171.51),
	(16, 6, 11, 120.36),
	(17, 6, 12, 9.03),
	(18, 7, 16, 3000.00);
    

INSERT INTO `concepto_opcion` (`idConcepto`, `idOpcion`, `idPerfilProrrateo`, `idGrupo`) VALUES
	(3, 1, 1, 0),
	(3, 2, 1, 0),
	(3, 3, 1, 0),
	(3, 4, 1, 0),
	(13, 4, 1, 0),
	(3, 5, 1, 0),
	(1, 6, 2, 0),
	(7, 6, 2, 0),
	(8, 6, 2, 1),
	(10, 6, 2, 0),
	(12, 6, 2, 0),
	(22, 6, 2, 3),
	(22, 6, 2, 4),
	(26, 6, 1, 0),
	(1, 7, 2, 0),
	(7, 7, 1, 0),
	(8, 7, 1, 2),
	(10, 7, 1, 0),
	(12, 7, 1, 0),
	(22, 7, 1, 3),
	(22, 7, 1, 4),
	(26, 7, 1, 0),
	(1, 8, 2, 0),
	(7, 8, 1, 0),
	(8, 8, 1, 2),
	(10, 8, 1, 0),
	(12, 8, 1, 0),
	(22, 8, 1, 3),
	(22, 8, 1, 4),
	(26, 8, 1, 0),
	(1, 9, 4, 0),
	(4, 9, 4, 0),
	(5, 9, 4, 0),
	(6, 9, 4, 0),
	(11, 9, 4, 0),
	(18, 9, 4, 0),
	(7, 10, 1, 0),
	(26, 10, 1, 0),
	(7, 11, 1, 0),
	(8, 11, 1, 1),
	(10, 11, 1, 0),
	(12, 11, 1, 0),
	(22, 11, 1, 3),
	(22, 11, 1, 4),
	(26, 11, 1, 0),
	(6, 12, 1, 0),
	(6, 13, 1, 0),
	(6, 14, 1, 0),
	(6, 15, 1, 0),
	(6, 16, 1, 0),
	(7, 16, 1, 0),
	(12, 16, 1, 0),
	(6, 17, 1, 0),
	(13, 17, 1, 0),
	(9, 18, 1, 0),
	(9, 19, 1, 0),
	(9, 20, 1, 0),
	(13, 21, 1, 0),
	(13, 22, 1, 0),
	(4, 23, 3, 0),
	(5, 23, 3, 0),
	(11, 23, 3, 0),
	(4, 24, 5, 0),
	(5, 24, 5, 0),
	(11, 24, 5, 0),
	(7, 25, 1, 0),
	(12, 25, 1, 0),
	(26, 25, 1, 0),
	(18, 26, 2, 0),
	(3, 28, 1, 0),
	(26, 29, 1, 0);
 ALTER TABLE `concepto_opcion` ENABLE KEYS ;

-- Dumping data for table gastos.gastos: ~6 rows (approximately)
 ALTER TABLE `gastos` DISABLE KEYS ;




 ALTER TABLE `gasto_prorrateo` ENABLE KEYS ;

INSERT INTO `prorrateos` (`idProrrateo`, `idPerfilProrrateo`, `idLinea`, `porcentaje`) VALUES
	(10, 1, 1, 57),
	(11, 1, 2, 40),
	(12, 1, 3, 3),
	(13, 2, 1, 97),
	(14, 2, 3, 3),
	(15, 3, 1, 100),
	(16, 4, 2, 100),
	(17, 5, 3, 100);
SET FOREIGN_KEY_CHECKS = 1;

END//
DELIMITER ;

-- Dumping structure for table heroku_5f1d7d573c9b3be.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `idRol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.roles: ~2 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`idRol`, `nombre`) VALUES
	(1, 'administrador'),
	(2, 'registrador');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table heroku_5f1d7d573c9b3be.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) DEFAULT NULL,
  `ci` varchar(250) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL,
  `usuario` varchar(250) DEFAULT NULL,
  `password` varbinary(64) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `FK_usuario_rol` (`idRol`),
  CONSTRAINT `FK_usuario_rol` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table heroku_5f1d7d573c9b3be.usuarios: ~2 rows (approximately)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`idUsuario`, `nombre`, `ci`, `idRol`, `usuario`, `password`) VALUES
	(1, 'Usuario Administrador', NULL, 1, 'admin', _binary 0x61363635613435393230343232663964343137653438363765666463346662386130346131663366666631666130376539393865383666376637613237616533),
	(2, 'Usuario Asistente', NULL, 2, 'asistente', _binary 0x61363635613435393230343232663964343137653438363765666463346662386130346131663366666631666130376539393865383666376637613237616533);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

-- Dumping structure for view heroku_5f1d7d573c9b3be.vwgetconceptos
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vwgetconceptos` (
	`idConcepto` INT(11) NOT NULL,
	`nombre` VARCHAR(250) NOT NULL COLLATE 'utf8_general_ci',
	`defaultIdPerfilProrrateo` INT(11) NULL,
	`idPerfilProrrateo` INT(11) NULL,
	`idOpcion` INT(11) NULL,
	`nombreopcion` VARCHAR(250) NULL COLLATE 'utf8_general_ci',
	`tipo` INT(11) NULL,
	`idGrupo` INT(11) NULL,
	`nombregrupo` VARCHAR(255) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view heroku_5f1d7d573c9b3be.vwlineas
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vwlineas` (
	`nombreperfil` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`idPerfilProrrateo` INT(11) NOT NULL,
	`descripcion` TEXT NULL COLLATE 'utf8_general_ci',
	`nombre` VARCHAR(250) NULL COLLATE 'utf8_general_ci',
	`porcentaje` DOUBLE NOT NULL,
	`idProrrateo` INT(11) NOT NULL,
	`color` VARCHAR(50) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view heroku_5f1d7d573c9b3be.vwlistagastos
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vwlistagastos` (
	`idGasto` INT(11) NOT NULL,
	`idConcepto` INT(11) NOT NULL,
	`idUsuario` INT(11) NOT NULL,
	`glosa` TEXT NULL COLLATE 'utf8_general_ci',
	`factura` VARCHAR(250) NULL COLLATE 'utf8_general_ci',
	`montoTotal` DECIMAL(10,2) NULL,
	`fecha` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci',
	`fechacompleta` VARCHAR(24) NULL COLLATE 'utf8mb4_general_ci',
	`conceptoNombre` VARCHAR(250) NOT NULL COLLATE 'utf8_general_ci',
	`usuarioNombre` VARCHAR(250) NULL COLLATE 'utf8_general_ci',
	`idGrupo` INT(11) NULL,
	`gruponombre` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`idOpcion` INT(11) NULL,
	`nombreopcion` VARCHAR(250) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view heroku_5f1d7d573c9b3be.vwlistaresumengastos
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vwlistaresumengastos` (
	`detalle` TEXT NULL COLLATE 'utf8_general_ci',
	`observacion` TEXT NULL COLLATE 'utf8_general_ci',
	`monto` DECIMAL(10,2) NULL,
	`fecha` DATETIME NULL,
	`factura` VARCHAR(250) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- Dumping structure for view heroku_5f1d7d573c9b3be.vwtempboleta
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vwtempboleta` (
	`total` DECIMAL(32,2) NULL,
	`prorrateo` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`linea` VARCHAR(250) NULL COLLATE 'utf8_general_ci',
	`fecha` DATETIME NULL
) ENGINE=MyISAM;

-- Dumping structure for view heroku_5f1d7d573c9b3be.vwgetconceptos
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vwgetconceptos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vwgetconceptos` AS select `c`.`idConcepto` AS `idConcepto`,`c`.`nombre` AS `nombre`,`c`.`idPerfilProrrateo` AS `defaultIdPerfilProrrateo`,`co`.`idPerfilProrrateo` AS `idPerfilProrrateo`,`op`.`idOpcion` AS `idOpcion`,`op`.`nombre` AS `nombreopcion`,`op`.`tipo` AS `tipo`,`g`.`idGrupo` AS `idGrupo`,`g`.`nombre` AS `nombregrupo` from (((`conceptos` `c` left join `concepto_opcion` `co` on((`co`.`idConcepto` = `c`.`idConcepto`))) left join `opciones` `op` on((`op`.`idOpcion` = `co`.`idOpcion`))) left join `grupos` `g` on((`g`.`idGrupo` = `co`.`idGrupo`))) order by `c`.`idConcepto`,`g`.`idGrupo`,`co`.`idOpcion`;

-- Dumping structure for view heroku_5f1d7d573c9b3be.vwlineas
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vwlineas`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vwlineas` AS select `per`.`nombre` AS `nombreperfil`,`per`.`idPerfilProrrateo` AS `idPerfilProrrateo`,`per`.`descripcion` AS `descripcion`,`li`.`nombre` AS `nombre`,`p`.`porcentaje` AS `porcentaje`,`p`.`idProrrateo` AS `idProrrateo`,`per`.`color` AS `color` from ((`lineas` `li` join `prorrateos` `p` on((`p`.`idLinea` = `li`.`idLinea`))) join `perfilesprorrateos` `per` on((`per`.`idPerfilProrrateo` = `p`.`idPerfilProrrateo`))) order by `p`.`idProrrateo`;

-- Dumping structure for view heroku_5f1d7d573c9b3be.vwlistagastos
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vwlistagastos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vwlistagastos` AS select `ga`.`idGasto` AS `idGasto`,`ga`.`idConcepto` AS `idConcepto`,`ga`.`idUsuario` AS `idUsuario`,`ga`.`glosa` AS `glosa`,`ga`.`factura` AS `factura`,`ga`.`montoTotal` AS `montoTotal`,date_format(`ga`.`fecha`,'%d-%m-%Y') AS `fecha`,date_format(`ga`.`fecha`,'%d-%m-%Y %H:%i:%s') AS `fechacompleta`,`con`.`nombre` AS `conceptoNombre`,`u`.`nombre` AS `usuarioNombre`,`gr`.`idGrupo` AS `idGrupo`,`gr`.`nombre` AS `gruponombre`,`op`.`idOpcion` AS `idOpcion`,`op`.`nombre` AS `nombreopcion` from ((((`gastos` `ga` join `conceptos` `con` on((`ga`.`idConcepto` = `con`.`idConcepto`))) join `usuarios` `u` on((`ga`.`idUsuario` = `u`.`idUsuario`))) left join `grupos` `gr` on((`gr`.`idGrupo` = `ga`.`idGrupo`))) left join `opciones` `op` on((`op`.`idOpcion` = `ga`.`idOpcion`))) order by `ga`.`idGasto` desc;

-- Dumping structure for view heroku_5f1d7d573c9b3be.vwlistaresumengastos
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vwlistaresumengastos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vwlistaresumengastos` AS select concat_ws(' ',`c`.`nombre`,`gru`.`nombre`,`op`.`nombre`) AS `detalle`,`g`.`glosa` AS `observacion`,`g`.`montoTotal` AS `monto`,`g`.`fecha` AS `fecha`,`g`.`factura` AS `factura` from (((`gastos` `g` join `conceptos` `c` on((`c`.`idConcepto` = `g`.`idConcepto`))) left join `opciones` `op` on((`op`.`idOpcion` = `g`.`idOpcion`))) left join `grupos` `gru` on((`gru`.`idGrupo` = `g`.`idGrupo`))) order by `g`.`fecha` desc;

-- Dumping structure for view heroku_5f1d7d573c9b3be.vwtempboleta
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vwtempboleta`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vwtempboleta` AS select sum(`gp`.`monto`) AS `total`,`pp`.`nombre` AS `prorrateo`,`li`.`nombre` AS `linea`,`g`.`fecha` AS `fecha` from ((((`gastos` `g` join `gasto_prorrateo` `gp` on((`g`.`idGasto` = `gp`.`idGasto`))) join `prorrateos` `pro` on((`pro`.`idProrrateo` = `gp`.`idProrrateo`))) join `perfilesprorrateos` `pp` on((`pp`.`idPerfilProrrateo` = `pro`.`idPerfilProrrateo`))) join `lineas` `li` on((`li`.`idLinea` = `pro`.`idLinea`))) where ((`g`.`idConcepto` = 1) and (`gp`.`idProrrateo` = 1));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
