-- CreateEnum
CREATE TYPE "rol" AS ENUM ('admin', 'cajero');

-- CreateTable
CREATE TABLE "usuario" (
    "id" UUID NOT NULL,
    "nombre" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "rol" "rol" NOT NULL DEFAULT 'cajero',
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "token_sis" (
    "id" UUID NOT NULL,
    "usuario_id" UUID NOT NULL,
    "token" TEXT NOT NULL,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expira_en" TIMESTAMP(3) NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "token_sis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "detalle_cajero" (
    "id" UUID NOT NULL,
    "usuario_id" UUID NOT NULL,
    "turno" TEXT NOT NULL,
    "caja_asignada" TEXT NOT NULL,

    CONSTRAINT "detalle_cajero_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuario_email_key" ON "usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "token_sis_usuario_id_key" ON "token_sis"("usuario_id");

-- CreateIndex
CREATE UNIQUE INDEX "detalle_cajero_usuario_id_key" ON "detalle_cajero"("usuario_id");

-- AddForeignKey
ALTER TABLE "token_sis" ADD CONSTRAINT "token_sis_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "detalle_cajero" ADD CONSTRAINT "detalle_cajero_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
