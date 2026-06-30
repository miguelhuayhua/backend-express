/*
  Warnings:

  - The primary key for the `producto` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `cantidad` on the `producto` table. All the data in the column will be lost.
  - You are about to drop the column `estado` on the `producto` table. All the data in the column will be lost.
  - You are about to drop the column `titulo` on the `producto` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[proveedor_id]` on the table `producto` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `nombre` to the `producto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `proveedor_id` to the `producto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `stock` to the `producto` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `id` on the `producto` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropIndex
DROP INDEX "producto_titulo_key";

-- AlterTable
ALTER TABLE "producto" DROP CONSTRAINT "producto_pkey",
DROP COLUMN "cantidad",
DROP COLUMN "estado",
DROP COLUMN "titulo",
ADD COLUMN     "activo" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "nombre" TEXT NOT NULL,
ADD COLUMN     "proveedor_id" UUID NOT NULL,
ADD COLUMN     "stock" INTEGER NOT NULL,
DROP COLUMN "id",
ADD COLUMN     "id" UUID NOT NULL,
ADD CONSTRAINT "producto_pkey" PRIMARY KEY ("id");

-- CreateTable
CREATE TABLE "proveedor" (
    "id" UUID NOT NULL,
    "nombre" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT false,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modificado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "proveedor_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "proveedor_email_key" ON "proveedor"("email");

-- CreateIndex
CREATE UNIQUE INDEX "producto_proveedor_id_key" ON "producto"("proveedor_id");

-- AddForeignKey
ALTER TABLE "producto" ADD CONSTRAINT "producto_proveedor_id_fkey" FOREIGN KEY ("proveedor_id") REFERENCES "proveedor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
