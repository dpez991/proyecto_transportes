<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{SITE_TITLE}}</title>

  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="{{BASE_DIR}}/public/css/appstyle.css" />
  <script src="https://kit.fontawesome.com/{{FONT_AWESOME_KIT}}.js" crossorigin="anonymous"></script>

  {{foreach SiteLinks}}
  <link rel="stylesheet" href="{{~BASE_DIR}}/{{this}}" />
  {{endfor SiteLinks}}

  {{foreach BeginScripts}}
  <script src="{{~BASE_DIR}}/{{this}}"></script>
  {{endfor BeginScripts}}

  <style>
    header * { box-sizing: border-box; }

    header {
      background: linear-gradient(90deg, #001f3f, #003366);
      display: flex;
      align-items: center;
      height: 70px;
      padding: 0 15px;
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1001;
    }

    .nav-wrapper {
      display: flex;
      align-items: center;
      width: 100%;
      gap: 15px;
    }

    .menu_toggle_icon {
      display: block !important;
      cursor: pointer;
      margin: 0 !important;
      min-width: 30px;
    }

    .header-left {
      display: flex;
      align-items: center;
      gap: 12px;
      flex-shrink: 0;
    }

    .header-left img {
      height: 50px;
      width: auto;
      display: block;
    }

    .site-title {
      color: #fff;
      font-weight: bold;
      font-size: 1.3rem;
      white-space: nowrap;
    }

    .header-right {
      margin-left: auto;
      color: #ddd;
      font-size: 0.9rem;
      white-space: nowrap;
    }

    main {
      margin-top: 70px;
      padding: 20px;
    }

    header nav {
      background-color: #001f3f;
      top: 17px !important;
    }

    header ul li a:hover {
      background-color: #0074D9;
    }

    /* ===== FOOTER PRO EMPRESA ===== */
    footer {
      background: linear-gradient(90deg, #001f3f, #003366);
      color: #fff;
      padding: 2.5rem 1rem;
      margin-top: 2rem;
      text-align: center;
    }

    .footer-container {
      max-width: 900px;
      margin: 0 auto;
      display: flex;
      flex-direction: column;
      gap: 12px;
    }

    .footer-title {
      font-weight: 700;
      font-size: 1.1rem;
    }

    .footer-text {
      font-size: 0.9rem;
      color: #ccc;
      line-height: 1.5;
    }

    .footer-contact {
      font-size: 0.9rem;
      color: #ddd;
    }

    .footer-copy {
      margin-top: 10px;
      font-size: 0.8rem;
      color: #aaa;
    }

    #menu_toggle {
      display: none;
    }
  </style>

</head>

<body>

<header>

  <input type="checkbox" class="menu_toggle" id="menu_toggle" />

  <div class="nav-wrapper">

    <label for="menu_toggle" class="menu_toggle_icon">
      <div class="hmb dgn pt-1"></div>
      <div class="hmb hrz"></div>
      <div class="hmb dgn pt-2"></div>
    </label>

    <div class="header-left">
      <img src="{{BASE_DIR}}/public/imgs/logo_transportes_nobg.png" alt="Logo">
      <span class="site-title">{{SITE_TITLE}}</span>
    </div>

    <div class="header-right">
      {{with login}}
        <i class="fas fa-user"></i> {{userName}}
      {{endwith login}}
    </div>

  </div>

  <nav id="menu">
    <ul>

      <li>
        <a href="index.php?page={{PRIVATE_DEFAULT_CONTROLLER}}">
          <i class="fas fa-home"></i>&nbsp;Inicio
        </a>
      </li>

      {{foreach NAVIGATION}}
        <li><a href="{{nav_url}}">{{nav_label}}</a></li>
      {{endfor NAVIGATION}}

      <li>
        <a href="index.php?page=sec_logout">
          <i class="fas fa-sign-out-alt"></i>&nbsp;Salir
        </a>
      </li>

    </ul>
  </nav>

</header>

<main>
  {{{page_content}}}
</main>

<footer>

  <div class="footer-container">

    <div class="footer-title">
      Rutas del Pacífico — Sistema de Gestión Interna
    </div>

    <div class="footer-text">
      Plataforma administrativa para la gestión de rutas, usuarios y operaciones de transporte.
      Este sistema permite supervisar la operación diaria, garantizar la calidad del servicio
      y mantener el control de la información de manera segura y eficiente.
    </div>

    <div class="footer-contact">
      📍 Honduras &nbsp; | &nbsp;
      ☎ +504 9596-9558 &nbsp; | &nbsp;
      ✉ soporte@rutasdelpacifico.com
    </div>

    <div class="footer-copy">
      © {{~CURRENT_YEAR}} Rutas del Pacífico — Todos los derechos reservados
    </div>

  </div>

</footer>

{{foreach EndScripts}}
<script src="{{~BASE_DIR}}/{{this}}"></script>
{{endfor EndScripts}}

</body>
</html>