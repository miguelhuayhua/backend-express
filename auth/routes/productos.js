import express from 'express';
import { prisma } from '../../lib/prisma.js';
import { upload } from '../../lib/multer.js';
const PRODUCTO_AUTH_ROUTER = express.Router();


PRODUCTO_AUTH_ROUTER.get("/", async (req, res) => {
    const productos = await prisma.producto.findMany()
    return res.json(productos)
})

PRODUCTO_AUTH_ROUTER.post("/", upload.single("imagen"), async (req, res) => {
    const { nombre, stock, precio } = req.body;
    const imagen = req.file;
    const producto = await prisma.producto.create({
        data: {
            imagen: "/uploads/" + imagen.filename,
            nombre,
            precio: +precio,
            stock: +stock,

        }
    })

    return res.json({ producto, estado: 200 }).status(200)

})


PRODUCTO_AUTH_ROUTER.put("/:id", upload.single('imagen'), async (req, res) => {
    const id = req.params.id;
    const { nombre, precio, stock } = req.body;
    const imagen = req.file;
    await prisma.producto.update(
        {
            where: { id },
            data: {
                nombre, precio: +precio, stock: +stock, imagen: "/uploads/" + imagen.filename
            }
        }
    )

    return res.json({ mensaje: "Producto actualizado" }).status(200)

})

export default PRODUCTO_AUTH_ROUTER;