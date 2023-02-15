<?php




//session start
session_start();

//configuration
define('BASE_PATH',__DIR__);
define('CURRENT_DOMAIN',currentDomain() . '/project/');
define('DISPLAY_ERROR',true);
define('DB_HOST','localhost');
define('DB_NAME','project');
define('DB_USERNAME','root');
define('DB_PASSWORD','mysql');

//mail
define('MAIL_HOST','smtp.gmail.com');
define('SMTP_AUTH',true);
define('MAIL_USERNAME','firstprojectmailer@gmail.com');
define('MAIL_PASSWORD','mbqagsvkwiczdqes');
define('MAIL_PORT',587);
define('SENDER_MAIL','firstprojectmailer@gmail.com');
define('SENDER_NAME','اولین پروژه سمت سرور');




//Admin
require_once 'database/DataBase.php';
require_once 'activities/Admin/Admin.php';
require_once 'activities/Admin/Dashboard.php';
require_once 'activities/Admin/Category.php';
require_once 'activities/Admin/Post.php';
require_once 'activities/Admin/Banner.php';
require_once 'activities/Admin/User.php';
require_once 'activities/Admin/Comment.php';
require_once 'activities/Admin/Menu.php';
require_once 'activities/Admin/Setting.php';

//Auth
require_once 'activities/Auth/Auth.php';

//app
require_once 'activities/App/Home.php';


//$db = new database\Database();

spl_autoload_register(function($className){
    $path = BASE_PATH . DIRECTORY_SEPARATOR .'lib' . DIRECTORY_SEPARATOR;
    $className = str_replace('\\', DIRECTORY_SEPARATOR, $className);
    include $path . $className . '.php';
});

/* $auth = new Auth();
$auth->sendMail('firstprojectmailer@gmail.com', 'تست', '<P>test</P>'); */


function jalaliDate($date){
    return \Parsidev\Jalali\jDate::forge($date)->format('datetime');
}
/* echo jalaliDate('today');
exit; */

//routing system

// uri('admin/category', 'Category', 'index');
// uri('admin/category/store', 'Category', 'store','POST');
function uri($reservedUrl, $class, $method, $requestMethod = 'GET'){

    //current url array
    $currentUrl = explode('?',currentUrl())[0];
    $currentUrl = str_replace(CURRENT_DOMAIN, '',$currentUrl);
    $currentUrl = trim($currentUrl, '/');
    $currentUrlArray = explode('/', $currentUrl);
    $currentUrlArray = array_filter($currentUrlArray);

    //reserved url array

    $reservedUrl = trim($reservedUrl, '/');
    $reservedUrlArray = explode('/', $reservedUrl);
    $reservedUrlArray = array_filter($reservedUrlArray);

    if(sizeof($currentUrlArray) !== sizeof($reservedUrlArray) || methodField() != $requestMethod){
        return false;
    }

    $parameters =[];

    for($key = 0; $key < sizeof($reservedUrlArray); $key++) {
        if($reservedUrlArray[$key][0] == "{" && $reservedUrlArray[$key][strlen($reservedUrlArray[$key]) - 1] == "}"){
            array_push($parameters, $currentUrlArray[$key]);
        }
        elseif($currentUrlArray[$key] !== $reservedUrlArray[$key]){
            return false;
        }
    }

        if (methodField() == 'POST'){
            $request = isset($_FILES) ? array_merge($_POST, $_FILES) : $_POST;  // &request = $_POST
            $parameters = array_merge([$request], $parameters);
        }
        $object = new $class;
        call_user_func_array(array($object, $method), $parameters);
        exit();
    
}

//admin/category/edit{id} reserved url
//admin/category/edit/5  current url



//helpers
function protocol(){
    return stripos($_SERVER['SERVER_PROTOCOL'], 'https') === true ? 'https://' : 'http://';
}

function currentDomain(){
    return protocol() . $_SERVER['HTTP_HOST'];
}

function asset($src){
    $domain = trim(CURRENT_DOMAIN,'/ ');
    $src = $domain . '/' . trim($src, '/');
    return $src;
}

function url($url){
    $domain = trim(CURRENT_DOMAIN,'/ ');
    $url = $domain . '/' . trim($url, '/');
    return $url;
}

function currentUrl(){
    return currentDomain() . $_SERVER['REQUEST_URI'];
}

function methodField(){
    return $_SERVER['REQUEST_METHOD'];
}

function displayError($displayerror){
    if($displayerror){
        ini_set('display_errors', 1);
        ini_set('display_startup_errors', 1);
        error_reporting(E_ALL);
    }
    else{
        ini_set('display_errors', 0);
        ini_set('display_startup_errors', 0);
        error_reporting(0);
    }
}

