-- CreateTable
CREATE TABLE "cliente" (
    "id" UUID NOT NULL,
    "nombre" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT false,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modificado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "cliente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "compra" (
    "id" UUID NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cantidad" INTEGER NOT NULL DEFAULT 0,
    "precio_unitario" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "activo" BOOLEAN NOT NULL DEFAULT false,
    "id_cliente" UUID NOT NULL,
    "id_producto" UUID NOT NULL,

    CONSTRAINT "compra_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "cliente_telefono_key" ON "cliente"("telefono");

-- CreateIndex
CREATE UNIQUE INDEX "cliente_email_key" ON "cliente"("email");

-- AddForeignKey
ALTER TABLE "compra" ADD CONSTRAINT "compra_id_cliente_fkey" FOREIGN KEY ("id_cliente") REFERENCES "cliente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "compra" ADD CONSTRAINT "compra_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
