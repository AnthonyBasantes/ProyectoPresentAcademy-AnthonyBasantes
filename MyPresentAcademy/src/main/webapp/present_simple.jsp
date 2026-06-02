<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Present Simple — Present Academy</title>
  <link href="css/estilos.css" rel="stylesheet">
  <style>
    .section-progress-bar {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 28px;
      padding: 14px 20px;
      background: rgba(240,165,0,0.06);
      border: 1px solid rgba(240,165,0,0.18);
      border-radius: 14px;
    }
    .section-progress-bar span { color: var(--muted); font-size: 0.82rem; white-space: nowrap; }
    .sbar { flex: 1; height: 8px; background: rgba(255,255,255,0.07); border-radius: 50px; overflow: hidden; }
    .sbar-fill { height: 100%; background: linear-gradient(90deg, #f0a500, #ffd060); border-radius: 50px; transition: width 0.6s cubic-bezier(.4,0,.2,1); }
    .sbar-pct { color: var(--gold); font-weight: 700; font-size: 0.88rem; min-width: 36px; text-align: right; }
    .content-block.done > h2::after { content: ' ✅'; font-size: 0.9rem; }
    .section-dots { display: flex; gap: 8px; margin-bottom: 18px; flex-wrap: wrap; }
    .sdot { width: 26px; height: 26px; border-radius: 50%; background: rgba(255,255,255,0.07); border: 2px solid rgba(255,255,255,0.12); display: flex; align-items: center; justify-content: center; font-size: 0.7rem; color: var(--muted); transition: background 0.3s, border-color 0.3s; }
    .sdot.active { background: rgba(240,165,0,0.25); border-color: var(--gold); color: var(--gold); font-weight: 700; }
    .sdot.done-dot { background: rgba(34,197,94,0.2); border-color: #22c55e; color: #22c55e; }
    .example-card {
      background: rgba(240,165,0,0.07);
      border: 1px solid rgba(240,165,0,0.2);
      border-radius: 14px;
      overflow: hidden;
      text-align: center;
      transition: transform 0.25s, box-shadow 0.25s;
    }
    .example-card:hover { transform: translateY(-4px); box-shadow: 0 12px 32px rgba(240,165,0,0.15); }
    .example-card img { width: 100%; height: 160px; object-fit: cover; display: block; border-bottom: 1px solid rgba(240,165,0,0.15); }
    .example-card .card-body { padding: 16px 18px; }
    .example-card strong { color: var(--gold2); font-size: 0.95rem; display: block; margin-bottom: 5px; }
    .example-card p { color: var(--muted); font-size: 0.82rem; margin: 0; }
    .model-3d-wrap {
      background: rgba(240,165,0,0.04);
      border: 1px solid rgba(240,165,0,0.15);
      border-radius: 16px;
      padding: 20px;
      margin-top: 24px;
      text-align: center;
    }
    .model-3d-wrap h3 { color: var(--gold); margin-bottom: 8px; font-size: 1rem; }
    .model-3d-wrap p { color: var(--muted); font-size: 0.85rem; margin-bottom: 14px; }
    #canvas-book { width: 100%; height: 320px; border-radius: 12px; display: block; cursor: grab; }
    #canvas-book:active { cursor: grabbing; }
    .model-hint { margin-top: 10px; color: var(--muted); font-size: 0.82rem; }
  </style>
</head>
<body>

<div class="particles" id="particles"></div>

<header class="navbar-pa">
  <a href="estudiante.jsp" class="logo">📘 Present<span>Academy</span></a>
  <nav>
    <a href="estudiante.jsp">← Volver</a>
    <button onclick="document.body.classList.toggle('dark-mode')"
      style="font-size:0.8rem;padding:6px 14px;background:none;border:1px solid rgba(255,255,255,0.15);
      color:var(--white);border-radius:50px;cursor:pointer;font-family:'Lato',sans-serif;">🌓 Contraste</button>
  </nav>
</header>

<main class="tema-page">
  <div class="tema-hero">
    <div style="font-size:3.5rem;margin-bottom:16px;">📅</div>
    <h1><span>Present</span> Simple</h1>
    <p>Rutinas, hábitos y hechos generales del inglés cotidiano.</p>
  </div>

  <div class="tema-content">

    <div class="section-progress-bar">
      <span>Tu progreso</span>
      <div class="sbar"><div class="sbar-fill" id="global-bar" style="width:0%"></div></div>
      <span class="sbar-pct" id="global-pct">0%</span>
    </div>

    <div class="section-dots">
      <div class="sdot active" id="dot-0" title="Estructura">1</div>
      <div class="sdot" id="dot-1" title="Ejemplos + Audio">2</div>
      <div class="sdot" id="dot-2" title="Reglas">3</div>
      <div class="sdot" id="dot-3" title="Video">4</div>
      <div class="sdot" id="dot-4" title="Quiz">5</div>
    </div>

    <!-- SECCIÓN 1: ESTRUCTURA -->
    <div class="content-block" id="block-0">
      <h2><span class="block-icon">📌</span> Estructura gramatical</h2>
      <div class="structure-box">
        <div class="formula">➕ Afirmativa: Subject + verb (+s/es) + complement</div>
        <div class="formula">➖ Negativa: Subject + do/does + not + verb</div>
        <div class="formula">❓ Interrogativa: Do/Does + subject + verb?</div>
      </div>
      <ul class="examples-list">
        <li><span>I / You / We / They</span> → I play soccer.</li>
        <li><span>He / She / It</span> → She plays soccer.</li>
        <li><span>Negativa</span> → He does not study.</li>
        <li><span>Pregunta</span> → Do you study English?</li>
      </ul>

      <!-- MODELO 3D: LIBRO -->
      <div class="model-3d-wrap">
        <h3>📖 Libro 3D interactivo</h3>
        <p>Arrastra para girar el libro. Representa el estudio diario del Present Simple.</p>
        <canvas id="canvas-book"></canvas>
        <p class="model-hint">🖱️ Clic y arrastra para rotar · Scroll para zoom</p>
      </div>

      <div style="margin-top:20px;text-align:right;">
        <button class="btn-primary-pa" onclick="markSection(0)" style="padding:8px 22px;font-size:0.85rem;">Marcar como leído ✓</button>
      </div>
    </div>

    <!-- SECCIÓN 2: EJEMPLOS EN CONTEXTO + AUDIO -->
    <div class="content-block" id="block-1">
      <h2><span class="block-icon">📝</span> Ejemplos en contexto</h2>
      <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:16px;margin-top:12px;margin-bottom:28px;">
        <div class="example-card">
          <img src="img/present_simple1.jpg" alt="I study English every day">
          <div class="card-body">
            <strong>I study English every day.</strong>
            <p>Rutina diaria</p>
          </div>
        </div>
        <div class="example-card">
          <img src="img/present_simple2.jpg" alt="She studies English every morning">
          <div class="card-body">
            <strong>She studies every morning.</strong>
            <p>Hábito matutino</p>
          </div>
        </div>
        <div class="example-card">
          <img src="img/present_simple3.jpg" alt="They play soccer on weekends">
          <div class="card-body">
            <strong>They play soccer on weekends.</strong>
            <p>Actividad semanal</p>
          </div>
        </div>
      </div>

      <!-- AUDIO JUSTO DESPUÉS DE LOS EJEMPLOS -->
      <div style="background:rgba(240,165,0,0.05);border:1px solid rgba(240,165,0,0.15);border-radius:16px;padding:28px;text-align:center;">
        <div style="font-size:2.5rem;margin-bottom:16px;">🎧</div>
        <p style="color:var(--muted);font-size:0.9rem;margin-bottom:6px;">Escucha estos ejemplos con pronunciación nativa</p>
        <p style="color:var(--muted);font-size:0.82rem;margin-bottom:18px;">Present Simple — Pronunciación y ejemplos</p>
        <audio controls style="width:100%;max-width:500px;accent-color:var(--gold);">
          <source src="audio/present_simple.mp3" type="audio/mpeg">
          Tu navegador no soporta audio HTML5.
        </audio>
        <p style="margin-top:14px;color:var(--muted);font-size:0.85rem;">
          💡 <strong style="color:var(--white);">Tip:</strong> Repite en voz alta cada oración para mejorar tu pronunciación.
        </p>
      </div>

      <div style="margin-top:20px;text-align:right;">
        <button class="btn-primary-pa" onclick="markSection(1)" style="padding:8px 22px;font-size:0.85rem;">Marcar como leído ✓</button>
      </div>
    </div>

    <!-- SECCIÓN 3: REGLAS -S/-ES -->
    <div class="content-block" id="block-2">
      <h2><span class="block-icon">📏</span> Reglas para He / She / It</h2>
      <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(230px,1fr));gap:14px;margin-top:8px;">
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:18px;">
          <strong style="color:var(--gold);">Regla general → agrega -s</strong>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;margin-top:8px;color:var(--white);">play → play<strong style="color:var(--gold2);">s</strong></p>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;color:var(--white);">work → work<strong style="color:var(--gold2);">s</strong></p>
        </div>
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:18px;">
          <strong style="color:var(--gold);">Termina en -ch/-sh/-x/-o → agrega -es</strong>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;margin-top:8px;color:var(--white);">watch → watch<strong style="color:var(--gold2);">es</strong></p>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;color:var(--white);">go → go<strong style="color:var(--gold2);">es</strong></p>
        </div>
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:18px;">
          <strong style="color:var(--gold);">Consonante + y → quita y, agrega -ies</strong>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;margin-top:8px;color:var(--white);">study → stud<strong style="color:var(--gold2);">ies</strong></p>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;color:var(--white);">carry → carr<strong style="color:var(--gold2);">ies</strong></p>
        </div>
      </div>
      <div style="margin-top:20px;text-align:right;">
        <button class="btn-primary-pa" onclick="markSection(2)" style="padding:8px 22px;font-size:0.85rem;">Marcar como leído ✓</button>
      </div>
    </div>

    <!-- SECCIÓN 4: VIDEO -->
    <div class="content-block" id="block-3">
      <h2><span class="block-icon">🎥</span> Video educativo</h2>
      <p style="color:var(--muted);margin-bottom:20px;">Aprende el Present Simple con explicación visual y ejemplos en contexto real.</p>
      <div class="media-wrapper">
        <iframe width="100%" height="380"
          src="https://www.youtube.com/embed/nvVdIJ0las0"
          title="Present Simple - Video educativo"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen>
        </iframe>
      </div>
      <div style="margin-top:20px;text-align:right;">
        <button class="btn-primary-pa" onclick="markSection(3)" style="padding:8px 22px;font-size:0.85rem;">Marcar como visto ✓</button>
      </div>
    </div>

    <!-- SECCIÓN 5: QUIZ -->
    <div class="content-block" id="block-4">
      <h2><span class="block-icon">🧠</span> Quiz: Present Simple</h2>
      <p style="color:var(--muted);font-size:0.9rem;margin-bottom:24px;">
        Pon a prueba tus conocimientos. 10 preguntas con retroalimentación inmediata.
      </p>
      <div class="quiz-progress">
        <div class="quiz-progress-bar" id="qbar" style="width:0%"></div>
      </div>
      <div id="quiz-body"></div>
    </div>

  </div>
</main>

<footer class="footer-pa">
  <span class="logo-f">📘 Present Academy</span>
  <p>Universidad Politécnica Salesiana · Anthony Basantes</p>
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
<script>
// ===== MODELO 3D: LIBRO =====
(function() {
  var canvas = document.getElementById('canvas-book');
  if (!canvas || typeof THREE === 'undefined') return;

  var renderer = new THREE.WebGLRenderer({ canvas: canvas, antialias: true, alpha: true });
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.shadowMap.enabled = true;

  var scene = new THREE.Scene();
  var camera = new THREE.PerspectiveCamera(45, canvas.clientWidth / canvas.clientHeight, 0.1, 100);
  camera.position.set(0, 0, 4);
  camera.lookAt(0, 0, 0);

  // Luces
  scene.add(new THREE.AmbientLight(0xffffff, 0.5));
  var dir = new THREE.DirectionalLight(0xffd060, 1.2);
  dir.position.set(3, 5, 3);
  dir.castShadow = true;
  scene.add(dir);
  var fill = new THREE.DirectionalLight(0xf0a500, 0.4);
  fill.position.set(-3, 2, -2);
  scene.add(fill);

  // Grupo libro
  var book = new THREE.Group();

  // Tapa trasera
  var coverMat = new THREE.MeshPhongMaterial({ color: 0x1a3a6b, shininess: 60 });
  var backCover = new THREE.Mesh(new THREE.BoxGeometry(2, 2.8, 0.08), coverMat);
  backCover.position.z = -0.22;
  book.add(backCover);

  // Páginas (bloque blanco)
  var pagesMat = new THREE.MeshPhongMaterial({ color: 0xf5f0e8, shininess: 20 });
  var pages = new THREE.Mesh(new THREE.BoxGeometry(1.88, 2.68, 0.36), pagesMat);
  book.add(pages);

  // Tapa delantera
  var frontCoverMat = new THREE.MeshPhongMaterial({ color: 0x1a3a6b, shininess: 60 });
  var frontCover = new THREE.Mesh(new THREE.BoxGeometry(2, 2.8, 0.08), frontCoverMat);
  frontCover.position.z = 0.22;
  book.add(frontCover);

  // Lomo
  var spineMat = new THREE.MeshPhongMaterial({ color: 0x0d2244, shininess: 40 });
  var spine = new THREE.Mesh(new THREE.BoxGeometry(0.12, 2.8, 0.52), spineMat);
  spine.position.x = -1.06;
  book.add(spine);

  // Franja dorada en tapa frontal
  var stripeMat = new THREE.MeshPhongMaterial({ color: 0xf0a500, shininess: 80 });
  var stripe = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.08, 0.02), stripeMat);
  stripe.position.set(0.1, 0.6, 0.25);
  book.add(stripe);
  var stripe2 = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.08, 0.02), stripeMat);
  stripe2.position.set(0.1, -0.6, 0.25);
  book.add(stripe2);

  // Título simulado (rectángulo)
  var titleMat = new THREE.MeshPhongMaterial({ color: 0xffd060, shininess: 100 });
  var titleRect = new THREE.Mesh(new THREE.BoxGeometry(1.4, 0.35, 0.02), titleMat);
  titleRect.position.set(0.1, 0.15, 0.25);
  book.add(titleRect);

  book.rotation.x = 0;
  book.rotation.y = 0.4;
  scene.add(book);

  // Resize
  function resize() {
    var w = canvas.parentElement.clientWidth;
    var h = 320;
    renderer.setSize(w, h);
    camera.aspect = w / h;
    camera.updateProjectionMatrix();
  }
  resize();
  window.addEventListener('resize', resize);

  // Drag to rotate
  var isDragging = false, prevX = 0, prevY = 0;
  canvas.addEventListener('mousedown', function(e) { isDragging = true; prevX = e.clientX; prevY = e.clientY; });
  window.addEventListener('mouseup', function() { isDragging = false; });
  window.addEventListener('mousemove', function(e) {
    if (!isDragging) return;
    book.rotation.y += (e.clientX - prevX) * 0.01;
    book.rotation.x += (e.clientY - prevY) * 0.005;
    prevX = e.clientX; prevY = e.clientY;
  });
  canvas.addEventListener('touchstart', function(e) { isDragging = true; prevX = e.touches[0].clientX; prevY = e.touches[0].clientY; });
  canvas.addEventListener('touchend', function() { isDragging = false; });
  canvas.addEventListener('touchmove', function(e) {
    if (!isDragging) return;
    book.rotation.y += (e.touches[0].clientX - prevX) * 0.01;
    book.rotation.x += (e.touches[0].clientY - prevY) * 0.005;
    prevX = e.touches[0].clientX; prevY = e.touches[0].clientY;
  });

  function animate() {
    requestAnimationFrame(animate);
    if (!isDragging) book.rotation.y += 0.005;
    renderer.render(scene, camera);
  }
  animate();
})();
</script>

