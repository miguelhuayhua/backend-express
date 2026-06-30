import bcrypt from 'bcrypt';


export const hashPassword = (password) => {
    return bcrypt.hashSync(password, 10);
}


export const evaluarPassword = (password, hash) => {
    return bcrypt.compareSync(password, hash)
}