<?php

namespace Admin;

use database\DataBase;

class Banner extends Admin{

    public function index(){
        $db = new Database();
        $banners = $db->select('SELECT * FROM banners ORDER BY id ASC');
        require_once(BASE_PATH . '/template/admin/banners/index.php');
    }
    public function create(){
        require_once(BASE_PATH . '/template/admin/banners/create.php');
    }
    public function store($request){
        
        $db = new Database();
        $request['image'] = $this->saveImage($request['image'], 'banner-image');
        if($request['image']){
            $db->insert('banners', array_keys($request), $request);
            $this->redirect('admin/banner');
        }else{
            $this->redirect('admin/banner');
        }
    }
    public function edit($id){
        $db = new Database();
        $banner = $db->select('SELECT * FROM banners WHERE id = ?;', [$id])->fetch();
        require_once(BASE_PATH . '/template/admin/banners/edit.php');
    }
    public function update($request, $id){
        $db = new Database();

        if($request['image']['tmp_name'] != null){
            $banner = $db->select('SELECT * FROM banners WHERE id =?;', [$id])->fetch();
            $this->removeImage($banner['image']);
            $request['image'] = $this->saveImage($request['image'], 'banner-image');
        }else{
            unset($banner['image']);
        }

        $db->update('banners', $id, array_keys($request), $request);
        $this->redirect('admin/banner');
    }
   
    public function delete($id){
        $db = new Database();
        $banner = $db->select('SELECT * FROM banners WHERE id =?;', [$id])->fetch();
        $this->removeImage($banner['image']);
        $db->delete('banners', $id);
        $this->redirectBack();
    }

}