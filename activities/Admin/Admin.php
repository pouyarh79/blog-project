<?php

namespace Admin;

use Auth\Auth;

class Admin {
        protected $currentDomain; // this may cause a problem
        protected $basePath;
    function __construct(){
        $auth = new Auth();
        $auth->checkAdmin();
        $this->currentDomain = CURRENT_DOMAIN;
        $this->basePath = BASE_PATH;
        }

        protected function redirect($url){
            header('location: '. trim($this->currentDomain, '/ ') .'/' . trim($url, '/ '));
            exit;
        }

        protected function redirectBack(){
            header('location: ' . $_SERVER['HTTP_REFERER']);
            exit;
        }

        protected function saveImage($image, $imagePath, $imageName = null){
            if($imageName){
                $extension = explode('/', $image['type'])[1];
                $imageName = $imageName . '.' . $extension; 
            }
            else{
                $extension = explode('/', $image['type'])[1];
                $imageName = date("Y-m-d-H-i-s") . '.' . $extension; 
            }

            $imageTemp = $image['tmp_name'];
            $imagePath = 'public/' . $imagePath . '/';

            if(move_uploaded_file($imageTemp, $imagePath . $imageName)){
                return $imagePath . $imageName;
            }
            else{
                return false;
            }

            return false;
        }

        protected function removeImage($path){
            $path = trim($this->basePath, '/ ') . '/' . trim($path, '/ ');
            if(file_exists($path)){
                unlink($path);
            }
        }
}