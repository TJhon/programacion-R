library(tidyverse)
library(readxl)
library(here)
#install.packages("janitor")
#install.packages("lubridate")
library(janitor)
library(lubridate)

df <- read_excel(here("data", "B-zona.csv")) %>% 
  clean_names()
sbs <- df %>% 
  fill(x1) %>% 
  select(!fuente_anexo_10_depositos_colocaciones_y_personal_por_oficinas) %>% 
  rename(reg = 1, 
         provincia = 2,
         distrito = 3) %>% 
  filter(!str_detect(reg, "[Tt]otal")) %>% 
  fill(provincia) %>% 
  mutate(fecha = as.numeric(reg)) %>% 
  fill(fecha) %>% 
  drop_na(x5) %>% 
  relocate(fecha, reg, provincia, distrito) %>% 
  select(1:4, x6, x9, x12, x15, x18) %>% 
  filter(!str_detect(reg, "Departamento")) %>% 
  rename("Creditos directos" = x6,
         "Depositos a la vista" = x9, 
         "Depositos de ahorro" = x12,
         "Depositos a plazo" = x15,
         "Depositos totales" = x18) %>% 
  mutate(fecha = as_date(fecha, origin = "1899-12-30")) %>% 
  mutate(anio = year(fecha),
         mes = month(fecha)) %>% 
  relocate(anio, mes) %>% 
  select(!fecha)


sbs <- 
  sbs %>% 
  group_by(anio, mes, reg, provincia, distrito) %>% 
  summarise_all(parse_number) %>% 
  ungroup()

# total por regiones

region <- sbs %>% 
  group_by(anio, mes, reg) %>% 
  select(!c(provincia, distrito)) %>% 
  summarise_all(sum) %>% 
  filter(!str_detect(reg, "Callao"))
provincia <- 
  sbs %>% 
  select(!c(distrito, reg)) %>% 
  group_by(anio, mes, provincia) %>% 
  summarise_all(sum)

provincia %>% 
  pivot_longer(!c(anio, mes, provincia))



## Limpiar varios archivos a la vez :v



df1 <- dir(here("data"), full.names = T) %>% 
  map_df(read_excel, range = "A1:R286") %>% 
  clean_names()

si_trabajo_sbs_orden_datos <- function(df){
  df %>% 
  fill(x1) %>% 
  select(1:18) %>% 
  rename(reg = 1, 
         provincia = 2,
         distrito = 3) %>% 
  filter(!str_detect(reg, "[Tt]otal")) %>% 
  fill(provincia) %>% 
  mutate(fecha = as.numeric(reg)) %>% 
  fill(fecha) %>% 
  drop_na(x5) %>% 
  relocate(fecha, reg, provincia, distrito) %>% 
  select(1:4, x6, x9, x12, x15, x18) %>% 
  filter(!str_detect(reg, "Departamento")) %>% 
  rename("Creditos directos" = x6,
         "Depositos a la vista" = x9, 
         "Depositos de ahorro" = x12,
         "Depositos a plazo" = x15,
         "Depositos totales" = x18) %>% 
  mutate(fecha = as_date(fecha, origin = "1899-12-30")) %>% 
  mutate(anio = year(fecha),
         mes = month(fecha)) %>% 
  relocate(anio, mes) %>% 
  select(!fecha)
}

df1 %>% 
  si_trabajo_sbs_orden_datos() %>% 
  saveRDS(here("data", "sbs.rds"))



















