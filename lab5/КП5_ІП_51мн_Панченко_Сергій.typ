#import "@preview/cetz:0.4.2"

#set text(font: "Times New Roman", size: 14pt)
#set page(
  paper: "a4",
  margin: (top: 1.5cm, bottom: 1.5cm, left: 2.5cm, right: 1.5cm)
)

#align(center)[
  #image("kpi.svg", width: 75%)

  Міністерство освіти і науки України

  Національний технічний університет України

  "Київський політехнічний інститут імені Ігоря Сікорського"

  Факультет інформатики та обчислювальної техніки

  Кафедра інформатики та програмної інженерії

  #align(horizon)[
    #text(size: 18pt)[
      *Комп'ютерний практикум №5*

      Бізнес-аналіз в IT
    ]

    Тема: Lean Model Canvas для стартапу "Онлайн школа"
  ]

  #columns(2, gutter: 8pt)[
    #align(left)[
      Виконали:

      студент групи ІП-51мн

      Панченко С., Пустовєтов П., Тарасов А.
    ]

    #colbreak()

    #align(right)[
      Перевірив:

      Гобов Д. А.
    ]
  ]
]

#align(center + bottom)[
  Київ 2026
]

#set page(numbering: "1")
#show outline: it => {
  show heading: set align(center)
  show heading: set text(weight: "regular")
  it
}
#outline(title: upper([Зміст]))

#set heading(numbering: (..nums) => nums.pos().map(str).join("."))
#show heading: it => {
  if it.level == 1 {
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: image)).update(0)
    set align(center)
    set text(weight: "regular", size: 18pt)
    pagebreak()
    upper(it)
  } else {
    set text(weight: "regular", size: 14pt)
    it
  }
}

#let figure-numbering(num) = context {
  let h-num = counter(heading).at(here()).at(0)
  str(h-num) + "." + str(num)
}

#show figure.where(kind: table): set block(breakable: true)
#show figure.where(kind: table): it => {
  align(left)[
    #it.supplement #context (it.counter.display(it.numbering)) #it.caption.body
  ]
  v(10pt, weak: true)
  align(center)[#it.body]
}
#show figure.where(kind: image): it => {
  set align(center)
  it.body
  v(8pt, weak: true)
  it.supplement
  [ ]
  context (it.counter.display(it.numbering))
  [ — ]
  it.caption.body
}

#set figure(numbering: figure-numbering)
#show figure.where(kind: image): set figure(supplement: [Рисунок])
#show figure.where(kind: table): set figure(supplement: [Таблиця])

#set table(stroke: 0.5pt, inset: 5pt)
#set par(first-line-indent: (amount: 1.25cm, all: true), justify: true, leading: 1em, spacing: 1em)
#set list(indent: 1.25cm)
#set enum(indent: 1.25cm)

#let canvas-block(width, title, body) = box(width: width)[
  #set par(first-line-indent: 0pt, justify: false, leading: 0.72em, spacing: 0pt)
  #text(size: 7.3pt, weight: "bold")[#title]
  #v(2pt)
  #text(size: 6.5pt)[#body]
]

