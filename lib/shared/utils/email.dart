import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Email {



  static sendLinkToEmail({required String email, required String token}) async {
    final smtpServer = SmtpServer('mail.csdnapps.com',
        port: 465, password: 'Cevs150289\$', ssl: true, username: 'app_agendi@csdnapps.com');

    final message = Message()
      ..from = Address('app_agendi@csdnapps.com', 'Agendi')
      ..recipients.add(email)
      ..subject = 'Link de ativação de conta'
      ..html = '''<html>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<style>
		.text{
			font-family: 'Arial'
		}
	</style>
	<div class="text"> Olá </div>
	</br>

	<div class="text"> Segue o link de ativação da conta no aplicativo agendi. Caso não tenha solicitado esse e-mail, por favor desconsiderar </div>
	</br>
	<a href="www.csdnapps.com/apps/agendi/index.php?t=$token" class="text">Clique aqui para ativar</a>
</html>''';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

  }

   static sendInfoResetPassword({required String email, required String newPassword}) async {
    final smtpServer = SmtpServer('mail.csdnapps.com',
        port: 465, password: 'Cevs150289\$', ssl: true, username: 'app_agendi@csdnapps.com');

    final message = Message()
      ..from = Address('app_agendi@csdnapps.com', 'Agendi')
      ..recipients.add(email)
      ..subject = 'Nova senha de acesso ao app agendi'
      ..html = '''<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<style>
		.text{
			font-family: 'Arial'
		}
    .pass{
	  font-family: 'Arial';
      background-color: #B4BCBF;
      font-weight: 600;
      padding: 10px;
	  border-radius: 5px;
	  text-align: center
		}
	</style>
	<div class="text"> Olá </div>
	</br>

	<div class="text"> Essa é sua nova senha de acesso ao app agendi: </div>
	</br>
	<div class="pass">
    $newPassword
  </div>
</html>''';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

  }
}
