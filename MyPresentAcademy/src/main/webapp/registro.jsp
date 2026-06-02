<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String msgError  = (String) request.getAttribute("msgError");
  String msgExito  = (String) request.getAttribute("msgExito");
  // Repoblar campos si hubo error
  String nombre  = request.getAttribute("nombre")  != null ? (String) request.getAttribute("nombre")  : "";
  String correo  = request.getAttribute("correo")  != null ? (String) request.getAttribute("correo")  : "";
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Registro — Present Academy</title>
  <link href="css/estilos.css" rel="stylesheet">
  <style>
    /* ===== PÁGINA REGISTRO ===== */
    .register-page {
      min-height: calc(100vh - 120px);
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 40px 20px;
    }

    .register-card {
      width: 100%;
      max-width: 480px;
      background: rgba(255,255,255,0.03);
      border: 1px solid rgba(255,255,255,0.09);
      border-radius: 20px;
      padding: 40px 36px;
    }

    .register-card .card-icon {
      font-size: 2.8rem;
      text-align: center;
      margin-bottom: 10px;
    }

    .register-card h1 {
      text-align: center;
      font-size: 1.6rem;
      font-weight: 800;
      color: var(--white);
      margin-bottom: 4px;
    }

    .register-card h1 span { color: var(--gold); }

    .register-card .subtitle {
      text-align: center;
      color: var(--muted);
      font-size: 0.85rem;
      margin-bottom: 30px;
    }

    /* Grupos */
    .form-group { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }
    .form-group label {
      font-size: 0.75rem; font-weight: 700; text-transform: uppercase;
      letter-spacing: 0.05em; color: var(--muted);
    }
    .form-group input {
      background: rgba(255,255,255,0.05);
      border: 1px solid rgba(255,255,255,0.1);
      border-radius: 11px;
      padding: 12px 16px;
      color: var(--white);
      font-size: 0.9rem;
      font-family: 'Lato', sans-serif;
      outline: none;
      transition: border-color 0.2s, box-shadow 0.2s;
    }
    .form-group input:focus {
      border-color: var(--gold);
      box-shadow: 0 0 0 3px rgba(240,165,0,0.1);
    }
    .form-group input.input-error { border-color: #f87171; }
    .form-group input.input-ok    { border-color: #4ade80; }
    .form-group input::placeholder { color: rgba(255,255,255,0.22); }

    /* Indicador fuerza contraseña */
    .pwd-strength { margin-top: 6px; }
    .pwd-bar { height: 4px; border-radius: 50px; background: rgba(255,255,255,0.07); overflow: hidden; }
    .pwd-bar-fill { height: 100%; border-radius: 50px; transition: width 0.3s, background 0.3s; width: 0%; }
    .pwd-hint { font-size: 0.75rem; color: var(--muted); margin-top: 4px; }

    /* Requisitos contraseña */
    .pwd-reqs { list-style: none; padding: 0; margin: 8px 0 0; display: flex; flex-direction: column; gap: 3px; }
    .pwd-reqs li { font-size: 0.78rem; color: var(--muted); transition: color 0.2s; }
    .pwd-reqs li.ok  { color: #4ade80; }
    .pwd-reqs li.ok::before  { content: '✓ '; }
    .pwd-reqs li:not(.ok)::before { content: '○ '; }

    /* Alertas */
    .alert {
      padding: 12px 16px; border-radius: 11px; font-size: 0.87rem;
      margin-bottom: 18px; display: flex; align-items: center; gap: 8px;
    }
    .alert-ok  { background: rgba(34,197,94,0.1);  border: 1px solid rgba(34,197,94,0.3);  color: #4ade80; }
    .alert-err { background: rgba(239,68,68,0.1);  border: 1px solid rgba(239,68,68,0.3);  color: #f87171; }

    /* Botón submit */
    .btn-submit {
      width: 100%; margin-top: 8px; padding: 13px;
      font-size: 0.95rem; font-weight: 700;
    }

    /* Separador */
    .divider {
      display: flex; align-items: center; gap: 10px;
      margin: 22px 0; color: var(--muted); font-size: 0.8rem;
    }
    .divider::before, .divider::after {
      content: ''; flex: 1; height: 1px; background: rgba(255,255,255,0.08);
    }

    .login-link {
      text-align: center; font-size: 0.85rem; color: var(--muted);
    }
    .login-link a { color: var(--gold); text-decoration: none; font-weight: 700; }
    .login-link a:hover { text-decoration: underline; }

    /* Info pública para invitado */
    .info-publica {
      background: rgba(240,165,0,0.05);
      border: 1px solid rgba(240,165,0,0.15);
      border-radius: 14px;
      padding: 20px;
      margin-top: 28px;
    }
    .info-publica h3 { color: var(--gold); font-size: 0.9rem; margin-bottom: 10px; }
    .info-publica ul { padding-left: 18px; }
    .info-publica ul li { color: var(--muted); font-size: 0.83rem; margin-bottom: 5px; }

    #error-inline {
      font-size: 0.82rem; color: #f87171; margin-top: 6px; display: none;
    }
  </style>
</head>
<body>

<div class="particles" id="particles"></div>

<header class="navbar-pa">
  <a href="index.jsp" class="logo">📘 Present<span>Academy</span></a>
  <nav>
    <a href="login.jsp">Iniciar sesión</a>
  </nav>
</header>

<main class="register-page">
  <div style="width:100%;max-width:480px;">

    <!-- CARD REGISTRO -->
    <div class="register-card">
      <div class="card-icon">📝</div>
      <h1>Crear <span>cuenta</span></h1>
      <p class="subtitle">Únete a Present Academy y empieza a aprender inglés</p>

      <!-- ALERTAS DEL SERVIDOR -->
      <% if (msgError != null) { %>
        <div class="alert alert-err">❌ <%= msgError %></div>
      <% } %>
      <% if (msgExito != null) { %>
        <div class="alert alert-ok">✅ <%= msgExito %></div>
      <% } %>

      <!-- FORMULARIO -->
      <form action="RegistroServlet" method="post" onsubmit="return validarRegistro()" novalidate>

        <div class="form-group">
          <label>Nombre completo *</label>
          <input type="text" name="nombre" id="reg-nombre"
                 value="<%= nombre %>"
                 placeholder="Tu nombre completo" required autocomplete="name">
        </div>

        <div class="form-group">
          <label>Correo electrónico *</label>
          <input type="email" name="correo" id="reg-correo"
                 value="<%= correo %>"
                 placeholder="ejemplo@correo.com" required autocomplete="email"
                 oninput="validarCorreo()">
          <span id="correo-hint" style="font-size:0.75rem;color:var(--muted);margin-top:3px;"></span>
        </div>

        <div class="form-group">
          <label>Contraseña * (mín. 8 caracteres)</label>
          <input type="password" name="clave" id="reg-clave"
                 placeholder="Mínimo 8 caracteres" required autocomplete="new-password"
                 oninput="evaluarClave()">
          <!-- Barra de fuerza -->
          <div class="pwd-strength">
            <div class="pwd-bar"><div class="pwd-bar-fill" id="pwd-fill"></div></div>
            <span class="pwd-hint" id="pwd-hint-txt"></span>
          </div>
          <!-- Requisitos -->
          <ul class="pwd-reqs">
            <li id="req-len">Mínimo 8 caracteres</li>
            <li id="req-upper">Al menos una mayúscula</li>
            <li id="req-num">Al menos un número</li>
          </ul>
        </div>

        <div class="form-group">
          <label>Confirmar contraseña *</label>
          <input type="password" id="reg-clave2"
                 placeholder="Repite tu contraseña" required autocomplete="new-password"
                 oninput="verificarCoincidencia()">
          <span id="clave2-hint" style="font-size:0.75rem;margin-top:3px;"></span>
        </div>

        <div id="error-inline"></div>

        <button type="submit" class="btn-primary-pa btn-submit">
          🚀 Crear mi cuenta
        </button>
      </form>

      <div class="divider">o</div>

      <p class="login-link">
        ¿Ya tienes cuenta? <a href="login.jsp">Inicia sesión aquí</a>
      </p>
    </div>

    <!-- INFO PARA USUARIO INVITADO -->
    <div class="info-publica">
      <h3>ℹ️ Información pública (usuario invitado)</h3>
      <ul>
        <li>📧 Se requiere un <strong style="color:var(--white);">correo electrónico válido</strong> para registrarse.</li>
        <li>🔒 La <strong style="color:var(--white);">contraseña debe tener mínimo 8 caracteres</strong>.</li>
        <li>✅ Tu cuenta será revisada y aprobada por un administrador.</li>
        <li>📚 Una vez aprobado, podrás acceder a todos los temas de inglés.</li>
        <li>🆓 El registro es completamente gratuito.</li>
      </ul>
    </div>

  </div>
</main>

<footer class="footer-pa">
  <span class="logo-f">📘 Present Academy</span>
  <p>Universidad Politécnica Salesiana · Anthony Basantes</p>
</footer>

<script>
// Partículas
(function() {
  var c = document.getElementById('particles');
  for (var i = 0; i < 20; i++) {
    var s = document.createElement('span');
    s.style.left = (Math.random() * 100) + 'vw';
    s.style.animationDuration = (12 + Math.random() * 18) + 's';
    s.style.animationDelay = (Math.random() * 10) + 's';
    c.appendChild(s);
  }
})();

// ===== VALIDAR CORREO EN TIEMPO REAL =====
function validarCorreo() {
  var input  = document.getElementById('reg-correo');
  var hint   = document.getElementById('correo-hint');
  var reg    = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (input.value === '') { hint.textContent = ''; input.classList.remove('input-error','input-ok'); return; }
  if (reg.test(input.value)) {
    hint.textContent = '✓ Correo válido';
    hint.style.color = '#4ade80';
    input.classList.remove('input-error'); input.classList.add('input-ok');
  } else {
    hint.textContent = '✗ Ingresa un correo válido (ej: nombre@dominio.com)';
    hint.style.color = '#f87171';
    input.classList.remove('input-ok'); input.classList.add('input-error');
  }
}

// ===== EVALUAR FUERZA CONTRASEÑA =====
function evaluarClave() {
  var val   = document.getElementById('reg-clave').value;
  var fill  = document.getElementById('pwd-fill');
  var hint  = document.getElementById('pwd-hint-txt');

  var reqLen   = document.getElementById('req-len');
  var reqUpper = document.getElementById('req-upper');
  var reqNum   = document.getElementById('req-num');

  var tieneLen   = val.length >= 8;
  var tieneUpper = /[A-Z]/.test(val);
  var tieneNum   = /[0-9]/.test(val);

  reqLen.classList.toggle('ok',   tieneLen);
  reqUpper.classList.toggle('ok', tieneUpper);
  reqNum.classList.toggle('ok',   tieneNum);

  var puntos = (tieneLen ? 1 : 0) + (tieneUpper ? 1 : 0) + (tieneNum ? 1 : 0);

  var colores = ['#f87171','#fbbf24','#4ade80'];
  var textos  = ['Débil','Regular','Fuerte'];
  var anchos  = ['33%','66%','100%'];

  if (val.length === 0) {
    fill.style.width = '0%'; hint.textContent = ''; return;
  }
  var idx = Math.max(0, puntos - 1);
  fill.style.width      = anchos[idx];
  fill.style.background = colores[idx];
  hint.textContent      = 'Seguridad: ' + textos[idx];
  hint.style.color      = colores[idx];

  verificarCoincidencia();
}

// ===== VERIFICAR QUE LAS CLAVES COINCIDAN =====
function verificarCoincidencia() {
  var c1   = document.getElementById('reg-clave').value;
  var c2   = document.getElementById('reg-clave2').value;
  var hint = document.getElementById('clave2-hint');
  var inp2 = document.getElementById('reg-clave2');
  if (c2 === '') { hint.textContent = ''; inp2.classList.remove('input-error','input-ok'); return; }
  if (c1 === c2) {
    hint.textContent = '✓ Las contraseñas coinciden';
    hint.style.color = '#4ade80';
    inp2.classList.remove('input-error'); inp2.classList.add('input-ok');
  } else {
    hint.textContent = '✗ Las contraseñas no coinciden';
    hint.style.color = '#f87171';
    inp2.classList.remove('input-ok'); inp2.classList.add('input-error');
  }
}

// ===== VALIDACIÓN FINAL AL ENVIAR =====
function validarRegistro() {
  var errDiv  = document.getElementById('error-inline');
  var nombre  = document.getElementById('reg-nombre').value.trim();
  var correo  = document.getElementById('reg-correo').value.trim();
  var clave   = document.getElementById('reg-clave').value;
  var clave2  = document.getElementById('reg-clave2').value;
  var emailReg = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (nombre === '') {
    mostrarError(errDiv, 'El nombre es obligatorio.'); return false;
  }
  if (!emailReg.test(correo)) {
    mostrarError(errDiv, 'Ingresa un correo electrónico válido.'); return false;
  }
  if (clave.length < 8) {
    mostrarError(errDiv, 'La contraseña debe tener mínimo 8 caracteres.'); return false;
  }
  if (clave !== clave2) {
    mostrarError(errDiv, 'Las contraseñas no coinciden.'); return false;
  }

  errDiv.style.display = 'none';
  return true;
}

function mostrarError(div, msg) {
  div.textContent = '❌ ' + msg;
  div.style.display = 'block';
  div.scrollIntoView({ behavior: 'smooth', block: 'center' });
}
</script>

</body>
</html>
