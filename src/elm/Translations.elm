module Translations exposing (..)


type Lang
    = Bg
    | De
    | En
    | Es
    | Fa
    | Hy
    | Nl
    | Ru
    | Tw
    | Ua
    | Zh


getLnFromCode : String -> Lang
getLnFromCode code =
    case code of
        "bg" ->
            Bg

        "de" ->
            De

        "en" ->
            En

        "es" ->
            Es

        "fa" ->
            Fa

        "hy" ->
            Hy

        "nl" ->
            Nl

        "ru" ->
            Ru

        "tw" ->
            Tw

        "ua" ->
            Ua

        "zh" ->
            Zh

        _ ->
            En


baseNext : Lang -> String
baseNext lang =
    case lang of
        Bg ->
            "Следващ"

        De ->
            "weiter"

        En ->
            "next"

        Es ->
            "siguente"

        Fa ->
            "بعدی"

        Hy ->
            "հաջորդը"

        Nl ->
            "verder"

        Ru ->
            "вперёд"

        Tw ->
            "繼續"

        Ua ->
            "далі"

        Zh ->
            "繼續"


basePrev : Lang -> String
basePrev lang =
    case lang of
        Bg ->
            "Предишен"

        De ->
            "zurück"

        En ->
            "previous"

        Es ->
            "anterior"

        Fa ->
            "قبلی"

        Hy ->
            "նախորդը"

        Nl ->
            "terug"

        Ru ->
            "назад"

        Tw ->
            "返回"

        Ua ->
            "назад"

        Zh ->
            "返回"


baseFont : Lang -> String
baseFont lang =
    case lang of
        Bg ->
            "Шрифт"

        De ->
            "Schrift"

        En ->
            "Font"

        Es ->
            "fuente"

        Fa ->
            "فونت"

        Hy ->
            "տառատեսակ"

        Nl ->
            "font"

        Ru ->
            "шрифт"

        Tw ->
            "字體"

        Ua ->
            "шрифт"

        Zh ->
            "字體"


baseDec : Lang -> String
baseDec lang =
    case lang of
        Bg ->
            "Увеличаване"

        De ->
            "verkleinern"

        En ->
            "decrease"

        Es ->
            "reducir"

        Fa ->
            "افزودن"

        Hy ->
            "նվազել"

        Nl ->
            "verkleinen"

        Ru ->
            "уменьшить"

        Tw ->
            "減少"

        Ua ->
            "зменшити"

        Zh ->
            "減少"


baseInc : Lang -> String
baseInc lang =
    case lang of
        Bg ->
            "Намаляване"

        De ->
            "vergrößern"

        En ->
            "increase"

        Es ->
            "aumentar"

        Fa ->
            "کاستن"

        Hy ->
            "աճել"

        Nl ->
            "vergroten"

        Ru ->
            "увеличить"

        Tw ->
            "增加"

        Ua ->
            "збільшити"

        Zh ->
            "增加"


baseSearch : Lang -> String
baseSearch lang =
    case lang of
        Bg ->
            "Търсене"

        De ->
            "Suche"

        En ->
            "Search"

        Es ->
            "buscar"

        Fa ->
            "جستجو"

        Hy ->
            "փնտրել"

        Nl ->
            "zoek"

        Ru ->
            "поиск"

        Tw ->
            "搜尋"

        Ua ->
            "пошук"

        Zh ->
            "搜尋"


baseDelete : Lang -> String
baseDelete lang =
    case lang of
        Bg ->
            "търсене изтриване"

        De ->
            "Suche löschen"

        En ->
            "clear search"

        Es ->
            "eliminar búsqueda"

        Fa ->
            "جستجو را حذف کنید"

        Hy ->
            "ջնջել որոնումը"

        Nl ->
            "Duidelijke zoek"

        Ru ->
            "удалить поиск"

        Tw ->
            "删除搜寻"

        Ua ->
            "видалити пошук"

        Zh ->
            "删除搜寻"


