-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versi server:                 5.1.63-community - MySQL Community Server (GPL)
-- OS Server:                    Win32
-- HeidiSQL Versi:               11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Membuang struktur basisdata untuk adiwraksa
CREATE DATABASE IF NOT EXISTS `adiwraksa` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `adiwraksa`;

-- membuang struktur untuk table adiwraksa.bom
CREATE TABLE IF NOT EXISTS `bom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bom_no` varchar(25) DEFAULT NULL,
  `tgl_input` date DEFAULT NULL,
  `keterangan` varchar(250) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `bom_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.bom_detail
CREATE TABLE IF NOT EXISTS `bom_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_bom` int(11) DEFAULT NULL,
  `id_divisi` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `keterangan` varchar(250) DEFAULT NULL,
  `jumlah` decimal(20,4) DEFAULT NULL,
  `unit` varchar(25) DEFAULT NULL,
  `standart_cost` decimal(20,4) DEFAULT NULL,
  `total_biaya` decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_bom` (`id_bom`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `bom_detail_ibfk_1` FOREIGN KEY (`id_bom`) REFERENCES `bom` (`id`),
  CONSTRAINT `bom_detail_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.bom_pekerjaan
CREATE TABLE IF NOT EXISTS `bom_pekerjaan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_bom` int(11) DEFAULT NULL,
  `id_divisi` int(11) DEFAULT NULL,
  `id_pekerjaan` int(11) DEFAULT NULL,
  `jumlah` decimal(20,4) DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `biaya_standart` decimal(20,4) DEFAULT NULL,
  `total_biaya` decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bom_pekerjaan_ibfk_1` (`id_pekerjaan`),
  KEY `bom_pekerjaan_ibfk_2` (`id_bom`),
  CONSTRAINT `bom_pekerjaan_ibfk_1` FOREIGN KEY (`id_pekerjaan`) REFERENCES `pekerjaan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bom_pekerjaan_ibfk_2` FOREIGN KEY (`id_bom`) REFERENCES `bom` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.detail_shipment
CREATE TABLE IF NOT EXISTS `detail_shipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomer` varchar(25) DEFAULT NULL,
  `no_container` varchar(25) DEFAULT NULL,
  `no_so` varchar(25) DEFAULT NULL,
  `itemno` varchar(50) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `qty_m3` decimal(10,4) DEFAULT NULL,
  `stts` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.divisi
CREATE TABLE IF NOT EXISTS `divisi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `divno` varchar(50) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `pic` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk function adiwraksa.fc_getQtyAwal
DELIMITER //
CREATE FUNCTION `fc_getQtyAwal`(varItem varchar (100),
  varNOSO varchar (100),
  varWO integer,
  varProcess integer
) RETURNS int(11)
BEGIN
  declare qtyAwal integer ;
  declare returnQtyAwal integer ;
  declare jmlData integer ;
  declare varUrutProgress integer ;
  
  select 
    s.no_urut into varUrutProgress 
  FROM
    setting_process s 
    LEFT JOIN item i 
      on i.id = s.item_id 
  where s.id_divisi = varProcess 
    and i.itemno=varItem;
    
    
    select 
      Count(id) into jmlData 
    from
      progress 
    WHERE item_no = varItem 
      and id_wo = varWO 
      and no_so = varNOSO ;
  if (ifnull(jmlData, 0) > 0) 
  then
	  begin
		if varUrutProgress > 1 then
		  select 
		    SUM(ifnull(p.qty, 0)) into qtyAwal 
		  from
		    progress p 
		    left join setting_process s 
		      on p.id_divisi = s.id_divisi 
		      and p.item_id = s.item_id 
		  where p.item_no = varItem 
		    and p.id_wo = varWO 
		    and p.no_so = varNOSO 
		    and s.no_urut = varUrutProgress - 1 and p.stts='WIP';
		else 
		   SELECT qty into qtyAwal FROM wo_jobs WHERE id_wo=varWO and so_no=varNOSO and item_no=varItem;
		end if;
	  end;
  elseif (ifnull(jmlData,0) = 0) then
	if varUrutProgress = 1 then
	   SELECT qty INTO qtyAwal FROM wo_jobs WHERE id_wo=varWO AND so_no=varNOSO AND item_no=varItem;
	else
	   set qtyAwal = 0;
	end if;
  end if;
  
  return qtyAwal;
END//
DELIMITER ;

-- membuang struktur untuk function adiwraksa.fc_qtyFinishContainer
DELIMITER //
CREATE FUNCTION `fc_qtyFinishContainer`(varItem VARCHAR (100),
  varNOSO VARCHAR (100),varNoContainer varChar(100)
) RETURNS int(11)
BEGIN
  DECLARE qtyFinish INT ;
  SELECT 
    SUM(IFNULL(p.qty, 0)) INTO qtyFinish 
  FROM
    progress p left join wo w on w.id=p.id_wo
  WHERE p.item_no = varItem 
    AND p.no_so = varNOSO and w.no_container=varNoContainer;
  RETURN qtyFinish ;
END//
DELIMITER ;

-- membuang struktur untuk function adiwraksa.fc_qtyFinishProcess
DELIMITER //
CREATE FUNCTION `fc_qtyFinishProcess`(varItem VARCHAR (100),
  varNOSO VARCHAR (100),
  varWO INTEGER,
  varProcess INTEGER
) RETURNS int(11)
BEGIN
  declare qtyFinish int ;
  select 
    sum(ifnull(p.qty,0)) into qtyFinish 
  from
    progress p 
  where item_no = varItem 
    and no_so = varNOSO 
    and id_wo = varWO 
    and id_divisi = varProcess ;
    
    return qtyFinish;
END//
DELIMITER ;

-- membuang struktur untuk function adiwraksa.fc_qtyFinishSO
DELIMITER //
CREATE FUNCTION `fc_qtyFinishSO`(varItem VARCHAR (100),
  varNOSO VARCHAR (100)
) RETURNS int(11)
BEGIN
  DECLARE qtyFinish INT ;
  SELECT 
    SUM(IFNULL(p.qty, 0)) INTO qtyFinish 
  FROM
    progress p 
  WHERE item_no = varItem 
    AND no_so = varNOSO ;
  RETURN qtyFinish ;
END//
DELIMITER ;

-- membuang struktur untuk function adiwraksa.fc_qtypacking
DELIMITER //
CREATE FUNCTION `fc_qtypacking`(Varno_container varchar (100),
  Varno_so varChar (100),
  Varitemno varchar (100)
) RETURNS int(11)
BEGIN
  declare qtyPacking integer ;
  select 
    sum(qty_packing) into qtyPacking 
  FROM
    shippment 
  where no_container = VarNo_container 
    and no_so = Varno_so 
    and itemno = Varitemno ;
   return qtyPacking;
END//
DELIMITER ;

-- membuang struktur untuk function adiwraksa.fc_qtyreadypacking
DELIMITER //
CREATE FUNCTION `fc_qtyreadypacking`(varItem VARCHAR (100),
  varNOSO VARCHAR (100),varNoContainer varChar(100)
) RETURNS int(11)
BEGIN
  DECLARE qtyFinish INT ;
  SELECT 
    SUM(IFNULL(p.qty, 0)) INTO qtyFinish 
  FROM
    progress p left join wo w on w.id=p.id_wo
  WHERE p.item_no = varItem 
    AND p.no_so = varNOSO and w.no_container=varNoContainer and p.stts='FINISH';
  RETURN qtyFinish ;
END//
DELIMITER ;

-- membuang struktur untuk function adiwraksa.fc_qtyShipped
DELIMITER //
CREATE FUNCTION `fc_qtyShipped`(Varno_container VARCHAR (100),
  Varno_so VARCHAR (100),
  Varitemno VARCHAR (100)
) RETURNS int(11)
BEGIN
	DECLARE qtyShipped INTEGER ;
  SELECT 
    SUM(qty_packing) INTO qtyShipped 
  FROM
    shippment 
  WHERE no_container = VarNo_container 
    AND no_so = Varno_so 
    AND itemno = Varitemno and stts='Shipped';
   RETURN qtyShipped;
    END//
DELIMITER ;

-- membuang struktur untuk table adiwraksa.gantt_chart
CREATE TABLE IF NOT EXISTS `gantt_chart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) DEFAULT NULL,
  `so_no` varchar(50) DEFAULT NULL,
  `tgl_input` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.gant_detail
