<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Autorizar {

        public function Usuario()
        {
            if (session_id() == '' || session_status() == PHP_SESSION_NONE) {
                session_start();                
            };
            if(isset($_SESSION["id"])){
                return true;
            };
            session_destroy();
            return false;
        }
        public function LogOut(){
            if (session_id() == '' || session_status() == PHP_SESSION_NONE) {
                session_start();                
            };
            unset($_SESSION["id"]);
            unset($_SESSION["nombre"]);
            unset($_SESSION["email"]);
            unset($_SESSION["rol"]);
            session_destroy();
        }
}