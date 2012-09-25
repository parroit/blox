package code;

class Mailer {
	
	public static function send(from, to, subject, message) {
		var cfg = code.Config.vars.mailer;
		
            untyped __php__("
                  require('phpmailer/class.phpmailer.php');
                  $mail = new PHPMailer();
                  $mail->IsSMTP();
                  $mail->Hostname=  $cfg->Hostname;
                  $mail->SMTPAuth = $cfg->SMTPAuth; 
                  $mail->Username = $cfg->Username;
                  $mail->Password = $cfg->Password;
                  
                  
                 
                  $mail->From = $from;
                  $mail->FromName = $from;
                  $mail->AddAddress($to,$to);
                  $mail->WordWrap = 50;
                  $mail->IsHTML(true); 
                  $mail->Subject = $subject;
                  $mail->Body = $message;
                  
                  $mail->Send();
            ");
        
	}
	
}
