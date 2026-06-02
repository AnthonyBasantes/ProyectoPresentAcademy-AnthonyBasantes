<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Present Continuous — Present Academy</title>
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
    #canvas-classroom { width: 100%; height: 320px; border-radius: 12px; display: block; cursor: grab; }
    #canvas-classroom:active { cursor: grabbing; }
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
    <div style="font-size:3.5rem;margin-bottom:16px;">⏳</div>
    <h1><span>Present</span> Continuous</h1>
    <p>Acciones que están ocurriendo en este preciso momento.</p>
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
      <div class="sdot" id="dot-2" title="Reglas -ing">3</div>
      <div class="sdot" id="dot-3" title="Video">4</div>
      <div class="sdot" id="dot-4" title="Quiz">5</div>
    </div>

    <!-- SECCIÓN 1: ESTRUCTURA -->
    <div class="content-block" id="block-0">
      <h2><span class="block-icon">📌</span> Estructura gramatical</h2>
      <div class="structure-box">
        <div class="formula">➕ Afirmativa: Subject + am/is/are + verb-ing + complement</div>
        <div class="formula">➖ Negativa: Subject + am/is/are + not + verb-ing</div>
        <div class="formula">❓ Interrogativa: Am/Is/Are + subject + verb-ing?</div>
      </div>
      <ul class="examples-list">
        <li><span>I am</span> → I am studying English.</li>
        <li><span>He / She / It is</span> → She is reading a book.</li>
        <li><span>We / You / They are</span> → They are practicing grammar.</li>
        <li><span>Negativa</span> → He is not watching TV right now.</li>
        <li><span>Pregunta</span> → Are you learning English now?</li>
      </ul>

      <!-- MODELO 3D: AULA -->
      <div class="model-3d-wrap">
        <h3>🏫 Aula 3D interactiva</h3>
        <p>Explora el aula mientras estudias las acciones en progreso del Present Continuous.</p>
        <canvas id="canvas-classroom"></canvas>
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
          <img src="img/present_continuous1.jpg" alt="I am learning English now">
          <div class="card-body">
            <strong>I am learning English now.</strong>
            <p>Acción en progreso</p>
          </div>
        </div>
        <div class="example-card">
          <img src="img/present_continuous2.jpg" alt="He is watching a class">
          <div class="card-body">
            <strong>He is watching a class.</strong>
            <p>Este momento</p>
          </div>
        </div>
        <div class="example-card">
          <img src="img/present_continuous3.jpg" alt="They are speaking English">
          <div class="card-body">
            <strong>They are speaking English.</strong>
            <p>Ahora mismo</p>
          </div>
        </div>
      </div>

      <!-- AUDIO JUSTO DESPUÉS DE LOS EJEMPLOS -->
      <div style="background:rgba(240,165,0,0.05);border:1px solid rgba(240,165,0,0.15);border-radius:16px;padding:28px;text-align:center;">
        <div style="font-size:2.5rem;margin-bottom:16px;">🎧</div>
        <p style="color:var(--muted);font-size:0.9rem;margin-bottom:6px;">Escucha estos ejemplos con pronunciación nativa</p>
        <p style="color:var(--muted);font-size:0.82rem;margin-bottom:18px;">Present Continuous — Pronunciación y ejemplos</p>
        <audio controls style="width:100%;max-width:500px;accent-color:var(--gold);">
          <source src="audio/present_continuous.mp3" type="audio/mpeg">
          Tu navegador no soporta audio HTML5.
        </audio>
        <p style="margin-top:14px;color:var(--muted);font-size:0.85rem;">
          💡 <strong style="color:var(--white);">Tip:</strong> Nota cómo el auxiliar am/is/are cambia según el sujeto.
        </p>
      </div>

      <div style="margin-top:20px;text-align:right;">
        <button class="btn-primary-pa" onclick="markSection(1)" style="padding:8px 22px;font-size:0.85rem;">Marcar como leído ✓</button>
      </div>
    </div>

    <!-- SECCIÓN 3: REGLAS -ING -->
    <div class="content-block" id="block-2">
      <h2><span class="block-icon">📏</span> Reglas para agregar -ing</h2>
      <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(230px,1fr));gap:14px;margin-top:8px;">
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:18px;">
          <strong style="color:var(--gold);">Regla general → agrega -ing</strong>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;margin-top:8px;color:var(--white);">play → play<strong style="color:var(--gold2);">ing</strong></p>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;color:var(--white);">read → read<strong style="color:var(--gold2);">ing</strong></p>
        </div>
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:18px;">
          <strong style="color:var(--gold);">Termina en -e → quita -e, agrega -ing</strong>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;margin-top:8px;color:var(--white);">make → mak<strong style="color:var(--gold2);">ing</strong></p>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;color:var(--white);">write → writ<strong style="color:var(--gold2);">ing</strong></p>
        </div>
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:18px;">
          <strong style="color:var(--gold);">CVC corta → dobla consonante final</strong>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;margin-top:8px;color:var(--white);">run → run<strong style="color:var(--gold2);">n</strong>ing</p>
          <p style="font-family:'Courier New',monospace;font-size:0.88rem;color:var(--white);">sit → sit<strong style="color:var(--gold2);">t</strong>ing</p>
        </div>
      </div>
      <div style="margin-top:20px;text-align:right;">
        <button class="btn-primary-pa" onclick="markSection(2)" style="padding:8px 22px;font-size:0.85rem;">Marcar como leído ✓</button>
      </div>
    </div>

    <!-- SECCIÓN 4: VIDEO -->
    <div class="content-block" id="block-3">
      <h2><span class="block-icon">🎥</span> Video educativo</h2>
      <p style="color:var(--muted);margin-bottom:20px;">Aprende el Present Continuous con ejemplos visuales y situaciones del día a día.</p>
      <div class="media-wrapper">
        <iframe width="100%" height="380"
          src="https://www.youtube.com/embed/rFdhrR6Dpco"
          title="Present Continuous - Video educativo"
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
      <h2><span class="block-icon">🧠</span> Quiz: Present Continuous</h2>
      <p style="color:var(--muted);font-size:0.9rem;margin-bottom:24px;">
        Demuestra lo que aprendiste. 10 preguntas con retroalimentación inmediata.
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
// ===== MODELO 3D: AULA =====
(function() {
  var canvas = document.getElementById('canvas-classroom');
  if (!canvas || typeof THREE === 'undefined') return;

  var renderer = new THREE.WebGLRenderer({ canvas: canvas, antialias: true, alpha: true });
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.shadowMap.enabled = true;

  var scene = new THREE.Scene();
  var camera = new THREE.PerspectiveCamera(50, canvas.clientWidth / canvas.clientHeight, 0.1, 100);
  camera.position.set(0, 3, 7);
  camera.lookAt(0, 0.5, 0);

  scene.add(new THREE.AmbientLight(0xffffff, 0.6));
  var dir = new THREE.DirectionalLight(0xffeedd, 1.0);
  dir.position.set(4, 6, 4);
  dir.castShadow = true;
  scene.add(dir);
  var fill = new THREE.DirectionalLight(0xf0a500, 0.3);
  fill.position.set(-4, 3, -2);
  scene.add(fill);

  var room = new THREE.Group();

  // Piso
  var floorMat = new THREE.MeshPhongMaterial({ color: 0x8a7560, shininess: 30 });
  var floor = new THREE.Mesh(new THREE.BoxGeometry(8, 0.15, 6), floorMat);
  floor.position.y = -0.5;
  room.add(floor);

  // Pared trasera
  var wallMat = new THREE.MeshPhongMaterial({ color: 0xddd0b8 });
  var wallBack = new THREE.Mesh(new THREE.BoxGeometry(8, 5, 0.15), wallMat);
  wallBack.position.set(0, 2, -3);
  room.add(wallBack);

  // Pizarrón
  var boardMat = new THREE.MeshPhongMaterial({ color: 0x1a4d2e, shininess: 10 });
  var board = new THREE.Mesh(new THREE.BoxGeometry(4, 1.8, 0.08), boardMat);
  board.position.set(0, 2.2, -2.9);
  room.add(board);

  // Marco del pizarrón
  var frameMat = new THREE.MeshPhongMaterial({ color: 0x5a3e28 });
  var frameH = new THREE.Mesh(new THREE.BoxGeometry(4.2, 0.1, 0.1), frameMat);
  frameH.position.set(0, 3.15, -2.85); room.add(frameH);
  var frameH2 = frameH.clone(); frameH2.position.y = 1.25; room.add(frameH2);
  var frameV = new THREE.Mesh(new THREE.BoxGeometry(0.1, 1.9, 0.1), frameMat);
  frameV.position.set(-2.1, 2.2, -2.85); room.add(frameV);
  var frameV2 = frameV.clone(); frameV2.position.x = 2.1; room.add(frameV2);

  // Texto en pizarrón (líneas simuladas)
  var chalkMat = new THREE.MeshPhongMaterial({ color: 0xffffff, shininess: 5 });
  for (var l = 0; l < 3; l++) {
    var line = new THREE.Mesh(new THREE.BoxGeometry(2.8 - l * 0.4, 0.06, 0.02), chalkMat);
    line.position.set(-0.2, 2.6 - l * 0.35, -2.84);
    room.add(line);
  }

  // Escritorio del profesor
  var deskMat = new THREE.MeshPhongMaterial({ color: 0x6b4c2a, shininess: 40 });
  var deskTop = new THREE.Mesh(new THREE.BoxGeometry(2, 0.1, 0.9), deskMat);
  deskTop.position.set(0, 0.5, -1.8);
  room.add(deskTop);
  var deskLeg1 = new THREE.Mesh(new THREE.BoxGeometry(0.1, 0.5, 0.1), deskMat);
  deskLeg1.position.set(-0.9, 0.2, -1.4); room.add(deskLeg1);
  var deskLeg2 = deskLeg1.clone(); deskLeg2.position.x = 0.9; room.add(deskLeg2);
  var deskLeg3 = deskLeg1.clone(); deskLeg3.position.set(-0.9, 0.2, -2.1); room.add(deskLeg3);
  var deskLeg4 = deskLeg1.clone(); deskLeg4.position.set(0.9, 0.2, -2.1); room.add(deskLeg4);

  // Sillas y pupitres estudiantes (2 filas x 3)
  var chairMat = new THREE.MeshPhongMaterial({ color: 0x2a5298, shininess: 30 });
  var pupitrePositions = [
    [-2.2, 0.8], [0, 0.8], [2.2, 0.8],
    [-2.2, 2.2], [0, 2.2], [2.2, 2.2]
  ];
  pupitrePositions.forEach(function(pos) {
    var pt = new THREE.Mesh(new THREE.BoxGeometry(0.9, 0.06, 0.6), deskMat);
    pt.position.set(pos[0], 0.45, pos[1]);
    room.add(pt);
    var leg1 = new THREE.Mesh(new THREE.BoxGeometry(0.06, 0.45, 0.06), deskMat);
    leg1.position.set(pos[0] - 0.4, 0.2, pos[1] - 0.25); room.add(leg1);
    var leg2 = leg1.clone(); leg2.position.set(pos[0] + 0.4, 0.2, pos[1] - 0.25); room.add(leg2);
    var leg3 = leg1.clone(); leg3.position.set(pos[0] - 0.4, 0.2, pos[1] + 0.25); room.add(leg3);
    var leg4 = leg1.clone(); leg4.position.set(pos[0] + 0.4, 0.2, pos[1] + 0.25); room.add(leg4);
    // Silla
    var seat = new THREE.Mesh(new THREE.BoxGeometry(0.6, 0.06, 0.55), chairMat);
    seat.position.set(pos[0], 0.35, pos[1] + 0.6);
    room.add(seat);
    var back = new THREE.Mesh(new THREE.BoxGeometry(0.6, 0.5, 0.06), chairMat);
    back.position.set(pos[0], 0.65, pos[1] + 0.88);
    room.add(back);
  });

  room.rotation.y = 0.4;
  scene.add(room);

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
    room.rotation.y += (e.clientX - prevX) * 0.01;
    room.rotation.x += (e.clientY - prevY) * 0.005;
    prevX = e.clientX; prevY = e.clientY;
  });
  canvas.addEventListener('touchstart', function(e) { isDragging = true; prevX = e.touches[0].clientX; prevY = e.touches[0].clientY; });
  canvas.addEventListener('touchend', function() { isDragging = false; });
  canvas.addEventListener('touchmove', function(e) {
    if (!isDragging) return;
    room.rotation.y += (e.touches[0].clientX - prevX) * 0.01;
    room.rotation.x += (e.touches[0].clientY - prevY) * 0.005;
    prevX = e.touches[0].clientX; prevY = e.touches[0].clientY;
  });

  function animate() {
    requestAnimationFrame(animate);
    if (!isDragging) room.rotation.y += 0.004;
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

  var TEMA = 'present_continuous';
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
    { q: "They _____ studying right now.", opts: ["is","are","am","be"], correct: 1, explain: "Con They siempre usamos 'are' en Present Continuous." },
    { q: "She _____ a book at the moment.", opts: ["read","reads","is reading","are reading"], correct: 2, explain: "She + is + verb-ing = is reading." },
    { q: "_____ you watching TV now?", opts: ["Do","Is","Are","Am"], correct: 2, explain: "Con You se usa 'Are' en preguntas de Present Continuous." },
    { q: "I _____ not sleeping, I am studying.", opts: ["are","is","am","do"], correct: 2, explain: "Con I siempre se usa 'am'." },
    { q: "The dog _____ in the garden right now.", opts: ["play","are playing","is playing","plays"], correct: 2, explain: "The dog = It, entonces: is + playing." },
    { q: "We _____ lunch at this moment.", opts: ["is having","am having","are having","has"], correct: 2, explain: "Con We se usa 'are': are having." },
    { q: "What _____ he doing right now?", opts: ["are","do","am","is"], correct: 3, explain: "Con He/She/It se usa 'is' en preguntas." },
    { q: "The children _____ not playing outside.", opts: ["is","am","are","be"], correct: 2, explain: "Con sujeto plural (children) se usa 'are'." },
    { q: "She _____ (write) an email now. Forma correcta:", opts: ["writing","is writing","writes","are writing"], correct: 1, explain: "She + is + writing (quita -e, agrega -ing)." },
    { q: "_____ they coming to the party tonight?", opts: ["Is","Am","Do","Are"], correct: 3, explain: "Con They se usa 'Are' en preguntas de Present Continuous." }
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
    var msg = pct >= 80 ? 'Excelente! Dominas el Present Continuous.' : pct >= 60 ? 'Buen intento. Un poco más de práctica.' : 'Repasa la lección e inténtalo de nuevo.';
    var html = '<div class="quiz-result"><div class="score-big">' + score + '/' + questions.length + '</div>';
    html += '<h3>' + medal + ' ' + msg + '</h3>';
    html += '<p>Obtuviste <strong style="color:var(--gold);">' + pct + '%</strong> de aciertos.</p>';
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
