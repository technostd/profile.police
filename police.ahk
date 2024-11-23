#SingleInstance Force
#NoEnv
#Include %A_ScriptDir%\Hotkey.ahk
FileEncoding UTF-8
; Script powered in 2024 by AHK Province & Techno's studio (techno)
; All rights reserwed
; vk.com/technostd
; vk.com/provinceahk

; MsgBox %A_ScriptFullPath%`n%A_IsAdmin%`n%0% %1% %2% %3%


{ ; Основные переменные
Global WorkingDir := A_ScriptDir
Global DataPath := WorkingDir "\police.prv"
Global DefaultHotkeysPath := A_ScriptDir "\default.police.prv"
Global DefaultProvPath := "C:\Province Games"
Global LogPath := "\MTA\logs"
Global DataSection := "PoliceData"
Global HotkeySection := "PoliceHotkeys"
Global SettingsSection := "PoliceSettings"
Global HIDDEN_NOW := False

Hotkey_IniPath(DataPath)
Hotkey_IniSection(HotkeySection)

Global Version := 100
Global GuiVersion := "1.0.0"
Global TextCreator = techno
Global TextGroup = AHK Province
Global TextFooter := "by techno (Artem_Zagoretskiy) | AHK Province ©2024"
Global DataFields    := ["City",       "License",     "Surname",     "Name",     "SecondName",     "Rank",       "Post",     "Department",     "DepartmentCode",     "TenCode",     "SpecialPost",     "Callsign",      "Signature",     "ProvPath",     "Gender"]
Global DataControls  := ["ChooseCity", "EditLicense", "EditSurname", "EditName", "EditSecondName", "ChooseRank", "EditPost", "EditDepartment", "EditDepartmentCode", "EditTenCode", "EditSpecialPost", "EditCallsign", "EditSignature", "EditProvPath", "Gender"]

Global SettingsFields := ["Special"]

Global HotkeysEnabled := False

Global HotkeyFields := {"00Knock": ["1", "Постучать в окно"], "01CivilianGreeting": ["1", "Приветствие гражд."], "02PoliceBadge": ["1", "Значок / нашивка"], "03ColleagueGreeting": ["1", "Воинское приветствие"],  "04LicenseOpen": ["1", "Удостоверение+"], "05LicenseClose": ["1", "Удостоверение-"], "06AskDocuments": ["1", "Попросить документы"], "06TakeDocuments": ["1", "Взять документы"], "07ReturnDocuments": ["1", "Вернуть документы"], "08PDAOn": ["1", "КПК+"], "09PDAOff": ["1", "КПК-"], "10Skan": ["1", "Пробить по базе"], "11Protocol": ["1", "Составить протокол"], "16Tsu": ["1", "Выписать штраф"], "18RadioOn": ["1", "Рация+"], "19RadioOff": ["1", "Рация-"], "20MegafonOn": ["1", "Мегафон+"], "21MegafonOff": ["1", "Мегафон-"], "22WalkWarn": ["1", "Пешее предупр."], "23SkipWarn": ["1", "Пропуск сл. авто"], "24Wanted": ["1", "/wanted"], "25FirstColumn": ["1", "Колонна 1"], "26SecondColumn": ["1", "Колонна 2"], "27ThirdColumn": ["1", "Колонна 3"], "28FirstWarn": ["1", "Предупреждение 1"], "29SecondWarn": ["1", "Предупреждение 2"], "30ThirdWarn": ["1", "Предупреждение 3"], "01AccMask": ["2", "Снять маску"], "01AccHat": ["2", "Снять голов. убор"], "01AccGlasses": ["2", "Снять очки"], "01AccHelmet": ["2", "Снять шлем"], "01BreakGlass": ["2", "Сломать стекло"], "02OpenDoor": ["2", "Открыть дверь"], "03PullCivilian": ["2", "Вытащить из машины"], "04Putpl": ["2", "Посадить в ПА"], "05Eject": ["2", "Высадить из ПА"], "06Photo": ["2", "Установить личность*"], "07Su": ["2", "Выдать розыск*"], "08ArrestCar": ["2", "Посадить в КПЗ"], "01Sos": ["3", "Код-0 /ro"], "02SosP": ["3", "Кнопка SOS в ПА"], "03SosS": ["3", "Кнопка SOS"], "04Protocol1": ["3", "Общее оформление 1"], "04Protocol2": ["3", "Общее оформление 2"], "04Protocol3": ["3", "Общее оформление 3"], "04ReadLection": ["3", "Прочитать выбр. лекцию"]}



Global HotkeyValues := Object()
; Global HotkeyHWNDs := Object()

; City: город трудоустройства
; License: удостоверение
; Surname: фамилия
; Name: имя
; SecondName: отчество
; Nickname: позывной
; Rank: звание
; Post: должность
; Gender: пол


Global InputType := True ; True - GUI, False - console

Global Cities := "Мирный||Приволжск|Невский"
Global Ranks := "рядовой||сержант|старшина|прапорщик|лейтенант|старший лейтенант|капитан|майор|подполковник|полковник|генерал-майор|генерал-лейтенант|генерал-полковник|генерал"
Global RanksArr := ["рядовой", "сержант", "старшина", "прапорщик", "лейтенант", "старший лейтенант", "капитан", "майор", "подполковник", "полковник", "генерал-майор"]
;Global RanksArr := {"рядовой": "do На плечах закреплены пустые погоны.", "сержант": "do На плечах закреплены погоны с тремя лычками поперек погон.", "старшина": "do На плечах погоны с одной лычкой вдоль погон.", "прапорщик": "do На плечах погоны с двумя звездами вдоль по он.", "лейтенант": "do На плечах погоны с двумя звездами и просветом.", "старший лейтенант": "do На плечах погоны с тремя звездами и просветом.", "капитан": "do На плечах погоны с четырьмя звездами и просветом.", "майор": "do На плечах погоны с одной звездой и двумя просветами.", "подполковник": "do На плечах погоны с двумя звездами и двумя просветами.", "Полковник": "do На плечах погоны с тремя звездами и двумя просветами.", "генерал-майор": "do На плечах погоны с одной большой звездой.", "генерал-лейтенант": "do На плечах погоны с двумя большими звездами.", "генерал-полковник": "do На плечах погоны с тремя большими звездами.", "генерал МВД": "do На плечах погоны с одной большой звездой и гербом МВД."}

Global PogonArr := {"рядовой": "пустые погоны", "сержант": "погоны с тремя лычками поперек погон", "старшина": "погоны с одной лычкой вдоль погон", "прапорщик": "погоны с двумя звездами вдоль погон", "лейтенант": "погоны с двумя звездами и просветом", "старший лейтенант": "погоны с тремя звездами и просветом", "капитан": "погоны с четырьмя звездами и просветом", "майор": "погоны с одной звездой и двумя просветами", "подполковник": "погоны с двумя звездами и двумя просветами", "полковник": "погоны с тремя звездами и двумя просветами", "генерал-майор": "погоны с одной большой звездой", "генерал-лейтенант": "погоны с двумя большими звездами", "генерал-полковник": "погоны с тремя большими звездами", "генерал": "погоны с одной большой звездой и гербом МВД"}

Global City
Global ID
Global License
Global Surname
Global Name
Global SecondName
Global Rank
Global Post
Global Department
Global DepartmentCode
Global TenCode
Global SpecialPost
Global Callsign
Global Signature
Global ProvPath
Global Gender

Global Special

Global lla
Global la
Global kca
Global kuce
Global syaas
Global kaci
Global Struct
Global Tag
Global Code
Global OSN
Global OSNTag


;Global Label
}

{ ; -------------------------------------------------- Control variables ------------------------------------
Global ChooseCity
Global EditLicense
Global EditSurname
Global EditName
Global EditSecondName
Global ChooseRank
Global EditPost
Global EditDepartment
Global EditDepartmentCode
Global EditTenCode
Global EditSpecialPost
Global EditCallsign
Global EditSignature
Global EditProvPath
Global RadioMale
Global RadioFemale
Global CheckSpecial
Global ButtonEditText
Global ButtonSpecialText

}


