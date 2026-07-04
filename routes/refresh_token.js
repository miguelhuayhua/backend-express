import express from 'express'
import { prisma } from '../lib/prisma.js'
import { verificarToken, generarAccesToken } from '../helpers/tokens.js';

export const REFRESH_ROUTER = express.Router();

REFRESH_ROUTER.post("/", async (req, res) => {
    const { refreshToken } = req.cookies;
    console.log(refreshToken)
    if (!refreshToken) return res.json({ mensaje: "Token no encontrado", estado: 401 }).status(401);

    const sesion = await prisma.token_sis.findFirst({ where: { token: refreshToken } })
    if (!sesion) return res.json({ mensaje: "Token no encontrado", estado: 401 }).status(401)

    const payload = verificarToken(refreshToken, "refresh")

    if (!payload) return res.json({ mensaje: "Token no valido", estado: 401 }).status(401)

    return res.json({
        accessToken: generarAccesToken({ sub: payload.sub, rol: payload.rol }),
        estado: 200,
        mensaje: "Token actualizado"
    }).status(200)
})