baseResults : Lang -> String
baseResults lang =
    case lang of
        Bg ->
            "Резултати"

        De ->
            "Ergebnisse"

        En ->
            "results"

        Es ->
            "Resultados"

        Fa ->
            "نتایج"

        Hy ->
            "արդյունքներ"

        Nl ->
            "Resultaten"

        Ru ->
            "результаты"

        Tw ->
            "结果"

        Ua ->
            "результати"

        Zh ->
            "结果"


baseOneResult : Lang -> String
baseOneResult lang =
    case lang of
        Bg ->
            "един резултат"

        De ->
            "ein Ergebnis"

        En ->
            "one result"

        Es ->
            "un resultado"

        Fa ->
            "یک نتیجه"

        Hy ->
            "մեկ արդյունք"

        Nl ->
            "een resultaat"

        Ru ->
            "один результат"

        Tw ->
            "一个结果"

        Ua ->
            "один результат"

        Zh ->
            "一个结果"


baseNoResult : Lang -> String
baseNoResult lang =
    case lang of
        Bg ->
            "няма резултати"

        De ->
            "kein Ergebnis"

        En ->
            "no results"

        Es ->
            "No hay resultados"

        Fa ->
            "هیچ نتیجه ای"

        Hy ->
            "արդյունք չկա"

        Nl ->
            "Geen resultaten"

        Ru ->
            "нет результатов"

        Tw ->
            "没有结果"

        Ua ->
            "немає результатів"

        Zh ->
            "没有结果"


baseToc : Lang -> String
baseToc lang =
    case lang of
        Bg ->
            "Съдържание"

        De ->
            "Inhaltsverzeichnis"

        En ->
            "Table of Contents"

        Es ->
            "índice"

        Fa ->
            "فهرست مطالب"

        Hy ->
            "բովանդակություն"

        Nl ->
            "Inhoudsopgave"

        Ru ->
            "оглавление"

        Tw ->
            "目錄"

        Ua ->
            "зміст"

        Zh ->
            "目錄"


baseShow : Lang -> String
baseShow lang =
    case lang of
        Bg ->
            "показване"

        De ->
            "zeigen"

        En ->
            "show"

        Es ->
            "mostrar"

        Fa ->
            "نشان دادن"

        Hy ->
            "ցույց տալ"

        Nl ->
            "tonen"

        Ru ->
            "показать"

        Tw ->
            "顯示"

        Ua ->
            "показати"

        Zh ->
            "顯示"


baseHide : Lang -> String
baseHide lang =
    case lang of
        Bg ->
            "скриване"

        De ->
            "verberghen"

        En ->
            "hide"

        Es ->
            "ocultar"

        Fa ->
            "پنهان کردن"

        Hy ->
            "թաքցնել"

        Nl ->
            "verbergen"

        Ru ->
            "скрыть"

        Tw ->
            "隱藏"

        Ua ->
            "приховати"

        Zh ->
            "隱藏"


baseLang : Lang -> String
baseLang lang =
    case lang of
        Bg ->
            "български"

        De ->
            "Deutsch"

        En ->
            "English"

        Es ->
            "Español"

        Fa ->
            "فارسی"

        Hy ->
            "հայերեն"

        Nl ->
            "Nederlands"

        Ru ->
            "русский"

        Tw ->
            "中国人"

        Ua ->
            "Український"

        Zh ->
            "中国人"


no_translation : Lang -> String
no_translation lang =
    case lang of
        Bg ->
            "Без превод"

        De ->
            "noch keine Übersetzungen vorhanden"

        En ->
            "no translation yet"

        Es ->
            "aún sin traducción"

        Fa ->
            "در دست ترجمه"

        Hy ->
            "դեռ թագմանություն չկա"

        Nl ->
            "noch geen vertaling aanwezig"

        Ru ->
            "перевода пока нет"

        Tw ->
            "尚未翻譯"

        Ua ->
            "переклад відсутній"

        Zh ->
            "尚未翻譯"


cColor : Lang -> String
cColor lang =
    case lang of
        Bg ->
            "Цвят"

        De ->
            "Farbe"

        En ->
            "Color"

        Es ->
            "color"

        Fa ->
            "رنگ"

        Hy ->
            "գույն"

        Nl ->
            "kleur"

        Ru ->
            "цвет"

        Tw ->
            "顏色"

        Ua ->
            "колір"

        Zh ->
            "顏色"