#let lean-canvas = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    let stroke-main = (paint: rgb("#1f2937"), thickness: 0.55pt)
    let fill-main = rgb("#fbfdff")
    let fill-accent = rgb("#eef6ff")
    let fill-center = rgb("#fff7ed")

    let cell(x, y, w, h, title, body, fill: fill-main) = {
      rect((x, y), (rel: (w, h)), stroke: stroke-main, fill: fill)
      content(
        (x + 0.12, y + h - 0.16),
        anchor: "north-west",
        canvas-block((w - 0.24) * 1cm, title, body),
      )
    }

    cell(0, 4.2, 3.0, 4.2, [Проблеми], [
      • різна якість онлайн-навчання \
      • розрізнені матеріали \
      • складний контроль прогресу
    ], fill: fill-accent)
    cell(0, 2.1, 3.0, 2.1, [Існуючі альтернативи], [
      • Zoom/Meet \
      • Google Classroom \
      • месенджери й файли
    ])

    cell(3.0, 4.2, 3.0, 4.2, [Рішення], [
      • єдина LMS для школи \
      • розклад і уроки \
      • завдання, оцінки, кабінети
    ])
    cell(3.0, 2.1, 3.0, 2.1, [Ключові метрики], [
      • активні школи \
      • відвідуваність \
      • виконані завдання
    ])

    cell(6.0, 2.1, 3.0, 6.3, [Унікальна ціннісна пропозиція], [
      Швидке впровадження онлайн-школи без власної IT-команди. \
      \
      Навчання, контроль і комунікація в одному середовищі.
    ], fill: fill-center)

    cell(9.0, 4.2, 3.0, 4.2, [Канали], [
      • прямі продажі школам \
      • пілотні впровадження \
      • освітні події \
      • рекомендації
    ])
    cell(9.0, 2.1, 3.0, 2.1, [Несправедлива перевага], [
      • локалізація \
      • шаблони процесів \
      • знання потреб шкіл
    ])

    cell(12.0, 2.1, 3.0, 6.3, [Сегменти клієнтів], [
      • приватні школи \
      • державні заклади \
      • навчальні центри \
      \
      Ранні послідовники - школи зі змішаним навчанням.
    ], fill: fill-accent)

    cell(0, 0, 7.5, 2.1, [Структура витрат], [
      • розробка та підтримка платформи \
      • хмарна інфраструктура \
      • підтримка користувачів \
      • продажі та навчання персоналу
    ])
    cell(7.5, 0, 7.5, 2.1, [Потоки доходів], [
      • щомісячна підписка за школу \
      • тариф за кількістю учнів \
      • платне впровадження \
      • додаткові модулі
    ])
  })
}

= Мета

Створити бізнес-модель для стартапу у форматі Lean Model Canvas.

= Завдання

Ідея стартапу - універсальне рішення "Онлайн школа" для впровадження в навчальних закладах України.

Для цієї ідеї обрано бережливу канву, оскільки продукт перебуває на рівні стартап-гіпотези. Lean Canvas дозволяє коротко описати проблему, сегменти клієнтів, рішення, канали, доходи, витрати та метрики, які потрібні для перевірки життєздатності ідеї.

= Виконання

== Lean Model Canvas

#figure(
  lean-canvas,
  caption: [Lean Model Canvas для стартапу "Онлайн школа"],
  kind: image,
)

== Опис канви

#figure(
  {
    set par(first-line-indent: 0pt, justify: false, leading: 0.82em, spacing: 0pt)
    table(
      columns: (28%, 72%),
      align: left,
      table.header([*Блок*], [*Зміст*]),
      [Проблеми], [Навчальні заклади використовують розрізнені інструменти для уроків, завдань, комунікації та контролю прогресу.],
      [Сегменти клієнтів], [Приватні школи, державні навчальні заклади та навчальні центри. Ранні послідовники - школи з досвідом змішаного або дистанційного навчання.],
      [Унікальна ціннісна пропозиція], [Школа отримує готову онлайн-платформу без потреби створювати власне IT-рішення.],
      [Рішення], [Система об'єднує розклад, уроки, матеріали, завдання, оцінювання і комунікацію між учасниками навчального процесу.],
      [Канали], [Продажі напряму школам, пілотні впровадження, освітні події та рекомендації вчителів.],
      [Потоки доходів], [Підписка за школу або кількість учнів, платне впровадження, навчання персоналу та додаткові модулі.],
      [Структура витрат], [Розробка, хмарна інфраструктура, технічна підтримка, навчання користувачів і продажі.],
      [Ключові метрики], [Кількість активних шкіл, регулярність використання, виконані завдання, утримання користувачів.],
      [Несправедлива перевага], [Локалізація під українські школи, готові шаблони освітніх процесів і знання потреб навчальних закладів.]
    )
  },
  caption: [Пояснення блоків Lean Canvas],
  kind: table,
)

= Висновок

У роботі було сформовано Lean Model Canvas для стартапу "Онлайн школа". Канва показує основні проблеми навчальних закладів, цільові сегменти клієнтів, ціннісну пропозицію, рішення, канали просування, джерела доходів, структуру витрат і метрики перевірки успішності продукту. Запропонована модель може бути використана як основа для перевірки стартап-гіпотези через пілотне впровадження в кількох навчальних закладах.