CREATE TABLE IF NOT EXISTS `gant_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gantt_code` varchar(50) DEFAULT NULL,
  `itemno` varchar(50) DEFAULT NULL,
  `deskripsi` text,
  `qty_order` int(11) DEFAULT NULL,
  `tgl_inspect` date DEFAULT NULL,
  `step_process` int(11) DEFAULT NULL,
  `keterangan` varchar(200) DEFAULT NULL,
  `satuanwaktu` varchar(20) DEFAULT NULL,
  `waktu` int(11) DEFAULT NULL,
  `jml_pekerja` int(11) DEFAULT NULL,
  `total_hari` int(11) DEFAULT NULL,
  `tgl_mulai` date DEFAULT NULL,
  `tgl_akhir` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.item
CREATE TABLE IF NOT EXISTS `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemno` varchar(200) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `item_type` int(11) DEFAULT NULL,
  `item_category` int(11) DEFAULT NULL,
  `stok` decimal(20,4) DEFAULT NULL,
  `unit_price` decimal(20,4) DEFAULT NULL,
  `discount` decimal(20,4) DEFAULT NULL,
  `on_sales` decimal(20,4) DEFAULT NULL,
  `on_order` decimal(20,4) DEFAULT NULL,
  `cost` decimal(20,4) DEFAULT NULL,
  `inventory_gl_accnt` varchar(20) DEFAULT NULL,
  `cogs_accnt` varchar(20) DEFAULT NULL,
  `purchase_ret_gl_accnt` varchar(20) DEFAULT NULL,
  `sales_accnt` varchar(20) DEFAULT NULL,
  `sales_ret_gl_accnt` varchar(20) DEFAULT NULL,
  `cost_methode` varchar(25) DEFAULT 'FIFO',
  `sales_discount_accnt` varchar(25) DEFAULT NULL,
  `goods_transaction_accnt` varchar(25) DEFAULT NULL,
  `unbilled_accnt` varchar(25) DEFAULT NULL,
  `weight` decimal(20,4) DEFAULT NULL,
  `dim_height` decimal(20,4) DEFAULT NULL,
  `dim_width` decimal(20,4) DEFAULT NULL,
  `dim_depth` decimal(20,4) DEFAULT NULL,
  `inventory_group` int(11) DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_ibfk_1` (`item_category`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`item_category`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86610 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.karyawan
CREATE TABLE IF NOT EXISTS `karyawan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_divisi` int(11) DEFAULT NULL,
  `karyawan_no` varchar(25) DEFAULT NULL,
  `nama` varchar(250) DEFAULT NULL,
  `alamat` varchar(250) DEFAULT NULL,
  `telpon` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `karyawan_ibfk_1` (`id_divisi`),
  CONSTRAINT `karyawan_ibfk_1` FOREIGN KEY (`id_divisi`) REFERENCES `divisi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.material
