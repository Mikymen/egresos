<?php

class GastosModel extends CI_Model
{  
    public function __construct()
    {
        $this->load->database();
    }
    public function GetLineas(){
        $query=$this->db->get("lineas"); 
        return $query->result_array();
    }
    public function GetConceptos(){
        $query=$this->db->get("vwgetconceptos"); 
        return $query->result_array();
    }
    public function GetTodasOpciones(){
        $query=$this->db->order_by('nombre')->get("opciones"); 
        return $query->result_array();
    }

    public function GuardarEgreso($idUsuario,$idConcepto,$idGrupo,$idOpcion,$monto,$detalle,$factura,$fecha){
        //$this->db->insert('gastos', $valores);
        $idGrupo=empty($idGrupo)?'NULL':$idGrupo;
        $idOpcion=empty($idOpcion)?'NULL':$idOpcion;
        $consulta=sprintf("call ProcGuardarGasto('%s','%s',%s,%s,'%s','%s','%s','%s')",$idUsuario,$idConcepto,$idGrupo,$idOpcion,$monto,$detalle,$factura,$fecha);
        $query=$this->db->query($consulta);  
        $result=$query->row_array();
        $query->free_result();
        return  $result;
    }
    public function GetEgresos($npagina, $tamPag){      
        $offset = ($npagina-1)*$tamPag;     
       $query2=$this->db->query('SELECT count(distinct(DATE(fecha))) as total from gastos');      
        $nReg = $query2->row_array()['total']; 
        $query=$this->db->query(sprintf('call ProcGetListaEgresos(%d,%d)', $offset, $tamPag));  
        $result=$query->result_array();
        $query->free_result();
        return Array(
            "res" => $result,
            "paginas" => $nReg,
            "npagina" => $npagina,
            "tamPag" => $tamPag
        );
    }
    public function GetEgresosUsuario($fecha, $idUsuario){
        $query=$this->db->where(['fecha'=>$fecha, 'idUsuario'=>$idUsuario])->get("vwlistagastos"); 
        return $query->result_array();
    }
    public function GetCuenta($id){
        $query="";        
        $query=$this->db->select('nombre, usuario')->where('idUsuario',$id)->get("usuarios"); 
        return $query->row_array();
    }
    public function GetListaAsistentes(){
        $query=$this->db->where('idRol',2)->get("usuarios"); 
        return $query->result_array();
    }
    public function GuardarCuenta($id, $datos){
        $query="";
        $password=trim($datos['password']);
        if( $password!=""){
            $password = hash('sha256', $password);
        }
        
        if($password!=""){
            $valores=['usuario'=>$datos["usuario"],'password'=>$password];
        }else{
            $valores=['usuario'=>$datos["usuario"]];
        }            
        $this->db->set($valores)->where('idUsuario', $id)->update('usuarios');
        
        
        return 1;
    }
    public function GetResumenGastosLinea($idConcepto, $fechaInicial,$fechaFinal){
        if(empty($idConcepto))
            $idConcepto='';
        if(empty($fechaFinal) && empty($fechaFinal)){
            $fechaFinal='';
            $fechaInicial='';
        }
        
        $query = $this->db->query(sprintf("call ProcGetResumen('%s','%s','%s')", $idConcepto, $fechaInicial,$fechaFinal));  
        $result=$query->result_array();
        $query->free_result();
        return $result;
    }
    
    public function GetResumenGastos($idConcepto,$npagina, $tamPag, $fechaInicial, $fechaFinal){ 
        $where = sprintf("DATE(fecha) BETWEEN '%s' AND '%s'", $fechaInicial, $fechaFinal );
        $nReg = $idConcepto==""? $this->db->where($where)->count_all_results("gastos") : $this->db->where("idConcepto",$idConcepto)->where($where)->count_all_results("gastos");
        $offset = ($npagina-1)*$tamPag;
        $sql = sprintf("call ProcGetListaResumenGastos ('%s','%s','%s','%s','%s')",$idConcepto, $fechaInicial, $fechaFinal, $tamPag, $offset);

        $query= $this->db->query($sql);  
        
        return Array(
            "res" => $query->result_array(),
            "paginas" => $nReg,
            "npagina" => $npagina,
            "tamPag" => $tamPag
        );
    }
    public function GetResumenGastosNoLimit($idConcepto,$fechaInicial, $fechaFinal){
        $sql = sprintf("call ProcGetListaResumenGastosNoLimit ('%s','%s','%s')",$idConcepto, $fechaInicial, $fechaFinal);
        $query= $this->db->query($sql);  
        return $query->result_array();
    }
    public function CrudOpcion($idOpcion, $tipo, $clase,$nombre){
        $sql = sprintf("call ProcCrudOpcion ('%s','%s','%s','%s')",$idOpcion, $tipo, $clase,$nombre);
        $query= $this->db->query($sql);  
        return $query->row_array()["id"];
    }
    public function EliminarEgreso($idGasto){
        $sql = sprintf("call ProcEliminarEgreso ('%s')",$idGasto);
        $query= $this->db->query($sql);  
        return $query->row_array()["salida"];
    }
    public function GetListaLineas(){
        $query=$this->db->get("vwlineas"); 
        return $query->result_array();
    }
    public function GuardarProrrateo($idProrrateo, $porcentaje){
        $data = array(
            'porcentaje' => $porcentaje
        );        
        $this->db->where('idProrrateo', $idProrrateo);
        return $this->db->update('prorrateos', $data);
    }
    public function CargaListaAsigConceptoProrrateo($idConcepto){
        $sql = sprintf("call ProcGetListaOpcionesAsigConcepto ('%s')",$idConcepto);
        $query= $this->db->query($sql);  
        return $query->result_array();
    }
    public function GetResumenGastosExcel($idConcepto, $fechaInicial, $fechaFinal){ 
        if($idConcepto=="undefined"){
            $idConcepto=0;
        }
        $sql = sprintf("call ProcGetListaResumenGastosNoLimit ('%s','%s','%s')",$idConcepto, $fechaInicial, $fechaFinal);

        $query= $this->db->query($sql);  
        
        return  $query->result_array();
    }

    //RECREAR LA BASE PARA FINES DE PRUEBA
    public function RECREAR_BASE(){
        $sql = sprintf("call RECREAR_BASE()");
        $query= $this->db->query($sql);  
    }
   
}