cDark : Lang -> String
cDark lang =
    case lang of
        Bg ->
            "Тъмно"

        De ->
            "Dunkel"

        En ->
            "Dark"

        Es ->
            "oscuro"

        Fa ->
            "تیره"

        Hy ->
            "մուգ"

        Nl ->
            "donker"

        Ru ->
            "тёмный"

        Tw ->
            "深"

        Ua ->
            "темний"

        Zh ->
            "深"


cBright : Lang -> String
cBright lang =
    case lang of
        Bg ->
            "Светло"

        De ->
            "Hell"

        En ->
            "Bright"

        Es ->
            "luminoso"

        Fa ->
            "روشن"

        Hy ->
            "բաց"

        Nl ->
            "licht"

        Ru ->
            "светлый"

        Tw ->
            "淺"

        Ua ->
            "світлий"

        Zh ->
            "淺"


cDefault : Lang -> String
cDefault lang =
    case lang of
        Bg ->
            "Подразбиране"

        De ->
            "Standard"

        En ->
            "Default"

        Es ->
            "defecto"

        Fa ->
            "پیشفرض"

        Hy ->
            "կանխադրված"

        Nl ->
            "standaard"

        Ru ->
            "стандарт по умолчанию"

        Tw ->
            "預設"

        Ua ->
            "стандартний"

        Zh ->
            "預設"


cAmber : Lang -> String
cAmber lang =
    case lang of
        Bg ->
            "Кехлибар"

        De ->
            "Bernstein"

        En ->
            "Amber"

        Es ->
            "ámbar"

        Fa ->
            "کهربایی"

        Hy ->
            "սաթագույն"

        Nl ->
            "amber"

        Ru ->
            "янтарный"

        Tw ->
            "琥珀色"

        Ua ->
            "бурштиновий"

        Zh ->
            "琥珀色"


cBlue : Lang -> String
cBlue lang =
    case lang of
        Bg ->
            "Синьо"

        De ->
            "Blau"

        En ->
            "Blue"

        Es ->
            "azul"

        Fa ->
            "آبی"

        Hy ->
            "կապույտ"

        Nl ->
            "blauw"

        Ru ->
            "синий"

        Tw ->
            "藍色"

        Ua ->
            "синій"

        Zh ->
            "藍色"


cGray : Lang -> String
cGray lang =
    case lang of
        Bg ->
            "Сиво"

        De ->
            "Grau"

        En ->
            "Gray"

        Es ->
            "gris"

        Fa ->
            "خاکستری"

        Hy ->
            "մոխրագույն"

        Nl ->
            "grijs"

        Ru ->
            "серый"

        Tw ->
            "灰色"

        Ua ->
            "сірий"

        Zh ->
            "灰色"


cGreen : Lang -> String
cGreen lang =
    case lang of
        Bg ->
            "Зелено"

        De ->
            "Grün"

        En ->
            "Green"

        Es ->
            "verde"

        Fa ->
            "سبز"

        Hy ->
            "կանաչ"

        Nl ->
            "groen"

        Ru ->
            "зелёный"

        Tw ->
            "綠色"

        Ua ->
            "зелений"

        Zh ->
            "綠色"


cPurple : Lang -> String
cPurple lang =
    case lang of
        Bg ->
            "Лилаво"

        De ->
            "Violett"

        En ->
            "Purple"

        Es ->
            "púrpura"

        Fa ->
            "بنفش"

        Hy ->
            "մանուշակագույն"

        Nl ->
            "paars"

        Ru ->
            "фиолетовый"

        Tw ->
            "紫色"

        Ua ->
            "фіолетовий"

        Zh ->
            "紫色"


cRed : Lang -> String
cRed lang =
    case lang of
        Bg ->
            "червен"

        De ->
            "Rot"

        En ->
            "Red"

        Es ->
            "rojo"

        Fa ->
            "قرمز"

        Hy ->
            "կարմիր"

        Nl ->
            "rood"

        Ru ->
            "красный"

        Tw ->
            "红色的"

        Ua ->
            "червоний"

        Zh ->
            "红色的"


