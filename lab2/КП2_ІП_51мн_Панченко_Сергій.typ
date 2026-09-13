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
      *Комп'ютерний практикум №2*

      Бізнес-аналіз в IT
    ]

    Тема: Матриця зацікавлених сторін для проєкту "Піцерія"
  ]

  #columns(2, gutter: 8pt)[
    #align(left)[
      Виконав:

      студент групи ІП-51мн

      Панченко С. В.
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
    set align(center)
    set text(weight: "regular", size: 18pt)
    pagebreak()
    upper(it)
  } else {
    set text(weight: "regular", size: 14pt)
    it
  }
}

#show figure: it => {
  set align(center)
  it.body
  v(8pt, weak: true)
  it.supplement
  [ ]
  context (it.counter.display(it.numbering))
  [ — ]
  it.caption.body
}
#set figure(
  supplement: [Рисунок],
  numbering: (num) => {
    context {
      let h-num = counter(heading).at(here()).at(0)
      str(h-num) + "." + str(num)
    }
  }
)

#set par(first-line-indent: (amount: 1.25cm, all: true), justify: true, leading: 1em, spacing: 1em)
#set list(indent: 1.25cm)
#set enum(indent: 1.25cm)

#let stakeholders = (
  (
    code: "S",
    name: "Sponsor / Owner",
    influence: 100,
    interest: 100,
    support: 100,
    color: rgb("#d33f49"),
    shift: (0.16, 0.12),
    reason: "Власник фінансує ініціативу, визначає бізнес-цілі та очікує зростання онлайн-продажів.",
  ),
  (
    code: "BA",
    name: "Business Analyst / Product Owner",
    influence: 93,
    interest: 93,
    support: 100,
    color: rgb("#d33f49"),
    shift: (0.16, -0.18),
    reason: "Формує вимоги, узгоджує очікування бізнесу та команди, впливає на зміст рішення.",
  ),
  (
    code: "PM",
    name: "Project Manager",
    influence: 90,
    interest: 83,
    support: 87,
    color: rgb("#f19a38"),
    shift: (0.14, 0.10),
    reason: "Керує строками, ресурсами та організацією роботи команди.",
  ),
  (
    code: "C",
    name: "Customers / End Users",
    influence: 80,
    interest: 100,
    support: 80,
    color: rgb("#2780c2"),
    shift: (0.12, -0.18),
    reason: "Користувачі напряму визначають успішність сайту, але не приймають формальних проєктних рішень.",
  ),
  (
    code: "BM",
    name: "Branch Managers",
    influence: 87,
    interest: 87,
    support: 77,
    color: rgb("#5a9f51"),
    shift: (0.16, 0.10),
    reason: "Керівники піцерій відповідають за роботу точок, виконання замовлень і локальні операційні правила.",
  ),
  (
    code: "KS",
    name: "Kitchen Staff",
    influence: 67,
    interest: 83,
    support: 67,
    color: rgb("#5a9f51"),
    shift: (0.12, -0.18),
    reason: "Працівники кухні виконують замовлення, тому їхня робота зміниться після запуску сайту.",
  ),
  (
    code: "CR",
    name: "Couriers",
    influence: 63,
    interest: 80,
    support: 57,
    color: rgb("#5a9f51"),
    shift: (0.14, 0.10),
    reason: "Кур'єри залучені до доставки й оплати при отриманні, але можуть обережно ставитися до нових процесів.",
  ),
  (
    code: "DEV",
    name: "Implementation SME / Developers",
    influence: 70,
    interest: 67,
    support: 80,
    color: rgb("#7c5cc4"),
    shift: (0.12, -0.18),
    reason: "Розробники визначають технічну реалізацію каталогу, замовлення, інтеграцій і адмін-функцій.",
  ),
  (
    code: "QA",
    name: "Tester / QA",
    influence: 60,
    interest: 60,
    support: 73,
    color: rgb("#7c5cc4"),
    shift: (0.14, 0.10),
    reason: "Тестувальники перевіряють коректність замовлення, фільтрів, сторінок товарів і інтеграцій.",
  ),
  (
    code: "OPS",
    name: "Operational Support",
    influence: 57,
    interest: 67,
    support: 60,
    color: rgb("#7c5cc4"),
    shift: (0.12, -0.18),
    reason: "Підтримка оброблятиме інциденти, звернення користувачів і проблеми після запуску.",
  ),
  (
    code: "PAY",
    name: "Payment Provider",
    influence: 80,
    interest: 47,
    support: 67,
    color: rgb("#586f7c"),
    shift: (0.14, 0.10),
    reason: "Потрібний для бажаної функції оплати карткою, має технічні та юридичні вимоги до інтеграції.",
  ),
  (
    code: "CRM",
    name: "Discount Card / CRM Provider",
    influence: 67,
    interest: 50,
    support: 70,
    color: rgb("#586f7c"),
    shift: (0.12, -0.18),
    reason: "Впливає на можливість використання дисконтних карток і персональних знижок.",
  ),
  (
    code: "REG",
    name: "Regulator / Auditor",
    influence: 90,
    interest: 30,
    support: 40,
    color: rgb("#586f7c"),
    shift: (0.14, 0.10),
    reason: "Має високий вплив через вимоги до платежів, персональних даних і споживчих правил, але не зацікавлений у продукті напряму.",
  ),
)

