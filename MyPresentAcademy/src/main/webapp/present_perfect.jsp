<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Present Perfect — Present Academy</title>
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
    #canvas-pencil { width: 100%; height: 320px; border-radius: 12px; display: block; cursor: grab; }
    #canvas-pencil:active { cursor: grabbing; }
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
    <div style="font-size:3.5rem;margin-bottom:16px;">✅</div>
    <h1><span>Present</span> Perfect</h1>
    <p>Experiencias y acciones con resultado en el presente.</p>
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
      <div class="sdot" id="dot-2" title="Signal Words">3</div>
      <div class="sdot" id="dot-3" title="Video">4</div>
      <div class="sdot" id="dot-4" title="Quiz">5</div>
    </div>

    <!-- SECCIÓN 1: ESTRUCTURA -->
    <div class="content-block" id="block-0">
      <h2><span class="block-icon">📌</span> Estructura gramatical</h2>
      <div class="structure-box">
        <div class="formula">➕ Afirmativa: Subject + have/has + past participle + complement</div>
        <div class="formula">➖ Negativa: Subject + have/has + not + past participle</div>
        <div class="formula">❓ Interrogativa: Have/Has + subject + past participle?</div>
      </div>
      <ul class="examples-list">
        <li><span>I / You / We / They have</span> → I have studied English.</li>
        <li><span>He / She / It has</span> → She has visited Quito.</li>
        <li><span>Negativa</span> → They have not finished yet.</li>
        <li><span>Pregunta</span> → Has he completed the activity?</li>
      </ul>

      <!-- MODELO 3D: LÁPIZ -->
      <div class="model-3d-wrap">
        <h3>✏️ Lápiz 3D interactivo</h3>
        <p>El lápiz representa el conocimiento adquirido. Gíralo mientras estudias el Present Perfect.</p>
        <canvas id="canvas-pencil"></canvas>
        <p class="model-hint">🖱️ Clic y arrastra para rotar · Scroll para zoom</p>
      </div>

      <div style="margin-top:20px;text-align:right;">
        <button class="btn-primary-pa" onclick="markSection(0)" style="padding:8px 22px;font-size:0.85rem;">Marcar como leído ✓</button>
      </div>
    </div>

    <!-- SECCIÓN 2: EJEMPLOS + AUDIO -->
    <div class="content-block" id="block-1">
      <h2><span class="block-icon">📝</span> Ejemplos en contexto</h2>
      <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:16px;margin-top:12px;margin-bottom:28px;">
        <div class="example-card">
          <img src="img/present_perfect1.jpg" alt="I have learned new verbs">
          <div class="card-body">
            <strong>I have learned new verbs.</strong>
            <p>Experiencia adquirida</p>
          </div>
        </div>
        <div class="example-card">
          <img src="img/present_perfect2.jpg" alt="He has finished the lesson">
          <div class="card-body">
            <strong>He has finished the lesson.</strong>
            <p>Acción reciente</p>
          </div>
        </div>
        <div class="example-card">
          <img src="img/present_perfect3.jpg" alt="They have completed it">
          <div class="card-body">
            <strong>They have completed it.</strong>
            <p>Resultado en el presente</p>
          </div>
        </div>
      </div>

      <!-- AUDIO JUSTO DESPUÉS DE LOS EJEMPLOS -->
      <div style="background:rgba(240,165,0,0.05);border:1px solid rgba(240,165,0,0.15);border-radius:16px;padding:28px;text-align:center;">
        <div style="font-size:2.5rem;margin-bottom:16px;">🎧</div>
        <p style="color:var(--muted);font-size:0.9rem;margin-bottom:6px;">Escucha estos ejemplos con pronunciación nativa</p>
        <p style="color:var(--muted);font-size:0.82rem;margin-bottom:18px;">Present Perfect — Pronunciación y ejemplos</p>
        <audio controls style="width:100%;max-width:500px;accent-color:var(--gold);">
          <source src="audio/present_perfect.mp3" type="audio/mpeg">
          Tu navegador no soporta audio HTML5.
        </audio>
        <p style="margin-top:14px;color:var(--muted);font-size:0.85rem;">
          💡 <strong style="color:var(--white);">Tip:</strong> Presta atención a la diferencia entre have y has según el sujeto.
        </p>
      </div>

      <div style="margin-top:20px;text-align:right;">
        <button class="btn-primary-pa" onclick="markSection(1)" style="padding:8px 22px;font-size:0.85rem;">Marcar como leído ✓</button>
      </div>
    </div>

    <!-- SECCIÓN 3: SIGNAL WORDS -->
    <div class="content-block" id="block-2">
      <h2><span class="block-icon">🔑</span> Palabras clave (signal words)</h2>
      <p style="color:var(--muted);margin-bottom:16px;font-size:0.9rem;">
        Estas palabras son señales de que debes usar Present Perfect:
      </p>
      <div style="display:flex;flex-wrap:wrap;gap:12px;">
        <span style="background:rgba(240,165,0,0.1);border:1px solid rgba(240,165,0,0.3);color:var(--gold2);padding:7px 18px;border-radius:50px;font-family:'Courier New',monospace;font-size:0.9rem;">already</span>
        <span style="background:rgba(240,165,0,0.1);border:1px solid rgba(240,165,0,0.3);color:var(--gold2);padding:7px 18px;border-radius:50px;font-family:'Courier New',monospace;font-size:0.9rem;">yet</span>
        <span style="background:rgba(240,165,0,0.1);border:1px solid rgba(240,165,0,0.3);color:var(--gold2);padding:7px 18px;border-radius:50px;font-family:'Courier New',monospace;font-size:0.9rem;">just</span>
        <span style="background:rgba(240,165,0,0.1);border:1px solid rgba(240,165,0,0.3);color:var(--gold2);padding:7px 18px;border-radius:50px;font-family:'Courier New',monospace;font-size:0.9rem;">ever</span>
        <span style="background:rgba(240,165,0,0.1);border:1px solid rgba(240,165,0,0.3);color:var(--gold2);padding:7px 18px;border-radius:50px;font-family:'Courier New',monospace;font-size:0.9rem;">never</span>
        <span style="background:rgba(240,165,0,0.1);border:1px solid rgba(240,165,0,0.3);color:var(--gold2);padding:7px 18px;border-radius:50px;font-family:'Courier New',monospace;font-size:0.9rem;">recently</span>
        <span style="background:rgba(240,165,0,0.1);border:1px solid rgba(240,165,0,0.3);color:var(--gold2);padding:7px 18px;border-radius:50px;font-family:'Courier New',monospace;font-size:0.9rem;">since</span>
        <span style="background:rgba(240,165,0,0.1);border:1px solid rgba(240,165,0,0.3);color:var(--gold2);padding:7px 18px;border-radius:50px;font-family:'Courier New',monospace;font-size:0.9rem;">for</span>
        <span style="background:rgba(240,165,0,0.1);border:1px solid rgba(240,165,0,0.3);color:var(--gold2);padding:7px 18px;border-radius:50px;font-family:'Courier New',monospace;font-size:0.9rem;">so far</span>
        <span style="background:rgba(240,165,0,0.1);border:1px solid rgba(240,165,0,0.3);color:var(--gold2);padding:7px 18px;border-radius:50px;font-family:'Courier New',monospace;font-size:0.9rem;">lately</span>
      </div>
      <div style="margin-top:24px;display:grid;grid-template-columns:1fr 1fr;gap:14px;">
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:18px;">
          <strong style="color:var(--gold);">SINCE → punto de inicio</strong>
          <p style="color:var(--muted);font-size:0.85rem;margin:8px 0 4px;">Fecha o momento específico</p>
          <p style="font-family:'Courier New',monospace;font-size:0.85rem;color:var(--white);">since 2015</p>
          <p style="font-family:'Courier New',monospace;font-size:0.85rem;color:var(--white);">since Monday</p>
          <p style="font-family:'Courier New',monospace;font-size:0.85rem;color:var(--white);">since I was a child</p>
        </div>
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:18px;">
          <strong style="color:var(--gold);">FOR → duración</strong>
          <p style="color:var(--muted);font-size:0.85rem;margin:8px 0 4px;">Periodo de tiempo</p>
          <p style="font-family:'Courier New',monospace;font-size:0.85rem;color:var(--white);">for 3 years</p>
          <p style="font-family:'Courier New',monospace;font-size:0.85rem;color:var(--white);">for two weeks</p>
          <p style="font-family:'Courier New',monospace;font-size:0.85rem;color:var(--white);">for a long time</p>
        </div>
      </div>
      <div style="margin-top:20px;text-align:right;">
        <button class="btn-primary-pa" onclick="markSection(2)" style="padding:8px 22px;font-size:0.85rem;">Marcar como leído ✓</button>
      </div>
    </div>

    <!-- SECCIÓN 4: VIDEO -->
    <div class="content-block" id="block-3">
      <h2><span class="block-icon">🎥</span> Video educativo</h2>
      <p style="color:var(--muted);margin-bottom:20px;">Comprende el Present Perfect con ejemplos claros y situaciones reales.</p>
      <div class="media-wrapper">
        <iframe width="100%" height="380"
          src="https://www.youtube.com/embed/553eeL1Dvho"
          title="Present Perfect - Video educativo"
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
      <h2><span class="block-icon">🧠</span> Quiz: Present Perfect</h2>
      <p style="color:var(--muted);font-size:0.9rem;margin-bottom:24px;">
        Pon a prueba lo aprendido. 10 preguntas con retroalimentación inmediata.
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
// ===== MODELO 3D: LÁPIZ =====
(function() {
  var canvas = document.getElementById('canvas-pencil');
  if (!canvas || typeof THREE === 'undefined') return;

  var renderer = new THREE.WebGLRenderer({ canvas: canvas, antialias: true, alpha: true });
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.shadowMap.enabled = true;

  var scene = new THREE.Scene();
  var camera = new THREE.PerspectiveCamera(40, canvas.clientWidth / canvas.clientHeight, 0.1, 100);
  camera.position.set(0, 0, 6);
  camera.lookAt(0, 0, 0);

  scene.add(new THREE.AmbientLight(0xffffff, 0.5));
  var dir = new THREE.DirectionalLight(0xffd060, 1.3);
  dir.position.set(3, 5, 4);
  dir.castShadow = true;
  scene.add(dir);
  var fill = new THREE.DirectionalLight(0xf0a500, 0.4);
  fill.position.set(-3, 2, -2);
  scene.add(fill);

  var pencil = new THREE.Group();

  // Cuerpo hexagonal del lápiz (aproximado con CylinderGeometry de 6 lados)
  var bodyMat = new THREE.MeshPhongMaterial({ color: 0xf5c518, shininess: 60 });
  var body = new THREE.Mesh(new THREE.CylinderGeometry(0.22, 0.22, 3.6, 6), bodyMat);
  pencil.add(body);

  // Líneas del costado (facetas)
  var lineMat = new THREE.MeshPhongMaterial({ color: 0xd4a000, shininess: 20 });
  for (var f = 0; f < 6; f++) {
    var angle = (f / 6) * Math.PI * 2;
    var stripe = new THREE.Mesh(new THREE.BoxGeometry(0.03, 3.62, 0.01), lineMat);
    stripe.position.set(Math.cos(angle) * 0.225, 0, Math.sin(angle) * 0.225);
    pencil.add(stripe);
  }

  // Borrador (punta superior — goma)
  var eraserMat = new THREE.MeshPhongMaterial({ color: 0xff8fa3, shininess: 30 });
  var eraser = new THREE.Mesh(new THREE.CylinderGeometry(0.22, 0.22, 0.28, 6), eraserMat);
  eraser.position.y = 1.94;
  pencil.add(eraser);

  // Banda metálica
  var bandMat = new THREE.MeshPhongMaterial({ color: 0xcccccc, shininess: 120 });
  var band = new THREE.Mesh(new THREE.CylinderGeometry(0.235, 0.235, 0.14, 16), bandMat);
  band.position.y = 1.73;
  pencil.add(band);

  // Cono de madera (punta inferior)
  var woodMat = new THREE.MeshPhongMaterial({ color: 0xc8864a, shininess: 20 });
  var wood = new THREE.Mesh(new THREE.CylinderGeometry(0.22, 0.06, 0.5, 6), woodMat);
  wood.position.y = -2.05;
  pencil.add(wood);

  // Punta de grafito
  var tipMat = new THREE.MeshPhongMaterial({ color: 0x333333, shininess: 80 });
  var tip = new THREE.Mesh(new THREE.CylinderGeometry(0.06, 0.01, 0.22, 6), tipMat);
  tip.position.y = -2.41;
  pencil.add(tip);

  // Núcleo de grafito visible en la punta
  var coreMat = new THREE.MeshPhongMaterial({ color: 0x222222 });
  var core = new THREE.Mesh(new THREE.CylinderGeometry(0.03, 0.005, 0.18, 6), coreMat);
  core.position.y = -2.42;
  pencil.add(core);

  pencil.rotation.z = 0.3;
  pencil.rotation.x = 0;
  scene.add(pencil);

  function resize() {
    var w = canvas.parentElement.clientWidth;
    var h = 320;
    renderer.setSize(w, h);
    camera.aspect = w / h;
    camera.updateProjectionMatrix();
  }
  resize();
  window.addEventListener('resize', resize);

  var isDragging = false, prevX = 0, prevY = 0;
  canvas.addEventListener('mousedown', function(e) { isDragging = true; prevX = e.clientX; prevY = e.clientY; });
  window.addEventListener('mouseup', function() { isDragging = false; });
  window.addEventListener('mousemove', function(e) {
    if (!isDragging) return;
    pencil.rotation.y += (e.clientX - prevX) * 0.01;
    pencil.rotation.x += (e.clientY - prevY) * 0.005;
    prevX = e.clientX; prevY = e.clientY;
  });
  canvas.addEventListener('touchstart', function(e) { isDragging = true; prevX = e.touches[0].clientX; prevY = e.touches[0].clientY; });
  canvas.addEventListener('touchend', function() { isDragging = false; });
  canvas.addEventListener('touchmove', function(e) {
    if (!isDragging) return;
    pencil.rotation.y += (e.touches[0].clientX - prevX) * 0.01;
    pencil.rotation.x += (e.touches[0].clientY - prevY) * 0.005;
    prevX = e.touches[0].clientX; prevY = e.touches[0].clientY;
  });

  function animate() {
    requestAnimationFrame(animate);
    if (!isDragging) pencil.rotation.y += 0.005;
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

  var TEMA = 'present_perfect';
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
    { q: "She _____ completed the class already.", opts: ["have","has","is","was"], correct: 1, explain: "Con She/He/It se usa 'has' en Present Perfect." },
    { q: "I _____ never visited London.", opts: ["has","have","was","am"], correct: 1, explain: "Con I se usa 'have'. 'Never' es signal word del Present Perfect." },
    { q: "They _____ just finished the exam.", opts: ["has","is","have","are"], correct: 2, explain: "Con They se usa 'have'. 'Just' indica acción reciente." },
    { q: "_____ you ever eaten sushi?", opts: ["Has","Is","Have","Do"], correct: 2, explain: "Con You se usa 'Have' en preguntas de Present Perfect." },
    { q: "He has lived here _____ 2015.", opts: ["for","yet","since","already"], correct: 2, explain: "'Since' se usa con punto específico en el tiempo (2015)." },
    { q: "We _____ studied for three hours.", opts: ["has","is","have","are"], correct: 2, explain: "Con We se usa 'have'." },
    { q: "She has worked here _____ five years.", opts: ["since","yet","already","for"], correct: 3, explain: "'For' se usa con duración (five years)." },
    { q: "_____ he finished his homework yet?", opts: ["Have","Is","Do","Has"], correct: 3, explain: "Con He/She/It se usa 'Has' en preguntas." },
    { q: "I have _____ seen that movie. (nunca)", opts: ["already","just","never","yet"], correct: 2, explain: "'Never' expresa experiencia negativa en Present Perfect." },
    { q: "They have not arrived _____.", opts: ["since","already","never","yet"], correct: 3, explain: "'Yet' se usa en negativas e interrogativas para indicar hasta ahora." }
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
    var msg = pct >= 80 ? 'Excelente! Dominas el Present Perfect.' : pct >= 60 ? 'Buen intento. Sigue practicando.' : 'Repasa la lección e inténtalo de nuevo.';
    var html = '<div class="quiz-result"><div class="score-big">' + score + '/' + questions.length + '</div>';
    html += '<h3>' + medal + ' ' + msg + '</h3>';
    html += '<p>Obtuviste <strong style="color:var(--gold);">' + pct + '%</strong> de aciertos en Present Perfect.</p>';
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
