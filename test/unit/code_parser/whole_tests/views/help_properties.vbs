' Copyright (c) 2000 ActivePDF, Inc.
' ActivePDF Server 2009
' Example generated 01/01/2000 

Dim FSO, isDebug, testVar

.Debug = "asdf"
.Debug = 4
.Debug = true
.Debug = false
.Debug = asdf
.Debug = 1
.Show = 1
.EngineToUse = 1
isDebug = .Debug
testVar = .GetUniqueID & ".pdf"
' Process Complete
Wscript.Echo("Done!")
