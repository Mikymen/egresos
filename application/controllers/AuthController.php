<?php
class AuthController extends CI_Controller {

    public function __construct(){
        parent::__construct();
        $this->load->model("AuthModel");
    }
    public function Index()
    {           
        
        $this->load->view('Plantillas/_TemplateCabecera');
        $this->load->view('Login/Index');
        $this->load->view('Plantillas/_TemplatePie'); 
    }
    
    public function Login(){
        //RECREAR BASE, se debe quitar en produccion
        $this->RECREAR();

        $username=$this->input->post('username');
        $password=hash('sha256', $this->input->post('password'));
        $admin = $this->AuthModel->GetAdmin($username,$password);
        if($admin!=null){
            session_start();
            $_SESSION["id"]=$admin["idUsuario"];
            $_SESSION["nombre"]=$admin["nombre"];
            //$_SESSION["email"]=$admin["email"];
            $_SESSION["rol"]=$admin["idRol"];
            redirect('/Inicio#/home');
        }
        redirect('/');
    }
    public function LogOut(){
        $this->load->library('autorizar');
        $this->autorizar->LogOut();
        redirect('/');
    }
    public function RECREAR(){    
        $this->load->model("GastosModel");
        $this->GastosModel->RECREAR_BASE();
        //RECREAR BASE
    }
}