CREATE TABLE IF NOT EXISTS `material` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode` varchar(200) DEFAULT NULL,
  `nama` varchar(200) DEFAULT NULL,
  `kategori` varchar(200) DEFAULT NULL,
  `stok` decimal(20,2) DEFAULT NULL,
  `hpp` decimal(20,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.material_release
CREATE TABLE IF NOT EXISTS `material_release` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_release` varchar(25) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `id_wo` int(11) DEFAULT NULL,
  `id_divisi` int(11) DEFAULT NULL,
  `keterangan` text,
  PRIMARY KEY (`id`),
  KEY `id_wo` (`id_wo`),
  KEY `id_divisi` (`id_divisi`),
  CONSTRAINT `material_release_ibfk_1` FOREIGN KEY (`id_wo`) REFERENCES `wo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `material_release_ibfk_2` FOREIGN KEY (`id_divisi`) REFERENCES `divisi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.material_release_detail
CREATE TABLE IF NOT EXISTS `material_release_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_material_release` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `qty` decimal(20,4) DEFAULT NULL,
  `unit` varchar(25) DEFAULT NULL,
  `notes` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_material_result` (`id_material_release`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `material_release_detail_ibfk_1` FOREIGN KEY (`id_material_release`) REFERENCES `material_release` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `material_release_detail_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.pekerjaan
