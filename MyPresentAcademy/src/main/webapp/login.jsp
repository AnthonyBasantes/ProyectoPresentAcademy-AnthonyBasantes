<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login — Present Academy</title>
  <link href="css/estilos.css" rel="stylesheet">
</head>
<body>

<div class="particles" id="particles"></div>

<header class="navbar-pa">
  <a href="index.jsp" class="logo">📘 Present<span>Academy</span></a>
  <nav>
    <a href="index.jsp">← Inicio</a>
  </nav>
</header>

<main class="form-page">
  <div class="form-card">
    <div style="font-size:2.5rem;margin-bottom:16px;">🔐</div>
    <h2>Bienvenido de vuelta</h2>
    <p class="form-sub">Inicia sesión para continuar aprendiendo.</p>

    <% if(request.getParameter("error") != null) { %>
      <div class="msg-error">⚠️ Correo, clave incorrecta o usuario bloqueado.</div>
    <% } %>
    <% if(request.getParameter("registro") != null) { %>
      <div class="msg-ok">✅ Registro exitoso. Ahora inicia sesión.</div>
    <% } %>

    <form action="LoginServlet" method="post">
      <div class="form-group">
        <label>Correo electrónico</label>
        <input type="email" name="correo" placeholder="tu@email.com" required>
      </div>
      <div class="form-group">
        <label>Contraseña</label>
        <input type="password" name="clave" placeholder="••••••••" required>
      </div>
      <button type="submit" class="btn-form">Ingresar →</button>
    </form>

    <div class="form-links">
      <p>¿No tienes cuenta? <a href="registro.jsp">Regístrate gratis</a></p>
      <p style="margin-top:10px;"><a href="index.jsp">Volver al inicio</a></p>
    </div>
  </div>
</main>

<script>
  const c = document.getElementById('particles');
  for (let i = 0; i < 25; i++) {
    const s = document.createElement('span');
    s.style.left = Math.random() * 100 + 'vw';
    s.style.animationDuration = (10 + Math.random() * 18) + 's';
    s.style.animationDelay = (Math.random() * 10) + 's';
    c.appendChild(s);
  }
</script>

</body>
</html>