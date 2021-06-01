Class CB.SetMethodFactory Extends %RegisteredObject
{

/// Description
ClassMethod getSourceLocation(propertyName As %String, globalNode As %String, piece As %Integer, ByRef code As %String) As %Status
{
    set sc = $$$OK
    try 
    {
        set code=$C(9)_"set "_propertyName_"=$Get(^|NS|"_globalNode_"),""^"","_piece_")"_$C(13)
    } 
    catch ex
    {
        set code=""
        Set sc=ex.AsStatus()
    }
    return sc
}

/// Description
ClassMethod FileManDT(propertyName As %String, ByRef code As %String) As %Status
{
    set sc = $$$OK
    try 
    {
        set code=$C(9)_"if ('##class(%FilemanTimeStamp).IsValid("_propertyName_"))"_$C(13)_
            $C(9)_"{"_$C(13)_
            $C(9,9)_"set "_propertyName_"="""""_$C(13)_
            $C(9)_"}"_$C(13)
    }
    catch ex 
    {
        set code=""
        set sc=ex.AsStatus()
    }
    return sc
}

/// Description
ClassMethod VariablePointerBase(propertyName As %String, ByRef code As %String) As %Status
{
    set sc = $$$OK
    try 
    {
        set code=$C(9)_"if "_propertyName_"]"""""_$C(13,9)_
            "{"_$C(13,9,9)_
            "set ien=$piece("_propertyName_","";"",1)"_$C(13,9,9)_
            "set global=$piece("_propertyName_","";"",2)"_$C(13)
    }
    catch ex 
    {
        set code=""
        set sc=ex.AsStatus()
    }
    return sc
}

/// Description
ClassMethod VariablePointerDefault(propertyName As %String, ByRef code As %String) As %Status
{
    set sc = $$$OK
    try 
    {
        set code=$C(9,9)_"set "_propertyName_"=$piece($get(@(""^|""""""_NS_""""""|_global_ien_"",0)"")),""^"")"_$C(13,9)_
            "}"_$C(13)
    }
    catch ex 
    {
        set code=""
        set sc=ex.AsStatus()
    }
    return sc
}

/// Description
ClassMethod VariablePointerIEN(propertyName As %String, mapComments As %String, ByRef code As %String) As %Status
{
    set sc = $$$OK
    try 
    {
        set code=$C(9,9)_"set "_propertyName_"=$case(global,"_mapComments_")"_$C(13,9)_
            "}"_$C(13)
    }
    catch ex 
    {
        set code=""
        set sc=ex.AsStatus()
    }
    return sc
}

}
