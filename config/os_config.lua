Config = {}
Config.OSCoreName = "QBCore"
Config.OSCommunityMenuKey = 121 -- This is "INS" button
Config.OSCommunityFont = 1 -- 4 is default
Config.OSCommunityLocale	= "os" 
Config.OSCommunityActionText = "Document Actions" 

Config.OSr = 155
Config.OSg = 5
Config.OSb = 5
Config.OSscale = 0.4069
Config.OScol1 = 200
Config.OScol2 = 0
Config.OScol3 = 0
Config.OSWid = 0.50069
Config.OShei = 0.040000000069

Config.UseOSCustomFonts 	= false -- If you need custom font turn ON
Config.CustomOSFontFile 	= "greek" -- only if you turn custom fonts on.
Config.CustomOSFontId 	= "OpenSans" -- only if you turn custom fonts on.

Config.OSCommunity = {
      ["public"] = {
        {
          headerTitle = "ФОРМА ЗА ПОТВЪРЖДЕНИЕ",
          headerSubtitle = "Гражданска форма за потвърждение.",
          elements = {
            { label = "СЪДЪРЖАНИЕ НА ПОТВЪРЖДЕНИЕТО", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "СВИДЕТЕЛСКИ ПОКАЗАНИЯ",
          headerSubtitle = "Официални свидетелски показания.",
          elements = {
            { label = "ДАТА НА ВЪЗНИКВАНЕ", type = "input", value = "", can_be_emtpy = false },
            { label = "СЪДЪРЖАНИЕ НА ПОКАЗАНИЯ", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "ДОКУМЕНТ ЗА ПРЕХВЪРЛЯНЕ НА КОЛА",
          headerSubtitle = "Прехвърляне на кола на човек",
          elements = {
            { label = "НОМЕР НА КОЛАТА", type = "input", value = "", can_be_emtpy = false },
            { label = "ИМЕТО НА ЧОВЕКА", type = "input", value = "", can_be_emtpy = false },
            { label = "ДОГОВОРЕНА ЦЕНА", type = "input", value = "", can_be_empty = false },
            { label = "ДРУГА ИНФОРМАЦИЯ", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "ДЕКЛАРАЦИЯ ЗА ПОЛУЧАВАНЕ НА КРЕДИТ",
          headerSubtitle = "",
          elements = {
            { label = "ИМЕ НА КРЕДИТОРА", type = "input", value = "", can_be_emtpy = false },
            { label = "ФАМИЛИЯ НА КРЕДИТОРА", type = "input", value = "", can_be_emtpy = false },
            { label = "ДЪЛЖИМА СУМА", type = "input", value = "", can_be_empty = false },
            { label = "ДО ДАТА", type = "input", value = "", can_be_empty = false },
            { label = "ДРУГА ИНФОРМАЦИЯ", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "ДЕКЛАРАЦИЯ ЗА ИЗПЛАЩАНЕ НА КРЕДИТ",
          headerSubtitle = "",
          elements = {
            { label = "ИМЕ НА ДЛЪЖНИКА", type = "input", value = "", can_be_emtpy = false },
            { label = "ФАМИЛИЯ НА ДЛЪЖНИКА", type = "input", value = "", can_be_emtpy = false },
            { label = "ДЪЛЖИМА СУМА", type = "input", value = "", can_be_empty = false },
            { label = "ДРУГА ИНФОРМАЦИЯ", type = "textarea", value = "ДЕКЛАРИРАМ, ЧЕ ДЛЪЖНИКА СИ Е ИЗПЛАТИЛ КРЕДИТА.", can_be_emtpy = false, can_be_edited = false },
          }
        }
      },
      ["police"] = {
        {
          headerTitle = "РАЗРЕШЕИНЕ ЗА ОРЪЖИЕ",
          headerSubtitle = "Специално разрешение за оръжие дадено от полицията.",
          elements = {
            { label = "ИМЕ НА ПРИТЕЖАТЕЛЯ", type = "input", value = "", can_be_emtpy = false },
            { label = "ФАМИЛИЯ НА ПРИТЕЖАТЕЛЯ", type = "input", value = "", can_be_emtpy = false },
            { label = "ВАЛИДЕН ДО", type = "input", value = "", can_be_empty = false },
            { label = "ИНФОРМАЦИЯ", type = "textarea", value = "СПОМЕНАТИЯТ ГРАЖДАНИН ИМА ПРАВОТО ДА ИЗПОЛЗВА ОРЪЖИЯ ДО КРАЯ НА ВАЛИДНОСТТА НА ДОКУМЕНТА", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "ИЗЧИСТВАНЕ НА КРИМИНАЛНО ДОСИЕ",
          headerSubtitle = "",
          elements = {
            { label = "ИМЕ НА ГРАЖДАНИНА", type = "input", value = "", can_be_emtpy = false },
            { label = "ФАМИЛИЯ НА ГРАЖДАНИНА", type = "input", value = "", can_be_emtpy = false },
            { label = "ВАЛИДНО ДО", type = "input", value = "", can_be_empty = false },
            { label = "RECORD", type = "textarea", value = "ПОЛИЦИЯТА ДЕКЛАРИРА, ЧЕ ГРАЖДАНИНА ИМА ЧИСТО ДОСИЕ ДО КРАЯ НА ВАЛИДНОСТТА НА ДОКУМЕНТА.", can_be_emtpy = false, can_be_edited = false },
          }         }
      },
      ["ambulance"] = {
        {
          headerTitle = "МЕДИЦИНСКИ ДОКЛАД - ПАТОЛОГИЯ",
          headerSubtitle = "Официален медицински доклад предоставен от патолог.",
          elements = {
            { label = "ИМЕ НА ГРАЖДАНИНА", type = "input", value = "", can_be_emtpy = false },
            { label = "ФАМИЛИЯ НА ГРАЖДАНИНА", type = "input", value = "", can_be_emtpy = false },
            { label = "ВАЛИДНО ДО", type = "input", value = "", can_be_empty = false },
            { label = "МЕДИЦИНСКИ ЗАПИСКИ", type = "textarea", value = "Гореспоменатият гражданин беше прегледан от служител на здравеопазването и е определен здрав без открити дългосрочни заболявания. Този доклад е валиден до споменатата дата.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "МЕДИЦИНСКИ ДОКЛАД - ПСИХОТЕСТ",
          headerSubtitle = "Официален медицински доклад предоставен от психолог.",
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "Гореспоменатият гражданин беше прегледан от служител на здравеопазването и е определен психически здрав от най-ниско одобрените стандарти. Този доклад е валиден до споменатата дата.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "МЕДИЦИНСКИ ДОКЛАД - ОЧЕН СПЕЦИАЛИСТ",
          headerSubtitle = "Официален медицински доклад предоставен от очен специалист.",
          elements = {
            { label = "INSURED FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "INSURED LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VALID UNTIL", type = "input", value = "", can_be_empty = false },
            { label = "MEDICAL NOTES", type = "textarea", value = "Гореспоменатият гражданин беше прегледан от служител на здравеопазването и е определен здрав без открити очни болести. Този доклад е валиден до споменатата дата.", can_be_emtpy = false },
          }
        },

      ["lawyer"] = {
        {
          headerTitle = "ДОГОВОР ЗА ПРАВНИ УСЛУГИ",
          headerSubtitle = "Договор за правни услуги направен от адвокат.",
          elements = {
            { label = "ИМЕ НА ГРАЖДАНИНА", type = "input", value = "", can_be_emtpy = false },
            { label = "ФАМИЛИЯ НА ГРАЖДАНИНА", type = "input", value = "", can_be_emtpy = false },
            { label = "ВАЛИДНО ДО", type = "input", value = "", can_be_empty = false },
            { label = "ИНФОРМАЦИЯ", type = "textarea", value = "THIS DOCUMENT IS PROOF OF LEGAL REPRESANTATION AND COVERAGE OF THE AFOREMENTIONED CITIZEN. LEGAL SERVICES ARE VALID UNTIL THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        }
      }
    }
  }