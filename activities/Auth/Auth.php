<?php

namespace Auth;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;
use database\DataBase;

class Auth
{
    protected function redirect($url)
    {
        header('Location: ' . trim(CURRENT_DOMAIN, '/ ') . '/' . trim($url, '/ '));
    }

    protected function redirectBack()
    {
        header('Location: ' . $_SERVER['HTTP_REFERER']);
    }

    private function hash($password)
    {
        $hashPassword = password_hash($password, PASSWORD_DEFAULT);
        return $hashPassword;
        
    }

    private function random()
    {
        return bin2hex(openssl_random_pseudo_bytes(32));
    }

    public function activationMessage($username, $verifyToken)
    {
        $message = ' <h1>فعال سازی حساب کاربری</h1>
        <p> عزیز برای فعال سازی حساب کاربری خود لطفا روی لینک زیر کلیک نمایید' . $username . ' </p>
        <di><a href="'. url('activation/' . $verifyToken) .'" >فعال سازی حساب کاربری</a></di>';
        return $message;
    }


    private function sendMail($emailAddress, $subject, $body)
    {
        //Create an instance; passing `true` enables exceptions
        $mail = new PHPMailer(true);

        try {
            //Server settings
            $mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
            $mail->CharSet = "UTF-8";
            $mail->isSMTP();                                            //Send using SMTP
            $mail->Host       = MAIL_HOST;                     //Set the SMTP server to send through
            $mail->SMTPAuth   = SMTP_AUTH;                                   //Enable SMTP authentication
            $mail->Username   = MAIL_USERNAME;                     //SMTP username
            $mail->Password   = MAIL_PASSWORD;                               //SMTP password
            $mail->SMTPSecure = 'tls';            //Enable implicit TLS encryption
            $mail->Port       = MAIL_PORT;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

            //Recipients
            $mail->setFrom(SENDER_MAIL, SENDER_NAME);
            $mail->addAddress($emailAddress);     //Add a recipient

            //Content
            $mail->isHTML(true);                                  //Set email format to HTML
            $mail->Subject = $subject;
            $mail->Body    = $body;

            $mail->send();
            return true;
        } catch (Exception $e) {
            echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
            return false;
        }
    }

    public function register()
    {
        require_once(BASE_PATH . '/template/auth/register.php');
    }
    public function registerStore($request)
    {
        if (empty($request['username']) || empty($request['password']) || empty($request['email'])) {
            flash('register_error', 'تمامی فیلدها الزامی می باشند');
            $this->redirectBack();
        } elseif (strlen($request['password']) < 8) {
            flash('register_error', 'رمز عبور باید بیشتر از 8 کارکتر باشد');
            $this->redirectBack();
        } elseif (!filter_var($request['email'], FILTER_VALIDATE_EMAIL)) {
            flash('register_error','ایمیل وارد شده معتبر نیست');
            $this->redirectBack();
        } else {
            $db = new DataBase();
            $user = $db->select('SELECT * FROM users WHERE email =?;', [$request['email']])->fetch();
            if ($user != null) {
                flash('register_error', 'کاربر با این مشخصات از قبل در سایت وجود دارد');
                $this->redirectBack();
            } else {
                $randomToken = $this->random();
                $activatonMessage = $this->activationMessage($request['username'], $randomToken);
                $result = $this->sendMail($request['email'], 'فعال سازی حساب کاربریی', $activatonMessage);
                if ($result) {
                    $request['verify_token'] = $randomToken;
                    $request['password'] = $this->hash($request['password']);
                    $db->insert('users', array_keys($request), $request);
                    $this->redirect('login');
                } else {
                    flash('register_error','ایمیل با موفقیت ارسال نشد');
                    $this->redirectBack();
                }
            }
        }
    }

    public function activation($verifyToken){
        $db = new Database();
        $user = $db->select("SELECT * FROM users WHERE verify_token = ? AND is_active = 0;", [$verifyToken])->fetch();
        if($user == null) {
            $this->redirect('login');
        }else{
            $result = $db->update('users', $user['id'], ['is_active'], [1]);
            $this->redirect('login');
        }
    }

