import express from 'express'
import { prisma } from '../lib/prisma.js';

const PROVEEDORES_ROUTER = express.Router();


PROVEEDORES_ROUTER.post("/", async (req, res) => {
    const data = req.body;
    const { nombre, telefono, email, activo } = data;
    await prisma.proveedor.create({
        data: { "email": email, "nombre": nombre, "telefono": telefono, activo }
    })
    return res.json({ mensaje: "Proveedor guardado" }).status(200)
})


PROVEEDORES_ROUTER.get("/", async (req, res) => {
    let datos = await prisma.proveedor.findMany();
    return res.json(datos).status(200)
})


export default PROVEEDORES_ROUTER;