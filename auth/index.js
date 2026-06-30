import express from 'express';
import AUTH_USUARIO_ROUTER from './routes/usuarios.js';

const AUTH_INDEX_ROUTER = express.Router();


AUTH_INDEX_ROUTER.use("/usuarios", AUTH_USUARIO_ROUTER)




export default AUTH_INDEX_ROUTER;