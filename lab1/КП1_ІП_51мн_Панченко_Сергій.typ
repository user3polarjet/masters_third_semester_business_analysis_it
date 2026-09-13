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
      *Комп'ютерний практикум №1*

      Бізнес-аналіз в IT
    ]

    Тема: Аналіз зацікавлених осіб. RACI матриця
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

#set par(first-line-indent: (amount: 1.25cm, all: true), justify: true, leading: 1em, spacing: 1em)
#set list(indent: 1.25cm)
#set enum(indent: 1.25cm)
#set table(
  stroke: 0.5pt,
  inset: 5pt,
  align: (left, left, left, left, left),
)

= Мета

Метою комп'ютерного практикуму є ознайомлення з підходами до аналізу зацікавлених осіб у бізнес-аналізі, визначення основних класів стейкхолдерів та побудова RACI матриці для розподілу ролей і відповідальності в межах типових проєктних активностей.

= Завдання

+ Розглянути основні класи зацікавлених осіб, які можуть брати участь в IT-проєкті.
+ Визначити ролі RACI для основних проєктних активностей: Project planning, Elicitation, Requirement analysis, Testing.
+ Заповнити RACI матрицю з урахуванням правил: для кожної активності має бути щонайменше один Responsible та рівно один Accountable.
+ Надати коротке обґрунтування розподілу ролей у матриці.

= Виконання

RACI матриця використовується для опису відповідальності за виконання задач у проєкті. У межах комп'ютерного практикуму використовуються такі позначення:

+ R - Responsible: виконує роботу.
+ A - Accountable: відповідає за результат.
+ C - Consulted: консультує під час виконання роботи.
+ I - Informed: інформується щодо результатів.

Можливі комбінації ролей: AR, CI. У комірках матриці зазначаються класи зацікавлених осіб.

== Класи зацікавлених осіб

#figure(
  table(
    columns: (32%, 68%),
    table.header(
      [*Generic Stakeholder*],
      [*Examples and Alternate Roles*],
    ),
    [Business Analyst], [Business Systems Analyst, Systems Analyst, Process Analyst, Consultant, Product Owner, etc.],
    [Customer], [Segmented by market, geography, industry, etc.],
    [Domain SME], [Broken out by organizational unit, job role, etc.],
    [End User], [Broken out by organizational unit, job role, etc.],
    [Implementation SME], [Project Librarian, Change Manager, Configuration Manager, Solution Architect, Developer, DBA, Information Architect, Usability Analyst, Trainer, Organizational Change Consultant, etc.],
    [Operational Support], [Help Desk, Network Technicians, Release Manager],
    [Project Manager], [Scrum Master, Team Leader],
    [Supplier], [Providers, Consultants, etc.],
    [Tester], [Quality Assurance Analyst],
    [Regulator], [Government, Regulatory Bodies, Auditors],
    [Sponsor], [Managers, Executives, Product Managers, Process Owners],
  ),
  caption: [Класи зацікавлених осіб]
)

== Заповнена RACI матриця

#figure(
  table(
    columns: (22%, 22%, 16%, 22%, 18%),
    table.header(
      [*Project activity*],
      [*R*],
      [*A*],
      [*C*],
      [*I*],
    ),
    [*Project planning*],
    [Project Manager, Business Analyst],
    [Sponsor],
    [Domain SME, Implementation SME, Operational Support],
    [Customer, End User, Tester, Supplier, Regulator],

    [*Elicitation*],
    [Business Analyst],
    [Business Analyst],
    [Customer, Domain SME, End User, Sponsor],
    [Project Manager, Implementation SME, Tester, Operational Support],

    [*Requirement analysis*],
    [Business Analyst, Domain SME],
    [Business Analyst],
    [End User, Implementation SME, Tester, Operational Support, Regulator],
    [Project Manager, Sponsor, Customer, Supplier],

    [*Testing*],
    [Tester, Implementation SME],
    [Project Manager],
    [Business Analyst, Domain SME, End User, Operational Support],
    [Sponsor, Customer, Supplier, Regulator],
  ),
  caption: [RACI матриця для проєктних активностей]
)

== Обґрунтування

Під час планування проєкту основну роботу виконує Project Manager разом із Business Analyst, оскільки потрібно визначити підхід до роботи, комунікації, ресурси та активності бізнес-аналізу. Accountable є Sponsor, бо саме він відповідає за бізнес-результат і затверджує напрям ініціативи.

За виявлення вимог відповідає Business Analyst, тому в активності Elicitation він одночасно є Responsible та Accountable. Customer, Domain SME, End User і Sponsor консультують, оскільки надають бізнес-інформацію, очікування, обмеження та бачення майбутнього рішення.

Під час Requirement analysis Business Analyst виконує аналіз вимог і відповідає за якість результату. Domain SME залучається як співвиконавець, бо допомагає уточнювати предметну область. Implementation SME, Tester, Operational Support і Regulator консультують щодо технічної реалізації, тестованості, підтримки та регуляторних обмежень.

Під час Testing основними виконавцями є Tester та Implementation SME, оскільки вони перевіряють рішення і виправляють знайдені дефекти. Accountable є Project Manager, бо він відповідає за організацію процесу тестування, ресурси, строки та готовність результату до передачі замовнику.

= Висновок

У ході комп'ютерного практикуму було проаналізовано основні класи зацікавлених осіб IT-проєкту та побудовано RACI матрицю для чотирьох типових проєктних активностей: планування проєкту, виявлення вимог, аналіз вимог і тестування.

Заповнена матриця дозволяє чітко визначити, хто виконує роботу, хто відповідає за результат, кого потрібно залучати для консультацій і кого достатньо інформувати. Такий підхід зменшує невизначеність у взаємодії зі стейкхолдерами та допомагає краще організувати бізнес-аналітичну роботу в межах проєкту.