cYellow : Lang -> String
cYellow lang =
    case lang of
        Bg ->
            "жълт"

        De ->
            "Gelb"

        En ->
            "Yellow"

        Es ->
            "amarillo"

        Fa ->
            "رنگ زرد"

        Hy ->
            "դեղին"

        Nl ->
            "geel"

        Ru ->
            "желтый"

        Tw ->
            "黄色的"

        Ua ->
            "жовтий"

        Zh ->
            "黄色的"


cTurquoise : Lang -> String
cTurquoise lang =
    case lang of
        Bg ->
            "тюркоаз"

        De ->
            "Türkis"

        En ->
            "Turquoise"

        Es ->
            "turquesa"

        Fa ->
            "فیروزه"

        Hy ->
            "փիրուզագույն"

        Nl ->
            "turkoois"

        Ru ->
            "бирюзовый"

        Tw ->
            "绿松石"

        Ua ->
            "бірюзовий"

        Zh ->
            "绿松石"


modeMode : Lang -> String
modeMode lang =
    case lang of
        Bg ->
            "Режим на презентация"

        De ->
            "Präsentationsmodus"

        En ->
            "Presentation mode"

        Es ->
            "Modo presentación"

        Fa ->
            "حالت ارائه"

        Hy ->
            "Ներկայացման ռեժիմ"

        Nl ->
            "Presentatiemodus"

        Ru ->
            "режим презентации"

        Tw ->
            "简报模式"

        Ua ->
            "режим презентації"

        Zh ->
            "简报模式"


modeTextbook : Lang -> String
modeTextbook lang =
    case lang of
        Bg ->
            "Текст"

        De ->
            "Lehrbuch"

        En ->
            "Textbook"

        Es ->
            "Manual"

        Fa ->
            "کتاب"

        Hy ->
            "գիրք"

        Nl ->
            "Studieboek"

        Ru ->
            "чтения"

        Tw ->
            "教科書"

        Ua ->
            "навчальна книга"

        Zh ->
            "教科書"


modePresentation : Lang -> String
modePresentation lang =
    case lang of
        Bg ->
            "Презентация"

        De ->
            "Präsentation"

        En ->
            "Presentation"

        Es ->
            "Presentación"

        Fa ->
            "ارائه"

        Hy ->
            "ներկայացում"

        Nl ->
            "Presentatie"

        Ru ->
            "презентации"

        Tw ->
            "報告"

        Ua ->
            "презентація"

        Zh ->
            "報告"


modeSlides : Lang -> String
modeSlides lang =
    case lang of
        Bg ->
            "Слайдове"

        De ->
            "Folien"

        En ->
            "Slides"

        Es ->
            "Imagen"

        Fa ->
            "اسلایدها"

        Hy ->
            "սլայդներ"

        Nl ->
            "Folies"

        Ru ->
            "слайды"

        Tw ->
            "幻燈片"

        Ua ->
            "слайди"

        Zh ->
            "幻燈片"


soundOn : Lang -> String
soundOn lang =
    case lang of
        Bg ->
            "Звук изкл."

        De ->
            "Sprecher an"

        En ->
            "Sound on"

        Es ->
            "Sonido encendido"

        Fa ->
            "صدا روشن"

        Hy ->
            "ձայնով"

        Nl ->
            "Luidspreker aan"

        Ru ->
            "звук включён"

        Tw ->
            "聲音開啟"

        Ua ->
            "увімкнений"

        Zh ->
            "聲音開啟"


soundOff : Lang -> String
soundOff lang =
    case lang of
        Bg ->
            "Звук вкл."

        De ->
            "Sprecher aus"

        En ->
            "Sound off"

        Es ->
            "Sonido apagado"

        Fa ->
            "صدا خاموش"

        Hy ->
            "առանց ձայն"

        Nl ->
            "Luidspreker uit"

        Ru ->
            "звук выключен"

        Tw ->
            "聲音關閉"

        Ua ->
            "вимкнений"

        Zh ->
            "聲音關閉"


infoAuthor : Lang -> String
infoAuthor lang =
    case lang of
        Bg ->
            "Автор: "

        De ->
            "Autor: "

        En ->
            "Author: "

        Es ->
            "Autor"

        Fa ->
            "نویسنده: "

        Hy ->
            "հեղինակ: "

        Nl ->
            "Auteur: "

        Ru ->
            "автор: "

        Tw ->
            "作者: "

        Ua ->
            "автор: "

        Zh ->
            "作者: "


