import express from 'express';
import { prisma } from '../../lib/prisma.js';

const AUTH_USUARIO_ROUTER = express.Router();

AUTH_USUARIO_ROUTER.get("/", async (req, res) => {
    const usuarios = await prisma.usuario.findMany();
    return res.json(usuarios).status(200);
})




export default AUTH_USUARIO_ROUTER;