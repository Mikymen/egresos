<?php
class InicioController extends CI_Controller {

        public function __construct(){
                parent::__construct();
                $this->load->model("GastosModel");               
                  
        }
        public function Index()
        {
                $this->load->library('autorizar');
                if(!$this->autorizar->Usuario()) redirect('/'); 

                $data['nombre']=$_SESSION["nombre"];
                $data['perfil']=$_SESSION["rol"];
                $conceptos = $this->GastosModel->GetConceptos();
                $data['conceptos']=json_encode($conceptos);
                $data['imgData']= $this->ImagenBase64("assets/img/logo.jpg");
                $data["lista_asistentes"] =json_encode($this->GastosModel->GetListaAsistentes());
                $data["lista_todas_opciones"] =json_encode($this->GastosModel->GetTodasOpciones());
                $data["lista_lineas"] =json_encode($this->GastosModel->GetListaLineas());
                
                $this->load->view('Plantillas/_TemplateCabecera', $data);
                $this->load->view('Inicio/IndexView');
                $this->load->view('Plantillas/_TemplatePie'); 
        }
        public function GuardarEgreso(){
                session_start();
                // $valores=[
                //         'idConcepto' => $this->input->post('idConcepto'),
                //         'idUsuario' => $_SESSION["id"], 
                //         'factura' => trim($this->input->post('factura')),
                //         'monto' => trim($this->input->post('monto')),
                //         'glosa' => trim($this->input->post('detalle')),
                //         'fecha' => $this->getDatetimeNow() 
                // ];
                // $lastId = $this->GastosModel->GuardarEgreso($valores);
                
                $resultado = $this->GastosModel->GuardarEgreso(
                        $_SESSION["id"],
                        $this->input->post('idConcepto'),
                        $this->input->post('idGrupo'),
                        $this->input->post('idOpcion'),
                        trim($this->input->post('monto')),
                        trim($this->input->post('detalle')),
                        trim($this->input->post('factura')), 
                        $this->getDatetimeNow()
                );

                $respuesta="";  
                $codigo=0;
                if($resultado["idGasto"]>0){                        
                      $respuesta="El registro fue guardado correctamente";
                      $codigo=1;
                }else{
                        $respuesta="Ocurrio un error al guardar";  
                        $codigo=0;
                }
                $arr=['Respuesta'=> $respuesta,'Codigo'=>$codigo,'Egreso'=>$resultado];
                header("Content-Type: application/json");
                echo json_encode($arr);
        }
        function getDatetimeNow() {
        $tz_object = new DateTimeZone('America/La_Paz');
        $datetime = new DateTime();
        $datetime->setTimezone($tz_object);
        return $datetime->format('Y-m-d H:i:s');
        }
        public function GetListaEgresos(){
                session_start();    
                $npagina = $this->input->post('npagina');
                $tamPag = intval($this->input->post('tamPag'));  
                $id="";
                $arr = $this->GastosModel->GetEgresos($npagina, $tamPag);
                                          
                header("Content-Type: application/json");
                echo json_encode($arr);                
        }
        public function GetEgresos(){
                session_start();  
                $fecha = $this->input->post('fecha'); 
                $idUsuario = $this->input->post('idUsuario');             
                
                $arr = $this->GastosModel->GetEgresosUsuario($fecha, $idUsuario);
                header("Content-Type: application/json");
                echo json_encode($arr);
                 
        }
        public function GetResumenGastosLinea(){
                session_start(); 
                $arr=[];
                if( $_SESSION["rol"]=="1"){
                        $idConcepto = $this->input->post('idConcepto'); 
                        $fechaInicial = $this->input->post('fechaInicial');    
                        $fechaFinal = $this->input->post('fechaFinal');
                        $arr = $this->GastosModel->GetResumenGastosLinea($idConcepto, $fechaInicial,$fechaFinal);
                }
                
                header("Content-Type: application/json");
                echo json_encode($arr);
        }
        private function ImagenBase64($imagen){
                $type= pathinfo($imagen, PATHINFO_EXTENSION);
                $data= file_get_contents($imagen);
                $base64= 'data:image/'.$type. ';base64,'. base64_encode($data);
                return $base64;
        }
        public function GetCuenta(){
                session_start();    
                $id ="";                 
                $id=$_SESSION["id"]; 
                $arr = $this->GastosModel->GetCuenta($id);
                header("Content-Type: application/json");
                echo json_encode($arr);
                
        }
        public function GuardarCuenta(){
                session_start();
                $datos = $this->input->post('datos');
                $id ="";
                $id=$_SESSION["id"];
                $res = $this->GastosModel->GuardarCuenta($id,$datos);
                header("Content-Type: application/json");
                echo json_encode($res);
                  
        }
        public function GetResumenGastos(){
                $idConcepto = $this->input->post('idConcepto');
                $npagina = $this->input->post('npagina');
                $tamPag = $this->input->post('tamPag');
                $fechaInicial = $this->input->post('fechaInicial');
                $fechaFinal = $this->input->post('fechaFinal');

                $arr = $this->GastosModel->GetResumenGastos($idConcepto, $npagina, $tamPag, $fechaInicial, $fechaFinal);
                header("Content-Type: application/json");
                echo json_encode($arr);                
        }
        public function GetResumenGastosNoLimit(){
                $idConcepto = $this->input->post('idConcepto');
                $fechaInicial = $this->input->post('fechaInicial');
                $fechaFinal = $this->input->post('fechaFinal');

                $arr = $this->GastosModel->GetResumenGastosNoLimit($idConcepto, $fechaInicial, $fechaFinal);
                header("Content-Type: application/json");
                echo json_encode($arr);  
        }
        public function CrudOpcion(){
                $idOpcion = intval($this->input->post('idOpcion'));
                $tipo = intval($this->input->post('tipo'));
                $clase = intval($this->input->post('clase'));
                $nombre = $this->input->post('nombre');
                $res = $this->GastosModel->CrudOpcion($idOpcion, $tipo, $clase,$nombre);
                
                echo $res;
        }
        public function ListaOpciones(){
                $arr=$this->GastosModel->GetTodasOpciones();
                header("Content-Type: application/json");
                echo json_encode($arr);
        }
        public function EliminarEgreso(){
                $idGasto = intval($this->input->post('idGasto'));
                $res = $this->GastosModel->EliminarEgreso($idGasto);                
                echo $res;
        }
        public function GuardarProrrateos(){
                $res=0;
                $prorrateos = $this->input->post('prorrateos');
                foreach ($prorrateos as $prorrateo) {
                        foreach($prorrateo["prorrateos"] as $p){
                                $res = $this->GastosModel->GuardarProrrateo(
                                        $p["idProrrateo"],
                                        $p["porcentaje"]
                                );
                        }
                }
                return $res;
        }
        public function CargaListaAsigConceptoProrrateo(){
                $idConcepto = $this->input->post('idConcepto');
                $arr=$this->GastosModel->CargaListaAsigConceptoProrrateo($idConcepto);
                header("Content-Type: application/json");
                echo json_encode($arr);
        }       
        public function GenerarExcel(){
                $idConcepto = $this->input->get('idConcepto');
                $fechaInicial = $this->input->get('fechaInicial');
                $fechaFinal = $this->input->get('fechaFinal');
                $arr = $this->GastosModel->GetResumenGastosExcel($idConcepto,$fechaInicial, $fechaFinal);

                        // create file name
                $fileName = 'resumen-'.time().'.xlsx';  
                        // load excel library
                $this->load->library('excel');
                
                header('Content-disposition: attachment; filename="'.XLSXWriter::sanitize_filename($fileName).'"');
                header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                header('Content-Transfer-Encoding: binary');
                header('Cache-Control: must-revalidate');
                header('Pragma: public');

                $header = array(
                        'Fecha'=>'datetime',
                        'Detalle'=>'string',
                        'Factura'=>'string',
                        'Monto (Bs.)'=>'#.##0',
                        'Observación'=>'string'
                      );
                //suma total:
                $sumaTotal=0;
                foreach($arr as $fila){
                        $sumaTotal+=number_format((float)$fila["monto"], 2, '.', '');
                }

                $rows=Array();
                foreach($arr as $fila){
                        $decimal=number_format((float)$fila["monto"], 2, '.', '');
                        array_push($rows,[$fila["fecha"], $fila["detalle"],$fila["factura"],$decimal,$fila["observacion"]]);
                }
                array_push($rows,["", "TOTAL","",$sumaTotal,""]);
                

                $writer = new XLSXWriter();
                $writer->writeSheetHeader('Resumen', $header, array('font-style'=>'bold') );
                $writer->setAuthor('MARKDIS'); 
                foreach($rows as $row)
                $writer->writeSheetRow('Resumen', $row);
                $writer->writeToStdOut();
                exit(0);  
        } 
        public function AgregarOpcion(){
                $idConcepto = $this->input->get('idConcepto');
                $idOpcion = $this->input->get('idOpcion');
                $idGrupo = $this->input->get('idGrupo');
        }
        public function QuitarOpcion(){
                $idConcepto = $this->input->get('idConcepto');
                $idOpcion = $this->input->get('idOpcion');
                $idGrupo = $this->input->get('idGrupo');
        }
}