infoDate : Lang -> String
infoDate lang =
    case lang of
        Bg ->
            "Дата: "

        De ->
            "Datum: "

        En ->
            "Date: "

        Es ->
            "fecha"

        Fa ->
            "تاریخ: "

        Hy ->
            "ամսաթիվ: "

        Nl ->
            "Datum: "

        Ru ->
            "дата: "

        Tw ->
            "日期: "

        Ua ->
            "дата: "

        Zh ->
            "日期: "


infoEmail : Lang -> String
infoEmail lang =
    case lang of
        Bg ->
            "eMail: "

        De ->
            "e-Mail: "

        En ->
            "eMail: "

        Es ->
            "email"

        Fa ->
            "ایمیل: "

        Hy ->
            "էլ․ փոստ: "

        Nl ->
            "e-email: "

        Ru ->
            "эл. почта: "

        Tw ->
            "電郵: "

        Ua ->
            "електронна пошта: "

        Zh ->
            "電郵: "


infoVersion : Lang -> String
infoVersion lang =
    case lang of
        Bg ->
            "Версия: "

        De ->
            "Version: "

        En ->
            "Version: "

        Es ->
            "versión"

        Fa ->
            "نسخه: "

        Hy ->
            "տարբերակ: "

        Nl ->
            "Versie: "

        Ru ->
            "версия: "

        Tw ->
            "版本: "

        Ua ->
            "версія: "

        Zh ->
            "版本: "


confInformation : Lang -> String
confInformation lang =
    case lang of
        Bg ->
            "Информация"

        De ->
            "Informationen"

        En ->
            "Information"

        Es ->
            "informaciones"

        Fa ->
            "اطلاعات"

        Hy ->
            "ինֆորմացիա"

        Nl ->
            "Informatie"

        Ru ->
            "информация"

        Tw ->
            "關於"

        Ua ->
            "інформація"

        Zh ->
            "關於"


confSettings : Lang -> String
confSettings lang =
    case lang of
        Bg ->
            "Настройки"

        De ->
            "Einstellungen"

        En ->
            "Settings"

        Es ->
            "configuración"

        Fa ->
            "تنظیمات"

        Hy ->
            "կարգավորումներ"

        Nl ->
            "Instellingen"

        Ru ->
            "настройки"

        Tw ->
            "設定"

        Ua ->
            "налаштування"

        Zh ->
            "設定"


confShare : Lang -> String
confShare lang =
    case lang of
        Bg ->
            "Споделяне"

        De ->
            "Teilen"

        En ->
            "Share"

        Es ->
            "compartir"

        Fa ->
            "اشتراک"

        Hy ->
            "կիսվել"

        Nl ->
            "Delen"

        Ru ->
            "поделиться"

        Tw ->
            "分享"

        Ua ->
            "поділитися"

        Zh ->
            "分享"


confTranslations : Lang -> String
confTranslations lang =
    case lang of
        Bg ->
            "Транслации"

        De ->
            "Übersetzungen"

        En ->
            "Translations"

        Es ->
            "traducciones"

        Fa ->
            "ترجمه ها"

        Hy ->
            "թարգմանություններ"

        Nl ->
            "Vertalingen"

        Ru ->
            "на других языках"

        Tw ->
            "翻譯"

        Ua ->
            "переклади"

        Zh ->
            "翻譯"


codeExecute : Lang -> String
codeExecute lang =
    case lang of
        Bg ->
            "Изпълни"

        De ->
            "Ausführen"

        En ->
            "Execute"

        Es ->
            "ejecutar"

        Fa ->
            "اجرا"

        Hy ->
            "իրականացնել"

        Nl ->
            "uitvoeren"

        Ru ->
            "выполнить"

        Tw ->
            "開始執行"

        Ua ->
            "запустити"

        Zh ->
            "開始執行"


