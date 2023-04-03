<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');
/*
 *  ======================================= 
 *  Author     : Team Tech Arise 
 *  License    : Protected 
 *  Email      : info@techarise.com 
 * 
 *  ======================================= 
 */
require_once APPPATH . "/third_party/simplexcel/xlsxwriter.class.php";
class Excel extends XLSXWriter {
    public function __construct() {
        parent::__construct();
    }
}
?>