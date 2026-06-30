import jwt from 'jsonwebtoken';



export const generarAccesToken = (payload) => {
    return jwt.sign(payload, process.env.ACCESS_TOKEN_SECRET, { expiresIn: "10m" })
}

export const generarRefreshToken = (payload) => {
    return jwt.sign(payload, process.env.REFRESH_TOKEN_SECRET, { expiresIn: "7d" })
}

export const verificarToken = (token, tipo) => {
    if (tipo == 'access') return jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
    if (tipo == 'refresh') return jwt.verify(token, process.env.REFRESH_TOKEN_SECRET);
}