codeRunning : Lang -> String
codeRunning lang =
    case lang of
        Bg ->
            "Работещ"

        De ->
            "wird ausgeführt"

        En ->
            "is running"

        Es ->
            "en funcionamiento"

        Fa ->
            "در حال اجرا"

        Hy ->
            "ընթանում է"

        Nl ->
            "wordt uitgevoerd"

        Ru ->
            "выполняется"

        Tw ->
            "執行中"

        Ua ->
            "виконується"

        Zh ->
            "執行中"


codePrev : Lang -> String
codePrev lang =
    case lang of
        Bg ->
            "Предишна версия"

        De ->
            "eine Version zurück"

        En ->
            "previous version"

        Es ->
            "versión anterior"

        Fa ->
            "نسخه قبلی"

        Hy ->
            "նախորդ տարբերակը"

        Nl ->
            "een versie terug"

        Ru ->
            "предыдущая версия"

        Tw ->
            "上一版"

        Ua ->
            "попередня версія"

        Zh ->
            "上一版"


codeNext : Lang -> String
codeNext lang =
    case lang of
        Bg ->
            "следваща версия"

        De ->
            "eine Version vor"

        En ->
            "next version"

        Es ->
            "versión siguiente"

        Fa ->
            "نسخه بعدی"

        Hy ->
            "հաջորդ տարբերակը"

        Nl ->
            "een versie vooruit"

        Ru ->
            "следующая версия"

        Tw ->
            "下一版"

        Ua ->
            "наступна версія"

        Zh ->
            "下一版"


codeFirst : Lang -> String
codeFirst lang =
    case lang of
        Bg ->
            "Първа версия"

        De ->
            "erste Version"

        En ->
            "first version"

        Es ->
            "primera versión"

        Fa ->
            "نسخه اولیه"

        Hy ->
            "առաջին տարբերակը"

        Nl ->
            "eerste versie"

        Ru ->
            "первая версия"

        Tw ->
            "最初版"

        Ua ->
            "перша версія"

        Zh ->
            "最初版"


codeLast : Lang -> String
codeLast lang =
    case lang of
        Bg ->
            "Последна версия"

        De ->
            "letzte Version"

        En ->
            "last version"

        Es ->
            "última versión"

        Fa ->
            "آخرین نسخه"

        Hy ->
            "վերջին տարբերակը"

        Nl ->
            "laatste versie"

        Ru ->
            "последняя версия"

        Tw ->
            "最終版"

        Ua ->
            "остання версія"

        Zh ->
            "最終版"


codeMinimize : Lang -> String
codeMinimize lang =
    case lang of
        Bg ->
            "Минимизиране"

        De ->
            "Darstellung minimieren"

        En ->
            "minimize view"

        Es ->
            "minimizar vista"

        Fa ->
            "کوچک کردن پنجره"

        Hy ->
            "նվազեցնել տեսքը"

        Nl ->
            "weergave verkleinen"

        Ru ->
            "свернуть"

        Tw ->
            "極小視窗"

        Ua ->
            "зображення зменшити"

        Zh ->
            "極小視窗"


codeMaximize : Lang -> String
codeMaximize lang =
    case lang of
        Bg ->
            "Максимизиране"

        De ->
            "Darstellung maximieren"

        En ->
            "maximize view"

        Es ->
            "maximinzar vista"

        Fa ->
            "بزرگ کردن پنجره"

        Hy ->
            "բարձրագունել տեսքը"

        Nl ->
            "weergave maximaliseren"

        Ru ->
            "показать полностью"

        Tw ->
            "極大視窗"

        Ua ->
            "зображення збільшити"

        Zh ->
            "極大視窗"


quizCheck : Lang -> String
quizCheck lang =
    case lang of
        Bg ->
            "Проверка"

        De ->
            "Prüfen"

        En ->
            "Check"

        Es ->
            "verificar"

        Fa ->
            "بررسی"

        Hy ->
            "ստուգել"

        Nl ->
            "bekijk"

        Ru ->
            "проверить"

        Tw ->
            "選取"

        Ua ->
            "перевірити"

        Zh ->
            "選取"


