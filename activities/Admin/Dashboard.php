<?php 

namespace Admin;

use database\DataBase;

class Dashboard extends Admin{

    public function index() {
        $db = new Database();
        $categoryCount = $db->select('SELECT count(*) FROM categories')->fetch();
        $userCount = $db->select('SELECT count(*) FROM users WHERE permission = "user" ')->fetch();
        $adminCount = $db->select('SELECT count(*) FROM users WHERE permission = "admin" ')->fetch();
        $postCount = $db->select('SELECT count(*) FROM posts ')->fetch();
        $postsViews = $db->select('SELECT SUM(view) FROM posts ')->fetch();
        $commentCount = $db->select('SELECT count(*) FROM comments')->fetch();
        $commentUnseenCount = $db->select('SELECT count(*) FROM comments WHERE status = "unseen"')->fetch();
        $commentApprovedCount = $db->select('SELECT count(*) FROM comments WHERE status = "approved"')->fetch();
        $mostViewedPosts = $db->select('SELECT * FROM posts ORDER BY view DESC LIMIT 0,5')->fetchAll();
        $mostCommentedPosts = $db->select('SELECT posts.*, COUNT(comments.post_id) AS comment_count FROM posts LEFT JOIN comments on posts.id = comments.post_id GROUP BY posts.id ORDER BY comment_count DESC LIMIT 0,5')->fetchAll();
        $lastComments = $db->select('SELECT comments.* , users.username FROM comments, users WHERE comments.user_id = users.id ORDER BY comments.created_at DESC LIMIT 0,5')->fetchAll();
        require_once(BASE_PATH . '/template/admin/dashboard/index.php');
    }
}

?>