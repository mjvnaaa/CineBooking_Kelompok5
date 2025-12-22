// main.typ
#import "conf.typ": project
#import "cover.typ": cover_page

#let members_data = (
  (name: "Moh. Jevon Attaillah", nim: "362458302035", role: "Backend Engineer & Data Seeder"),
  (name: "Adelia Fioren Zety", nim: "362458302124", role: "UI Engineer - Home Module"),
  (name: "Intan Rahma Safira", nim: "362458302099", role: "UI Engineer - Seat Matrix"),
  (name: "Salam Rizqi Mulia", nim: "362458302041", role: "Logic Controller"),
  (name: "Achmad Alfarizy Satriya G", nim: "362458302147", role: "QA Lead, Auth & Profile"),
)

#show: doc => project(
  title: "Laporan Final Project: CineBooking App",
  semester: "3 (Tiga)",
  team_number: "03",
  members: members_data,
  doc
)

// Generate Cover
#cover_page(
  title: "Laporan Final Project: CineBooking App",
  semester: "3 (Tiga)",
  team_number: "03",
  members: members_data
)

// Include Bab-bab
#include "chapters/bab1.typ"
#include "chapters/bab2.typ"
#include "chapters/bab3.typ"
#include "chapters/bab4.typ"
#include "chapters/bab5.typ"
#include "chapters/bab6.typ"
#include "chapters/bab7.typ"
#include "chapters/bab8.typ"