quizChecked : Lang -> String
quizChecked lang =
    case lang of
        Bg ->
            "Проверено"

        De ->
            "Gelöst"

        En ->
            "Checked"

        Es ->
            "verificado"

        Fa ->
            "بررسی شده"

        Hy ->
            "ստուգված"

        Nl ->
            "bekeken"

        Ru ->
            "проверено"

        Tw ->
            "已選取"

        Ua ->
            "перевірено"

        Zh ->
            "已選取"


quizSolution : Lang -> String
quizSolution lang =
    case lang of
        Bg ->
            "Отговор"

        De ->
            "zeige Lösung"

        En ->
            "show solution"

        Es ->
            "mostrar solución"

        Fa ->
            "نمایش راهکار"

        Hy ->
            "ցույց տալ լուծումը"

        Nl ->
            "toon oplossing"

        Ru ->
            "показать решение"

        Tw ->
            "顯示解答"

        Ua ->
            "показати розв'язок"

        Zh ->
            "顯示解答"


quizResolved : Lang -> String
quizResolved lang =
    case lang of
        Bg ->
            "Решено"

        De ->
            "Aufgelöst"

        En ->
            "Resolved"

        Es ->
            "resuelto"

        Fa ->
            "حل شده"

        Hy ->
            "լուծված է "

        Nl ->
            "opgelost"

        Ru ->
            "решено"

        Tw ->
            "以解答"

        Ua ->
            "розв'язано"

        Zh ->
            "以解答"


quizHint : Lang -> String
quizHint lang =
    case lang of
        Bg ->
            "Подсказване"

        De ->
            "zeige Hinweis"

        En ->
            "show hint"

        Es ->
            "mostrar indicio"

        Fa ->
            "نمایش یادآوری"

        Hy ->
            "ցուցադրել ակնարկ"

        Nl ->
            "toon hint"

        Ru ->
            "подсказка"

        Tw ->
            "暗示"

        Ua ->
            "показати підказку"

        Zh ->
            "暗示"


surveySubmit : Lang -> String
surveySubmit lang =
    case lang of
        Bg ->
            "Изпрати"

        De ->
            "Abschicken"

        En ->
            "Submit"

        Es ->
            "enviar"

        Fa ->
            "ارسال"

        Hy ->
            "ներկայացնել"

        Nl ->
            "Verzenden"

        Ru ->
            "отправить"

        Tw ->
            "遞交"

        Ua ->
            "відіслати"

        Zh ->
            "遞交"


surveySubmitted : Lang -> String
surveySubmitted lang =
    case lang of
        Bg ->
            "Благодаря"

        De ->
            "Dankeshön"

        En ->
            "Thanks"

        Es ->
            "enviado"

        Fa ->
            "تشکر"

        Hy ->
            "շնորհակալություն"

        Nl ->
            "Vriendelijk bedankt"

        Ru ->
            "отправлено"

        Tw ->
            "感謝"

        Ua ->
            "дякую"

        Zh ->
            "感謝"


surveyText : Lang -> String
surveyText lang =
    case lang of
        Bg ->
            "Въведете текст..."

        De ->
            "Texteingabe ..."

        En ->
            "Enter some text..."

        Es ->
            "introducir texto"

        Fa ->
            "لطفا متن وارد کنید"

        Hy ->
            "Մուտքագրեք որոշ տեքստ"

        Nl ->
            "Tekstinvoer ..."

        Ru ->
            "ввод текста"

        Tw ->
            "輸入文字..."

        Ua ->
            "Ввід тексту ..."

        Zh ->
            "輸入文字..."


chartPie : Lang -> String
chartPie lang =
    case lang of
        De ->
            "Tortendiagramm"

        Tw ->
            "饼图"

        Zh ->
            "饼图"

        _ ->
            "Pie chart"


chartBar : Lang -> String
chartBar lang =
    case lang of
        De ->
            "Balkendiagramm"

        Tw ->
            "柱状图"

        Zh ->
            "柱状图"

        _ ->
            "Bar chart"


chartLine : Lang -> String
chartLine lang =
    case lang of
        De ->
            "Liniendiagramm"

        Tw ->
            "折线图"

        Zh ->
            "折线图"

        _ ->
            "Line chart"


chartScatter : Lang -> String
chartScatter lang =
    case lang of
        De ->
            "Streudiagramm"

        Tw ->
            "散点图"

        Zh ->
            "散点图"

        _ ->
            "Scatter plot"


