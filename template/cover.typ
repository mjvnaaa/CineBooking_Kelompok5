// cover.typ
#let cover_page(
  title: "",
  semester: "",
  team_number: "",
  members: ()
) = {
  set page(numbering: none)
  align(center)[
    #v(2em)
    #text(size: 16pt, weight: "bold")[POLITEKNIK NEGERI BANYUWANGI]
    #text(size: 14pt)[JURUSAN TEKNOLOGI INFORMASI]
    #text(size: 14pt)[PROGRAM STUDI TEKNIK REKAYASA PERANGKAT LUNAK]
    #v(2em)

    #text(size: 18pt, weight: "bold")[#title]
    #v(1em)
    #text(size: 14pt)[Pemrograman Perangkat Bergerak]
    #linebreak()
    #text(size: 14pt)[Semester #semester]

    #v(4em)
    #text(size: 14pt, weight: "bold")[KELOMPOK #team_number]
    #v(1em)

    // Tabel Anggota
    #table(
      columns: (1fr, auto, 1fr),
      stroke: none,
      align: (left, left, left),
      ..members.map(m => (
        text(weight: "bold")[#m.name],
        [#m.nim],
        text(style: "italic")[#m.role]
      )).flatten()
    )

    #v(1fr)
    #text(size: 12pt)[Dosen Pengampu: Tri Hadiah Mulia Bunda, S.Kom., M.T.]
    #text(size: 12pt)[Desember 2024]
  ]
}