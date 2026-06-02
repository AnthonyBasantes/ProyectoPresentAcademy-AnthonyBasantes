<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.presentacademy.modelo.Usuario" %>
<%@ page import="com.presentacademy.modelo.Bitacora" %>
<%
  List<Usuario> usuarios   = (List<Usuario>) request.getAttribute("usuarios");
  List<Bitacora> bitacoras = (List<Bitacora>) request.getAttribute("bitacoras");

  if (usuarios  == null) usuarios  = new java.util.ArrayList<>();
  if (bitacoras == null) bitacoras = new java.util.ArrayList<>();

  String msg   = request.getParameter("msg");
  String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin — Present Academy</title>
  <link href="css/estilos.css" rel="stylesheet">
  <style>
    /* ── MODAL ── */
    .modal-overlay {
      display: none; position: fixed; inset: 0; z-index: 2000;
      background: rgba(0,0,0,0.75); backdrop-filter: blur(6px);
      align-items: center; justify-content: center;
    }
    .modal-overlay.open { display: flex; }
    .modal-box {
      background: var(--card-bg);
      border: 1px solid rgba(240,165,0,0.25);
      border-radius: 20px; padding: 44px 40px;
      width: 100%; max-width: 460px;
      position: relative; animation: fadeInUp 0.3s ease;
    }
    .modal-box h3 {
      font-family: 'Playfair Display', serif;
      font-size: 1.5rem; margin-bottom: 24px; color: var(--white);
    }
    .modal-close {
      position: absolute; top: 16px; right: 20px;
      background: none; border: none; color: var(--muted);
      font-size: 1.4rem; cursor: pointer; transition: color 0.3s;
    }
    .modal-close:hover { color: var(--gold); }
    .modal-box .form-group { margin-bottom: 18px; }
    .modal-box .form-group label {
      display: block; font-size: 0.8rem; font-weight: 700;
      text-transform: uppercase; letter-spacing: 0.5px;
      color: var(--muted); margin-bottom: 7px;
    }
    .modal-box .form-group input,
    .modal-box .form-group select {
      width: 100%; padding: 12px 16px;
      background: rgba(255,255,255,0.05);
      border: 1px solid rgba(255,255,255,0.1);
      border-radius: 10px; color: var(--white);
      font-size: 0.95rem; font-family: 'Lato', sans-serif;
      transition: border-color 0.3s;
    }
    .modal-box .form-group input:focus,
    .modal-box .form-group select:focus {
      outline: none; border-color: var(--gold);
      box-shadow: 0 0 0 3px rgba(240,165,0,0.15);
    }
    .modal-box .form-group select option { background: var(--navy2); }
    .btn-modal-submit {
      width: 100%; padding: 13px;
      background: var(--gold); color: var(--navy);
      border: none; border-radius: 10px;
      font-size: 0.95rem; font-weight: 700;
      cursor: pointer; font-family: 'Lato', sans-serif;
      transition: var(--transition); margin-top: 6px;
    }
    .btn-modal-submit:hover {
      background: var(--gold2); transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(240,165,0,0.35);
    }
    .btn-nuevo {
      display: inline-flex; align-items: center; gap: 8px;
      background: var(--gold); color: var(--navy);
      padding: 10px 24px; border-radius: 50px;
      font-weight: 700; font-size: 0.9rem;
      border: none; cursor: pointer;
      font-family: 'Lato', sans-serif;
      transition: var(--transition);
    }
    .btn-nuevo:hover {
      background: var(--gold2); transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(240,165,0,0.35);
    }
    .action-link.editar {
      color: var(--gold2); border: 1px solid rgba(255,209,102,0.3);
      margin-right: 6px;
    }
    .action-link.editar:hover { background: rgba(255,209,102,0.1); }
    .td-acciones { display: flex; gap: 6px; flex-wrap: wrap; }
    .flash-msg {
      padding: 13px 20px; border-radius: 10px;
      font-size: 0.92rem; font-weight: 600; margin-bottom: 28px;
    }
    .flash-ok  { background: rgba(6,214,160,0.12); border: 1px solid rgba(6,214,160,0.3); color: var(--success); }
    .flash-err { background: rgba(239,71,111,0.12); border: 1px solid rgba(239,71,111,0.3); color: var(--danger); }
    .bitacora-header {
      display: flex; align-items: center; justify-content: space-between;
      flex-wrap: wrap; gap: 12px;
    }
    .filter-tabs { display: flex; gap: 8px; }
    .filter-tab {
      padding: 6px 18px; border-radius: 50px; font-size: 0.82rem;
      font-weight: 700; cursor: pointer; border: 1px solid rgba(255,255,255,0.1);
      background: none; color: var(--muted); transition: var(--transition);
      font-family: 'Lato', sans-serif;
    }
    .filter-tab.active, .filter-tab:hover {
      background: rgba(240,165,0,0.15); border-color: var(--gold); color: var(--gold);
    }
  </style>
