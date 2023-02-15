<?php

namespace Admin;

use database\DataBase;

class Setting extends Admin
{

    public function index()
    {
        $db = new Database();
        $setting = $db->select('SELECT * FROM setting ORDER BY id ASC')->fetch();
        require_once(BASE_PATH . '/template/admin/setting/index.php');
    }

    public function edit()
    {
        $db = new Database();
        $setting = $db->select('SELECT * FROM setting ORDER BY id ASC')->fetch();
        require_once(BASE_PATH . '/template/admin/setting/edit.php');
    }
    public function update($request)
    {
        $db = new Database();
        $setting = $db->select('SELECT * FROM setting')->fetch();
        if($request['logo']['tmp_name'] != ''){
            $request['logo'] = $this->saveImage($request['logo'], 'setting', 'logo');
        }
        else{
            unset($request['logo']);
        }
        if($request['icon']['tmp_name'] != ''){
            $this->removeImage($setting['image']);
            $request['icon'] = $this->saveImage($request['icon'], 'setting', 'icon');
        }else{
            unset($request['icon']);
        }
        if(!empty($setting)){
            $db->update('setting',$setting['id'], array_keys($request), $request);
        }else{
            $db->insert('setting', array_keys($request), $request);
        }
        $this->redirect('admin/setting');
    }
}