#let stakeholder-table-cells(data) = data.map(stakeholder => (
  [#stakeholder.code],
  [#stakeholder.name],
  [#str(stakeholder.influence)],
  [#str(stakeholder.interest)],
  [#str(stakeholder.support)],
  [#stakeholder.reason],
)).flatten()

#let scale-score(value) = value / 100 * 3

#let stakeholder-map(data) = {
  cetz.canvas(length: 1.9cm, {
    import cetz.draw: *

    let project(x, y, z) = (
      x * 1.25 + z * 0.72,
      y * 0.9 + z * 0.44,
    )

    let axis-stroke = (paint: rgb("#2f3a45"), thickness: 0.8pt)
    let grid-stroke = (paint: rgb("#c9d3dd"), thickness: 0.35pt)
    let back-stroke = (paint: rgb("#e1e7ed"), thickness: 0.3pt)

    for i in range(0, 4) {
      line(project(i, 0, 0), project(i, 3, 0), stroke: grid-stroke)
      line(project(0, i, 0), project(3, i, 0), stroke: grid-stroke)
      line(project(i, 0, 3), project(i, 3, 3), stroke: back-stroke)
      line(project(0, i, 3), project(3, i, 3), stroke: back-stroke)
      line(project(i, 0, 0), project(i, 0, 3), stroke: back-stroke)
      line(project(0, i, 0), project(0, i, 3), stroke: back-stroke)
    }

    line(project(0, 0, 0), project(3.35, 0, 0), stroke: axis-stroke)
    line(project(0, 0, 0), project(0, 3.35, 0), stroke: axis-stroke)
    line(project(0, 0, 0), project(0, 0, 3.35), stroke: axis-stroke)

    content(project(3.55, 0, 0), text(size: 8pt)[Influence])
    content(project(0, 3.55, 0), text(size: 8pt)[Interest])
    content(project(0, 0, 3.55), text(size: 8pt)[Support])

    content(project(0, -0.22, 0), text(size: 7pt)[0])
    content(project(1.5, -0.22, 0), text(size: 7pt)[50])
    content(project(3, -0.22, 0), text(size: 7pt)[100])
    content(project(-0.35, 0, 0), text(size: 7pt)[0])
    content(project(-0.38, 1.5, 0), text(size: 7pt)[50])
    content(project(-0.42, 3, 0), text(size: 7pt)[100])
    content(project(-0.18, -0.15, 0), text(size: 7pt)[0])
    content(project(-0.18, -0.15, 1.5), text(size: 7pt)[50])
    content(project(-0.18, -0.15, 3), text(size: 7pt)[100])

    // Plane projection dot helper
    let shadow(p, code, dot-color, text-color) = {
      circle(p, radius: 0.045, fill: dot-color, stroke: none)
      content(
        (p.at(0) + 0.10, p.at(1) - 0.06),
        text(size: 5pt, fill: text-color)[#code],
      )
    }

    // Color definitions per plane
    let floor-dot  = rgb("#3b82f6").lighten(20%) // Blue: Floor (Influence vs Support)
    let floor-text = rgb("#1d4ed8")
    let left-dot   = rgb("#f59e0b").lighten(20%) // Amber: Left wall (Interest vs Support)
    let left-text  = rgb("#b45309")
    let back-dot   = rgb("#10b981").lighten(20%) // Emerald: Back wall (Influence vs Interest)
    let back-text  = rgb("#047857")

    // Main 3D dot
    let dot(stakeholder) = {
      let x = scale-score(stakeholder.influence)
      let y = scale-score(stakeholder.interest)
      let z = scale-score(stakeholder.support)
      let code = stakeholder.code
      let shift = stakeholder.shift

      // 1. Distinct color per plane
      shadow(project(x, 0, z), code, floor-dot, floor-text)
      shadow(project(0, y, z), code, left-dot, left-text)
      shadow(project(x, y, 0), code, back-dot, back-text)

      // 2. Central 3D marker and label
      let p = project(x, y, z)
      circle(p, radius: 0.08, fill: stakeholder.color, stroke: black)
      content(
        (p.at(0) + shift.at(0), p.at(1) + shift.at(1)),
        box(fill: white, inset: 1pt, stroke: rgb("#d8dee4"), radius: 1pt)[#text(size: 7pt)[#code]],
      )
    }

    for stakeholder in data {
      dot(stakeholder)
    }
  })
}

#let stakeholder-projection(data, x-key, y-key, x-label, y-label) = {
  cetz.canvas(length: 3cm, {
    import cetz.draw: *

    let axis-stroke = (paint: rgb("#2f3a45"), thickness: 0.8pt)
    let grid-stroke = (paint: rgb("#d7dee6"), thickness: 0.35pt)

    for i in range(0, 4) {
      line((i, 0), (i, 3), stroke: grid-stroke)
      line((0, i), (3, i), stroke: grid-stroke)
    }

    line((0, 0), (3.25, 0), stroke: axis-stroke)
    line((0, 0), (0, 3.25), stroke: axis-stroke)

    content((1.5, -0.38), text(size: 7pt)[#x-label])
    content((-0.42, 1.5), text(size: 7pt)[#y-label], angle: 90deg)
    content((0, -0.18), text(size: 6pt)[0])
    content((1.5, -0.18), text(size: 6pt)[50])
    content((3, -0.18), text(size: 6pt)[100])
    content((-0.25, 0), text(size: 6pt)[0])
    content((-0.27, 1.5), text(size: 6pt)[50])
    content((-0.28, 3), text(size: 6pt)[100])

    for stakeholder in data {
      let x = scale-score(stakeholder.at(x-key))
      let y = scale-score(stakeholder.at(y-key))
      circle((x, y), radius: 0.065, fill: stakeholder.color, stroke: black)
      content(
        (x + 0.08, y + 0.08),
        box(fill: white, inset: 0.8pt, stroke: rgb("#d8dee4"), radius: 1pt)[
          #text(size: 5.5pt)[#stakeholder.code]
        ],
      )
    }
  })
}

= Мета

Метою комп'ютерного практикуму є створення карти зацікавлених сторін для проєкту розроблення вебсайту онлайн-замовлення піци для мережі піцерій, а також аналіз рівня впливу, зацікавленості та підтримки ключових стейкхолдерів.

= Завдання

+ Проаналізувати опис проєкту "Піцерія".
+ Визначити основні внутрішні та зовнішні групи зацікавлених сторін.
+ Побудувати об'ємну stakeholder map за трьома параметрами: Influence, Interest, Support.
+ Обґрунтувати розміщення кожної групи стейкхолдерів на карті.

= Опис проєкту

Замовник має мережу піцерій в англомовній країні та хоче створити вебсайт для онлайн-замовлення доставки піци. Сайт має бути простим, але привабливим для користувачів.

Основні вимоги до сайту:

+ показувати список товарів із фотографією, ціною та коротким описом;
+ відкривати окрему сторінку товару з більшою фотографією, повним описом, ціною, інгредієнтами та іншою інформацією;
+ підтримувати прості фільтри та сортування;
+ дозволяти створювати замовлення з оплатою кур'єру, без обов'язкової оплати на сайті.

Бажані додаткові можливості:

+ оплата кредитною карткою;
+ використання дисконтних карток.

= Виконання

Для побудови карти було використано об'ємну модель, у якій кожна група зацікавлених сторін оцінюється за трьома осями:

+ Influence - рівень впливу на проєкт і прийняття рішень.
+ Interest - рівень зацікавленості в результатах проєкту.
+ Support - очікуване ставлення до змін: від нейтрального або обережного до позитивного.

Шкала оцінювання: від 0 до 100, де 0 означає найнижчий рівень, 50 - середній рівень, а 100 - найвищий рівень. Для побудови графіків ці значення автоматично нормалізуються до координат полотна без зміни відносного положення точок.

== Об'ємна карта зацікавлених сторін

#figure(
  stakeholder-map(stakeholders),
  caption: [Об'ємна stakeholder map для проєкту вебсайту онлайн-замовлення піци]
)

== Двовимірні проєкції карти

Для уточнення положення точок на об'ємній карті побудовано три двовимірні проєкції: на площину XY, на площину YZ та на площину XZ.

#figure(
  stakeholder-projection(stakeholders, "influence", "interest", [Influence], [Interest]),
  caption: [Проєкція stakeholder map на площину XY: Influence / Interest]
)

#figure(
  stakeholder-projection(stakeholders, "interest", "support", [Interest], [Support]),
  caption: [Проєкція stakeholder map на площину YZ: Interest / Support]
)

#figure(
  stakeholder-projection(stakeholders, "influence", "support", [Influence], [Support]),
  caption: [Проєкція stakeholder map на площину XZ: Influence / Support]
)

== Реєстр зацікавлених сторін

#text(size: 11pt)[
  #table(
    columns: (9%, 27%, 9%, 9%, 9%, 37%),
    stroke: 0.5pt,
    inset: 3.5pt,
    table.header(
      [*Код*],
      [*Зацікавлена сторона*],
      [*Inf.*],
      [*Int.*],
      [*Sup.*],
      [*Обґрунтування*],
    ),
    ..stakeholder-table-cells(stakeholders),
  )
]

У таблиці використано скорочення: Inf. - Influence, Int. - Interest, Sup. - Support.

== Аналіз карти

До групи з найвищим впливом, зацікавленістю та підтримкою належать Sponsor / Owner, Business Analyst / Product Owner та Project Manager. Саме з ними потрібно підтримувати найтіснішу комунікацію, оскільки вони визначають бізнес-цілі, пріоритети, обсяг робіт і критерії успішності рішення.

Customers / End Users мають дуже високий рівень зацікавленості, бо сайт створюється саме для них. Їхній формальний вплив нижчий, ніж у спонсора, але їхня поведінка визначатиме фактичну успішність продукту. Тому для цієї групи доцільно використовувати інтерв'ю, опитування, тестування прототипів і аналіз поведінки на сайті.

Branch Managers, Kitchen Staff і Couriers є операційними стейкхолдерами. Вони не завжди ухвалюють стратегічні рішення, але саме їхня робота зміниться після впровадження онлайн-замовлень. Особливо важливо врахувати процес оплати кур'єру, передачу замовлення на кухню, обробку статусів і можливі помилки в адресах або складі замовлення.

Implementation SME, Tester і Operational Support представляють команду створення та підтримки рішення. Їх потрібно залучати до уточнення нефункціональних вимог, перевірки тестованості, обговорення стабільності сайту, обробки помилок та майбутньої підтримки.

Payment Provider, Discount Card / CRM Provider і Regulator / Auditor є зовнішніми стейкхолдерами. Їхня зацікавленість у самому проєкті нижча, але вони можуть суттєво впливати на вимоги. Особливо це стосується онлайн-оплати, захисту персональних даних, правил обробки платіжної інформації та інтеграції дисконтних карток.

= Висновок

У ході комп'ютерного практикуму було визначено основні зацікавлені сторони проєкту створення вебсайту для онлайн-замовлення піци. Для кожної групи було оцінено рівень впливу, зацікавленості та підтримки, після чого побудовано об'ємну stakeholder map за допомогою пакета CeTZ у Typst.

Отримана карта показує, що найбільш критичними для успіху проєкту є Sponsor / Owner, Business Analyst / Product Owner, Project Manager, Customers / End Users та операційні працівники мережі піцерій. Саме ці групи потрібно активно залучати до виявлення вимог, перевірки прототипів і погодження майбутнього процесу онлайн-замовлення.

Зовнішні стейкхолдери мають нижчий рівень зацікавленості, але їхній вплив не можна ігнорувати, оскільки вони визначають обмеження для платежів, дисконтних карток, персональних даних і відповідності рішення регуляторним вимогам.