CREATE TABLE IF NOT EXISTS `pekerjaan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_divisi` int(11) DEFAULT NULL,
  `deskripsi` varchar(250) DEFAULT NULL,
  `biaya` decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pekerjaan_ibfk_1` (`id_divisi`),
  CONSTRAINT `pekerjaan_ibfk_1` FOREIGN KEY (`id_divisi`) REFERENCES `divisi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode` varchar(100) DEFAULT NULL,
  `nama` varchar(250) DEFAULT NULL,
  `kategori` varchar(200) DEFAULT NULL,
  `hpp` decimal(20,2) DEFAULT NULL,
  `hargajual` decimal(20,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.progress
CREATE TABLE IF NOT EXISTS `progress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tgl` date DEFAULT NULL,
  `nobukti` varchar(50) DEFAULT NULL,
  `id_wo` int(11) DEFAULT NULL,
  `no_so` varchar(50) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `item_no` varchar(50) DEFAULT NULL,
  `id_divisi` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `stts` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.setting_process
CREATE TABLE IF NOT EXISTS `setting_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_divisi` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.shippment
CREATE TABLE IF NOT EXISTS `shippment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomer` varchar(25) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `no_container` varchar(25) DEFAULT NULL,
  `no_so` varchar(50) DEFAULT NULL,
  `itemno` varchar(50) DEFAULT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `qty_packing` int(11) DEFAULT NULL,
  `cbm` decimal(10,4) DEFAULT NULL,
  `stts` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk procedure adiwraksa.sp_progressSO
DELIMITER //
CREATE PROCEDURE `sp_progressSO`(
  in varNOSO varchar (100),
  in varItemId INTEGER,
  in varIdWO integer
)
BEGIN
  declare finish int default 0 ;
  declare varPekerjaan varChar (200) ;
  declare varIdPekerjaan int ;
  declare str text ;
  declare curr cursor for 
  select Distinct 
    s.id_divisi,
    d.name 
  from
    setting_process s 
    left join divisi d 
      on d.id = s.id_divisi 
  where s.item_id = varItemId 
  order by s.no_urut ASC ;
  declare continue handler for not found set finish = 1 ;
  
  set str =  'SELECT ';
  open curr ;
  LoopPekerjaan :
  loop
    fetch curr into varIdPekerjaan,varPekerjaan;
    
    if finish = 1 then leave LoopPekerjaan;
    end if;
    
    set str = CONCAT(str,' SUM(CASE WHEN p.id_divisi=',varIdPekerjaan,' then p.qty else 0 END) as "',varPekerjaan,'",');
  END LOOP ;
  CLOSE curr ;
  SET str = SUBSTR(str, 1, CHAR_LENGTH(str) - 1) ;
  
  SET @str = CONCAT(
    str,
    ' FROM progress p WHERE p.id_wo=',varIdWO,' AND p.no_so="',varNOSO,'" and p.item_id=',varItemId,' '
  ) ;
  PREPARE stmt FROM @str ;
  EXECUTE stmt ;
  DEALLOCATE PREPARE stmt ;
    
    
  END//
DELIMITER ;

-- membuang struktur untuk table adiwraksa.temptgl
CREATE TABLE IF NOT EXISTS `temptgl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tglawal` date DEFAULT NULL,
  `tglakhir` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.temp_bom_detail
CREATE TABLE IF NOT EXISTS `temp_bom_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_divisi` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `keterangan` varchar(250) DEFAULT NULL,
  `jumlah` decimal(20,4) DEFAULT NULL,
  `unit` varchar(25) DEFAULT NULL,
  `standart_cost` decimal(20,4) DEFAULT NULL,
  `total_biaya` decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.temp_bom_pekerjaan
CREATE TABLE IF NOT EXISTS `temp_bom_pekerjaan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_divisi` int(11) DEFAULT NULL,
  `id_pekerjaan` int(11) DEFAULT NULL,
  `jumlah` decimal(20,4) DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `biaya_standart` decimal(20,4) DEFAULT NULL,
  `total_biaya` decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_pekerjaan` (`id_pekerjaan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.user_login
CREATE TABLE IF NOT EXISTS `user_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) DEFAULT NULL,
  `full_name` varchar(50) DEFAULT NULL,
  `user_level` int(11) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.wip