</head>
<body>

<div class="particles" id="particles"></div>

<header class="navbar-pa">
  <a href="#" class="logo">📘 Present<span>Academy</span></a>
  <nav role="navigation" aria-label="Menú principal">
    <span style="color:var(--gold);font-size:0.85rem;font-weight:700;">🛡️ Panel Admin</span>
    <a href="LogoutServlet" aria-label="Cerrar sesión de la plataforma">Cerrar sesión</a>
  </nav>
</header>

<main class="admin-page">
  <h1 class="admin-title">🛡️ Panel de Administración</h1>

  <!-- ── MENSAJES FLASH ── -->
  <% if ("creado".equals(msg)) { %>
    <div class="flash-msg flash-ok">✅ Usuario creado correctamente.</div>
  <% } else if ("actualizado".equals(msg)) { %>
    <div class="flash-msg flash-ok">✅ Usuario actualizado correctamente.</div>
  <% } else if (msg != null) { %>
    <div class="flash-msg flash-err">❌ Ocurrió un error en la base de datos.</div>
  <% } %>
  <% if ("datos_crear".equals(error) || "datos_editar".equals(error)) { %>
    <div class="flash-msg flash-err">❌ Datos inválidos. Revisá correo (debe tener @) y clave (mínimo 8 caracteres).</div>
  <% } else if ("correo_existe".equals(error)) { %>
    <div class="flash-msg flash-err">❌ Ese correo ya está registrado.</div>
  <% } %>

  <!-- ═══════════════════════════════════
       GESTIÓN DE USUARIOS
  ════════════════════════════════════ -->
  <div class="admin-table-wrap">
    <div style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;padding:24px 32px;border-bottom:1px solid rgba(255,255,255,0.06);">
      <h2 style="padding:0;border:none;font-family:'Playfair Display',serif;font-size:1.3rem;">👥 Gestión de usuarios</h2>
      <button class="btn-nuevo" aria-label="Crear nuevo usuario" onclick="abrirModalCrear()">＋ Nuevo usuario</button>
    </div>

    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Nombre</th>
          <th>Correo</th>
          <th>Rol</th>
          <th>Estado</th>
          <th>Acciones</th>
        </tr>
      </thead>
      <tbody>
        <% if (usuarios.isEmpty()) { %>
          <tr><td colspan="6" style="text-align:center;color:var(--muted);padding:30px;">No hay usuarios registrados.</td></tr>
        <% } %>
        <% for (Usuario u : usuarios) { %>
        <tr>
          <td style="color:var(--gold);">#<%= u.getId() %></td>
          <td style="color:var(--white);font-weight:600;"><%= u.getNombre() %></td>
          <td><%= u.getCorreo() %></td>
          <td>
            <% if ("admin".equals(u.getRol())) { %>
              <span style="color:var(--gold);font-weight:700;">🛡️ admin</span>
            <% } else { %>
              <span style="color:var(--muted);">🎓 estudiante</span>
            <% } %>
          </td>
          <td>
            <% if ("activo".equals(u.getEstado())) { %>
              <span class="badge-activo">● activo</span>
            <% } else { %>
              <span class="badge-bloqueado">● bloqueado</span>
            <% } %>
          </td>
          <td>
            <div class="td-acciones">
              <a href="javascript:void(0)"
                 class="action-link editar"
                 onclick="abrirModalEditar(<%= u.getId() %>, '<%= u.getNombre().replace("'", "\\'") %>', '<%= u.getCorreo() %>', '<%= u.getRol() %>')">
                ✏️ Editar
              </a>
              <% if ("activo".equals(u.getEstado())) { %>
                <a href="BloquearUsuarioServlet?id=<%= u.getId() %>&accion=bloquear"
                   class="action-link bloquear"
                   onclick="return confirm('¿Bloquear a <%= u.getNombre().replace("'", "\\'") %>? No podrá acceder al sitio.')">
                  🔒 Bloquear
                </a>
              <% } else { %>
                <a href="BloquearUsuarioServlet?id=<%= u.getId() %>&accion=activar"
                   class="action-link activar">
                  ✅ Activar
                </a>
              <% } %>
            </div>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>

  <!-- ═══════════════════════════════════
       BITÁCORA DE ACTIVIDAD
  ════════════════════════════════════ -->
  <div class="admin-table-wrap">
    <div style="padding:24px 32px;border-bottom:1px solid rgba(255,255,255,0.06);">
      <div class="bitacora-header">
        <h2 style="padding:0;border:none;font-family:'Playfair Display',serif;font-size:1.3rem;">📋 Bitácora de actividad</h2>
        <div class="filter-tabs">
          <button class="filter-tab active" onclick="filtrarBitacora('todos', this)">Todos</button>
          <button class="filter-tab" onclick="filtrarBitacora('estudiante', this)">Solo Estudiantes</button>
          <button class="filter-tab" onclick="filtrarBitacora('admin', this)">Solo Admin</button>
        </div>
      </div>
    </div>

    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Usuario</th>
          <th>Rol</th>
          <th>Acción</th>
          <th>Fecha</th>
        </tr>
      </thead>
      <tbody id="tbody-bitacora">
        <%
          java.util.Map<Integer, Usuario> mapaUsuarios = new java.util.HashMap<>();
          for (Usuario u : usuarios) { mapaUsuarios.put(u.getId(), u); }
        %>
        <% if (bitacoras.isEmpty()) { %>
          <tr><td colspan="5" style="text-align:center;color:var(--muted);padding:30px;">No hay registros en la bitácora.</td></tr>
        <% } %>
        <% for (Bitacora b : bitacoras) {
             Usuario uRef     = mapaUsuarios.get(b.getUsuarioId());
             String rolRef    = (uRef != null) ? uRef.getRol()    : "desconocido";
             String nombreRef = (uRef != null) ? uRef.getNombre() : "ID " + b.getUsuarioId();
        %>
        <tr data-rol="<%= rolRef %>">
          <td style="color:var(--gold);">#<%= b.getId() %></td>
          <td style="color:var(--white);font-weight:600;"><%= nombreRef %></td>
          <td>
            <% if ("admin".equals(rolRef)) { %>
              <span style="color:var(--gold);font-size:0.82rem;font-weight:700;">🛡️ admin</span>
            <% } else { %>
              <span style="color:#64b5f6;font-size:0.82rem;font-weight:700;">🎓 estudiante</span>
            <% } %>
          </td>
          <td style="color:var(--white);"><%= b.getAccion() %></td>
          <td style="font-family:'Courier New',monospace;font-size:0.85rem;"><%= b.getFecha() %></td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>

</main>

<footer class="footer-pa">
  <span class="logo-f">📘 Present Academy</span>
  <p>Universidad Politécnica Salesiana · Anthony Basantes</p>
</footer>

<!-- ═══════════════════════════════════
     MODAL: CREAR USUARIO
════════════════════════════════════ -->
<div class="modal-overlay" id="modal-crear" role="dialog" aria-modal="true" aria-labelledby="titulo-crear">
  <div class="modal-box">
    <button class="modal-close" aria-label="Cerrar modal" onclick="cerrarModal('modal-crear')">✕</button>
    <h3 id="titulo-crear">➕ Crear nuevo usuario</h3>
    <form action="ActualizarUsuarioServlet" method="post" onsubmit="return validarCrear()">
      <input type="hidden" name="accion" value="crear">
      <div class="form-group">
        <label for="crear-nombre">Nombre completo</label>
        <input type="text" name="nombre" id="crear-nombre" placeholder="Ej: Juan Pérez" required>
      </div>
      <div class="form-group">
        <label for="crear-correo">Correo electrónico</label>
        <input type="email" name="correo" id="crear-correo" placeholder="correo@ejemplo.com" required>
      </div>
      <div class="form-group">
        <label for="crear-clave">Contraseña (mín. 8 caracteres)</label>
        <input type="password" name="clave" id="crear-clave" placeholder="••••••••" required minlength="8">
      </div>
      <div class="form-group">
        <label for="crear-rol">Rol</label>
        <select name="rol" id="crear-rol" required>
          <option value="estudiante">🎓 Estudiante</option>
          <option value="admin">🛡️ Administrador</option>
        </select>
      </div>
      <div id="crear-error" style="color:var(--danger);font-size:0.85rem;margin-bottom:10px;display:none;"></div>
      <button type="submit" class="btn-modal-submit">Crear usuario</button>
    </form>
  </div>
</div>

<!-- ═══════════════════════════════════
     MODAL: EDITAR USUARIO
════════════════════════════════════ -->
<div class="modal-overlay" id="modal-editar" role="dialog" aria-modal="true" aria-labelledby="titulo-editar">
  <div class="modal-box">
    <button class="modal-close" aria-label="Cerrar modal" onclick="cerrarModal('modal-editar')">✕</button>
    <h3 id="titulo-editar">✏️ Editar usuario</h3>
    <form action="ActualizarUsuarioServlet" method="post" onsubmit="return validarEditar()">
      <input type="hidden" name="accion" value="editar">
      <input type="hidden" name="id"     id="editar-id">
      <div class="form-group">
        <label for="editar-nombre">Nombre completo</label>
        <input type="text" name="nombre" id="editar-nombre" placeholder="Nombre" required>
      </div>
      <div class="form-group">
        <label for="editar-correo">Correo electrónico</label>
        <input type="email" name="correo" id="editar-correo" placeholder="correo@ejemplo.com" required>
      </div>
      <div class="form-group">
        <label for="editar-rol">Rol</label>
        <select name="rol" id="editar-rol" required>
          <option value="estudiante">🎓 Estudiante</option>
          <option value="admin">🛡️ Administrador</option>
        </select>
      </div>
      <div id="editar-error" style="color:var(--danger);font-size:0.85rem;margin-bottom:10px;display:none;"></div>
      <button type="submit" class="btn-modal-submit">Guardar cambios</button>
    </form>
  </div>
</div>

<script>
  /* ── PARTÍCULAS ── */
  const c = document.getElementById('particles');
  for (let i = 0; i < 20; i++) {
    const s = document.createElement('span');
    s.style.left = Math.random() * 100 + 'vw';
    s.style.animationDuration = (12 + Math.random() * 18) + 's';
    s.style.animationDelay   = (Math.random() * 10) + 's';
    c.appendChild(s);
  }

  /* ── MODALES ── */
  function abrirModalCrear() {
    document.getElementById('modal-crear').classList.add('open');
  }

  function abrirModalEditar(id, nombre, correo, rol) {
    document.getElementById('editar-id').value     = id;
    document.getElementById('editar-nombre').value = nombre;
    document.getElementById('editar-correo').value = correo;
    document.getElementById('editar-rol').value    = rol;
    document.getElementById('modal-editar').classList.add('open');
  }

  function cerrarModal(id) {
    document.getElementById(id).classList.remove('open');
  }

  document.querySelectorAll('.modal-overlay').forEach(function(overlay) {
    overlay.addEventListener('click', function(e) {
      if (e.target === overlay) overlay.classList.remove('open');
    });
  });

  /* ── VALIDACIONES ── */
  function validarCrear() {
    const clave  = document.getElementById('crear-clave').value;
    const correo = document.getElementById('crear-correo').value;
    const errDiv = document.getElementById('crear-error');
    if (clave.length < 8) {
      errDiv.textContent = '⚠️ La clave debe tener al menos 8 caracteres.';
      errDiv.style.display = 'block';
      return false;
    }
    if (!correo.includes('@') || !correo.includes('.')) {
      errDiv.textContent = '⚠️ Ingresá un correo válido.';
      errDiv.style.display = 'block';
      return false;
    }
    errDiv.style.display = 'none';
    return true;
  }

  function validarEditar() {
    const correo = document.getElementById('editar-correo').value;
    const errDiv = document.getElementById('editar-error');
    if (!correo.includes('@') || !correo.includes('.')) {
      errDiv.textContent = '⚠️ Ingresá un correo válido.';
      errDiv.style.display = 'block';
      return false;
    }
    errDiv.style.display = 'none';
    return true;
  }

  /* ── FILTRO BITÁCORA ── */
  function filtrarBitacora(filtro, btn) {
    document.querySelectorAll('.filter-tab').forEach(function(b) {
      b.classList.remove('active');
    });
    btn.classList.add('active');

    document.querySelectorAll('#tbody-bitacora tr').forEach(function(row) {
      const rol = row.getAttribute('data-rol');
      if (filtro === 'todos') {
        row.style.display = '';
      } else if (filtro === 'estudiante') {
        row.style.display = (rol === 'estudiante') ? '' : 'none';
      } else if (filtro === 'admin') {
        row.style.display = (rol === 'admin') ? '' : 'none';
      }
    });
  }

  /* ── AUTO-OCULTAR FLASH ── */
  const flash = document.querySelector('.flash-msg');
  if (flash) {
    setTimeout(function() {
      flash.style.transition = 'opacity 0.8s';
      flash.style.opacity = '0';
      setTimeout(function() { flash.remove(); }, 800);
    }, 4000);
  }
</script>

</body>
</html>
