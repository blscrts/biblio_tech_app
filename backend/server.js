// API REST de BiblioGest - versión inicial.
// Los datos viven en memoria (se pierden al reiniciar el servidor).
// Más adelante se reemplazan por consultas a la base de datos real.

const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());          // permite que la app web de Flutter llame a esta API
app.use(express.json());  // permite leer el cuerpo de las peticiones en JSON

// ---- Datos de ejemplo ----
const instituciones = [
    { id: 1, nombre: 'Biblioteca municipal' },
    { id: 2, nombre: 'Biblioteca escolar' },
    { id: 3, nombre: 'Biblioteca universitaria' },
    { id: 4, nombre: 'Centro comunitario' },
    { id: 5, nombre: 'Biblioteca parroquial' },
    { id: 6, nombre: 'Otro' },
];

const usuarios = [
    { id: 1, nombres: 'Ana María', apellidos: 'Torres Rojas', institucionId: null },
];

// ---- Endpoints ----

// Lista de instituciones para la lista desplegable
app.get('/instituciones', (req, res) => {
    res.json(instituciones);
});

// Datos de un usuario
app.get('/usuarios/:id', (req, res) => {
    const usuario = usuarios.find((u) => u.id === Number(req.params.id));
    if (!usuario) {
        return res.status(404).json({ error: 'Usuario no encontrado' });
    }
    res.json(usuario);
});

// Actualizar la institución de un usuario
app.put('/usuarios/:id', (req, res) => {
    const usuario = usuarios.find((u) => u.id === Number(req.params.id));
    if (!usuario) {
        return res.status(404).json({ error: 'Usuario no encontrado' });
    }

    const { institucionId } = req.body;
    if (institucionId === undefined || institucionId === null) {
        return res.status(400).json({ error: 'La institución es obligatoria' });
    }
    if (!instituciones.some((i) => i.id === Number(institucionId))) {
        return res.status(400).json({ error: 'La institución no existe' });
    }

    usuario.institucionId = Number(institucionId);
    res.json(usuario);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`API de BiblioGest escuchando en http://localhost:${PORT}`);
});