import express from 'express';
import PROVEEDORES_ROUTER from './routes/proveedores.js';
import { LOGIN_ROUTER } from './routes/login.js';
import AUTH_INDEX_ROUTER from './auth/index.js';
import { verificarToken } from './helpers/tokens.js';
const server = express();

server.use(express.json())


server.use("/api/proveedores", PROVEEDORES_ROUTER);

//RUTAS PARA EL LOGIN 
server.use("/api/login", LOGIN_ROUTER);

const middleware = (req, res, next) => {
    let token = req.headers.authorization;
    token = token.split(" ")[1]
    const payload = verificarToken(token, "access");
    if (payload) next()
    else {
        res.json({ mensaje: "No autorizado" }).status(401)
    }
}

//RUTA INDEX PROTEGIDA 
server.use("/api/auth", middleware, AUTH_INDEX_ROUTER)

server.listen(8000, () => {
    console.log("Servidor corriendo en el puerto 8000")
})