<script>
(function() {
  var c = document.getElementById('particles');
  for (var p = 0; p < 20; p++) {
    var s = document.createElement('span');
    s.style.left = (Math.random() * 100) + 'vw';
    s.style.animationDuration = (12 + Math.random() * 18) + 's';
    s.style.animationDelay = (Math.random() * 10) + 's';
    c.appendChild(s);
  }

  var TEMA = 'present_simple';
  var TOTAL_SECTIONS = 5;

  var saved = JSON.parse(localStorage.getItem('pa_progress_' + TEMA) || '[]');
  var completedSections = new Array(TOTAL_SECTIONS).fill(false);
  saved.forEach(function(i) { completedSections[i] = true; });

  completedSections.forEach(function(done, idx) {
    if (done) {
      var block = document.getElementById('block-' + idx);
      if (block) block.classList.add('done');
      var dot = document.getElementById('dot-' + idx);
      if (dot) { dot.classList.remove('active'); dot.classList.add('done-dot'); dot.textContent = '✓'; }
    }
  });
  for (var i = 0; i < TOTAL_SECTIONS; i++) {
    if (!completedSections[i]) {
      var d = document.getElementById('dot-' + i);
      if (d && !d.classList.contains('done-dot')) d.classList.add('active');
      break;
    }
  }
  updateGlobalProgress();

  window.markSection = function(idx) {
    if (completedSections[idx]) return;
    completedSections[idx] = true;
    var block = document.getElementById('block-' + idx);
    if (block) block.classList.add('done');
    var dot = document.getElementById('dot-' + idx);
    if (dot) { dot.classList.remove('active'); dot.classList.add('done-dot'); dot.textContent = '✓'; }
    if (idx + 1 < TOTAL_SECTIONS) {
      var next = document.getElementById('dot-' + (idx + 1));
      if (next && !next.classList.contains('done-dot')) next.classList.add('active');
    }
    var donelist = completedSections.map(function(v,i){return v?i:null;}).filter(function(v){return v!==null;});
    localStorage.setItem('pa_progress_' + TEMA, JSON.stringify(donelist));
    saveGlobalProgress();
    updateGlobalProgress();
  };

  function updateGlobalProgress() {
    var done = completedSections.filter(Boolean).length;
    var pct = Math.round((done / TOTAL_SECTIONS) * 100);
    document.getElementById('global-bar').style.width = pct + '%';
    document.getElementById('global-pct').textContent = pct + '%';
  }

  function saveGlobalProgress() {
    var done = completedSections.filter(Boolean).length;
    var pct = Math.round((done / TOTAL_SECTIONS) * 100);
    localStorage.setItem('pa_gprogress_' + TEMA, pct);
  }

  var questions = [
    { q: "She _____ English every morning.", opts: ["study","studies","is studying","has studied"], correct: 1, explain: "Con He/She/It se agrega -ies al verbo: studies." },
    { q: "They _____ soccer on weekends.", opts: ["plays","playing","play","have played"], correct: 2, explain: "Con They el verbo no cambia: play." },
    { q: "I _____ English every day.", opts: ["studies","studying","study","has studied"], correct: 2, explain: "Con I el verbo no cambia: study." },
    { q: "He _____ not like coffee.", opts: ["do","does","is","are"], correct: 1, explain: "Con He/She/It se usa 'does' para la negativa." },
    { q: "_____ you speak English?", opts: ["Does","Is","Do","Are"], correct: 2, explain: "Con You usamos 'Do' para las preguntas." },
    { q: "The sun _____ in the east.", opts: ["rise","risen","is rise","rises"], correct: 3, explain: "Hecho universal + He/She/It: rises." },
    { q: "She _____ to school by bus.", opts: ["go","going","goes","have gone"], correct: 2, explain: "Con She usamos la forma con -es: goes." },
    { q: "_____ he work on Saturdays?", opts: ["Do","Is","Are","Does"], correct: 3, explain: "Con He/She/It se usa 'Does' en preguntas." },
    { q: "Water _____ at 100°C.", opts: ["boil","boiling","boils","have boiled"], correct: 2, explain: "Hecho científico + sujeto singular: boils." },
    { q: "They _____ not watch TV in the morning.", opts: ["does","is","do","are"], correct: 2, explain: "Con They se usa 'do' para la negativa." }
  ];

  var current = 0, score = 0, answered = false;

  function buildOptions(q) {
    var html = '<div class="quiz-options">';
    for (var i = 0; i < q.opts.length; i++) {
      html += '<button class="quiz-opt" onclick="quizAnswer(' + i + ')">' + q.opts[i] + '</button>';
    }
    return html + '</div>';
  }

  function renderQuestion() {
    if (current >= questions.length) { showResult(); return; }
    var q = questions[current];
    document.getElementById('qbar').style.width = ((current / questions.length) * 100) + '%';
    var isLast = (current + 1 >= questions.length);
    var html = '<div class="quiz-q-num">Pregunta ' + (current + 1) + ' de ' + questions.length + '</div>';
    html += '<div class="quiz-question">' + q.q + '</div>';
    html += buildOptions(q);
    html += '<div class="quiz-feedback" id="qfb"></div>';
    html += '<div class="quiz-nav"><span style="color:var(--muted);font-size:0.9rem;">⭐ Puntos: ' + score + '</span>';
    html += '<button class="btn-primary-pa" id="next-btn" onclick="quizNext()" style="display:none;padding:10px 28px;font-size:0.9rem;">' + (isLast ? 'Ver resultado &rarr;' : 'Siguiente &rarr;') + '</button></div>';
    document.getElementById('quiz-body').innerHTML = html;
    answered = false;
  }

  window.quizAnswer = function(idx) {
    if (answered) return;
    answered = true;
    var q = questions[current];
    var opts = document.querySelectorAll('.quiz-opt');
    for (var i = 0; i < opts.length; i++) opts[i].disabled = true;
    opts[q.correct].classList.add('correct');
    var fb = document.getElementById('qfb');
    if (idx === q.correct) {
      score++;
      fb.className = 'quiz-feedback ok show';
      fb.innerHTML = '✅ <strong>Correcto!</strong> ' + q.explain;
    } else {
      opts[idx].classList.add('wrong');
      fb.className = 'quiz-feedback fail show';
      fb.innerHTML = '❌ <strong>Incorrecto.</strong> ' + q.explain;
    }
    document.getElementById('next-btn').style.display = 'inline-flex';
  };

  window.quizNext = function() { current++; renderQuestion(); };

  function showResult() {
    document.getElementById('qbar').style.width = '100%';
    markSection(4);
    var pct = Math.round((score / questions.length) * 100);
    var medal = pct >= 80 ? '🏆' : pct >= 60 ? '🥈' : '📘';
    var msg = pct >= 80 ? 'Excelente dominio del Present Simple!' : pct >= 60 ? 'Buen trabajo. Sigue practicando.' : 'Repasa la lección e inténtalo de nuevo.';
    var html = '<div class="quiz-result"><div class="score-big">' + score + '/' + questions.length + '</div>';
    html += '<h3>' + medal + ' ' + msg + '</h3>';
    html += '<p>Obtuviste <strong style="color:var(--gold);">' + pct + '%</strong> de aciertos en Present Simple.</p>';
    html += '<div style="margin-top:24px;display:flex;gap:12px;justify-content:center;flex-wrap:wrap;">';
    html += '<button class="btn-primary-pa" onclick="quizReset()">🔄 Reintentar</button>';
    html += '<a href="estudiante.jsp" class="btn-secondary-pa">← Volver al dashboard</a></div></div>';
    document.getElementById('quiz-body').innerHTML = html;
  }

  window.quizReset = function() { current = 0; score = 0; renderQuestion(); };

  renderQuestion();
})();
</script>

</body>
</html>
