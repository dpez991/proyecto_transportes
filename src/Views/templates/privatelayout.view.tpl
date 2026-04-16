<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{SITE_TITLE}}</title>

  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="{{BASE_DIR}}/public/css/appstyle.css" />
  
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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

<div class="header-right" style="display: flex; align-items: center;">
    <a href="index.php?page=Checkout_Checkout" 
       style="display: flex !important; align-items: center; justify-content: center; color: #ffffff !important; text-decoration: none; margin-right: 30px; position: relative; width: 40px; height: 40px;">
        
        <i class="fas fa-shopping-cart" 
           style="font-family: 'Font Awesome 5 Free' !important; font-weight: 900 !important; font-size: 22px !important; color: white !important; display: inline-block !important; visibility: visible !important;"></i>
        
        {{if CART_COUNT}}
        <span style="position: absolute; top: 0px; right: -5px; background-color: #ff4757; color: white; border-radius: 50%; min-width: 18px; height: 18px; padding: 2px; font-size: 11px; text-align: center; font-weight: bold; line-height: 14px; border: 2px solid #001f3f; display: flex; align-items: center; justify-content: center; z-index: 10;">
            {{CART_COUNT}}
        </span>
        {{endif CART_COUNT}}
    </a>

    {{with login}}
<a href="index.php?page=Private_MiPerfil" 
   style="display: flex; align-items: center; gap: 8px; color: white; font-weight: bold; text-decoration: none;">
    
    <i class="fas fa-user" style="font-size: 18px;"></i>
    <span class="user-name">{{userName}}</span>

</a>
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