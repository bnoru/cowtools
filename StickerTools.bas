Attribute VB_Name = "StickerTools"
Option Explicit

Public Sub ReplaceGroupWithCopies()

    Dim sr As ShapeRange
    Dim source As Shape
    Dim targetGroup As Shape
    Dim target As Shape
    Dim copy As Shape

    Dim i As Long
    Dim commandStarted As Boolean
    Dim oldReferencePoint As cdrReferencePoint

    If ActiveDocument Is Nothing Then
        MsgBox "No document is open."
        Exit Sub
    End If

    Set sr = ActiveSelectionRange

    If sr.Count <> 2 Then
        MsgBox "Select exactly two objects:" & vbCrLf & _
               "1. the artwork" & vbCrLf & _
               "2. the group of placeholder objects"
        Exit Sub
    End If

    ' Identify artwork and template group
    If sr(1).Type = cdrGroupShape And sr(2).Type <> cdrGroupShape Then

        Set targetGroup = sr(1)
        Set source = sr(2)

    ElseIf sr(2).Type = cdrGroupShape And sr(1).Type <> cdrGroupShape Then

        Set targetGroup = sr(2)
        Set source = sr(1)

    ElseIf sr(1).Type = cdrGroupShape And sr(2).Type = cdrGroupShape Then

        ' If both are groups, assume the group containing
        ' more objects is the placeholder template.
        If sr(1).Shapes.Count > sr(2).Shapes.Count Then
            Set targetGroup = sr(1)
            Set source = sr(2)
        ElseIf sr(2).Shapes.Count > sr(1).Shapes.Count Then
            Set targetGroup = sr(2)
            Set source = sr(1)
        Else
            MsgBox "Both selected objects are groups with the same number of objects." & vbCrLf & _
                   "The macro cannot determine which one is the template."
            Exit Sub
        End If

    Else
        MsgBox "One of the two selected objects must be the grouped template."
        Exit Sub
    End If

    On Error GoTo ErrorHandler

    oldReferencePoint = ActiveDocument.ReferencePoint
    ActiveDocument.BeginCommandGroup "Fill sticker template"
    commandStarted = True

    ActiveDocument.ReferencePoint = cdrCenter

    For i = 1 To targetGroup.Shapes.Count

        Set target = targetGroup.Shapes(i)
        Set copy = source.Duplicate(0, 0)

        ' Match the placeholder dimensions exactly
        copy.SetSize target.SizeWidth, target.SizeHeight

        ' Center on the placeholder
        copy.SetPositionEx cdrCenter, target.CenterX, target.CenterY

    Next i

    ' Remove the placeholder group
    targetGroup.Delete

    ActiveDocument.ReferencePoint = oldReferencePoint

    ActiveDocument.EndCommandGroup
    commandStarted = False

    Exit Sub

ErrorHandler:

    On Error Resume Next
    ActiveDocument.ReferencePoint = oldReferencePoint

    If commandStarted Then
        ActiveDocument.EndCommandGroup
    End If

    MsgBox "The macro stopped because of an error:" & vbCrLf & _
           Err.Description

End Sub
