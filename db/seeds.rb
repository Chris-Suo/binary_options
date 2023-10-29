# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#  movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#  Character.create(name: "Luke", movie: movies.first)

# user

admin = User.create({ username: "admin", password: "aaa1234", quota: 0, level: 2, active: true })
vip = User.create({ username: "premium", password: "aaa1234", quota: 0, level: 1, active: true, created_by_user: admin })
User.create({ username: "basic", password: "aaa1234", quota: 0, level: 0, active: true, created_by_user: vip })

User.create({ username: "dummy1", password: "aaa1234", quota: 123_555, level: 0, active: true, created_by_user: vip })
User.create({ username: "dummy2", password: "aaa1234", quota: 123_555, level: 0, active: true, created_by_user: vip })
User.create({ username: "dummy3", password: "aaa1234", quota: 123_555, level: 0, active: true, created_by_user: vip })
User.create({ username: "dummy4", password: "aaa1234", quota: 123_555, level: 0, active: true, created_by_user: vip })

# machine
Machine.create(
  name: "Surgical robot 手術機器人",
  description: "Surgical robot 手術機器人",
  image_url: "1.webp",
  slug: "surgical-robot",
  exam_options: [
    "SSI Mantra",
    "Xenex LightStrike",
    "Da Vinci SP",
    "Da Vinci Xi",
    "Da Vinci X",
  ],
  option1: "懸垂測試 Dangle test",
  option2: "電力測試 electricity test",
  option3: "排放測試 emission test",
  option4: "PDN測試 PDA test",
)
Machine.create(
  name: "Intelligent handling robot 智慧搬運機器人",
  description: "Intelligent handling robot 智慧搬運機器人",
  image_url: "2.webp",
  slug: "intelligent-handling-robot",
  exam_options: [
    "TUG Exchange",
    "TUG Door",
    "TUG DRAWER",
    "TUG T3",
    "TUG T3XL",
  ],
  option1: "承載能力 Carrying capacity",
  option2: "爬坡檢測 Hill climbing detection",
  option3: "晶圓檢測 Wafer inspection",
  option4: "儀表辨識 Instrument identification",
)
Machine.create(
  name: "Ophthalmic Equipment 眼科",
  description: "Ophthalmic Equipment 眼科",
  image_url: "3.webp",
  slug: "ophthalmic-equipment",
  exam_options: [
    "MEGATRON S4HPS",
    "MEL® 90",
    "iRes®2",
    "FEMTO LDV Z8",
    "Visionix VX110",
  ],
  option1: "光須檢測 Light whiskers",
  option2: "耐電壓試驗 Withstand Voltage Test",
  option3: "絕緣電阻測試 Insulation Resistance Test",
  option4: "EMS測試 EWM Test",
)
Machine.create(
  name: "Medical 3D printers 醫用3D打印機",
  description: "Medical 3D printers 醫用3D打印機",
  image_url: "4.webp",
  slug: "medical-3d-printers",
  exam_options: [
    "F123 Series",
    "J5 MediJet",
    "Connex3 Objet260",
    "Fortus 450mc",
    "Objet500 Connex1",
  ],
  option1: "噪音測試 Airborne Noise Test",
  option2: "負空間測試 negative space test",
  option3: "橋接測試 bridge test",
  option4: "回抽測試 retraction test",
)

Machine.create(
  name: "Dental 3D Printers 牙科 3D 打印機",
  description: "Dental 3D Printers 牙科 3D 打印機",
  image_url: "5.jpg",
  slug: "dental-3d-printers",
  exam_options: [
    "EVERES UNO",
    "ProJet MJP 3600",
    "HBD-100D",
    "HBD-200",
    "HBD-350/350T",
  ],
  option1: "垂直打印測試 vertical print test",
  option2: "準確度測試 accuracy test",
  option3: "支撐測試 support test",
  option4: "料絲檢測 Filament detection",
  on_off: false,
)

Machine.create(
  name: "CT scanners CT掃描儀",
  description: "CT scanners CT掃描儀",
  image_url: "6.jpg",
  slug: "ct-scanners",
  exam_options: [
    "3D Accuitomo 170",
    "Revolution Frontier",
    "ScintCare CT64/128",
    "Aquilion ONE / GENESIS SP",
    "IQon",
  ],
  option1: "水假影像測試 Water CT number accuracy",
  option2: "擷取測試 Acquisition test",
  option3: "噪音測試 Noise test",
  option4: "線性度測試 Linearity test",
  on_off: false
)

# Machine.find_by(image_url: "1.webp").update(image_url: "1.jpg")
# Machine.find_by(image_url: "2.webp").update(image_url: "2.jpg")
# Machine.find_by(image_url: "3.webp").update(image_url: "3.jpg")
# Machine.find_by(image_url: "4.webp").update(image_url: "4.jpg")
# Machine.find_by(image_url: "5.webp").update(image_url: "5.jpg")
# Machine.find_by(image_url: "6.webp").update(image_url: "6.jpg")