    public function login(){
        require_once(BASE_PATH . '/template/auth/login.php');
    }
    public function checkLogin($request){
        if(empty($request['email']) || empty($request['password'])){
            flash('login_error','تمامی فیلدها الزامی می باشند');
            $this->redirectBack();
        }else{
            $db = new Database();
            $user = $db->select("SELECT * FROM users WHERE email = ?", [$request['email']])->fetch();

            if($user != null){
                if(password_verify($request['password'], $user['password']) && $user['is_active'] == 1){
                    $_SESSION['user'] = $user['id'];
                    $this->redirect('admin');
                }else{
                    flash('login_error','ورورد انجام نشد');
                    $this->redirectBack();
                }
            }else{
                flash('login_error','کاربری با این مشخصات یافت نشد');
                $this->redirectBack();
            }
        }
    }

    public function checkAdmin() {
        if(isset($_SESSION['user'])){
            $db = new database();
            $user = $db->select('SELECT * FROM users WHERE id = ?', [$_SESSION['user']])->fetch();
            if($user != null) {
                if($user['permission'] != 'admin'){
                    $this->redirect('home');
                }
            }else{
                $this->redirect('home');
            }
        }else{
            $this->redirect('home');
        }
    }

    public function logout(){
        if(isset($_SESSION['user'])){
            unset($_SESSION['user']);
            session_destroy();
        }
        $this->redirect('home');
    }

    public function forgot(){
        require_once(BASE_PATH . '/template/auth/forgot.php');
    }

    public function forgotMessage($username, $forgotToken)
    {
        $message = ' <h1>بازیابی رمز عبور</h1>
        <p> عزیز برای تغییر رمز عبور حساب کاربری خود لطفا روی لینک زیر کلیک نمایید' . $username . ' </p>
        <di><a href="'. url('reset-password-form/' . $forgotToken) .'" > <h3>کلیک کنید</h3> </a></di>';
        return $message;
    }

    public function forgotRequest($request){
        if(empty($request['email'])){
            flash('forgot_error','ایمیل الزامی می باشد');
            $this->redirectBack();
        }else if(!filter_var($request['email'], FILTER_VALIDATE_EMAIL)){
            flash('forgot_error','ایمیل معتبر وارد نشده');
            $this->redirectBack();
        }else{
            $db = new database();
            $user = $db->select('SELECT * FROM users WHERE email = ?', [$request['email']])->fetch();
            if($user == null){
                flash('forgot_error','کاربر با این مشخصات یافت نشد');
                $this->redirectBack();
            }else{
                $randomToken = $this->random();
                $forgotMessage = $this->forgotMessage($user['username'], $randomToken);
                $result = $this->sendMail($request['email'], 'بروووو رمزو عوض کن', $forgotMessage);
            }
            if($result){
                date_default_timezone_set('Asia/Tehran');
                $db->update('users',$user['id'], ['forgot_token', 'forgot_token_expire'], [$randomToken, date('Y-m-d H:i:s', strtotime('+ 15 minutes'))]);
                $this->redirect('login');
            }else{
                flash('forgot_error','ارسال ایمیل انجام نشد');
                $this->redirectBack();
            }
        }
    }

    public function resetPasswordView($forgot_token) {
        require_once (BASE_PATH . '/template/auth/reset-password.php');
    }
    public function resetPassword($request, $forgot_token)
    {
        if(!isset($request['password']) || strlen($request['password']) < 8)
        {
            flash('reset_error', 'رمز عبور وارد شده باید بیش از ۸ کاراکتر باشد');
            $this->redirectBack();
        }
        else{
            $db = new DataBase();
            $user = $db->select('SELECT * FROM users WHERE forgot_token = ?', [$forgot_token])->fetch();
            if($user == null)
            {
                flash('reset_error', 'کاربر یافت نشد');
                $this->redirectBack();
            }
            else{
                date_default_timezone_set('Asia/Tehran');
                if($user['forgot_token_expire'] < date('Y-m-d H:i:s'))
                {
                    flash('reset_error', 'توکن ارسال شده معتبر نمیباشد ( تاریخ به اتمام رسیده )');
                    $this->redirectBack();
                }
                elseif($user)
                {
                    $db->update('users', $user['id'], ['password'], [$this->hash($request['password'])]);
                    $this->redirect('login');
                }
                else{
                    flash('reset_error', '2کاربر یافت نشد');
                    $this->redirectBack();
                }
            }
        }
    }
}