CheckAdmin()
{

    if(not A_IsAdmin and %0% == 0)
    {
        try
        {
            if(A_IsCompiled)
                Run *RunAs "%A_ScriptFullPath%" /restart
            else
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
        ExitApp
    }

}

CheckUIA()
{
    if (!A_IsCompiled && !InStr(A_AhkPath, "_UIA")) {
        Run % "*uiAccess " A_ScriptFullPath
        ExitApp
    }
}

SetLocaleRu()
{
    SendMessage, 0x50,, 0x4190419,, A ;
}

SetLocaleEn()
{
    SendMessage, 0x50,, 0x4090409,, A ;
}

CheckLocale(String) {
    ; Проверка на наличие кириллицы с помощью регулярного выражения
    if (RegExMatch(String, "[А-Яа-яЁё]")) {
        SetLocaleRu()
    } else {
        SetLocaleEn()
    }
}

SetCapsOff()
{
    SetCapsLockState Off
}


CheckUpdate()
{
	FileDelete, %A_Temp%\update.ahk
	Http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    Http.Open("GET", "https://github.com/sookolin/profile.tp/raw/main/version.profile.md")
    Http.Send()
    ;MsgBox % Http.ResponseText
    Versions := StrSplit(Http.ResponseText, "`n")
    NewVersion := Versions[1]
    GuiNewVersion := Versions[2]
    ;MsgBox k%NewVersion%k
    for Num, Value in Versions
        if(Num>=3)
            ChangeList = %Changelist%`n• %Value%
    ;MsgBox % Version<NewVersion
    
	if(NewVersion <= Version)
    {
		StartScript()
        Return
    }
    Gui 4:Destroy
    IM = %WorkingDir%\ahk.ico
    IfExist, %IM%
    Menu, Tray, Icon, %IM%
    Gui 4:Font, s12 c000000 Bold, Bahnschrift
    Gui 4:Add, Text, , Вышла новая версия! Обновить с %GuiVersion% на %GuiNewVersion%?
    Gui 4:Font, s16
    Gui 4:Add, Link, xp yp+40, Список изменений (<a href="https://vk.com/@provinceahk-changelogtp">ChangeLog</a>):
    Gui 4:Font, s12 
    for Num, Value in Versions
        if(Num>=3)
            Gui 4:Add, Text, xp yp+30, • %Value%
    Gui 4:Add, Button, xp yp+30 w145 gUpdate Default, Обновить
    Gui 4:Add, Button, xp+150 yp w145 gSkipUpdate, Не обновлять
    Gui 4:Add, Button, xp+150 yp w145 gClose, Закрыть скрипт
    

    Gui 4:Show,, AHK ГИБДД #5 | AHK Province
    Return
    
    Update:    
    URL = https://raw.githubusercontent.com/sookolin/profile.tp/main/tp.ahk
    ;URL = https://my-files.su/Save/d6bcxl/ahk.tp.exe
	URLDownloadToFile, %URL%, %A_Temp%\update.ahk
    ;MsgBox %A_Temp%\update.ahk
	PID := DllCall("GetCurrentProcessId")

	Run *uiAccess %A_Temp%\update.ahk /update %PID% %A_ScriptFullPath%
    ExitApp
    
    SkipUpdate:
    Gui 4:Destroy
    StartScript()
    Return
    
    GuiClose:
    ExitApp
    
    Close:
    ExitApp
}



Update(PID, Path) {
	Process, Close, %PID%
	Process, WaitClose, %PID%, 3
	If ErrorLevel
	{
		MsgBox, % 16, Ошибка, Не удаётся закрыть процесс`nКод ошибки: 1.
		ExitApp
	}
	FileCopy, %A_ScriptFullPath%, %Path%, 1
	If ErrorLevel
	{
		MsgBox, % 16, Ошибка, Не удалось выполнить копирование, возможно были запущены несколько экземпляров программы.`nКод ошибки: 2.
		ExitApp
	}
	PID := DllCall("GetCurrentProcessId")
	Run %Path% /tempdelete "%PID%" "%A_ScriptFullPath%"
	ExitApp
}

TempDelete(PID, Path) {
	Process, Close, %PID%
	Process, WaitClose, %PID%, 2
	FileDelete, %Path%
	Return
}

ParamCheck()
{   
    ;ComParam1 := %0%
    ;MsgBox % ComParam1
        if(A_Args[1]=="/update")
        {
            Update(A_Args[2], A_Args[3])
            Return
        }   
        if(A_Args[1]=="/tempdelete")
        {
            TempDelete(A_Args[2], A_Args[3])
            StartScript()
            Return
        }
 
        CheckAdmin()
        ; CheckUpdate()
       StartScript()
}


RefreshTray() ; Трэй
{
TrayTip, AHK ГИБДД #5 (%GuiVersion%), Скрипт успешно запущен.
IM = %WorkingDir%\ahk.ico
IfExist, %IM%
Menu, Tray, Icon, %IM%
Menu, Tray, NoStandard
Menu, Tray, Add, VKowner
Menu, Tray, Rename, VKowner, AHK Province
Menu, Tray, Add ; SEPARATOR
Menu, Tray, Add, VKmemo
Menu, Tray, Rename, VKmemo, Памятка
Menu, Tray, Add ; SEPARATOR
Menu, Tray, Add, ReloadMenu
Menu, Tray, Rename, ReloadMenu, Перезапуск
Menu, Tray, Add, HideShowMenu
Menu, Tray, Rename, HideShowMenu, Свернуть
Menu, Tray, Add, ExitMenu
Menu, Tray, Rename, ExitMenu, Закрыть
Menu, Tray, Tip, AHK ГИБДД #5 (%GuiVersion%)
Return

VKowner:
Run, https://vk.com/provinceahk
Return

VKmemo:
Run, https://vk.com/@provinceahk-pamyatkaahk    
Return

ReloadMenu:
Reload
ExitApp 

HideShowMenu:
If HIDDEN_NOW
{
Menu, Tray, Rename, Развернуть, Свернуть
Gui Show
}
Else
{
Menu, Tray, Rename, Свернуть, Развернуть
Gui Hide
}
HIDDEN_NOW := !HIDDEN_NOW
Return

ExitMenu:
ExitApp
Reload

YesUpdate:
Return
}

{ ; -------------------------------------------------- URL's ------------------------------------------------
Global URLVkGroup         := "https://vk.com/provinceahk"
Global URLForumMVD        := "https://forum.gtaprovince.ru/forum/404-министерство-внутренних-дел/"
Global URLForumGUVDM      := "https://forum.gtaprovince.ru/forum/417-guvd-mirnogo/"
Global URLForumGUVDP      := "https://forum.gtaprovince.ru/forum/416-guvd-privolzhska/"
Global URLForumGUVDN      := "https://forum.gtaprovince.ru/forum/423-guvd-nevskogo/"
Global URLForumFZoP       := "https://forum.gtaprovince.ru/topic/456451-ministerstvo-vnutrennih-del-federalnyy-zakon-o-policii/"
Global URLForumPDD        := "https://forum.gtaprovince.ru/topic/639262-pravila-dorozhnogo-dvizheniya-respubliki/"
Global URLForumUPK        := "https://forum.gtaprovince.ru/topic/639258-ugolovnyy-kodeks-respubliki/"
Global URLForumKoAP       := "https://forum.gtaprovince.ru/topic/639260-kodeks-ob-administrativnyh-pravonarusheniyah-respubliki/"
Global URLMetodGUVD       := "https://forum.gtaprovince.ru/topic/847765-metodicheskoe-posobie-gu-mvd/"
Global URLDepartmentsGUVD := "https://forum.gtaprovince.ru/topic/847764-polozhenie-ob-otdelah-gu-mvd/"
}

RefreshData()
{
    for Num, Field in DataFields
    {
        IniRead %Field%, %DataPath%, %DataSection%, %Field%
       
        if(%Field%=="ERROR")
            %Field% := ""
    }
    if(City=="Мирный")
    {
        Struct=ГУ МВД России по г. Мирный
        OSN=ОСпН «Гром»
        OSNTag=ОСпН
        Tag=ГУ МВД-М
        Code=77
    }
    if(City=="Приволжск")
    {
        Struct=ГУ МВД России по г. Приволжск
        OSN=СОБР
        OSNTag=СОБР
        Tag=УГИБДД-П
        Code=63
    }
    if(City=="Невский")
    {
        Struct=ГУ МВД России по г. Невский
        OSN=ЦСН «БАРС»
        OSNTag=ЦСН
        Tag=УГИБДД-Н
        Code=78
    }
    
    if(Gender=="Male"){
		lla = л
        la =
		kca = к
        kuce = ку
		syaas = ся
		kaci = ка
	}
	else if(Gender=="Female"){
		lla = ла
        la = ла
		kca = ца
        kuce = це
		syaas = ась
		kaci = цы
	}
    
}

RefreshHotkeys()
{
    for KeyName in Hotkey_Arr("AllHotkeys")
	{
		if Reset
			Hotkey % Hotkey_Value(KeyName), Off, UseErrorLevel
		else
			Hotkey % Hotkey_Write(KeyName), %KeyName%, UseErrorLevel On
        Hotkey_Disable(KeyName)
	}
    /*
    for Field, Value in HotkeyFields
    {
        Label := SubStr(Field, 3)
        IniRead %Label%, %DataPath%, %HotkeySection%, %Label%
        HotkeyValues[Label] := %Label%
    }
    */
}
/*
SetHotkeys()
{
    for Label, Value in HotkeyValues
    {
        Value := EncodeHotkey(HotkeyValues[Label])
        if((Value<>"") and (Value<>"ERROR"))
            Hotkey %Value%, %Label%
    }
}
*/
GetHotkeys()
{
    for Field, Value in HotkeyFields
    {
        Label := SubStr(Field, 3)
        IniRead %Label%, %DataPath%, %HotkeySection%, %Label%
        
        HotkeyValues[Label] := %Label%
        ; HotkeyValues[Label] := Hotkey_Read(Label)
    }
}

GetSettings()
{
    for Value in SettingsFields
    {
        IniRead %Value%, %DataPath%, %SettingsSection%, %Value%
    }
}

SaveSettings()
{
    for Key, Value in SettingsFields
    {
        Key := %Value%
        IniWrite %Key%, %DataPath%, %SettingsSection%, %Value%
    }
}

GetDefaultHotkeys()
{
    ; DefaultHotkeysPath = %%\default.tp.prv
    URLDownloadToFile https://raw.githubusercontent.com/sookolin/profile.tp/main/default.tp.prv, %DefaultHotkeysPath%
	PID := DllCall("GetCurrentProcessId")
    
    for Field, Value in HotkeyFields
    {
        Label := SubStr(Field, 3)
        IniRead %Label%, %DefaultHotkeysPath%, %HotkeySection%, %Label%
        if(EncodeDelete(HotkeyValues[Label])=="ERROR")
        {
            HotkeyValues[Label] := %Label%
            Key := %Label%
            IniWrite %Key%, %DataPath%, %HotkeySection%, %Label%
        } else {
            IniRead %Label%, %DataPath%, %HotkeySection%, %Label%
            HotkeyValues[Label] := %Label%
        }
    }
    
    
    RefreshHotkeys()
    ;MsgBox Writed
    FileDelete, %DefaultHotkeysPath%
    ; TempDelete(PID, DefaultHotkeysPath)
}

CheckData()
{
    for Num, Field in DataFields
    {
        if(%Field%=="ERROR")
            %Field% := ""
        if(%Field%=="")
            Return False
    }
    Return True
}

CheckHotkeys()
{
    for Field, Value in HotkeyFields
    {
        Label := SubStr(Field, 3)
        HotkeyValue := EncodeDelete(HotkeyValues[Label])
        if(HotkeyValue=="ERROR")
            Return False
    }
    Return True
}

WriteData()
{
    for Num, Control in DataControls
    {
        Value := %Control%
        DataField := DataFields[Num]
        IniWrite %Value%, %DataPath%, %DataSection%, %DataField%
    }
}

/*
WriteHotkeys()
{
    for Label, Value in HotkeyValues
    {
        ; Label := SubStr(Field, 3)
        IniWrite %Value%, %DataPath%, %HotkeySection%, %Label%
    }
}
*/
ShowMainGui()
{ ; ------------------------------------------------ GUI #1 "Main" ------------------------------------------
; URLDownloadToFile https://github.com/technostd/Scripts/blob/b6849e4df232b5a72f5a503f81ec269a2d21c8ef/ahk.ico, %A_Temp%\ahk.ico
Gui 1:Destroy

; -------------------------------------------------- Icon ---------------------------------------------------
;Menu, Tray, Icon, %A_WorkingDir%\ahk.ico
;Menu Actions, 

;Gui 1:Menu, 
; -------------------------------------------------- Font ---------------------------------------------------
Gui 1:Font, s10 CDefault, Bahnschrift

; -------------------------------------------------- Footer -------------------------------------------------
Gui 1:Font, s10 c545454
Gui 1:Add, Text, x002 y700 w500 h15, v%GuiVersion% Хочешь помочь с дополнением? Пиши свои пожелания в t.me/provinceahk
Gui 1:Add, Text, x488 yp w400 h15 Right, %TextFooter%

Gui 1:Font, s10 c000000 Bold
Gui 1:Add, Button, x425 y005 w150 h30 gButtonEdit vButtonEditText , Изменить клавиши
Gui 1:Add, Button, xp+155 yp w70 h30 gButtonData, Анкета
Gui 1:Add, Button, xp+75 yp w70 h30 gButtonHelp, Ссылки
Gui 1:Add, Button, xp+75 yp w150 h30 gButtonSpecial vButtonSpecialText, Повседневная форма
;Gui 1:Add, Button, xp yp+215 w30 h200 gButtonReload, Перезапуск
;Gui 1:Add, Button, xp yp+215 w30 h200 gButtonClose, Закрыть



Gui 1:Font, s13 c000000 Bold
Gui 1:Add, Tab2, x10 y5 h40 w600 Buttons -Wrap, Основное|Документы|Рация|ПМП ;|Дополнительно
; Gui 1:Add, Text, x0 y5 h35 w920 Center, Здесь скоро появятся разделы
Gui 1:Tab, 1

Gui 1:Add, GroupBox, x010 y40 w290 h650, [ Основное ]
Gui 1:Add, GroupBox, xp+290 y40 w290 h335, [ Задержание ]
Gui 1:Add, GroupBox, xp y365 w290 h325, [ Дополнительно ]
Gui 1:Add, GroupBox, xp+290 y40 w290 h650, [ Команды ]

Gui 1:Font, Bold C000000 s7

Hotkey_Arr("OnlyEngSym", True)

Gui 1:Add, Text, x175 y040 Hidden
for Field, Value in HotkeyFields
{   
    if(Value[1]=="1")
    {
        Desc := Value[2]
        Label := SubStr(Field, 3)
        HotkeyValue := HotkeyValues[Label]
        Gui 1:Font, C000000 s10
        Gui 1:Add, Text, xp-160 yp+22 w150 h26 , % Desc
        Gui 1:Font, C540000 s8
        Hotkey_Add("xp+160 yp w120 -Center", Label, "KMJNDG1", Hotkey_Read(Label), "Save")
        
        Hotkey_Disable(Label)
        ; Gui 1:Add, Hotkey, xp+180 yp w100 h20 Disabled hwndhwnd, % HotkeyValue
        ; HotkeyHWNDs[Label] := hwnd
    }

}

Gui 1:Add, Text, x465 y040 Hidden   
for Field, Value in HotkeyFields
{   
    if(Value[1]=="2")
    {
        Desc := Value[2]
        Label := SubStr(Field, 3)
        HotkeyValue := HotkeyValues[Label]
        Gui 1:Font, C000000 s10
        Gui 1:Add, Text, xp-160 yp+22 w150 h26 , % Desc
        Gui 1:Font, C540000 s8
        Hotkey_Add("xp+160 yp w120 -Center", Label, "KMJNDG1", Hotkey_Read(Label), "Save")
        
        Hotkey_Disable(Label)
        ; Gui 1:Add, Hotkey, xp+180 yp w100 h20 Disabled hwndhwnd, % HotkeyValue
        ; HotkeyHWNDs[Label] := hwnd
    }

}

Gui 1:Add, Text, x465 y365 Hidden
for Field, Value in HotkeyFields
{   
    if(Value[1]=="3")
    {
        Desc := Value[2]
        Label := SubStr(Field, 3)
        HotkeyValue := HotkeyValues[Label]
        Gui 1:Font, C000000 s10
        Gui 1:Add, Text, xp-160 yp+22 w150 h26, % Desc
        Gui 1:Font, C540000 s8
        Hotkey_Add("xp+160 yp w120 -Center", Label, "KMJNDG1", Hotkey_Read(Label), "Save")
        
        Hotkey_Disable(Label)
        ; Gui 1:Add, Hotkey, xp+180 yp w100 h20 Disabled hwndhwnd, % HotkeyValue
        ; HotkeyHWNDs[Label] := hwnd
    }

}

Gui 1:Font, Bold C540000 s10
Gui 1:Add, Text, x595 y062 w100 h20, /р+
Gui 1:Add, Text, xp yp+20 w100 h20, /р-
Gui 1:Add, Text, xp yp+20 w100 h20, /м <Сообщение>
Gui 1:Add, Text, xp yp+20 w100 h20, /двр<1-4>
Gui 1:Add, Text, xp yp+20 w100 h20, /камеры
Gui 1:Add, Text, xp yp+20 w100 h20, /удо+
Gui 1:Add, Text, xp yp+20 w100 h20, /удо-
Gui 1:Add, Text, xp yp+20 w100 h20, /рейд+
Gui 1:Add, Text, xp yp+20 w100 h20, /рейд-
Gui 1:Add, Text, xp yp+20 w100 h20, /кпк+
Gui 1:Add, Text, xp yp+20 w100 h20, /кпк-
Gui 1:Add, Text, xp yp+20 w100 h20, /доки
Gui 1:Add, Text, xp yp+20 w100 h20, /доки+
Gui 1:Add, Text, xp yp+20 w100 h20, /доки-
Gui 1:Add, Text, xp yp+20 w100 h20, /кримрек <ID>
Gui 1:Add, Text, xp yp+20 w100 h20, /протокол
Gui 1:Add, Text, xp yp+20 w100 h20, /чист<1-4>
Gui 1:Add, Text, xp yp+20 w100 h20, /конвоир <ID>
Gui 1:Add, Text, xp yp+20 w100 h20, /вкпз <ID>
Gui 1:Add, Text, xp yp+20 w100 h20, /штраф <ID...>
Gui 1:Add, Text, xp yp+20 w100 h20, /вроз <ID...>
Gui 1:Add, Text, xp yp+20 w100 h20, /впа <ID>
Gui 1:Add, Text, xp yp+20 w100 h20, /изпа <ID>

Gui 1:Font, c000000
Gui 1:Add, Text, x705 y062 w170 h20,Подключиться к рации
Gui 1:Add, Text, xp yp+20 w170 h20, Отключиться от рации
Gui 1:Add, Text, xp yp+20 w170 h20, Крикнуть в мегафон
Gui 1:Add, Text, xp yp+20 w170 h20, Видеорегистратор
Gui 1:Add, Text, xp yp+20 w170 h20, Запись с камеры (КПК)
Gui 1:Add, Text, xp yp+20 w170 h20, Показать УДО
Gui 1:Add, Text, xp yp+20 w170 h20, Убрать УДО
Gui 1:Add, Text, xp yp+20 w170 h20, Показать приказ о рейде
Gui 1:Add, Text, xp yp+20 w170 h20, Убрать приказ о рейде
Gui 1:Add, Text, xp yp+20 w170 h20, Достать КПК
Gui 1:Add, Text, xp yp+20 w170 h20, Убрать КПК
Gui 1:Add, Text, xp yp+20 w170 h20, Попросить документы
Gui 1:Add, Text, xp yp+20 w170 h20, Взять документы
Gui 1:Add, Text, xp yp+20 w170 h20, Вернуть документы
Gui 1:Add, Text, xp yp+20 w170 h20, Пробить по базе (КПК)
Gui 1:Add, Text, xp yp+20 w170 h20, Составить протокол
Gui 1:Add, Text, xp yp+20 w170 h20, Чистосердечное признание
Gui 1:Add, Text, xp yp+20 w170 h20, Арест (на парковке)
Gui 1:Add, Text, xp yp+20 w170 h20, Арест (около КПЗ)
Gui 1:Add, Text, xp yp+20 w170 h20, Выписать штраф (КПК)
Gui 1:Add, Text, xp yp+20 w170 h20, Объявить в розыск
Gui 1:Add, Text, xp yp+20 w170 h20, Посадить в ПА
Gui 1:Add, Text, xp yp+20 w170 h20, Высадить из ПА


Gui 1:Font, s16 c000000 
Gui 1:Tab, 2
Gui 1:Add, GroupBox, x010 y40 w290 h650, [ КоАП ]
Gui 1:Add, GroupBox, xp+290 yp w290 h650, [ ФЗоП ]
Gui 1:Add, GroupBox, xp+290 yp w290 h650, [ УК РП ]

Gui 1:Font, s12 

Gui 1:Add, Text, x015 y070 w280 r20, Для всех статей КоАП предусмотрена команда вида /коапX.Y, где X.Y - номер статьи`n`nВыдает только расшифровку статьи.

Gui 1:Add, Text, xp+290 yp w280 r20, К сожалению, для ФЗоП команд на данный момент не предусмотрено.`n`nРазыскивается тот, кто сделает это во благо ГУ МВД :)`nПисать в t.me/provinceahk

Gui 1:Add, Text, xp+290 yp w280 r20, К сожалению, для УК РП команд на данный момент не предусмотрено.`n`nРазыскивается тот, кто сделает это во благо ГУ МВД :)`nПисать в t.me/provinceahk

Gui 1:Font, s16 c000000 
Gui 1:Tab, 3
Gui 1:Add, GroupBox, x010 y40 w870 h650, [ Рация ]
Gui 1:Font, s12 
Gui 1:Font, Bold C540000 s10
Gui 1:Add, Text, x015 y072 w200 h20, /пппсн
Gui 1:Add, Text, xp yp+20 w200 h20, /пппсм
Gui 1:Add, Text, xp yp+20 w200 h20, /пппсп
Gui 1:Add, Text, xp yp+20 w200 h20, /пдпсн
Gui 1:Add, Text, xp yp+20 w200 h20, /пдпсм
Gui 1:Add, Text, xp yp+20 w200 h20, /пдпсп
Gui 1:Add, Text, xp yp+20 w200 h20, /пк <Тег>
Gui 1:Add, Text, xp yp+20 w200 h20, /пдк <Тег>
Gui 1:Add, Text, xp yp+20 w200 h20, /наряд <Местоположение>
Gui 1:Add, Text, xp yp+20 w200 h20, /нарядкдчн
Gui 1:Add, Text, xp yp+20 w200 h20, /нарядкдчм
Gui 1:Add, Text, xp yp+20 w200 h20, /нарядкдчп
; Gui 1:Add, Text, xp yp+20 w100 h20, /врозыск <Cерия паспорта>
Gui 1:Add, Text, xp yp+20 w200 h20, /вп+
Gui 1:Add, Text, xp yp+20 w200 h20, /впп
Gui 1:Add, Text, xp yp+20 w200 h20, /вп-
Gui 1:Add, Text, xp yp+20 w200 h20, /со+
Gui 1:Add, Text, xp yp+20 w200 h20, /соп
Gui 1:Add, Text, xp yp+20 w200 h20, /со-
Gui 1:Add, Text, xp yp+20 w200 h20, /код0 <Местоположение>
Gui 1:Add, Text, xp yp+20 w200 h20, /код0п <Местоположение>
Gui 1:Add, Text, xp yp+20 w200 h20, /код0с <Местоположение>
Gui 1:Add, Text, xp yp+20 w200 h20, /асмп <Местоположение>
Gui 1:Add, Text, xp yp+20 w200 h20, /пмедкарта <Cерия паспорта>


Gui 1:Font, c000000

Gui 1:Add, Text, xp yp+20 w500 h20, Хочешь помочь с дополнением? Пиши свои пожелания - t.me/provinceahk
Gui 1:Add, Text, x215 y072 w500 h20, Принять вызов от ГУ МВД-Н
Gui 1:Add, Text, xp yp+20 w500 h20, Принять вызов от ГУ МВД-М
Gui 1:Add, Text, xp yp+20 w500 h20, Принять вызов от ГУ МВД-П
Gui 1:Add, Text, xp yp+20 w500 h20, Принять вызов от ГИБДД-Н
Gui 1:Add, Text, xp yp+20 w500 h20, Принять вызов от ГИБДД-М
Gui 1:Add, Text, xp yp+20 w500 h20, Принять вызов от ГИБДД-П
Gui 1:Add, Text, xp yp+20 w500 h20, Принять вызов от [<Тег>] в /ro (IC рация МВД)
Gui 1:Add, Text, xp yp+20 w500 h20, Принять вызов от [<Тег>] в /d (IC рация департамента) (с 7 ранга (капитан))
Gui 1:Add, Text, xp yp+20 w500 h20, Вызвать наряд ДПС к <Местоположение>
Gui 1:Add, Text, xp yp+20 w500 h20, Вызвать наряд ДПС к ДЧ г. Невский
Gui 1:Add, Text, xp yp+20 w500 h20, Вызвать наряд ДПС к ДЧ г. Мирный
Gui 1:Add, Text, xp yp+20 w500 h20, Вызвать наряд ДПС к ДЧ г. Приволжск
; Gui 1:Add, Text, xp yp+20 w500 h20, Запрос на объявление в розыск
Gui 1:Add, Text, xp yp+20 w500 h20, Вылетел в воздушное патрулирование
Gui 1:Add, Text, xp yp+20 w500 h20, Продолжаю воздушное патрулирование
Gui 1:Add, Text, xp yp+20 w500 h20, Закончил воздушное патрулирование
Gui 1:Add, Text, xp yp+20 w500 h20, Начали СО по отлову ОП и ООП (ОСН)
Gui 1:Add, Text, xp yp+20 w500 h20, Продолжаем СО по отлову ОП и ООП (ОСН)
Gui 1:Add, Text, xp yp+20 w500 h20, Закончили СО по отлову ОП и ООП (ОСН)
Gui 1:Add, Text, xp yp+20 w500 h20, Объявить код-0
Gui 1:Add, Text, xp yp+20 w500 h20, Активация SOS на торпеде ПА
Gui 1:Add, Text, xp yp+20 w500 h20, Активация SOS, вшитой в форму
Gui 1:Add, Text, xp yp+20 w500 h20, Запрос на АСМП (с 7 ранга (капитан))
Gui 1:Add, Text, xp yp+20 w500 h20, Запрос на продление медкарты (с 7 ранга (капитан))

Gui 1:Tab, 4
Gui 1:Add, Text, x010 y40 w870 h650, Друзья! Насколько мне известно, этот ахк ждет много народу, поэтому не хочу ради пары разделов задерживать его выпуск. Основа написана, жду ваших предложений и пожеланий в чате нашего канала t.me/provinceahk`n`nОбязательно сообщайте о возникающих ошибках туда же. Надеюсь, что их будет немного, но постараюсь оперативно фиксить. При выходе обновления вам автоматически предложит его установить. Я надеюсь...



Global ChooseCity
Global EditLicense
Global EditSurname
Global EditName
Global EditSecondName
Global EditDepartment
Global EditNickname
Global ChooseRank
Global EditPost
Global EditProvPath
Global CheckSpecial

;Menu HelpMenu, Add, &Анкета, ButtonData
;    Menu HelpMenu, Add, &Форма ОСН, ButtonSpecial
;
;Menu MenuBar, Add, &Действия, :HelpMenu
;Gui 1:Menu, MenuBar
Gui 1:Show, h715 w890, ГУ МВД #5 | AHK Province
Return

ButtonEdit:
; MsgBox, 16, Ошибка, Функция недоступна, находится в разработке.
if(HotkeysEnabled)
{
    
    for KeyName in Hotkey_Arr("AllHotkeys")
	{
		if Reset
			Hotkey % Hotkey_Value(KeyName), Off, UseErrorLevel
		else
			Hotkey % Hotkey_Write(KeyName), %KeyName%, UseErrorLevel On
        Hotkey_Disable(KeyName)
	}
    HotkeysEnabled := False
    GuiControl 1:Text, ButtonEditText, Изменить клавиши
}    
else
{

    /*
    for Label, Value in HotkeyHWNDs
    {
        GuiControl 1:Enable, % Value
        HotkeyValue := HotkeyValues[Label]
        if(HotkeyValue<>"")
            Hotkey %HotkeyValue%, Off
    }
    */
    
    for KeyName in Hotkey_Arr("AllHotkeys")
    {
        Hotkey % Hotkey_Value(KeyName), Off, UseErrorLevel
        Hotkey_Disable(KeyName, false)
    }
    HotkeysEnabled := True
    GuiControl 1:Text, ButtonEditText, Сохранить
}
Return

ButtonSpecial:
Special := !Special

If(Special)
    GuiControl 1:Text, ButtonSpecialText, Форма ОСН
Else
    GuiControl 1:Text, ButtonSpecialText, Повседневная форма
SaveSettings()

Return

ButtonData:
Gui 1:+Disabled
ShowGetDataGui()
Return

ButtonHelp:
ShowHelpGui()
Return

ButtonReload:
Reload
ExitApp 

ButtonClose:
Gui 1:Cancel
Return

1GuiClose:
Gui 1:Cancel
Return

}

ShowGetDataGui() ; GD
{ ; ------------------------------------------------ GUI #2 "GetData" ---------------------------------------

Gui 2:Destroy

if(City=="")
    City := "Мирный"
if(Rank=="")
    Rank := "Рядовой"

if(Gender=="Male"){
	CheckedMale = Checked
	CheckedFemale = 
}
if(Gender=="Female"){
	CheckedMale = 
	CheckedFemale = Checked
}
if(MB)
    CheckedMB = Checked

; -------------------------------------------------- Icon ---------------------------------------------------
;Menu, Tray, Icon, C:\Scripts\ahk.ico

; -------------------------------------------------- Font ---------------------------------------------------
Gui 2:Font, s18 CDefault Bold, Bahnschrift

; -------------------------------------------------- Title --------------------------------------------------

Gui 2:Add, Text, x010 y005 w400 h40 , Данные сотрудника
Gui 2:Add, Text, x010 y260 w400 h40 , Информация в спецподразделении
Gui 2:Add, Text, x010 y340 w400 h40 , Техническая информация
; ["City", "License", "Surname", "Name", "SecondName", "Rank", "Post", "Department", "Tencode", "Callsign", "Signature", "ProvPath", "Gender", "Special"]

; -------------------------------------------------- Fields -------------------------------------------------
Gui 2:Font, s12

Gui 2:Add, DropDownList, x435 y005 w150 r3 vChooseCity, %Cities%

Gui 2:Add, Edit, x010 y060 w190 r1 vEditSurname, %Surname%
Gui 2:Add, Edit, xp+195 yp w190 r1 vEditName, %Name%
Gui 2:Add, Edit, xp+195 yp w190 r1 vEditSecondName, %SecondName%

Gui 2:Add, Edit, x010 y120 w190 r1 vEditDepartment, %Department%
Gui 2:Add, Edit, xp+195 y120 w385 r1 vEditPost, %Post%

Gui 2:Add, ComboBox, x010 y180 w190 r11 vChooseRank, %Ranks%
Gui 2:Add, Edit, xp+195 yp w190 r1 vEditLicense, %License%
Gui 2:Add, Edit, xp+195 yp w90 r1 vEditDepartmentCode, %DepartmentCode%
Gui 2:Add, Edit, xp+100 yp w90 r1 vEditTenCode, %TenCode%
Gui 2:Add, Text, xp-10 yp w10 +Center r1, -

Gui 2:Add, Radio, x010 y235 h15 Group %CheckedMale% vRadioMale, Мужской
Gui 2:Add, Radio, xp+120 yp h15 %CheckedFemale% vRadioFemale, Женский
Gui 2:Add, Edit, xp+160 yp w300 r1 vEditSignature, %Signature%

Gui 2:Add, Edit, x010 y315 w190 r1 vEditCallsign, %Callsign%
Gui 2:Add, Edit, xp+195 y315 w385 r1 vEditSpecialPost, %SpecialPost%

Gui 2:Add, Edit, x010 y395 w450 r1 ReadOnly vEditProvPath, %ProvPath%
Gui 2:Add, Button, xp+455 yp w125 h30 gButtonChangePath, Изменить

;Gui 2:Add, Edit, xp yp+40 w300 r1 vEditPost, %Post%
;Gui 2:Add, Edit, xp yp+40 w300 h40 ReadOnly vEditProvPath, %ProvPath%
;Gui 2:Add, Button, xp+305 yp w100 h40 gButtonChangePath, Изменить
;Gui 2:Add, Radio, xp-220 yp+40 h15 Group %CheckedMale% vRadioMale, Мужской
;Gui 2:Add, Radio, xp yp+40 h15 %CheckedFemale% vRadioFemale, Женский
;Gui 2:Add, CheckBox, xp+200 yp-20 h15 %CheckedSpecial% vCheckSpecial, Мотобатальон


GuiControl 2:ChooseString, ChooseCity, %City%
GuiControl 2:Text, ChooseRank, %Rank%

Gui 2:Font, s10 C540000 Bold
;Gui 2:Add, Text, x320 y080 w300 r03, Город трудоустройства
Gui 2:Add, Text, x010 y040 w190 r01, Фамилия | *Иванов*
Gui 2:Add, Text, xp+195 yp w190 r01, Имя | *Иван*
Gui 2:Add, Text, xp+195 yp w190 r01, Отчество | *Иванович*
Gui 2:Add, Text, x010 y100 w190 r01, Подразделение | *УЦ ППС*
Gui 2:Add, Text, xp+195 y100 w385 r01, Должность | *курсант УЦ ППС ГУ МВД России по г. Мирный*
Gui 2:Add, Text, x010 y160 w190 r01, Звание | *cтаршина*
Gui 2:Add, Text, xp+195 yp w190 r01, № удостоверения | *123456*
Gui 2:Add, Text, xp+195 yp w190 r01, Тен-код | *52-26*
Gui 2:Add, Text, x010 y220 w190 r01, Пол персонажа
Gui 2:Add, Text, xp+280 yp w300 r01, Подпись | *ИвановИИ*

Gui 2:Add, Text, x010 y295 w190 r01, Позывной | *Ястреб*
Gui 2:Add, Text, xp+195 y295 w385 r01, Должность в ОСН | *Старший оперативный сотрудник*

Gui 2:Add, Text, x010 y375 w300 r01, Путь до папки с игрой | *C:\Province Games*

;Gui 2:Add, Text, x320 yp+40 w300 r01, Звание | *Старшина*
;Gui 2:Add, Text, x320 yp+40 w300 r01, Должность | *Инспектор ДПС*

Gui 2:Font, s16 C000000 Norm Bold
Gui 2:Add, Button, x060 y440 w120 h50 gButtonReset, Сбросить
Gui 2:Add, Button, x240 yp   w120 h50 gButtonSave Default, Сохранить
Gui 2:Add, Button, x420 yp   w120 h50 gButtonCancel, Отменить


; -------------------------------------------------- Footer -------------------------------------------------
Gui 2:Font, s10 c545454
Gui 2:Add, Text, x002 y500 w100 h15, v%GuiVersion%
Gui 2:Add, Text, x198 y500 w400 h15 Right, %TextFooter%

Gui 2:Show, h515 w600, ГУ МВД #5 | AHK Province
Return

ButtonChangePath:
FileSelectFolder EditProvPath, *%ProvPath%, 3, Выберите папку c игрой "..\Province Games\"
GuiControl 2:Text, EditProvPath, %EditProvPath%
Return

ButtonReset:
Gui 2:Submit, NoHide

GuiControl 2:ChooseString, ShooseCity, Мирный
GuiControl 2:ChooseString, ChooseRank, Рядовой
GuiControl 2:Text, EditSurname
GuiControl 2:Text, EditName
GuiControl 2:Text, EditSecondName
GuiControl 2:Text, EditNickname
GuiControl 2:Text, EditLicense
GuiControl 2:Text, EditPost
GuiControl 2:Text, EditSignature
GuiControl 2:Text, EditProvPath, %DefaultProvPath%

Return

ButtonSave:
Gui 1:-Disabled
Gui 2:Submit
if(RadioMale=="1")
	Gender = Male
if(RadioFemale=="1")
	Gender = Female
if(CheckMB=="1")
    MB := True

WriteData()
RefreshData()
Return

2GuiClose:
Gui 1:-Disabled
Gui 2:Cancel
Return

ButtonCancel:
Gui 1:-Disabled
Gui 2:Cancel
Return

}

ShowHelpGui() ; GD
{ ; ------------------------------------------------ GUI #3 "Help" ---------------------------------------

Gui 3:Destroy

; -------------------------------------------------- Icon ---------------------------------------------------
;Menu, Tray, Icon, C:\Scripts\ahk.ico

; -------------------------------------------------- Font ---------------------------------------------------
Gui 3:Font, s18 CDefault, Bahnschrift

; -------------------------------------------------- Title --------------------------------------------------

Gui 3:Add, Text, x000 y000 w500 h40 +Center, Полезные ссылки

; -------------------------------------------------- Fields -------------------------------------------------

Gui 3:Font, s14 Bold
Gui 3:Add, Button, x015 y040 w200 r1 gButtonURLVkGroup, AHK Province
Gui 3:Add, Button, x015 y080 w200 r1 gButtonURLForumMVD, МВД
Gui 3:Add, Button, x015 y120 w200 r1 gButtonURLForumGUVDM, ГИБДД-М
Gui 3:Add, Button, x015 y160 w200 r1 gButtonURLForumGUVDP, ГИБДД-П
Gui 3:Add, Button, x015 y200 w200 r1 gButtonURLForumGUVDN, ГИБДД-Н
Gui 3:Add, Button, x015 y240 w200 r1 gButtonURLForumFZoP, ФЗоП
Gui 3:Add, Button, x015 y280 w200 r1 gButtonURLForumPDD, ПДД
Gui 3:Add, Button, x015 y320 w200 r1 gButtonURLForumUPK, УПК
Gui 3:Add, Button, x015 y360 w200 r1 gButtonURLForumKoAP, КоАП
Gui 3:Add, Button, x015 y400 w200 r1 gButtonURLMetodGUVD, Методичка
Gui 3:Add, Button, x015 y440 w200 r1 gButtonURLDepartmentsGUVD, Отделы

Gui 3:Font, s12 C540000 Bold
Gui 3:Add, Text, x220 y045 w300 r01, Наша группа ВК
Gui 3:Add, Text, x220 y085 w300 r01, Форумный раздел МВД
Gui 3:Add, Text, x220 y125 w300 r01, Форумный раздел Мирного
Gui 3:Add, Text, x220 y165 w300 r01, Форумный раздел Приволжска
Gui 3:Add, Text, x220 y205 w300 r01, Форумный раздел Невского
Gui 3:Add, Text, x220 y245 w300 r01, Федеральный закон "О полиции"
Gui 3:Add, Text, x220 y285 w300 r01, Правила дорожного движения
Gui 3:Add, Text, x220 y325 w300 r01, Уголовно-процессуальный кодекс
Gui 3:Add, Text, x220 y365 w300 r01, Кодекс об адм. правонарушениях
Gui 3:Add, Text, x220 y405 w300 r01, Методичка ГУ МВД
Gui 3:Add, Text, x220 y445 w300 r01, Положение об отделах ГУ МВД

; -------------------------------------------------- Footer -------------------------------------------------
Gui 3:Font, s10 c545454 Norm
Gui 3:Add, Text, x002 y485 w100 h15, v%GuiVersion%
Gui 3:Add, Text, x98 y485 w400 h15 Right, %TextFooter%

Gui 3:Show, h500 w500, ГУ МВД #5 | AHK Province
Return

ButtonURLVkGroup:
Run % URLVkGroup
Return
ButtonURLForumMVD:
Run % URLForumMVD
Return
ButtonURLForumGUVDM:
Run % URLForumGUVDM
Return
ButtonURLForumGUVDP:
Run % URLForumGUVDP
Return
ButtonURLForumGUVDN:
Run % URLForumGUVDN
Return
ButtonURLForumFZoP:
Run % URLForumFZoP
Return
ButtonURLForumPDD:
Run % URLForumPDD
Return
ButtonURLForumUPK:
Run % URLForumUPK
Return
ButtonURLForumKoAP:
Run % URLForumKoAP
Return
ButtonURLMetodGUVD:
Run % URLMetodGUVD
Return
ButtonURLDepartmentsGUVD:
Run % URLDepartmentsGUVD
Return

}

Encoded(Target)
{
    Target := StrReplace(Target, "#", "{#}")
    Target := StrReplace(Target, "!", "{!}")
    Target := StrReplace(Target, "^", "{^}")
    Target := StrReplace(Target, "+", "{+}")
    Target := StrReplace(Target, "&", "{&}")
	
	Return Target
}

EncodeDelete(Target)
{
    for Key, Value in ["#", "!", "^", "+", "&", "``", ",", ".", ";", "'", "/", "\", "-", "="]
        Target := StrReplace(Target, Value, "")
	Return Target
}

SendChat(TextBind, SleepBind)
{
    CheckLocale(TextBind)

    SetCapsOff()
    TextBind := Encoded(TextBind)
    Clipboard :=
    SendPlay {F8}^A{Delete}%TextBind%{Enter}{F8}
    Sleep %SleepBind%
} 

GetInput(Target, GUIText, ConsoleText)
{
    SetLocaleRu()
    SetCapsOff()
    if(InputType){
        InputBox %Target%, TechnoAHK:Input, % GUIText
        if ErrorLevel
            Return
        else if %Target% =
            Return
    } else {
        SendPlay {F8}%ConsoleText%{Space}
        Input %Target%, V, {Enter}
        SendPlay {F8}
        Sleep 100
    }
}

GetLogsLastLine(Index = 0)
{
    If (ProvPath != "")
    {
        Sleep 100
        
        Loop, read, %ProvPath%%LogPath%\console.log
            LastLine := A_LoopReadLine
            
        Return LastLine
    }
}

GetSkanned(consoleLine)
{
    RegExMatch(consoleLine, "\[Output\] : Уведомление: У [^ ]+ (.*)", matchedText)
    Return matchedText1
}


GetTryRes()
{
    LastLine := GetLogsLastLine()
    
    IfInString LastLine, Неудачно ;РќРµСѓРґР°С‡РЅРѕ
    {
        Return False
    }
    IfInString LastLine, Удачно ;РЈРґР°С‡РЅРѕ
    {
        Return True
    }
    if(InputType){
        MsgBox, 36, Результат, Удачно?
        IfMsgBox, Yes
            Return True
        IfMsgBox, No
            Return False
    } else {
    SendPlay {F8}Удачно? введите "да" или "нет" (в любой раскладке):{Space}
    Input TryRes, V, {Enter} 
    SendPlay {F8}
    if(TryRes=="да")||(TryRes=="lf")||(TryRes=="ДА")||(TryRes=="LF")
        Return True
    if(TryRes=="нет")||(TryRes=="ytn")||(TryRes=="НЕТ")||(TryRes=="YTN")
        Return False
    else
        Return False
    }
}

ReadComFile(FileName){
    Loop, read, %FileName%
        SendChat(Encoded(A_LoopReadLine), ComFileDelay)
}

GetArgsForHotstring(Hotstring, Target)
{
    SendPlay {Escape}{F6}
    Sleep 20
    SendPlay /%Hotstring%{Space}
    Input %Target%, V, {Enter}
}

StartScript()
{
    
    
    
    RefreshTray()
    
    GetHotkeys()
    
    GetSettings()
    
    ch := CheckHotkeys()
    if(!ch)
        GetDefaultHotkeys()

    RefreshData()
    
    ShowMainGui()
    
    RefreshHotkeys()
    
    if(not CheckData())
        ShowGetDataGui()
}

; CheckAdmin()

CheckUIA()

ParamCheck()

Return

{ ; Hotstrings - строки автозамены


{
    
        ; #include NPD\KoAP.ahk
{ ; #include prisyaga.ahk
        :?:/присяга+::
SendPlay {Enter}
SendChat("do В руках папка с присягой МВД.", "500")
SendChat("me переда" lla " папку с присягой сотруднику МВД", "0")
Return

:?:/присяга::
SendPlay {Enter}
SendChat("me взя" lla " папку с присягой, затем открыл её", "2000")
SendChat("me положив правую руку к сердцу, нача" lla " читать присягу вслух", "2000")
SendChat("say Я, " Surname " " Name " " SecondName ", поступая на службу в органы внутренних дел,", "2000")
SendChat("say торжественно присягаю на верность Республике Провинции и ее народу!", "2000")
SendChat("say Клянусь при осуществлении полномочий сотрудника органов внутренних дел", "2000")
SendChat("say уважать и защищать права и свободы человека и гражданина,", "2000")
SendChat("say свято соблюдать Конституцию Республики Провинции и федеральные законы!", "2000")
SendChat("say Быть мужественным, честным и бдительным, не щадить своих сил в борьбе с преступностью,", "2000")
SendChat("say достойно исполнять свой служебный долг и возложенные на меня обязанности", "2000")
SendChat("say по обеспечению безопасности,законности и правопорядка,", "2000")
SendChat("хранить государственную и служебную тайну.", "2000")
SendChat("say Служу Провинции, служу Закону!", "2000")
SendChat("me закрыв папку с присягой, переда" lla " ее генералу", "0")
Return

:?:/присяга-::
SendPlay {Enter}
SendChat("me взя" lla " папку с присягой у сотрудника МВД", "0")
Return
        }
{ ; #include radio.ahk
:?:/пппсн::
SendPlay {Enter}
SendChat("ro [" Tag "][ГУ МВД-Н] Принято.", "0")
Return

:?:/пппсм::
SendPlay {Enter}
SendChat("ro [" Tag "][ГУ МВД-М] Принято.", "0")
Return

:?:/пппсп::
SendPlay {Enter}
SendChat("ro [" Tag "][ГУ МВД-П] Принято.", "0")
Return

:?:/пдпсн::
SendPlay {Enter}
SendChat("ro [" Tag "][ГИБДД-Н] Принято.", "0")
Return

:?:/пдпсм::
SendPlay {Enter}
SendChat("ro [" Tag "][ГИБДД-М] Принято.", "0")
Return

:?:/пдпсп::
SendPlay {Enter}
SendChat("ro [" Tag "][ГИБДД-П] Принято.", "0")
Return

:?:/пк::
GetArgsForHotstring("пк", "ToTag")
SendPlay {Enter}
SendChat("ro [" Tag "][" ToTag "] Принято.", "0")
Return

:?:/пдк::
GetArgsForHotstring("пк", "ToTag")
SendPlay {Enter}
SendChat("d [" Tag "][" ToTag "] Принято.", "0")
Return

:?:/экипаж::
GetArgsForHotstring("экипаж", "Place")
SendPlay {Enter}
SendChat("ro [" Tag "][ГУ МВД] Требуется экипаж ДПС. Местоположение: " Place ".", "0")
Return

:?:/нарядкдчм::
SendPlay {Enter}
SendChat("ro [" Tag "][ГИБДД] Требуется сотрудник ДПС к дежурной части города Мирный.", "0")
Return

:?:/нарядкдчп::
SendPlay {Enter}
SendChat("ro [" Tag "][ГИБДД] Требуется сотрудник ДПС к дежурной части города Приволжск.", "0")
Return

:?:/нарядкдчн::
SendPlay {Enter}
SendChat("ro [" Tag "][ГИБДД] Требуется сотрудник ДПС к дежурной части города Невский.", "0")
Return

:?:/номера::
GetArgsForHotstring("номера", "Plate")
SendPlay {Enter}
SendChat("ro [" Tag "][ГИБДД] Пробейте владельца автомобиля с грз " Plate ".", "0")
Return

:?:/штраф::
GetArgsForHotstring("штраф", "ID")
SendPlay {Enter}
SendChat("ro [" Tag "][ГИБДД] Выпишите штраф человеку с серией паспорта " ID ".", "0")
Return

:?:/вп+::
SendPlay {Enter}
SendChat("ro [" Tag " ВП][МВД] Начал воздушное патрулирование.", "0")
Return

:?:/впп::
SendPlay {Enter}
SendChat("ro [" Tag " ВП][МВД] Продолжаю воздушное патрулирование.", "0")
Return

:?:/вп-::
SendPlay {Enter}
SendChat("ro [" Tag " ВП][МВД] Закончил воздушное патрулирование. Иду на посадку.", "0")
Return

:?:/со+::
SendPlay {Enter}
SendChat("ro [" OSN "][МВД] Начали спецоперацию по отлову ОП и ООП.", "0")
Return

:?:/соп::
SendPlay {Enter}
SendChat("ro [" OSN "][МВД] Продолжаем спецоперацию по отлову ОП и ООП.", "0")
Return

:?:/со-::
SendPlay {Enter}
SendChat("ro [" OSN "][МВД] Завершили спецоперацию по отлову ОП и ООП. Потерь среди личного состава нет.", "0")
Return

:?:/код0::
GetArgsForHotstring("код0", "Place")
Gosub SosCom
Return

:?:/код0п::
GetArgsForHotstring("код0п", "Place")
Gosub SosPCom
Return

:?:/код0с::
GetArgsForHotstring("код0с", "Place")
Gosub SosSCom
Return

:?:/асмп::
GetArgsForHotstring("асмп", "Place")
SendPlay {Enter}
SendChat("d [" Tag "][МЗ] Требуется АСМП. Местоположение: " Place ".", "0")
Return

:?:/пмедкарта::
GetArgsForHotstring("пмедкарта", "Pass")
SendPlay {Enter}
SendChat("d [" Tag "][МЗ] Требуется продление медкарты для сотрудника с серией паспорта " Pass ".", "0")
Return


/*
:?:/::
SendPlay {Enter}
SendChat("", "0")
Return
*/
        }
        ; #include cam.ahk
        
        :?:/р+::
        SendPlay {Enter}
        Gosub RadioEnable
        Return
        
        :?:/р-::
        SendPlay {Enter}
        Gosub RadioDisable
        Return
        
        :?:/м::
        GetArgsForHotstring("м", "Message")
        Gosub Megafon
        Return
        
        :?:/двр1::
        SendPlay {Enter}
        Gosub DVRGet
        Return
        
        :?:/двр2::
        SendPlay {Enter}
        Gosub DVROn
        Return
    
        :?:/двр3::
        SendPlay {Enter}
        Gosub DVROff
        Return
        
        :?:/двр4::
        SendPlay {Enter}
        Gosub DVRSet
        Return
        
        :?:/нк::
        SendPlay {Enter}
        SendChat("", "0")
        Return
        
        :?:/камеры::
        SendPlay {Enter}
        Gosub StreetCameras
        Return
        
        :?:/удо+::
        GetArgsForHotstring("удо{+}", "ID")
        Gosub LicenseOpenCom
        Return
    
        :?:/удо-::
        SendPlay {Enter}
        Gosub LicenseClose
        Return
        
        :?:/кпк+::
        SendPlay {Enter}
        Gosub PDAOn
        Return
    
        :?:/кпк-::
        SendPlay {Enter}
        Gosub PDAOff
        Return
        
        :?:/доки::
        SendPlay {Enter}
        Gosub AskDocuments
        Return
        
        :?:/доки+::
        SendPlay {Enter}
        Gosub TakeDocuments
        Return
    
        :?:/доки-::
        SendPlay {Enter}
        Gosub ReturnDocuments
        Return
        
        :?:/кримрек::
        GetArgsForHotstring("кримрек", "ID")
        SendPlay {Enter}
        Gosub SkanCom
        Return
    
        :?:/протокол::
        SendPlay {Enter}
        Gosub Protocol
        Return
        
        :?:/конвоир::
        GetArgsForHotstring("конвоир", "ID")
        SendPlay {Enter}
        Gosub ArrestCarCom
        Return        
        
        :?:/вкпз::
        GetArgsForHotstring("вкпз", "ID")
        SendPlay {Enter}
        Gosub ArrestCom
        Return        
    
        :?:/штраф::
        GetArgsForHotstring("штраф", "ID")
        SendPlay {Enter} 
        Gosub TsuCom
        Return        
    
        :?:/вроз::
        GetArgsForHotstring("вроз", "ID")
        SendPlay {Enter} 
        Gosub SuCom
        Return
    
        :?:/впа::
        GetArgsForHotstring("впа", "ID")
        SendPlay {Enter}
        Gosub PutplCom
        Return
    
        :?:/изпа::
        GetArgsForHotstring("изпа", "ID")
        SendPlay {Enter}
        Gosub EjectCom
        Return
    
        :?:/рейд+::
        SendPlay {Enter}
        Gosub RaidOrderOn
        Return
    
        :?:/рейд-::
        SendPlay {Enter}
        Gosub RaidOrderOff
        Return
        
        :?:/погоны1::
        SendPlay {Enter}
        Gosub SayPogon
        Return
        
        :?:/погоны2::
        GetArgsForHotstring("погоны2", "ID")
        SendPlay {Enter}
        Gosub GivePogon
        Return
        
        :?:/чист1::
        SendPlay {Enter}
        Gosub Sincere1
        Return
        
        :?:/чист2::
        SendPlay {Enter}
        Gosub Sincere2
        Return
        
        :?:/чист3::
        SendPlay {Enter}
        Gosub Sincere3
        Return
        
        :?:/чист4::
        SendPlay {Enter}
        Gosub Sincere4
        Return
        

        
        }
        { ; КоАП
        
        
:?:/коап3.1::
SendPlay {Enter}
SendChat("say Предупреждение – мера, выраженная в пресечении правонарушения лицом без применения иных видов административных наказаний.", "0")
Return

:?:/коап3.2::
SendPlay {Enter}
SendChat("say Штраф является денежным взысканием, выражается в рублях и устанавливается для...", "0")
SendChat("say ...граждан в размере, указанном в соответствующей статье настоящего Кодекса.", "500")
Return

:?:/коап3.3::
SendPlay {Enter}
SendChat("say Лишение права на управление транспортным средством устанавливается за грубое или систематическое нарушение...", "0")
SendChat("say ...порядка пользования этим правом в случаях, предусмотренных статьями настоящего Кодекса.", "500")
Return

:?:/коап4.1::
SendPlay {Enter}
SendChat("say 4.1 КоАП гласит: Наказание за совершение административного правонарушения назначается в пределах, установленных законом...", "0")
SendChat("say ...предусматривающим ответственность за данное административное правонарушение, в соответствии с настоящим Кодексом.", "500")
Return

:?:/коап4.2::
SendPlay {Enter}
SendChat("say 4.2 КоАП гласит: При назначении наказания физическому лицу учитываются характер совершенного им административного правонарушения...", "0")
SendChat("say ...личность виновного, его имущественное положение, обстоятельства, смягчающие ответственность, и обстоятельства, отягчающие ответственность.", "500")
Return

:?:/коап4.3::
SendPlay {Enter}
SendChat("say 4.3 КоАП гласит: Никто не может нести ответственность дважды за одно и то же административное правонарушение подряд.", "0")
Return

:?:/коап4.4.1::
SendPlay {Enter}
SendChat("say 4.4.1 КоАП гласит: Уполномоченное лицо, рассматривая дело об административном правонарушении, вправе при отсутствии спора о возмещении...", "0")
SendChat("say ...имущественного ущерба одновременно с назначением наказания решить вопрос о возмещении имущественного ущерба.", "500")
Return

:?:/коап4.4.2::
SendPlay {Enter}
SendChat("say 4.4.2 КоАП гласит: Споры о возмещении морального вреда, причиненного административным правонарушением...", "0")
SendChat("say ...рассматриваются на городском портале Республики Провинция.", "500")
Return

:?:/коап4.5::
SendPlay {Enter}
SendChat("say 4.5 КоАП гласит: Срок давности привлечения к административной ответственности составляет 14 месяцев.", "0")
Return

:?:/коап5.1::
SendPlay {Enter}
SendChat("say 5.1 КоАП гласит: Управление транспортным средством водителем, не имеющим при себе документов...", "0")
SendChat("say ...предусмотренных правилами дорожного движения. Штраф ровняется 20.000 рублей.", "500")
Return

:?:/коап5.2::
SendPlay {Enter}
SendChat("say 5.2 КоАП гласит: Непредоставление по требованию сотрудника полиции документов, предусмотренных правилами дорожного движения...", "0")
SendChat("say ...Штраф ровняется 30.000 рублей или лишение права на управление транспортным средством с возможностью моментального переобучения.", "500")
Return

:?:/коап5.3::
SendPlay {Enter}
SendChat("say 5.3 КоАП гласит: Запрещается управление транспортным средством, не зарегистрированным в установленном порядке...", "0")
SendChat("say ...а также управление транспортным средством без государственных регистрационных знаков когда прошло более 3 суток, штраф-10.000 руб.", "500")
Return

:?:/коап5.4::
SendPlay {Enter}
SendChat("say 5.4 КоАП гласит: Управление транспортным средством, на котором установлена тонировка, светопропускаемость...", "0")
SendChat("say ...которой менее 70 процентов на боковых передних и лобовом стеклах.Штраф - 20.000 рублей.", "500")
Return

:?:/коап5.5::
SendPlay {Enter}
SendChat("say 5.5 КоАП гласит: Управление транспортным средством при наличии технической неисправности или при наличии условия...", "0")
SendChat("say ...когда она запрещена. Предупреждение или штраф - от 10.000 до 30.000 рублей.", "500")
Return

:?:/коап5.6::
SendPlay {Enter}
SendChat("say 5.6 КоАП гласит: Управление мотоциклом или мопедом либо перевозка на мотоцикле или мопеде пассажиров без мотошлемов..", "0")
SendChat("say ...Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап5.7::
SendPlay {Enter}
SendChat("say 5.7 КоАП гласит: Нарушение правил дорожного движения пешеходами и велосипедистами.Предупреждение или штраф от 5.000 до 15.000 рублей", "0")
Return

:?:/коап5.8::
SendPlay {Enter}
SendChat("say 5.8 КоАП гласит: Посадка или высадка пассажиров со стороны проезжей части в нарушение правил дорожного движения...", "0")
Return

:?:/коап5.9::
SendPlay {Enter}
SendChat("say 5.9 КоАП гласит: Игнорирование водителем требования об остановке с помощью жезла. Штраф - 20.000 рублей.", "0")
Return

:?:/коап5.10::
SendPlay {Enter}
SendChat("say 5.10 КоАП гласит: Несоблюдение требований, предписанных дорожными знаками или разметкой проезжей части дороги.Штраф - 5.000 рублей.", "0")
Return

:?:/коап6.1::
SendPlay {Enter}
SendChat("say 6.1 КоАП гласит: Использование приоритета в движении при следовании с включенными маячками и звуковым сигналом...", "0")
SendChat("say ...не убедившись в безопасности данного манёвра.Штраф - 10.000 рублей.", "500")
Return

:?:/коап6.2::
SendPlay {Enter}
SendChat("say 6.2 КоАП гласит: Нарушение правил использования аварийных сигналов.Предупреждение или штраф - 10.000 рублей.", "0")
Return

:?:/коап6.3::
SendPlay {Enter}
SendChat("say 6.3 КоАП гласит: Нарушение правил использования знака аварийной остановки. Предупреждение или штраф - 10.000 рублей.", "0")
Return

:?:/коап6.4::
SendPlay {Enter}
SendChat("say 6.4 КоАП гласит: Управление транспортным средством с выключенными фарами. Предупреждение или штраф - 5.000 рублей.", "0")
Return

:?:/коап6.5::
SendPlay {Enter}
SendChat("say 6.5 КоАП гласит: Использование звукового сигнала в нарушение правил дорожного движения. Предупреждение или штраф - 10.000 рублей.", "0")
Return

:?:/коап7.1::
SendPlay {Enter}
SendChat("say 7.1 КоАП гласит: Проезд на красный сигнал светофора, а равно проезд на запрещающий жест регулировщика,или на жёлтый сигнал светофора...", "0")
SendChat("say ...при возможности совершить остановку, не повлекшую создание опасности для движения иных участников дорожного движения", "500")
SendChat("say Штраф - 20.000 рублей.", "500")
Return

:?:/коап7.2::
SendPlay {Enter}
SendChat("say 7.2 КоАП гласит: Невыполнение требования Правил дорожного движения об остановке перед стоп-линией, обозначенной дорожными знаками...", "0")
SendChat("say ...или разметкой проезжей части дороги, при запрещающем сигнале светофора или запрещающем жесте регулировщика", "500")
SendChat("say Штраф - 10.000 рублей.", "500")
Return

:?:/коап8.1::
SendPlay {Enter}
SendChat("say 8.1 КоАП гласит: Начало движения, перестроение, поворот (разворот) и остановка без использования...", "0")
SendChat("say ...сигнала световыми указателями поворота соответствующего направления.Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап8.2::
SendPlay {Enter}
SendChat("say 8.2 КоАП гласит: Непредоставление при перестроении преимущества транспортному средству, движущемуся попутно...", "0")
SendChat("say ...без изменения направления движения, а равно непредоставление при одновременном перестроении преимущества...", "500")
SendChat("say ...транспортному средству, движущемуся справа. Штраф - 20.000 рублей.", "500")
Return

:?:/коап8.3::
SendPlay {Enter}
SendChat("say 8.3 КоАП гласит: Поворот направо, налево или разворот из полосы движения, не предназначенной для данного манёвра", "0")
SendChat("say Штраф - 20.000 рублей.", "500")
Return

:?:/коап8.4::
SendPlay {Enter}
SendChat("say 8.3 КоАП гласит: Поворот направо, налево, разворот или движение задним ходом в нарушение требований...", "0")
SendChat("say ...правил дорожного движения, дорожных знаков или дорожной разметки. Штраф - 20.000 рублей.", "500")
Return

:?:/коап9.1::
SendPlay {Enter}
SendChat("say Движение по полосе, предназначенной для встречного движения, в нарушение правил дорожного движения", "0")
SendChat("say Штраф - 50.000 рублей с лишением права на управление транспортным средством сроком до 2 лет. ", "500")
Return

:?:/коап9.2::
SendPlay {Enter}
SendChat("say 9.2 КоАП гласит: Выезд на полосу, предназначенную для встречного движения, в нарушение правил дорожного движения", "0")
SendChat("say Штраф - 50.000 рублей.", "500")
Return

:?:/коап9.3::
SendPlay {Enter}
SendChat("say 9.3 КоАП гласит: Движение вне населённых пунктов по левым полосам движения при свободных правых", "0")
SendChat("say Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап9.4::
SendPlay {Enter}
SendChat("say 9.4 КоАП гласит: Движение по прерывистым линиям разметки в нарушение правил дорожного движения", "0")
SendChat("say Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап9.5::
SendPlay {Enter}
SendChat("say 9.5 КоАП гласит: Движение по разделительным полосам и обочинам, тротуарам и пешеходным дорожкам", "0")
SendChat("say Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап9.6::
SendPlay {Enter}
SendChat("say 9.6 КоАП гласит: Несоблюдение дистанции до впереди идущего транспортного средства, а также бокового...", "0")
SendChat("say ...интервала между движущимися транспортными средствами.Предупреждение или штраф - 10.000 рублей.", "500")
Return

:?:/коап9.6::
SendPlay {Enter}
SendChat("say 9.6 КоАП гласит: Несоблюдение дистанции до впереди идущего транспортного средства, а также бокового...", "0")
SendChat("say ...интервала между движущимися транспортными средствами.Предупреждение или штраф - 10.000 рублей.", "500")
Return

:?:/коап10.1::
SendPlay {Enter}
SendChat("say 10.1 КоАП гласит: Обгон транспортного средства, имеющего нанесенные на наружные поверхности специальные...", "0")
SendChat("say ...цветографические схемы с включенными проблесковым маячком синего цвета и специальным звуковым сигналом.", "500")
SendChat("say  Штраф - 20.000 рублей.", "500")
Return

:?:/коап10.2::
SendPlay {Enter}
SendChat("say 10.2 КоАП Тоже что и пункт 10.1 КоАП только обгон транспорта с маячками синего и(или) красного цветов и...", "0")
SendChat("say ...специальным звуковым сигналом, а также сопровождаемого им транспортного средства. Штраф - 20.000 рублей.", "500")
Return

:?:/коап10.3::
SendPlay {Enter}
SendChat("say 10.3 КоАП гласит: Обгон транспортных средств в случаях, когда данный манёвр запрещён.", "0")
SendChat("say Штраф - 20.000 рублей.", "500")
Return

:?:/коап10.4::
SendPlay {Enter}
SendChat("say 10.4 КоАП гласит: Препятствование обгону", "0")
SendChat("say Штраф - 20.000 рублей.", "500")
Return

:?:/коап11.1::
SendPlay {Enter}
SendChat("say 11.1 КоАП гласит: Остановка или стоянка транспортных средств на пешеходном переходе и ближе 5 метров перед ним...", "0")
SendChat("say ... остановка или стоянка транспортных средств на тротуаре.Штраф - 10.000 рублей.", "500")
Return

:?:/коап11.2::
SendPlay {Enter}
SendChat("say 11.2 КоАП гласит: Остановка или стоянка транспортных средств в местах остановки маршрутных транспортных средств...", "0")
SendChat("say ...либо ближе 15 метров от мест остановки маршрутных транспортных средств за исключением остановки для посадки или...", "500")
SendChat("say ...высадки пассажиров, вынужденной остановки. Штраф - 10.000 рублей.", "500")
Return

:?:/коап11.3::
SendPlay {Enter}
SendChat("say 11.3 КоАП гласит: Остановка или стоянка транспортных средств на трамвайных путях, газоне либо остановка  или стоянка...", "0")
SendChat("say ...транспортных средств далее первого ряда от края проезжей части. Штраф - 10.000 рублей.", "500")
Return

:?:/коап11.4::
SendPlay {Enter}
SendChat("say 11.4 КоАП гласит: Нарушение правил остановки или стоянки транспортных средств на проезжей части, в тоннелях...", "0")
SendChat("say ...повлекшее создание препятствий для движения других транспортных средств. Штраф - 10.000 рублей.", "500")
Return

:?:/коап11.5::
SendPlay {Enter}
SendChat("say 11.5 КоАП гласит: Нарушение правил остановки или стоянки транспортных средств, за исключением случаев...", "0")
SendChat("say ...предусмотренных частями 1 - 4 настоящей статьи. Штраф - 10.000 рублей. ", "500")
Return

:?:/коап12.1::
SendPlay {Enter}
SendChat("say 12.1 КоАП гласит: Нарушения правил проезда перекрёстков, не повлекшие опасности другим участникам движения.", "0")
SendChat("say Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап12.2::
SendPlay {Enter}
SendChat("say 12.2 КоАП гласит: Нарушения правил проезда перекрёстков, повлекшие опасность другим участникам движения.", "0")
SendChat("say Штраф - 10.000 рублей.", "500")
Return

:?:/коап13.1::
SendPlay {Enter}
SendChat("say 13.1 КоАП гласит: Пересечение железнодорожных путей в местах, не оборудованных для этого", "0")
SendChat("say Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап13.2::
SendPlay {Enter}
SendChat("say 13.2 КоАП гласит: Выезд на железнодорожный переезд в случаях, когда это запрещено", "0")
SendChat("say Штраф - 20.000 рублей.", "500")
Return

:?:/коап13.3::
SendPlay {Enter}
SendChat("say 13.3 КоАП гласит: Остановка транспортного средства ближе 5 м от шлагбаума... ", "0")
SendChat("say ... а при его отсутствии – ближе 10 м до ближайшего рельс. Штраф - 20.000 рублей.", "500")
Return

:?:/коап14.1::
SendPlay {Enter}
SendChat("say 14.1 КоАП гласит: Движение по автомагистрали транспортных средств, скорость которых по технической... ", "0")
SendChat("say ... характеристике или их состоянию менее 40 км/ч . Штраф - 10.000 рублей.", "500")
Return

:?:/коап14.2::
SendPlay {Enter}
SendChat("say 14.2 КоАП гласит: Движение по автомагистрали грузовых автомобилей далее второй полосы. ", "0")
SendChat("say Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап14.3::
SendPlay {Enter}
SendChat("say 14.3 КоАП гласит: Движение по автомагистрали задним ходом. Штраф - 10.000 рублей. ", "0")
Return

:?:/коап14.4::
SendPlay {Enter}
SendChat("say 14.4 КоАП гласит: Создание пешеходом помех для автомобилей при движении в жилых зонах. ", "0")
SendChat("say Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап14.5::
SendPlay {Enter}
SendChat("say 14.5 КоАП гласит: Сквозное движение, учебная езда, стоянка с работающим двигателем, а также стоянка...", "0")
SendChat("say ...грузовых автомобилей с разрешенной максимальной массой более 3,5 тонны вне специально выделенных...", "500")
SendChat("say ...и обозначенных знаками и(или) разметкой мест. Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап14.6::
SendPlay {Enter}
SendChat("say 14.6 КоАП гласит: Движение в колонне в нарушение правил дорожного движения. Предупреждение или штраф-10.000 рублей.", "0")
Return

:?:/коап15.1::
SendPlay {Enter}
SendChat("say 15.1 КоАП гласит: Непредоставление преимущества транспортному средству с включенным проблесковым маячком синего цвета... ", "0")
SendChat("say ...и(или) красного цвета и специальным звуковым сигналом. Штраф - 20.000 рублей.", "500")
Return

:?:/коап15.2::
SendPlay {Enter}
SendChat("say 15.2 КоАП гласит: Непредоставление преимущества троллейбусам и автобусам, начинающим движение... ", "0")
SendChat("say ...от обозначенного места остановки. Штраф - 5.000 рублей.", "500")
Return

:?:/коап15.3::
SendPlay {Enter}
SendChat("say 15.3 КоАП гласит: Непредоставление преимущества транспортным средствам, движущимся по главной дороге... ", "0")
SendChat("say ...а равно при выезде с прилегающей территории. Штраф - 10.000 рублей.", "500")
Return

:?:/коап15.4::
SendPlay {Enter}
SendChat("say 15.4 КоАП гласит:  Непредоставление преимущества в движении пешеходам и(или) велосипедистам, пересекающих проезжую часть", "0")
SendChat("say Предупреждение или штраф - 5.000 рублей.", "500")
Return

:?:/коап16.1::
SendPlay {Enter}
SendChat("say 16.1 КоАП гласит:  Оставление водителем в нарушение правил дорожного движения места дорожно-транспортного...", "0")
SendChat("say ...происшествия, участником которого он являлся. Штраф - 30.000 рублей с лишением права на управление...", "500")
SendChat("say ...транспортным средством сроком от 3 до 4 лет, а также административный арест на 20 суток.", "500")
Return

:?:/коап16.2::
SendPlay {Enter}
SendChat("say 16.2 КоАП: Неоказание первой помощи в случаях, если такая помощь необходима, при дорожно-транспортном происшествии", "0")
SendChat("say Штраф - 20.000 рублей.", "500")
Return

:?:/коап16.3::
SendPlay {Enter}
SendChat("say 16.3 КоАП гласит:  Невыполнение водителем обязанностей, предусмотренных Правилами дорожного движения, в связи...", "0")
SendChat("say ...с дорожно-транспортным происшествием, участником оторого он является, за исключением случаев...", "500")
SendChat("say ...редусмотренных статьей 16.1.  Штраф от 10.000 до 35.000 рублей.", "500")
Return

:?:/коап17.1::
SendPlay {Enter}
SendChat("say 17.1 КоАП гласит: Управление транспортным средством в состоянии опьянения или передача управления...", "0")
SendChat("say ...транспортным средством лицу, находящемуся в состоянии опьянения.  Штраф - 30.000 рублей...", "500")
SendChat("say ...с лишением права на управление транспортным средством сроком до 1 года.", "500")
Return

:?:/коап17.2::
SendPlay {Enter}
SendChat("say 17.2 КоАП гласит: Опасное вождение. Штраф - до 30.000 рублей с лишением права на управление...", "0")
SendChat("say ...транспортным средством сроком до 2 лет", "500")
Return

:?:/коап17.3::
SendPlay {Enter}
SendChat("say 17.3 КоАП гласит: Управление механическим транспортным средством...", "0")
SendChat("say ...имея неуплату штрафов на общую сумму до 10.000 рублей. Предупреждение.", "500")
Return
:?:/коап17.4::
SendPlay {Enter}
SendChat("say 17.4 КоАП гласит: Управление механическим транспортным средством имея неуплату штрафов...", "0")
SendChat("say ... на общую сумму до от 10.000 до 50.000 рублей. Штраф - 30.000 рублей.", "500")
Return

:?:/коап17.5::
SendPlay {Enter}
SendChat("say 17.5 КоАП гласит: Управление механическим транспортным средством имея неуплату штрафов...", "0")
SendChat("say ... на общую сумму от 50.000 до 100.000 рублей.", "500")
SendChat("say Штраф - 50.000 рублей с лишением права на управление транспортным средством сроком на 1 год.", "500")
Return

:?:/коап17.6::
SendPlay {Enter}
SendChat("say 17.6 КоАП гласит: Управление механическим транспортным средством имея неуплату штрафов...", "0")
SendChat("say ...на общую сумму более 100.000 рублей. Штраф - 100.000 рублей с лишением права...", "500")
SendChat("say ...на управление транспортным средством сроком на 2 года.", "500")
Return

:?:/коап18.1::
SendPlay {Enter}
SendChat("say 18.1 КоАП гласит: Превышение установленной скорости движения транспортного средства...", "0")
SendChat("say ...на 10-20 км/час, зафиксированное сотрудниками полиции. Предупреждение.", "500")
Return

:?:/коап18.2::
SendPlay {Enter}
SendChat("say 18.2 КоАП гласит: Превышение установленной скорости движения транспортного средства...", "0")
SendChat("say ...на 20-40 км/час, зафиксированное сотрудниками полиции. Штраф - 2.000 рублей.", "500")
Return

:?:/коап18.3::
SendPlay {Enter}
SendChat("say 18.3 КоАП гласит: Превышение установленной скорости движения транспортного средства...", "0")
SendChat("say ...на 40-60 км/час, зафиксированное сотрудниками полиции. Штраф - 5.000 рублей.", "500")
Return

:?:/коап18.4::
SendPlay {Enter}
SendChat("say 18.4 КоАП гласит: Превышение установленной скорости движения транспортного средства...", "0")
SendChat("say ...на 60-80 км/час, зафиксированное сотрудниками полиции. Штраф - 7.000 рублей.", "500")
Return

:?:/коап18.5::
SendPlay {Enter}
SendChat("say 18.5 КоАП гласит: Превышение установленной скорости движения транспортного средства на 80+ км/час...", "0")
SendChat("say ...зафиксированное сотрудниками полиции. Штраф - 10.000 рублей с лишением прав на 1 год.", "500")
Return

:?:/коап19.1::
SendPlay {Enter}
SendChat("say 19.1 КоАП: Мелкое хулиганство, нарушение общественного порядка, хождение в нижнем белье...", "0")
SendChat("say ...в общественных местах и уничтожение или повреждение чужого имущества", "500")
SendChat("say Штраф - до 10.000 рублей или административный арест 10 суток.", "500")
Return

:?:/коап19.2::
SendPlay {Enter}
SendChat("say 19.2 КоАП: Оскорбление, унижение чести и достоинства другого лица, выраженное в неприличной...", "0")
SendChat("say ...или иной противоречащей общепринятым нормам морали и нравственности форме.", "500")
SendChat("say Штраф - до 10.000 рублей или административный арест 10 суток.", "500")
Return

:?:/коап19.3::
SendPlay {Enter}
SendChat("say 19.3 КоАП: Нанесение побоев или совершение иных насильственных действий, причинивших...", "0")
SendChat("say ...физическую боль, если эти действия не содержат уголовно наказуемого деяния.", "500")
SendChat("say Штраф - до 20.000 рублей или административный арест 10 суток.", "500")
Return

:?:/коап19.4::
SendPlay {Enter}
SendChat("say 19.4 КоАП: Потребление (распитие) алкогольной продукции в общественных местах, а также...", "0")
SendChat("say ...нахождение в общественных местах в состоянии алкогольного или наркотического опьянения.", "500")
SendChat("say Штраф - до 5.000 рублей.", "500")
Return

:?:/коап19.5::
SendPlay {Enter}
SendChat("say 19.5 КоАП: Занятие попрошайничеством в общественных местах. ", "0")
SendChat("say Предупреждение или административный арест 10 суток.", "500")
Return

:?:/коап19.6::
SendPlay {Enter}
SendChat("say 19.6 КоАП: Осуществление предпринимательской деятельности без регистрации или без лицензии...", "0")
SendChat("say ...в случаях когда такие регистрация и лицензия обязательны. Штраф - 100.000 рублей.", "500")
Return

:?:/коап19.7::
SendPlay {Enter}
SendChat("say 19.7 КоАП: Заведомо ложный вызов пожарной охраны, полиции, скорой медицинской помощи...", "0")
SendChat("say ...или иных специализированных служб. Штраф - 20.000 рублей.", "500")
Return

:?:/коап19.8::
SendPlay {Enter}
SendChat("say 19.8 КоАП: Организация, участие и(или) призыв к несанкционированному несогласованному митингу...", "0")
SendChat("say ...повлекший нарушение общественного порядка, нарушение функционирования и сохранности объектов...", "500")
SendChat("say ...жизнеобеспечения, создание помех в движении пешеходов и(или) транспортных средств.", "500")
SendChat("say Штраф - до 20.000 рублей или административный арест 10 суток.", "500")
Return

:?:/коап19.9::
SendPlay {Enter}
SendChat("say 19.9 КоАП: Неповиновение законному распоряжению сотрудника полиции или военнослужащего.", "0")
SendChat("say Штраф - 20.000 рублей илилишение права на управление транспортным средством сроком...", "500")
SendChat("say ...на 1 год, или административный арест до 20 суток.", "500")
Return

:?:/коап19.10::
SendPlay {Enter}
SendChat("say 19.10 КоАП: Клевета, то есть распространение заведомо ложных сведений, порочащих честь и достоинство", "0")
SendChat("say ...другого лица или подрывающих его репутацию. Штраф - 20.000 рублей.", "500")
Return
        
        }
         ; Текстовые бинды с метками
    Knock:
    SendChat("me постуча" lla " в окно", "0")
    Return
    
    ColleagueGreeting:
    SendChat("animarmy 3", "500")
    SendChat("say Здравия желаю!", "0")
    Return
    
    CivilianGreeting:
    SendChat("animarmy 3", "500")
    If(Special){
        SendChat("say Здравия желаю, " SpecialPost " " OSN ", позывной: " Callsign ". ", "500")
    } Else {
        SendChat("say Здравия желаю, " Post ", " Rank " полиции " Surname ". ", "500")
    }
    PoliceBadge:    
    If(Special){
        SendChat("do На бронежилете нашивка: || " SpecialPost " " OSN " || [" OSNTag "-" TenCode "] || Позывной: " Callsign ". [" Struct "].", "500")
    } Else {
        SendChat("do На груди закреплен полицейский знак с личным номером: " Code "-" License ".", "500")
    }
    Pogon:
    If(!Special)
        SendChat("do На плечах " PogonArr[Rank] ".", "500")
    Return
    
    LicenseOpen:
    GetInput("ID", "Показать удостоверение.`nВведите ID гражданина:", "Показать удостоверение. Введите ID гражданина:")
    LicenseOpenCom:
    SendChat("do Удостоверение лежит в нагрудном кармане.", "500")
    SendChat("me доста" lla " удостоверение из нагрудного кармана и разверну" lla " его", "500")
    SendChat("ud " ID, "0")
    Return
        
    LicenseClose:
    SendChat("me захлопну" lla " удостоверение и убра" lla " его в нагрудный карман", "0")
    Return
    
    AskDocuments:
    SendChat("say Гражданин, передайте документ, удостоверяющий вашу личность.", "500")
    SendChat("say Это может быть паспорт, военный билет или водительское удостоверение.", "500")
    SendChat("b /me передал(-а) документы сотруднику", "500")
    SendChat("b /pass [Мой ID]", "500")
    Return
    
    Protocol1:
    Gosub TakeDocuments
    Gosub PDAOn
    Gosub Skan
    Gosub PDAOff
    Return
    
    Protocol2:
    Gosub Protocol
    Gosub ArrestCar
    Return
    
    Protocol3:
    Gosub Protocol
    Gosub Su
    Gosub ArrestCarCom
    Return
    
    TakeDocuments:
    SendChat("me протяну" lla " правую руку и взя" lla " документы гражданина", "500")
    SendChat("me изучив документы гражданина, убра" lla " их в нагрудный карман", "0")
    Return
    
    Protocol:
    SendChat("say Гражданин, сейчас мы составим протокол вашего задержания.", "500")
    if (Special) {
        SendChat("do В кармане разгрузки лежат бланки протоколов с ручкой.", "2500")
        SendChat("me откры" lla " карман и доста" lla " из него бланк протоколов и ручку", "2500")
    } else {
        SendChat("do Бланки протокола с ручкой лежат в сумке на плече сотрудника.", "2500")
        SendChat("me откры" lla " сумку и доста" lla " бланк протокола с ручкой", "2500")
    }
    SendChat("me взя" lla " ручку и нача" lla " заполнять протокол", "2500")
    SendChat("me заполни" lla " личные данные гражданина", "2500")
    SendChat("me заполни" lla " статью, нарушенную водителем", "2500")
    SendChat("me постави" lla " дату " A_DD "." A_MM "." A_YYYY " и подпись '" Signature "'", "2500")
    SendChat("do Протокол составлен.", "5")
    SendChat("me вырвал копию протокола", "5")
    SendChat("me положил копию в карман гражданина", "5")
    SendChat("do Копия лежит в кармане.", "0")
    Return
    
    ArrestCar:
    GetInput("ID", "Отправить в КПЗ.`nВведите ID задержанного:", "Отправить в КПЗ. Введите ID задержанного:")
    
    ArrestCarCom:
    SendChat("say Пора Вас конвоиру передавать. Свои вещи заберете у конвоира.", "5")
    Gosub RadioOn
    SendChat("me вызвал конвоира", "5")
    SendChat("do Конвоир подошел к задержанному.", "5")
    SendChat("me отпустил кнопку и закрепил рацию на нагрудном кармане", "5")
    SendChat("me открыл дверь и передал задержанного конвоиру", "5")
    SendChat("say Уведите задержанного.", "5")
    SendChat("do Конвоир увел задержанного.", "5")
    SendChat("r Задержанный был передан конвоиру. Протокол задержания передан в канцелярию.", "5")
    SendChat("arrest " ID, "0")
    Gosub RadioOff
    Return

    Arrest:
    GetInput("ID", "Посадить в КПЗ.`nВведите ID задержанного:", "Посадить в КПЗ. Введите ID задержанного:")
    
    ArrestCom:
    SendChat("say Пора Вас посадить в КПЗ. Свои вещи заберете у дежурного.", "5")
    SendChat("do Ключи от двери КПЗ в кармане.", "5")
    SendChat("me достав ключи, открыл дверь КПЗ", "5")
    SendChat("me завел задержанного в клетку, затем закрыл дверь КПЗ", "5")
    SendChat("arrest " ID, "5")
    SendChat("me убрал ключи в карман", "5")
    SendChat("r Задержанный был отправлен в КПЗ. Протокол задержания передан в канцелярию.", "5")
    Return
    
    Sincere1:
    SendChat("do На столе лежит стопка пустых бланков.", "500")
    SendChat("me взяв бланк, закрепил его в планшетке", "500")
    SendChat("do Ручка на столе.", "500")
    SendChat("me взяв ручку, начал записывать случившееся", "500")
    SendChat("say Гражданин, рассказывайте, что произошло.", "0")
    Return
    
    Sincere2:
    SendChat("say Передайте документ, удостоверяющий вашу личность.", "0")
    Return
    
    Sincere3:
    SendChat("me записал данные гражданина", "500")
    SendChat("me записал дату и поставил подпись", "500")
    SendChat("do Бланк заполнен.", "500")
    SendChat("do Ручка лежит на столе.", "500")
    SendChat("me взяв ручку со стола, протянул ее вместе с бланком", "500")
    SendChat("say Распишитесь в нижнем углу.", "500")
    SendChat("b /me расписался в бланке", "0")
    Return
    
    Sincere4:
    SendChat("me взял ручку с бланком", "500")
    SendChat("do Ручка с бланком в руке.", "500")
    SendChat("me вытащив бланк из планшетки, положил его в стопку с бланками", "500")
    SendChat("do Бланк лежит в стопке бланков.", "500")
    SendChat("say Гражданин, ваше чистосердечное заявление принято, вы арестованы.", "500")
    SendChat("say Встать лицом к стене, руки за спину.", "0")
    Return
    
    ReturnDocuments:
    SendChat("do Документ гражданина в нагрудном кармане.", "500")
    SendChat("me доста" lla " документы из нагрудного кармана и верну" lla " гражданину", "500")
    SendChat("say Уважаемый, держите ваши документы.", "500")
    SendChat("b /me взял(-а) документы", "0")
    Return
    
    Putpl:
    GetInput("ID", "Посадить в ПА.`nВведите ID задержанного:", "Посадить в ПА. Введите ID задержанного:")
    
    PutplCom:
    SendChat("say Берегите голову при посадке в автомобиль!", "500")
    SendChat("me взя" lla " нарушителя за руки и посади" lla " в служебный автомобиль", "5000")
    SendChat("putpl " ID, "0")
    Return
    
    Eject:
    GetInput("ID", "Высадить из ПА.`nВведите ID задержанного:", "Высадить из ПА. Введите ID задержанного:")
    
    EjectCom:
    SendChat("me вытащи" lla " задержанного из автомобиля", "500")
    SendChat("do Задержанный стоит на улице.", "5")
    SendChat("eject " ID, "0")
    Return
    
    
    Photo:
    GetInput("ID", "Распознать личность.`nВведите [ID]:", "Распознать личность. Введите [ID]:")
    PhotoCom:
    SendChat("me включи" lla " режим распознавания личности, наве" lla " камеру планшета на лицо подозреваемого и нажа" lla " кнопку 'Распознать'", "5")
    SendChat("do На экране высветилась информация по гражданину.", "5")
    SendChat("crimrec " ID, "5")
    SendChat("wanted", "0")
    Return
    
    Su:
    GetInput("ID", "Выдать розыск.`nВведите [ID уровень причина]:", "Выдать розыск. Введите [ID уровень причина]:")
    SuCom:
    GoSub RadioOn
    SendChat("me связа" lla syaas " с диспетчером и передал ориентировку на преступника", "5")
    GoSub RadioOff
    SendChat("su " ID, "0")
    Return    
    
    RadioEnable:
    SendChat("me включи" lla " звук на рации", "5")
    SendChat("fracvoice 2", "0")
    Return
    
    RadioOn:
    If(Special){
        SendChat("do Гарнитура закреплена на правом ухе.", "5")
        SendChat("me нажав кнопку на гарнитуре, переве" lla " её в режим радиовещания", "5")
    } Else {
        SendChat("do Рация ТАКТ-363 П45 закреплена на нагрудном кармане.", "5")
        SendChat("me сня" lla " рацию с нагрудного кармана и нажа" lla " кнопку для переговоров", "5")
    }
    SendChat("fracvoice 1", "0")
    Return
    
    RadioOff:
    If(Special){
        SendChat("me нажав кнопку на гарнитуре, переве" lla " её в режим прослушивания", "5")
    } Else {
        SendChat("me закончив переговоры, повеси" lla " рацию на нагрудный карман", "5")
    }
    SendChat("fracvoice 2", "0")
    Return    

    RadioDisable:
    SendChat("me отключи" lla " звук на рации", "5")
    SendChat("fracvoice 0", "0")
    Return
    
    MegafonOn:
    SendChat("do Тангета СГУ «Ермак» закреплена на торпеде.", "5")
    SendChat("me сня" lla " тангету с крепления и, зажав кнопку звукоусиления, прислони" lla " ко рту", "5")
    Return
    
    MegafonOff:
    SendChat("me отпусти" lla " кнопку и верну" lla " тангету на крепление", "0")
    Return
    
    Megafon:
    Gosub MegafonOn
    SendChat("m " Message, "5")
    Gosub MegafonOff
    Return
    
    FirstColumn:
    Gosub MegafonOn
    SendChat("m Водители, внимание, движется организованная колонна!", "5")
    Gosub MegafonOff
    Return
    
    SecondColumn:
    Gosub MegafonOn
    SendChat("m Водители, внимание! Движется организованная колонна, останавливаемся!", "5")
    Gosub MegafonOff
    Return
    
    ThirdColumn:
    Gosub MegafonOn
    SendChat("m Водители, внимание! Продолжаем движение! Организованная колонна проехала!", "5")
    Gosub MegafonOff
    Return
    
    FirstWarn:
    Gosub MegafonOn
    SendChat("m #99ff33Водитель, примите крайнее правое положение и остановитесь!", "5")
    Gosub MegafonOff
    Return
    
    SecondWarn:
    Gosub MegafonOn
    SendChat("m Повторяю, водитель, прижмитесь вправо и остановитесь!", "5")
    Gosub MegafonOff
    Return
    
    ThirdWarn:
    Gosub MegafonOn
    SendChat("m #e74c3cОстанавливайтесь! В случае отказа откроем огонь!", "5")
    Gosub MegafonOff
    Return
    
    SkipWarn:
    Gosub MegafonOn
    if (MB) 
        SendChat("m Уступите дорогу служебному мотоциклу!", "5")
    else 
        SendChat("m Уступите дорогу служебному автомобилю!", "5")
    Gosub MegafonOff
    Return
    
    WalkWarn:
    SendChat("s Гражданин, немедленно остановитесь, иначе откроем огонь!", "0")
    Return
    
    PDAOn:
    SendChat("do Планшет марки “MIG LT11i” в кармане.", "500")
    SendChat("me доста" lla " планшет из кармана и запусти" lla " его", "500")
    Return
    
    PDAOff:
    SendChat("me выключи" lla " планшет и убра" lla " в карман", "500")
    Return
    
    Wanted:
    SendChat("me подключи" lla syaas " к базе данных", "5")
    SendChat("me запроси" lla " данные гражданских в федеральном розыске в реальном времени", "5")
    SendChat("do Данные выводятся на экран в реальном времени.", "5")
    SendChat("wanted", "0")
    Return
    
    Skan:
    GetInput("ID", "Пробить гражданина по базе нарушений.`nВведите ID гражданина:", "Пробить гражданина по базе нарушений.`nВведите ID гражданина:")
    SkanCom:
    SendChat("me откры" lla " базу данных правонарушений", "500")
    SendChat("me ввё" lla " данные водителя в строку поиска и нажа" lla " кнопку 'Запросить'", "500")
    SendChat("do Информация о гражданине высветилась на экране.", "500")
    SendChat("crimrec " ID, "0")
    Return
    
    Tsu:
    GetInput("ID", "Выписать штраф.`nВведите [ID сумма причина]:", "Выписать штраф.`nВведите [ID сумма причина]:")
    TsuCom:
    SendChat("me внес" la " данные о нарушении гражданина в базу", "500")
    SendChat("do Данные введены.", "500")
    SendChat("tsu " ID, "0")
    Return
    
    BreakGlass:
    SendChat("me замахну" lla syaas " дубинкой и удари" lla " по стеклу", "5")
    SendChat("try разби" lla " стекло дубинкой", "5")
    if(GetTryRes())
        SendChat("do Стекло разбито.", "0")
    else
        SendChat("do Сотрудни" kuce " не удалось разбить стекло.", "0")
    Return
    
    BreakGlassPistol:
    SendChat("me замахнул" lla syaas " пистолетом и удари" lla " рукоятью по стеклу", "5")
    SendChat("try разби" lla " стекло пистолетом", "5")
    if(GetTryRes())
        SendChat("do Стекло разбито.", "0")
    else
        SendChat("do Сотрудни" kuce " не удалось разбить стекло.", "0")
    Return
    
    BreakGlassRifle:
    SendChat("me замахну" lla syaas " автоматом и удари" lla " прикладом по стеклу", "5")
    SendChat("try разби" lla " стекло прикладом автомата", "5")
    if(GetTryRes())
        SendChat("do Стекло разбито.", "0")
    else
        SendChat("do Сотрудни" kuce " не удалось разбить стекло.", "0")
    Return
    
    OpenDoor:
    SendChat("me потяну" lla syaas " рукой до дверного замка и откры" lla " дверь изнутри", "5")
    SendChat("me откры" lla " дверь", "0")
    Return
    
    PullCivilian:
    SendChat("try вытащи" lla " гражданина напротив из автомобиля", "5")
    if(GetTryRes())
        SendChat("do Гражданин на земле.", "0")
    else
        SendChat("do Сотрудни" kuce " не удалось вытащить гражданина из автомобиля.", "0")
    Return
    
    StreetCameras:
    SendChat("me откры" lla " базу данных камер видеонаблюдения и запроси" lla " запись с нужной камеры", "500")
    SendChat("me отмота" lla " запись на нужный момент и включи" lla " воспроизведение", "500")
    SendChat("do Запись с камеры воспроизводится на экране планшета.", "0")
    Return
    
    DVRGet:
    SendChat("do Видеорегистратор закреплен на лобовом стекле.", "500")
    SendChat("me сня" lla " видеорегистратор с крепления", "0")
    Return
    
    DVROn:
    SendChat("me откры" lla " нужный файл и подготови" lla " его к просмотру", "5000")
    SendChat("me повернув видеорегистратор в сторону гражданина, запусти" lla " запись", "0")
    Return
    
    DVROff:
    SendChat("me выключи" lla " воспроизведение видеофайла", "0")
    Return
    
    DVRSet:
    SendChat("me закрепи" lla " видеорегистратор на крепление", "0")
    Return
    
    RaidOrderOn:
    SendChat("do В нагрудном кармане лежит приказ о проведении рейда.", "500")
    SendChat("me доста" lla " приказ, разверну" lla " его и показа" lla " гражданину напротив", "500")
    SendChat("do Приказ №098: гербовая печать, подпись начальника " Struct " [от " A_DD "." A_MM "." A_YYYY "].", "0")
    Return
    
    RaidOrderOff:
    SendChat("me сложи" lla " приказ и убра" lla " в нагрудный карман", "0")
    Return
    
    SayPogon:
    SendChat("say Снимайте старые погоны и сдайте удостоверение.", "500")
    Return

    GivePogon:
    SendChat("me забра" lla " погоны и удостоверение сотрудника и убра" lla " их в нижний ящик стола", "500")
    SendChat("do Новые погоны и пустые удостоверения с подписью начальника УГИБДД в верхнем ящике стола.", "500")
    SendChat("me доста" lla " " PogonArr[RanksArr[ID]] " и положи" lla " перед сотрудником", "500")
    SendChat("me доста" lla " пустое удостоверение и заполни" lla " данные сотрудника", "500")
    SendChat("me вклеи" lla " фотографию сотрудника и постави" lla " гербовую печать управления", "500")
    SendChat("me закры" lla " удостоверение и положи" lla " перед сотрудником", "500")
    SendChat("say Закрепляйте погоны, забирайте удостоверение. Поздравляю с повышением!", "0")
    Return
    
    ReadLection:
    MsgBox % GetLogsLastLine(2)
;     ReadComFile(FileForRead)
    Return

    Sos:
    GetInput("Place", "Объявить код-0 по рации.`nВведите [местоположение]:", "Активировать кнопку SOS.`nВведите [местоположение]:")
    SosCom:
    SendChat("ro [" Tag "][МВД] Код-0. Местоположение: " Place ".", "0")
    Return
    
    SosP:
    GetInput("Place", "Активировать кнопку SOS в патрульном авто.`nВведите [местоположение]:", "Активировать кнопку SOS.`nВведите [местоположение]:")
    SosPCom:
    SendChat("me нажа" lla " кнопку тревоги на панели управления системы ""Око""", "50")
    SendChat("do Сигнал тревоги с координатами отправлен в дежурную часть управления.", "50")
    SendChat("ro [Система ""Око""][МВД] Код-0. Активирована кнопка тревоги. Местоположение: " Place ".", "0")
    Return

    SosS:
    GetInput("Place", "Активировать кнопку SOS.`nВведите [местоположение]:", "Активировать кнопку SOS.`nВведите [местоположение]:")
    SosSCom:
    SendChat("me незаметно нажа" lla " кнопку тревоги, вшитую в форму и подключённую к планшету марки ""MIG LT11i""", "50")
    SendChat("do Сигнал тревоги с координатами отправлен в дежурную часть управления.", "50")
    SendChat("ro [MIG LT11i " License "][МВД] Код-0. Активирована кнопка тревоги. Местоположение: " Place ".", "0")
    Return
    
    AccMask:
    SendChat("me сняв маску с гражданина, положил её в карман задержанного", "0")
    Return

    AccHat:
    SendChat("me сняв головной убор с гражданина, положил его в карман задержанного", "0")
    Return
    
    AccGlasses:
    SendChat("me сняв очки с гражданина, положил их в карман задержанного", "0")
    Return

    AccHelmet:
    SendChat("me сняв шлем с гражданина, поставил его на землю", "0")
    SendChat("do Под шлемом есть аксессуары?", "0")
    SendChat("b Ответ необходимо писать в /do, например /do Под шлемом есть маска. или /do Нет.", "0")
    Return
}   

