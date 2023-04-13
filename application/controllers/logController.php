<?php
class logController extends CI_Controller {

    public function __construct(){
        parent::__construct();
        $this->load->helper('download');              
          
    }
    public function Index()
    {
        $directorio = isset($_ENV["LOG_DIR"])? $_ENV["LOG_DIR"] : DIRECTORY_SEPARATOR;
        $data['directorio'] = $this->obtener_estructura_directorios($directorio);
        $this->load->view('Logs/index', $data);
    }
    public function ruta($dir)
    {
        $data['directorio'] = $this->obtener_estructura_directorios(DIRECTORY_SEPARATOR.urldecode($dir));
        $this->load->view('Logs/index', $data);

    }
    function obtener_estructura_directorios($ruta){
        $salida="";
        if (is_dir($ruta)){
            $gestor = opendir($ruta);
            $salida = "<ul>";
            while (($archivo = readdir($gestor)) !== false)  {
                    
                $ruta_completa = $ruta==DIRECTORY_SEPARATOR? $ruta.$archivo  : $ruta . DIRECTORY_SEPARATOR . $archivo;
                if ($archivo != "." && $archivo != "..") {
                    if (is_dir($ruta_completa)) {
                        $salida .= "<li><strong><a href='".base_url()."logController/ruta/".urlencode(substr($ruta_completa,1))."' >" . $archivo . "</a></strong></li>";
                        //$this->obtener_estructura_directorios($ruta_completa);
                    } else {
                        if(substr($archivo,-3)=="txt")
                            $salida .= "<li><a href='".base_url()."logController/descargar?dir=".urlencode(substr($ruta_completa,1))."' >" . $archivo . "</a></li>";
                        else
                            $salida .= "<li>" . $archivo . "</li>";
                    }
                }
            }
            closedir($gestor);
            return $salida ."</ul>";
        } else {
            echo "No es una ruta de directorio valida";
        }
    }
    public function descargar()
    {
         $file = DIRECTORY_SEPARATOR.urldecode($_GET['dir']);
        if(!file_exists($file)){ 
            die('Archivo no encontrado: '.$file );
        } else {
            force_download($file, NULL);
        }

    }
}