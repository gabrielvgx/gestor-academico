<?php

namespace App\Template;

class Mail {
  static function getLogoImg() {
    $dirSep = DIRECTORY_SEPARATOR;
    return [
      'path' => __DIR__ . $dirSep . 'school.jpg',
      'name' => 'school',
    ];
  }
  static function getOneTimePassword($otpValue, $messages = []) {
    $title = $messages['title'] ?? "Código de verificação";
    $expirationMsg = $messages['expirationMsg'] ?? "Válido por 5 (cinco) minutos";
    $descriptionMsg = $messages['description'] ?? "Este é o código para verificar o seu usuário no Gestor Acadêmico.";
    $logo = '<img width="30" src="cid:school" style="margin-right: 10px">';
    $disclamerMsg = "
    O código é único e válido para uma única entrada. Não entramos em contato com você por telefone, SMS ou Whatsapp.
    Para deixar sua conta ainda mais segura, não compartilhe o código com outra pessoa.";
    return "
    <div style='background-color: #fafafa'>
      <div style='margin: 0px auto; max-width: 600px; background: #ffffff'>
        <div>
          <div
            style='
              max-width: 300px;
              margin: auto;
              margin-bottom: 32px;
              margin-top: 32px;
            '
          >
            <table>
              <tr>
                  <td>
                    {$logo}
                  </td>
                  <td>
                      <span
                  style='font-family: Roboto, sans-serif; font-size: 28px; font-weight: 700;'>
                  Gestor Acadêmico
              </span>
                  </td>
              </tr>
            </table>
          </div>
        </div>
        <div
          style='background-color: #3953a4; padding: 32px; text-align: center; color: #fafafa; font-weight: 600; font-family: \"Open Sans\", sans-serif;'
        >
          <span
            style='
              color: #fafafa;
              text-align: center;
              font-family: \"Open Sans\", sans-serif;
              font-size: 20px;
              font-weight: 600;
              line-height: 30px;
              text-align: center;
            '
            >{$title}</span
          >
        </div>
        <div
          style='
            color: #323232;
            font-family: sans-serif;
            font-size: 13px;
            font-weight: normal;
            line-height: 23.4px;
            text-align: center;
            padding: 32px;
          '
        >
          <span>{$descriptionMsg}<br />
            <strong>{$expirationMsg}</strong>
          </span>
        </div>
        <div
          style='text-align: center; padding: 32px; background-color: #fafafa'
        >
          <span
            style='
              text-decoration: none;
              text-align: center;
              color: #000000;
              font-family: Roboto, sans-serif;
              font-size: 32px;
              font-weight: 700;
              line-height: 120%;
              text-transform: none;
              margin: 0px;
              letter-spacing: 16px;
            '
            >{$otpValue}</span
          >
        </div>
        <div
          style='
            color: #323232;
            font-family: 'Open Sans', sans-serif;
            font-size: 13px;
            font-weight: normal;
            line-height: 23.4px;
            text-align: left;
            padding: 16px;
          '
        >
          <p style='margin: 0'>
            <span style='color: #525252; text-align: justify'
              ><strong>Importante:</strong> {$disclamerMsg}</span
            >
          </p>
        </div>
      </div>
    </div>
    ";
  }

  static function getWelcome($token) {
    $loginPage = $_ENV['LOGIN_PAGE_URL'] . "?auth=$token";
    $logo = '<img width="30" src="cid:school" style="margin-right: 10px">';
    $disclamerMsg = "Este link de acesso é único e válido para uma única entrada. Não entramos em contato com você por telefone, SMS ou Whatsapp.
    Para deixar sua conta ainda mais segura, não compartilhe este e-mail ou senha da plataforma com outra pessoa.";
    return "
      <div style='background-color: #fafafa'>
        <div style='margin: 0px auto; max-width: 600px; background: #ffffff'>
          <div>
            <div
              style='
                max-width: 300px;
                margin: auto;
                margin-bottom: 32px;
                margin-top: 32px;
              '
            >
              <table>
                <tr>
                    <td>
                      {$logo}
                    </td>
                    <td>
                        <span
                    style='font-family: Roboto, sans-serif; font-size: 28px; font-weight: 700;'>
                    Gestor Acadêmico
                </span>
                    </td>
                </tr>
              </table>
            </div>
          </div>
          <div
            style='background-color: #3953a4; padding: 32px; text-align: center; color: #fafafa; font-weight: 600; font-family: \"Open Sans\", sans-serif;'
          >
            <span
              style='
                color: #fafafa;
                text-align: center;
                font-family: \"Open Sans\", sans-serif;
                font-size: 20px;
                font-weight: 600;
                line-height: 30px;
                text-align: center;
              '
              >Bem vindo</span
            >
          </div>
          <div
            style='
              color: #323232;
              font-family: sans-serif;
              font-size: 13px;
              font-weight: normal;
              line-height: 23.4px;
              text-align: center;
              padding: 32px;
            '
          >
            <span>
              Olá! Seja bem vindo ao <strong>Gestor Acadêmico</strong>. Uma plataforma para auxiliar sua rotina escolar diária. Para concluir seu cadastro na plataforma clique no botão abaixo<br />
            </span>
          </div>
          <div style='margin: auto; width: 165px'>
            <a href='$loginPage' target=\"_blank\" rel=\"noreferrer\"
                style='text-align: center; padding: 12px; text-decoration: none; border-radius: 4px;
                background-color: #3953a4; color: #fafafa; font-weight: 600; font-family: \"Open Sans\", sans-serif;
                '
            >
            Concluir cadastro
            </a>
            </div>
          <div
            style='
              color: #323232;
              font-family: \"Open Sans\", sans-serif;
              font-size: 13px;
              font-weight: normal;
              line-height: 23.4px;
              text-align: left;
              padding: 16px;
            '
          >
            <p style='margin: 0'>
              <span style='color: #525252; text-align: justify'
                ><strong>Importante:</strong> {$disclamerMsg}</span
              >
            </p>
          </div>
        </div>
      </div>
    ";
  }
}
