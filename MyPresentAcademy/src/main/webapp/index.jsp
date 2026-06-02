<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Present Academy — Aprende Inglés</title>
  <link href="css/estilos.css" rel="stylesheet">
</head>
<body>

<!-- Partículas de fondo -->
<div class="particles" id="particles"></div>

<!-- NAVBAR -->
<header class="navbar-pa">
  <a href="index.jsp" class="logo">📘 Present<span>Academy</span></a>
  <nav>
    <a href="index.jsp">Inicio</a>
    <a href="#categorias">Categorías</a>
    <a href="#recursos">Recursos</a>
    <a href="login.jsp" class="btn-nav">Iniciar sesión</a>
  </nav>
</header>

<!-- HERO -->
<section class="hero">
  <div class="hero-content">
    <div class="hero-badge">🎓 ODS 4 · Educación de Calidad</div>
    <h1>Domina el inglés<br>con <em>Present Academy</em></h1>
    <p>Aprende los tres tiempos presentes del inglés con recursos interactivos: audio, video, modelos 3D y quizzes.</p>
    <div class="hero-btns">
      <a href="registro.jsp" class="btn-primary-pa">Comenzar gratis →</a>
      <a href="login.jsp" class="btn-secondary-pa">Ya tengo cuenta</a>
    </div>
    <div class="hero-stats">
      <div class="stat-card">
        <div class="num">3</div>
        <div class="label">Categorías</div>
      </div>
      <div class="stat-card">
        <div class="num">100%</div>
        <div class="label">Interactivo</div>
      </div>
      <div class="stat-card">
        <div class="num">🆓</div>
        <div class="label">Gratuito</div>
      </div>
    </div>
  </div>
</section>

<!-- CATEGORÍAS -->
<section class="section" id="categorias">
  <div class="section-inner">
    <span class="section-label">Contenido principal</span>
    <h2 class="section-title">Tres tiempos presentes<br>del inglés</h2>
    <p class="section-sub">Cada categoría incluye teoría, ejemplos, multimedia y un quiz de práctica.</p>

    <div class="cards-grid">
      <div class="card-pa">
        <span class="card-icon">📅</span>
        <h3>Present Simple</h3>
        <p>Rutinas, hábitos y hechos generales. El tiempo verbal más utilizado.</p>
        <div class="card-example">I study English every day.</div>
        <a href="login.jsp" class="btn-card">Explorar →</a>
      </div>

      <div class="card-pa">
        <span class="card-icon">⏳</span>
        <h3>Present Continuous</h3>
        <p>Acciones que están ocurriendo en este preciso momento.</p>
        <div class="card-example">I am studying English now.</div>
        <a href="login.jsp" class="btn-card">Explorar →</a>
      </div>

      <div class="card-pa">
        <span class="card-icon">✅</span>
        <h3>Present Perfect</h3>
        <p>Experiencias pasadas con resultado o relevancia en el presente.</p>
        <div class="card-example">I have studied English.</div>
        <a href="login.jsp" class="btn-card">Explorar →</a>
      </div>
    </div>
  </div>
</section>

<!-- RECURSOS -->
<section class="section" id="recursos"
  style="background: linear-gradient(rgba(255,255,255,0.02), transparent);">
  <div class="section-inner">
    <span class="section-label">Metodología</span>
    <h2 class="section-title">Recursos interactivos</h2>
    <p class="section-sub">Aprendizaje multimodal para todos los estilos de aprendizaje.</p>

    <div class="recursos-grid">
      <div class="recurso-card">
        <span class="r-icon">🎧</span>
        <h4>Audio</h4>
        <p>Pronunciación nativa del vocabulario y oraciones.</p>
      </div>
      <div class="recurso-card">
        <span class="r-icon">🎥</span>
        <h4>Video</h4>
        <p>Explicaciones visuales con ejemplos en contexto.</p>
      </div>
      <div class="recurso-card">
        <span class="r-icon">🧊</span>
        <h4>Modelo 3D</h4>
        <p>Interacción tridimensional para aprendizaje inmersivo.</p>
      </div>
      <div class="recurso-card">
        <span class="r-icon">🧠</span>
        <h4>Quiz</h4>
        <p>Evalúa tu progreso con preguntas interactivas.</p>
      </div>
      <div class="recurso-card">
        <span class="r-icon">♿</span>
        <h4>Accesibilidad</h4>
        <p>Modo alto contraste para mejor legibilidad.</p>
      </div>
    </div>
  </div>
</section>

<!-- ODS -->
<section class="section">
  <div class="section-inner">
    <div class="ods-banner">
      <div style="font-size:3rem;margin-bottom:16px;">🌍</div>
      <h2>ODS 4 — Educación de Calidad</h2>
      <p>Present Academy promueve el aprendizaje inclusivo del inglés mediante tecnología educativa, recursos digitales accesibles y contenido interactivo para todos.</p>
      <div style="margin-top:32px;">
        <a href="registro.jsp" class="btn-primary-pa">Únete ahora →</a>
      </div>
    </div>
  </div>
</section>

<!-- FOOTER -->
<footer class="footer-pa">
  <span class="logo-f">📘 Present Academy</span>
  <p>Proyecto Educativo Interactivo · Anthony Basantes</p>
  <p style="margin-top:6px;">Universidad Politécnica Salesiana</p>
</footer>

<script>
  // Generar partículas
  const container = document.getElementById('particles');
  for (let i = 0; i < 40; i++) {
    const s = document.createElement('span');
    s.style.left = Math.random() * 100 + 'vw';
    s.style.animationDuration = (8 + Math.random() * 20) + 's';
    s.style.animationDelay = (Math.random() * 15) + 's';
    s.style.width = s.style.height = (2 + Math.random() * 3) + 'px';
    container.appendChild(s);
  }

  // Scroll reveal suave
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.style.opacity = '1';
        e.target.style.transform = 'translateY(0)';
      }
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.card-pa, .recurso-card').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(30px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(el);
  });
</script>

</body>
</html>