chartEffectScatter : Lang -> String
chartEffectScatter lang =
    case lang of
        De ->
            "Welligkeits-Streudiagramm"

        Tw ->
            "涟漪散点图"

        Zh ->
            "涟漪散点图"

        _ ->
            "Ripple scatter plot"


chartRadar : Lang -> String
chartRadar lang =
    case lang of
        De ->
            "Radar-Karte"

        Tw ->
            "雷达图"

        Zh ->
            "雷达图"

        _ ->
            "Radar chart"


chartTree : Lang -> String
chartTree lang =
    case lang of
        De ->
            "Baum"

        Tw ->
            "树图"

        Zh ->
            "树图"

        _ ->
            "Tree"


chartTreemap : Lang -> String
chartTreemap lang =
    case lang of
        De ->
            "Baumkarte"

        Tw ->
            "矩形树图"

        Zh ->
            "矩形树图"

        _ ->
            "Treemap"


chartBoxplot : Lang -> String
chartBoxplot lang =
    case lang of
        Tw ->
            "箱型图"

        Zh ->
            "箱型图"

        _ ->
            "Boxplot"


chartCandlestick : Lang -> String
chartCandlestick lang =
    case lang of
        De ->
            "Kerzenständer"

        Tw ->
            "K线图"

        Zh ->
            "K线图"

        _ ->
            "Candlestick"


chartK : Lang -> String
chartK lang =
    case lang of
        De ->
            "K Liniendiagramm"

        Tw ->
            "K线图"

        Zh ->
            "K线图"

        _ ->
            "K line chart"


chartHeatmap : Lang -> String
chartHeatmap lang =
    case lang of
        De ->
            "Heatmap"

        Tw ->
            "热力图"

        Zh ->
            "热力图"

        _ ->
            "Heat map"


chartMap : Lang -> String
chartMap lang =
    case lang of
        De ->
            "Karte"

        Tw ->
            "地图"

        Zh ->
            "地图"

        _ ->
            "Map"


chartParallel : Lang -> String
chartParallel lang =
    case lang of
        De ->
            "Parallele Koordinatenkarte"

        Tw ->
            "平行坐标图"

        Zh ->
            "平行坐标图"

        _ ->
            "Parallel coordinate map"


chartLines : Lang -> String
chartLines lang =
    case lang of
        De ->
            "Liniendiagramm"

        Tw ->
            "线图"

        Zh ->
            "线图"

        _ ->
            "Line graph"


chartGraph : Lang -> String
chartGraph lang =
    case lang of
        De ->
            "Beziehungsgrafik"

        Tw ->
            "关系图"

        Zh ->
            "关系图"

        _ ->
            "Relationship graph"


chartSankey : Lang -> String
chartSankey lang =
    case lang of
        De ->
            "Sankey-Diagramm"

        Tw ->
            "桑基图"

        Zh ->
            "桑基图"

        _ ->
            "Sankey diagram"


chartFunnel : Lang -> String
chartFunnel lang =
    case lang of
        De ->
            "Trichterdiagramm"

        Tw ->
            "漏斗图"

        Zh ->
            "漏斗图"

        _ ->
            "Funnel chart"


chartGauge : Lang -> String
chartGauge lang =
    case lang of
        De ->
            "Meßanzeige"

        Tw ->
            "仪表盘图"

        Zh ->
            "仪表盘图"

        _ ->
            "Guage"


chartPictorialBar : Lang -> String
chartPictorialBar lang =
    case lang of
        De ->
            "Bildlicher Balken"

        Tw ->
            "象形柱图"

        Zh ->
            "象形柱图"

        _ ->
            "Pictorial bar"


chartThemeRiver : Lang -> String
chartThemeRiver lang =
    case lang of
        De ->
            "Thematische Flusskarte"

        Tw ->
            "主题河流图"

        Zh ->
            "主题河流图"

        _ ->
            "Theme River Map"


chartSunburst : Lang -> String
chartSunburst lang =
    case lang of
        De ->
            "Sonnenausbruch"

        Tw ->
            "旭日图"

        Zh ->
            "旭日图"

        _ ->
            "Sunburst"
