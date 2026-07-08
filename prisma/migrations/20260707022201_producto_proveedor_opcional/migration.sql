-- DropForeignKey
ALTER TABLE "producto" DROP CONSTRAINT "producto_proveedor_id_fkey";

-- AlterTable
ALTER TABLE "producto" ALTER COLUMN "proveedor_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "producto" ADD CONSTRAINT "producto_proveedor_id_fkey" FOREIGN KEY ("proveedor_id") REFERENCES "proveedor"("id") ON DELETE SET NULL ON UPDATE CASCADE;
