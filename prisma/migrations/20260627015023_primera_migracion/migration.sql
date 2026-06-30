-- CreateTable
CREATE TABLE "producto" (
    "id" INTEGER NOT NULL,
    "titulo" TEXT NOT NULL,
    "precio" DOUBLE PRECISION NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT false,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modificado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "producto_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "producto_titulo_key" ON "producto"("titulo");
