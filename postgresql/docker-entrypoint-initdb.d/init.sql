CREATE TABLE "invoice" (
	"invoce_tax" DOUBLE PRECISION NOT NULL,
	"invoice_before" DOUBLE PRECISION NOT NULL,
	"paid" BOOLEAN NOT NULL,
	"id_invoice_deduction" integer NOT NULL,
	"id_invoice" serial NOT NULL,
	CONSTRAINT "invoice_pk" PRIMARY KEY ("id_invoice")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "invoice_deduction" (
	"id_invoice" integer NOT NULL,
	"id_invoice_deduction" serial NOT NULL,
	"value" integer NOT NULL,
	"id_invoice_tag" integer NOT NULL,
	CONSTRAINT "invoice_deduction_pk" PRIMARY KEY ("id_invoice_deduction")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "invoice_tags" (
	"invoice_tag" TEXT NOT NULL UNIQUE,
	"id_invoice_tag" serial NOT NULL UNIQUE,
	CONSTRAINT "invoice_tags_pk" PRIMARY KEY ("id_invoice_tag")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "expense" (
	"id_expense" serial NOT NULL,
	"timestamp" timestamp with time zone NOT NULL,
	"value" TEXT NOT NULL,
	"metadata" jsonb NOT NULL,
	"id_expense_category" integer NOT NULL,
	CONSTRAINT "expense_pk" PRIMARY KEY ("id_expense")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "expense_tag" (
	"id_expense" integer NOT NULL,
	"id_expense_tag" integer NOT NULL,
	"expense_tag" TEXT NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "expense_forecast" (
	"id_expense_forecast" serial NOT NULL,
	"id_expense_fk" integer NOT NULL,
	"forecast_value" DOUBLE PRECISION NOT NULL,
	CONSTRAINT "expense_forecast_pk" PRIMARY KEY ("id_expense_forecast")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "expense_sum" (
	"id_expense_sum" serial NOT NULL,
	"id_expense" integer NOT NULL,
	"expense_sum" DOUBLE PRECISION NOT NULL,
	CONSTRAINT "expense_sum_pk" PRIMARY KEY ("id_expense_sum")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "expense_category" (
	"id_expense_category" serial NOT NULL,
	"value" serial NOT NULL,
	"metadata" jsonb NOT NULL,
	CONSTRAINT "expense_category_pk" PRIMARY KEY ("id_expense_category")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "invoice_expanse" (
	"id_invoice" integer NOT NULL UNIQUE,
	"id_expense" integer NOT NULL UNIQUE
) WITH (
  OIDS=FALSE
);



CREATE TABLE "expense_limit" (

) WITH (
  OIDS=FALSE
);



ALTER TABLE "invoice" ADD CONSTRAINT "invoice_fk0" FOREIGN KEY ("id_invoice_deduction") REFERENCES "invoice_deduction"("id_invoice_deduction");

ALTER TABLE "invoice_deduction" ADD CONSTRAINT "invoice_deduction_fk0" FOREIGN KEY ("id_invoice") REFERENCES "invoice"("id_invoice");
ALTER TABLE "invoice_deduction" ADD CONSTRAINT "invoice_deduction_fk1" FOREIGN KEY ("id_invoice_tag") REFERENCES "invoice_tags"("id_invoice_tag");


ALTER TABLE "expense" ADD CONSTRAINT "expense_fk0" FOREIGN KEY ("id_expense_category") REFERENCES "expense_category"("id_expense_category");

ALTER TABLE "expense_tag" ADD CONSTRAINT "expense_tag_fk0" FOREIGN KEY ("id_expense") REFERENCES "expense"("id_expense");

ALTER TABLE "expense_forecast" ADD CONSTRAINT "expense_forecast_fk0" FOREIGN KEY ("id_expense_fk") REFERENCES "expense"("id_expense");

ALTER TABLE "expense_sum" ADD CONSTRAINT "expense_sum_fk0" FOREIGN KEY ("id_expense") REFERENCES "expense"("id_expense");


ALTER TABLE "invoice_expanse" ADD CONSTRAINT "invoice_expanse_fk0" FOREIGN KEY ("id_invoice") REFERENCES "invoice"("id_invoice");
ALTER TABLE "invoice_expanse" ADD CONSTRAINT "invoice_expanse_fk1" FOREIGN KEY ("id_expense") REFERENCES "expense"("id_expense");