displayError(DISPLAY_ERROR);

global $flashmessage;

if(isset($_SESSION['flash_message'])){
    $flashmessage = $_SESSION['flash_message'];
    unset($_SESSION['flash_message']);
}

function flash($name, $value = null){
    if($value === null){
        global $flashmessage;
        $message = isset($flashmessage[$name]) ? $flashmessage[$name] : '';
        return $message;
    }
    else{
        $_SESSION['flash_message'][$name] = $value;
    }
}
//flash('login_error', 'hiiiiii');
//echo flash('login_error');

function dd($var){
    echo '<pre>';
    var_dump($var);
    exit;
}

//dashboard
uri('admin', 'Admin\Dashboard' , 'index');


//category
uri('admin/category', 'Admin\Category' , 'index');
uri('admin/category/create', 'Admin\Category' , 'create');
uri('admin/category/store', 'Admin\Category' , 'store', 'POST');
uri('admin/category/edit/{id}', 'Admin\Category' , 'edit');
uri('admin/category/update/{id}', 'Admin\Category' , 'update','POST');
uri('admin/category/delete/{id}', 'Admin\Category' , 'delete');


//posts
uri('admin/post', 'Admin\Post', 'index');
uri('admin/post/create', 'Admin\Post' , 'create');
uri('admin/post/store', 'Admin\Post' , 'store', 'POST');
uri('admin/post/edit/{id}', 'Admin\Post' , 'edit');
uri('admin/post/update/{id}', 'Admin\Post' , 'update','POST');
uri('admin/post/delete/{id}', 'Admin\Post' , 'delete');
uri('admin/post/selected/{id}', 'Admin\Post' , 'selected');
uri('admin/post/breaking-news/{id}', 'Admin\Post' , 'breakingNews');

//banners
uri('admin/banner', 'Admin\Banner', 'index');
uri('admin/banner/create', 'Admin\Banner' , 'create');
uri('admin/banner/store', 'Admin\Banner' , 'store', 'POST');
uri('admin/banner/edit/{id}', 'Admin\Banner' , 'edit');
uri('admin/banner/update/{id}', 'Admin\Banner' , 'update','POST');
uri('admin/banner/delete/{id}', 'Admin\Banner' , 'delete');

//users
uri('admin/user', 'Admin\User', 'index');
uri('admin/user/edit/{id}', 'Admin\User' , 'edit');
uri('admin/user/update/{id}', 'Admin\User' , 'update','POST');
uri('admin/user/delete/{id}', 'Admin\User' , 'delete');
uri('admin/user/permission/{id}', 'Admin\User' , 'Permission');

//comments
uri('admin/comment', 'Admin\Comment', 'index');
uri('admin/comment/create', 'Admin\Comment' , 'create');
uri('admin/comment/store', 'Admin\Comment' , 'store', 'POST');
uri('admin/comment/change-status/{id}', 'Admin\Comment' , 'changeStatus');

//menus
uri('admin/menu', 'Admin\Menu', 'index');
uri('admin/menu/create', 'Admin\Menu' , 'create');
uri('admin/menu/store', 'Admin\Menu' , 'store', 'POST');
uri('admin/menu/edit/{id}', 'Admin\Menu' , 'edit');
uri('admin/menu/update/{id}', 'Admin\Menu' , 'update','POST');
uri('admin/menu/delete/{id}', 'Admin\Menu' , 'delete');

//setting
uri('admin/setting', 'Admin\Setting', 'index');
uri('admin/setting/edit', 'Admin\Setting' , 'edit');
uri('admin/setting/update', 'Admin\Setting' , 'update','POST');

//------------------------------------------------------


//auth

uri('register', 'Auth\Auth', 'register');
uri('register/store', 'Auth\Auth', 'registerStore','POST');
uri('activation/{verify_token}', 'Auth\Auth', 'activation');
uri('login', 'Auth\Auth', 'login');
uri('check-login', 'Auth\Auth', 'checkLogin','POST');
uri('logout', 'Auth\Auth', 'logout');
uri('forgot', 'Auth\Auth', 'forgot');
uri('forgot/request', 'Auth\Auth', 'forgotRequest','POST');
uri('reset-password-form/{forgot_token}', 'Auth\Auth', 'resetPasswordView');
uri('reset-password/{forgot_token}', 'Auth\Auth', 'resetPassword', 'POST');



//app

uri('/', 'App\Home', 'index');
uri('/home', 'App\Home', 'index');
uri('/show-post/{id}', 'App\Home', 'show');
uri('/show-category/{id}', 'App\Home', 'category');
uri('/comment-store', 'App\Home', 'commentStore', 'POST');