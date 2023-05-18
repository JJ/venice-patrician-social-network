#!/usr/bin/env Rscript

marriages.raw <- read.csv("data-raw/venice_marriages_puga_treffler_families.csv")
save(marriages.raw, file="data/venice-marriages.rda")

