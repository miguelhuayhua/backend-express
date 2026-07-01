/*
  Warnings:

  - You are about to drop the `compra` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[codigo_barra]` on the table `producto` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `password` to the `cliente` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "compra" DROP CONSTRAINT "compra_id_cliente_fkey";

-- DropForeignKey
ALTER TABLE "compra" DROP CONSTRAINT "compra_id_producto_fkey";

-- DropIndex
DROP INDEX "producto_proveedor_id_key";

-- DropIndex
DROP INDEX "token_sis_usuario_id_key";

-- AlterTable
ALTER TABLE "cliente" ADD COLUMN     "password" TEXT NOT NULL,
ALTER COLUMN "email" DROP NOT NULL,
ALTER COLUMN "activo" SET DEFAULT true,
ALTER COLUMN "modificado_en" DROP DEFAULT;

-- AlterTable
ALTER TABLE "marca" ALTER COLUMN "modificado_en" DROP DEFAULT;

-- AlterTable
ALTER TABLE "producto" ADD COLUMN     "codigo_barra" TEXT,
ADD COLUMN     "fecha_vencimiento" TIMESTAMP(3),
ADD COLUMN     "marca_id" UUID,
ADD COLUMN     "requiere_receta" BOOLEAN NOT NULL DEFAULT false,
ALTER COLUMN "modificado_en" DROP DEFAULT,
ALTER COLUMN "activo" SET DEFAULT true;

-- AlterTable
ALTER TABLE "proveedor" ALTER COLUMN "activo" SET DEFAULT true,
ALTER COLUMN "modificado_en" DROP DEFAULT;

-- DropTable
DROP TABLE "compra";

-- CreateTable
CREATE TABLE "venta" (
    "id" UUID NOT NULL,
    "total" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cliente_id" UUID,
    "usuario_id" UUID NOT NULL,

    CONSTRAINT "venta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "detalle_venta" (
    "id" UUID NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "precio_unitario" DOUBLE PRECISION NOT NULL,
    "subtotal" DOUBLE PRECISION NOT NULL,
    "venta_id" UUID NOT NULL,
    "producto_id" UUID NOT NULL,

    CONSTRAINT "detalle_venta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "token_cli" (
    "id" UUID NOT NULL,
    "id_cliente" UUID NOT NULL,
    "token" TEXT NOT NULL,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expira_en" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "estado" BOOLEAN NOT NULL,

    CONSTRAINT "token_cli_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "producto_codigo_barra_key" ON "producto"("codigo_barra");

-- AddForeignKey
ALTER TABLE "producto" ADD CONSTRAINT "producto_marca_id_fkey" FOREIGN KEY ("marca_id") REFERENCES "marca"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venta" ADD CONSTRAINT "venta_cliente_id_fkey" FOREIGN KEY ("cliente_id") REFERENCES "cliente"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venta" ADD CONSTRAINT "venta_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "detalle_venta" ADD CONSTRAINT "detalle_venta_venta_id_fkey" FOREIGN KEY ("venta_id") REFERENCES "venta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "detalle_venta" ADD CONSTRAINT "detalle_venta_producto_id_fkey" FOREIGN KEY ("producto_id") REFERENCES "producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "token_cli" ADD CONSTRAINT "token_cli_id_cliente_fkey" FOREIGN KEY ("id_cliente") REFERENCES "cliente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
