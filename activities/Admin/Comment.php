<?php

namespace Admin;

use database\DataBase;

class Comment extends Admin
{
    public function index()
    {
        $db = new Database;
        $comments = $db->select('SELECT comments.*, posts.title AS title, users.username AS username FROM comments LEFT JOIN posts ON comments.post_id = posts.id LEFT JOIN users ON comments.user_id = users.id ORDER BY `id` ASC');
        $unseenComments = $db->select('SELECT * FROM comments WHERE status = ?', ['unseen']);
        foreach($unseenComments as $unseenComment){
            $db->update('comments', $unseenComment['id'], ['status'], ['seen']);
        }
        require_once(BASE_PATH . '/template/admin/comments/index.php');
    }
    public function changeStatus($id)
    {
        $db = new Database;
        $comment = $db->select('SELECT * FROM comments WHERE id = ?;', [$id])->fetch();
        if(empty($comment)){
            $this->redirectBack();
        }
        if($comment['status'] =='seen'){
            $db->update('comments', $id, ['status'], ['approved']);
        }else{
            $db->update('comments', $id, ['status'], ['seen']);
        }
        $this->redirectBack();
    }
}
