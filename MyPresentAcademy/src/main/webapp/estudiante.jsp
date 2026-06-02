<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.presentacademy.modelo.Usuario" %>
<%
  Usuario usuario = (Usuario) session.getAttribute("usuario");
  if(usuario == null){
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dashboard — Present Academy</title>
  <link href="css/estilos.css" rel="stylesheet">
  <style>
    /* ── Barras de progreso por lección ── */
    .progress-section {
      margin-top: 60px;
    }
    .prog-item {																																																																																																																																																														
      margin-bottom: 22px;
    }
    .prog-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 8px;
    }
    .prog-label {
      font-size: 0.9rem;
      color: var(--white);
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .prog-label span.icon { font-size: 1.1rem; }
    .prog-pct {
      font-size: 0.88rem;
      font-weight: 700;
      color: var(--gold);
      min-width: 42px;
      text-align: right;
    }
    .prog-bar-bg {
      background: rgba(255,255,255,0.07);
      border-radius: 50px;
      height: 10px;
      overflow: hidden;
    }
    .prog-bar-fill {
      height: 100%;
      border-radius: 50px;
      background: linear-gradient(90deg, #f0a500, #ffd060);
      transition: width 0.8s cubic-bezier(.4,0,.2,1);
    }
    .prog-bar-fill.complete {
      background: linear-gradient(90deg, #22c55e, #4ade80);
    }
    .prog-status {
      font-size: 0.78rem;
      color: var(--muted);
      margin-top: 5px;
    }
    .prog-status.done { color: #22c55e; }

    /* ── Barra de progreso total del curso ── */
    .course-progress-card {
      background: rgba(240,165,0,0.06);
      border: 1px solid rgba(240,165,0,0.2);
      border-radius: 18px;
      padding: 28px 32px;
      margin-top: 60px;
      display: flex;
      flex-direction: column;
      gap: 16px;
    }
    .course-progress-card h2 {
      margin: 0;
      font-size: 1.1rem;
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .course-total-row {
      display: flex;
      align-items: center;
      gap: 14px;
    }
    .course-total-bar {
      flex: 1;
      height: 14px;
      background: rgba(255,255,255,0.07);
      border-radius: 50px;
      overflow: hidden;
    }
    .course-total-fill {
      height: 100%;
      border-radius: 50px;
      background: linear-gradient(90deg, #f0a500, #ffd060);
      transition: width 0.9s cubic-bezier(.4,0,.2,1);
    }
    .course-total-pct {
      font-size: 1.1rem;
      font-weight: 800;
      color: var(--gold);
      min-width: 48px;
      text-align: right;
    }
    .course-msg {
      font-size: 0.88rem;
      color: var(--muted);
    }
    .course-msg strong { color: var(--white); }

    /* Reset progreso */
    .reset-btn {
      background: none;
      border: 1px solid rgba(255,255,255,0.1);
      color: var(--muted);
      font-size: 0.78rem;
      padding: 5px 14px;
      border-radius: 50px;
      cursor: pointer;
      font-family: 'Lato', sans-serif;
      transition: border-color 0.2s, color 0.2s;
    }
    .reset-btn:hover { border-color: rgba(240,165,0,0.4); color: var(--gold); }
  </style>
</head>
<body>

<div class="particles" id="particles"></div>

<header class="navbar-pa">
  <a href="estudiante.jsp" class="logo">📘 Present<span>Academy</span></a>
  <nav>
    <a href="LogoutServlet">Cerrar sesión</a>
  </nav>
</header>

<main class="dashboard">

  <!-- Bienvenida -->
  <div class="welcome-banner">
    <div>
      <h1>Hola, <span><%= usuario.getNombre() %></span> 👋</h1>
      <p>Selecciona una categoría y comienza a aprender inglés.</p>
    </div>
    <div style="display:flex;flex-direction:column;align-items:flex-end;gap:12px;">
      <div class="welcome-emoji">📘</div>
      <button class="contrast-toggle" onclick="document.body.classList.toggle('dark-mode')">
        🌓 Cambiar contraste
      </button>
    </div>
  </div>

  <!-- Categorías -->
  <span class="section-label">Elige tu lección</span>
  <h2 class="section-title" style="margin-bottom:40px;">Categorías de aprendizaje</h2>

  <div class="cards-grid">

    <div class="card-pa">
      <span class="card-icon">📅</span>
      <h3>Present Simple</h3>
      <p>Rutinas, hábitos y hechos generales. El pilar del inglés cotidiano.</p>
      <div class="card-example">She studies every morning.</div>
      <a href="InteraccionServlet?tema=Present Simple&pagina=present_simple.jsp" class="btn-card">
        Entrar a la lección →
      </a>
    </div>

    <div class="card-pa">
      <span class="card-icon">⏳</span>
      <h3>Present Continuous</h3>
      <p>Acciones que están ocurriendo en este momento. Dinámico y visual.</p>
      <div class="card-example">They are learning now.</div>
      <a href="InteraccionServlet?tema=Present Continuous&pagina=present_continuous.jsp" class="btn-card">
        Entrar a la lección →
      </a>
    </div>

    <div class="card-pa">
      <span class="card-icon">✅</span>
      <h3>Present Perfect</h3>
      <p>Experiencias y acciones recientes con impacto en el presente.</p>
      <div class="card-example">He has finished the task.</div>
      <a href="InteraccionServlet?tema=Present Perfect&pagina=present_perfect.jsp" class="btn-card">
        Entrar a la lección →
      </a>
    </div>

  </div>

  <!-- PROGRESO TOTAL DEL CURSO -->
  <div class="course-progress-card">
    <h2>
      <span class="block-icon">🎓</span>
      Progreso total del curso
      <button class="reset-btn" onclick="resetProgress()" style="margin-left:auto;">🔄 Reiniciar</button>
    </h2>
    <div class="course-total-row">
      <div class="course-total-bar">
        <div class="course-total-fill" id="course-total-fill" style="width:0%"></div>
      </div>
      <span class="course-total-pct" id="course-total-pct">0%</span>
    </div>
    <p class="course-msg" id="course-msg">Comienza una lección para registrar tu avance.</p>
  </div>

  <!-- PROGRESO POR LECCIÓN -->
  <div class="content-block progress-section">
    <h2>
      <span class="block-icon">📊</span>
      Tu progreso por lección
    </h2>

    <div style="margin-top:20px;">

      <!-- Present Simple -->
      <div class="prog-item">
        <div class="prog-header">
          <span class="prog-label"><span class="icon">📅</span> Present Simple</span>
          <span class="prog-pct" id="pct-simple">0%</span>
        </div>
        <div class="prog-bar-bg">
          <div class="prog-bar-fill" id="bar-simple" style="width:0%"></div>
        </div>
        <p class="prog-status" id="status-simple">Sin iniciar</p>
      </div>

      <!-- Present Continuous -->
      <div class="prog-item">
        <div class="prog-header">
          <span class="prog-label"><span class="icon">⏳</span> Present Continuous</span>
          <span class="prog-pct" id="pct-continuous">0%</span>
        </div>
        <div class="prog-bar-bg">
          <div class="prog-bar-fill" id="bar-continuous" style="width:0%"></div>
        </div>
        <p class="prog-status" id="status-continuous">Sin iniciar</p>
      </div>

      <!-- Present Perfect -->
      <div class="prog-item">
        <div class="prog-header">
          <span class="prog-label"><span class="icon">✅</span> Present Perfect</span>
          <span class="prog-pct" id="pct-perfect">0%</span>
        </div>
        <div class="prog-bar-bg">
          <div class="prog-bar-fill" id="bar-perfect" style="width:0%"></div>
        </div>
        <p class="prog-status" id="status-perfect">Sin iniciar</p>
      </div>

    </div>
  </div>

</main>

<footer class="footer-pa" style="margin-top:80px;">
  <span class="logo-f">📘 Present Academy</span>
  <p>Universidad Politécnica Salesiana · Anthony Basantes</p>
</footer>

<script>
  // Partículas
  const pc = document.getElementById('particles');
  for (let i = 0; i < 30; i++) {
    const s = document.createElement('span');
    s.style.left = Math.random() * 100 + 'vw';
    s.style.animationDuration = (10 + Math.random() * 18) + 's';
    s.style.animationDelay = (Math.random() * 12) + 's';
    pc.appendChild(s);
  }

  // ── Leer progreso guardado por cada lección ──
  const TEMAS = [
    { key: 'present_simple',     barId: 'bar-simple',     pctId: 'pct-simple',     statusId: 'status-simple'     },
    { key: 'present_continuous', barId: 'bar-continuous', pctId: 'pct-continuous', statusId: 'status-continuous' },
    { key: 'present_perfect',    barId: 'bar-perfect',    pctId: 'pct-perfect',    statusId: 'status-perfect'    }
  ];

  function getStatus(pct) {
    if (pct === 0)   return { text: 'Sin iniciar', done: false };
    if (pct < 100)   return { text: 'En progreso — ' + pct + '% completado', done: false };
    return { text: '¡Lección completada! 🎉', done: true };
  }

  function getCourseMsg(pct) {
    if (pct === 0)   return 'Comienza una lección para registrar tu avance.';
    if (pct < 34)    return '<strong>¡Buen comienzo!</strong> Sigue así, vas progresando.';
    if (pct < 67)    return '<strong>¡Excelente!</strong> Llevas más de la mitad del curso.';
    if (pct < 100)   return '<strong>¡Casi lo logras!</strong> Estás muy cerca de completar todo.';
    return '<strong>🏆 ¡Felicitaciones!</strong> Completaste el 100% del curso.';
  }

  function loadProgress() {
    let total = 0;
    TEMAS.forEach(function(t) {
      // Primero intentamos leer desde pa_gprogress_ (guardado por cada lección)
      // Fallback: calcular desde pa_progress_
      let pct = 0;
      const gp = localStorage.getItem('pa_gprogress_' + t.key);
      if (gp !== null) {
        pct = parseInt(gp, 10) || 0;
      } else {
        const saved = JSON.parse(localStorage.getItem('pa_progress_' + t.key) || '[]');
        pct = Math.round((saved.length / 5) * 100);
      }

      total += pct;

      const bar = document.getElementById(t.barId);
      const pctEl = document.getElementById(t.pctId);
      const statusEl = document.getElementById(t.statusId);
      const st = getStatus(pct);

      bar.style.width = pct + '%';
      if (pct === 100) bar.classList.add('complete');
      else bar.classList.remove('complete');
      pctEl.textContent = pct + '%';
      statusEl.textContent = st.text;
      if (st.done) statusEl.classList.add('done');
      else statusEl.classList.remove('done');
    });

    // Promedio del curso (3 lecciones)
    const coursePct = Math.round(total / TEMAS.length);
    document.getElementById('course-total-fill').style.width = coursePct + '%';
    document.getElementById('course-total-pct').textContent = coursePct + '%';
    document.getElementById('course-msg').innerHTML = getCourseMsg(coursePct);
    if (coursePct === 100) {
      document.getElementById('course-total-fill').style.background = 'linear-gradient(90deg,#22c55e,#4ade80)';
    }
  }

  function resetProgress() {
    if (!confirm('¿Seguro que deseas reiniciar todo tu progreso? Esta acción no se puede deshacer.')) return;
    TEMAS.forEach(function(t) {
      localStorage.removeItem('pa_progress_' + t.key);
      localStorage.removeItem('pa_gprogress_' + t.key);
    });
    loadProgress();
  }

  // Cargar al iniciar
  loadProgress();

  // Actualizar cada vez que se regresa a la página (visibilitychange)
  document.addEventListener('visibilitychange', function() {
    if (!document.hidden) loadProgress();
  });
</script>

</body>
</html>
