import express from 'express';
import { prisma } from '../../lib/prisma.js';

export const MARCAS_AUTH_ROUTER = express.Router();



MARCAS_AUTH_ROUTER.get("/", async (req, res) => {
    let marcas = await prisma.marca.findMany();
    return res.json(marcas).status(200)
})