import express from 'express';
import { prisma } from '../../lib/prisma.js';
import { hashPassword } from '../../helpers/auth.js';

export const CLIENTES_AUTH_ROUTER = express.Router();


CLIENTES_AUTH_ROUTER.post("/", async (req, res) => {
    const { nombre, password, telefono, email } = req.body;

    let cliente = await prisma.cliente.create({
        data: {
            nombre, telefono, email, password: hashPassword(password)
        }
    })
    if (cliente) {
        return res.json({ mensaje: "Cliente creado" }).status(200)
    }
    else {
        return res.json({ mensaje: "El cliente no se creó" }).status(400)
    }
})


CLIENTES_AUTH_ROUTER.get("/", async (req, res) => {
    let clientes = await prisma.cliente.findMany();
    return res.json(clientes).status(200);
})

CLIENTES_AUTH_ROUTER.put("/:id", async (req, res) => {
    const id = req.params.id;
    const { nombre, password, telefono, email } = req.body;

    let cliente = await prisma.cliente.update({
        data: { nombre, telefono, email, password: hashPassword(password) },
        where: { id }
    })

    if (cliente) {
        return res.json({ mensaje: "Cliente modificado con éxito" }).status(201)
    }
    else {
        return res.json({ mensaje: "El cliente no se modificó" }).status(400)
    }
})

CLIENTES_AUTH_ROUTER.delete("/:id", async (req, res) => {
    const id = req.params.id;
    let cliente = await prisma.cliente.delete({
        where: { id }
    })
    if (cliente)
        return res.json({ mensaje: "Cliente eliminado correctamente" }).status(200)
    else
        return res.json({ mensaje: "No se pudo eliminar cliente" }).status(400)
})