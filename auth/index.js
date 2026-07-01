import express from 'express';
import AUTH_USUARIO_ROUTER from './routes/usuarios.js';
import { CLIENTES_AUTH_ROUTER } from './routes/clientes.js';
import { MARCAS_AUTH_ROUTER } from './routes/marcas.js';

const AUTH_INDEX_ROUTER = express.Router();


AUTH_INDEX_ROUTER.use("/usuarios", AUTH_USUARIO_ROUTER)
AUTH_INDEX_ROUTER.use("/clientes", CLIENTES_AUTH_ROUTER)
AUTH_INDEX_ROUTER.use("/marcas", MARCAS_AUTH_ROUTER)






export default AUTH_INDEX_ROUTER;