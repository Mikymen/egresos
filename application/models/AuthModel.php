<?php

class AuthModel extends CI_Model
{
    
    public function __construct()
    {
        $this->load->database();
    }
    public function GetAdmin($usuario,$password){
        $query= $this->db->get_where('usuarios',['usuario' => $usuario, 'password' => $password]);
        return $query->row_array();
        
    }
}