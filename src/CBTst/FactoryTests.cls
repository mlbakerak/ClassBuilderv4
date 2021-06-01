Class CBTst.FactoryTests Extends %UnitTest.TestCase
{

Method TestSourceLocation()
{
    set propertyName="PatientName"
    set global="DPT(D0,0)"
    set piece=1
    set code1=$C(9)_"set PatientName=$Get(^|NS|DPT(D0,0)),""^"",1)"_$C(13)
    set sc=##class(CB.SetMethodFactory).getSourceLocation(propertyName,global,piece,.code2)
    do $$$AssertEquals(code1,code2,"Test source location code")
}

Method TestFMDate()
{
    set propertyName="PatientBirthDate"
    set code1=$C(9)_"if ('##class(%FilemanTimeStamp).IsValid(PatientBirthDate))"_$C(13)_
            $C(9)_"{"_$C(13)_
            $C(9,9)_"set PatientBirthDate="""""_$C(13)_
            $C(9)_"}"_$C(13)
    set sc=##class(CB.SetMethodFactory).FileManDT(propertyName,.code2)
    do $$$AssertEquals(code1,code2,"Test FMDate code")
}

Method TestVariablePointer()
{
    set propertyName="PatientIEN"
    set mapComments="""DPT("":ien,:"""""
    set code1=$C(9)_"if PatientIEN]"""""_$C(13,9)_
            "{"_$C(13,9,9)_
            "set ien=$piece(PatientIEN,"";"",1)"_$C(13,9,9)_
            "set global=$piece(PatientIEN,"";"",2)"_$C(13)
    set code2=$C(9,9)_"set PatientIEN=$piece($get(@(""^|""""""_NS_""""""|_global_ien_"",0)"")),""^"")"_$C(13,9)_
        "}"_$C(13)
    set code3=$C(9,9)_"set PatientIEN=$case(global,""DPT("":ien,:"""")"_$C(13,9)_
        "}"_$C(13)
    set sc=##class(CB.SetMethodFactory).VariablePointerBase(propertyName,.code11)
    set sc=##class(CB.SetMethodFactory).VariablePointerDefault(propertyName,.code12)
    set sc=##class(CB.SetMethodFactory).VariablePointerIEN(propertyName,mapComments,.code13)
    do $$$AssertEquals(code1,code11,"Test VariablePointerBase")
    do $$$AssertEquals(code2,code12,"Test VariablePointerDefault")
    do $$$AssertEquals(code3,code13,"Test VariablePointerIEN")
}

}
