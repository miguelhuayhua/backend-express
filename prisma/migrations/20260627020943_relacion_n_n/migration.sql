-- CreateTable
CREATE TABLE "marca" (
    "id" UUID NOT NULL,
    "nombre" TEXT NOT NULL,
    "laboratorio" TEXT NOT NULL,
    "pais_origen" TEXT NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modificado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "marca_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_marcaToproveedor" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL,

    CONSTRAINT "_marcaToproveedor_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_marcaToproveedor_B_index" ON "_marcaToproveedor"("B");

-- AddForeignKey
ALTER TABLE "_marcaToproveedor" ADD CONSTRAINT "_marcaToproveedor_A_fkey" FOREIGN KEY ("A") REFERENCES "marca"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_marcaToproveedor" ADD CONSTRAINT "_marcaToproveedor_B_fkey" FOREIGN KEY ("B") REFERENCES "proveedor"("id") ON DELETE CASCADE ON UPDATE CASCADE;