CREATE TABLE IF NOT EXISTS `wip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_input` varchar(25) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `id_wo` int(11) DEFAULT NULL,
  `id_divisi` int(11) DEFAULT NULL,
  `item_no` varchar(200) DEFAULT NULL,
  `id_pekerjaan` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.wo
CREATE TABLE IF NOT EXISTS `wo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_wo` varchar(15) DEFAULT NULL,
  `no_container` varchar(100) DEFAULT NULL,
  `tgl_input` date DEFAULT NULL,
  `tgl_mulai` date DEFAULT NULL,
  `tgl_selesai` date DEFAULT NULL,
  `pic` varchar(100) DEFAULT NULL,
  `deskripsi` text,
  `progress` decimal(20,4) DEFAULT '0.0000',
  `finished` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.wo_bom
CREATE TABLE IF NOT EXISTS `wo_bom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_wo` int(11) DEFAULT NULL,
  `id_bom_detail` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `standart_cost` decimal(20,4) DEFAULT NULL,
  `total_cost` decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_wo` (`id_wo`),
  KEY `id_bom_detail` (`id_bom_detail`),
  CONSTRAINT `wo_bom_ibfk_1` FOREIGN KEY (`id_wo`) REFERENCES `wo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wo_bom_ibfk_2` FOREIGN KEY (`id_bom_detail`) REFERENCES `bom_detail` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.wo_bom_pekerjaan
CREATE TABLE IF NOT EXISTS `wo_bom_pekerjaan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_wo` int(11) DEFAULT NULL,
  `id_bom_pekerjaan` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `unit` varchar(10) DEFAULT NULL,
  `standart_cost` decimal(20,4) DEFAULT NULL,
  `total_cost` decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_wo` (`id_wo`),
  KEY `id_bom_pekerjaan` (`id_bom_pekerjaan`),
  CONSTRAINT `wo_bom_pekerjaan_ibfk_1` FOREIGN KEY (`id_wo`) REFERENCES `wo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wo_bom_pekerjaan_ibfk_2` FOREIGN KEY (`id_bom_pekerjaan`) REFERENCES `bom_pekerjaan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk table adiwraksa.wo_jobs
CREATE TABLE IF NOT EXISTS `wo_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_wo` int(11) DEFAULT NULL,
  `deskripsi` text,
  `item_no` varchar(20) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `unit_price` decimal(20,4) DEFAULT NULL,
  `totalcost` decimal(20,4) DEFAULT NULL,
  `so_no` varchar(25) DEFAULT NULL,
  `id_bom` int(11) DEFAULT NULL,
  `finished` decimal(20,4) DEFAULT '0.0000',
  `qtyorder` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_wo` (`id_wo`),
  CONSTRAINT `wo_jobs_ibfk_1` FOREIGN KEY (`id_wo`) REFERENCES `wo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Pengeluaran data tidak dipilih.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
