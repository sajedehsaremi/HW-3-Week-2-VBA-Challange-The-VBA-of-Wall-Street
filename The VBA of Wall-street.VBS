VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisWorkbook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub Calculate_MultipleYearStock():


' Explain Variables
Dim ticker As String
Dim number_tickers As Integer
Dim lastRowState As Long
Dim opening_pric
Dim closing_price As Double
Dim yearly_change As Double
Dim percent_change As Double
Dim total_stock_volume As Double

' Explain Variables for challange section
Dim greatest_percent_increase As Double
Dim greatest_percent_increase_ticker As String
Dim greatest_percent_decrease As Double
Dim greatest_percent_decrease_ticker As String
Dim greatest_stock_volume As Double
Dim greatest_stock_volume_ticker As String


For Each ws In Worksheets

    ' Make the worksheet active.
    ws.Activate

    ' Find the last row of each worksheet
    lastRowState = ws.Cells(Rows.Count, "A").End(xlUp).Row

    ' Add header columns for each worksheet
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"
    
    ' Initialize variables for each worksheet.
    number_tickers = 0
    ticker = ""
    yearly_change = 0
    opening_price = 0
    percent_change = 0
    total_stock_volume = 0
    
    ' Skipping the header row, loop through the list of tickers.
    For i = 2 To lastRowState

        ' Get the value of the ticker symbol we are currently calculating for.
        ticker = Cells(i, 1).Value
        
        ' Get the start of the year opening price for the ticker.
        If opening_price = 0 Then
            opening_price = Cells(i, 3).Value
        End If
        
        ' Add up the total stock volume values for a ticker.
        total_stock_volume = total_stock_volume + Cells(i, 7).Value
        
        ' If we have a change in ticker in column A.
        If Cells(i + 1, 1).Value <> ticker Then
            ' Increase the number of tickers when we get to a change in tickers.
            number_tickers = number_tickers + 1
            Cells(number_tickers + 1, 9) = ticker
            
            ' End of the year closing price for ticker
            closing_price = Cells(i, 6)
            
            ' yearly change value
            yearly_change = closing_price - opening_price
            
            ' Add up yearly change value to the appropriate cell in each worksheet.
            Cells(number_tickers + 1, 10).Value = yearly_change
            
            ' If yearly change value is greater than 0, change the cell color to the green.
            If yearly_change > 0 Then
                Cells(number_tickers + 1, 10).Interior.ColorIndex = 4
            ' If yearly change value is less than 0, change the cell color to the red.
            ElseIf yearly_change < 0 Then
                Cells(number_tickers + 1, 10).Interior.ColorIndex = 3
            ' If yearly change value is 0, change the cell color to the yellow.
            Else
                Cells(number_tickers + 1, 10).Interior.ColorIndex = 6
            End If
            
            
            ' Calculate percent change value for ticker.
            If opening_price = 0 Then
                percent_change = 0
            Else
                percent_change = (yearly_change / opening_price)
            End If
            
            
            ' Format the percent_change value as a percent.
            Cells(number_tickers + 1, 11).Value = Format(percent_change, "Percent")
            
            
            ' Uncomment the following for color shading of percent change column.
            ' If percent change value is greater than 0, shade cell green.
            ' If percent_change > 0 Then
                ' Cells(number_tickers + 1, 11).Interior.ColorIndex = 4
            ' If percent change value is less than 0, shade cell red.
            ' ElseIf percent_change < 0 Then
                ' Cells(number_tickers + 1, 11).Interior.ColorIndex = 3
            ' If percent change value is 0, shade cell yellow.
            ' Else
                ' Cells(number_tickers + 1, 11).Interior.ColorIndex = 6
            ' End If
            
            
            ' Set opening price back to 0 when we get to a different ticker in the list.
            opening_price = 0
            
            ' Add total stock volume value to the appropriate cell in each worksheet.
            Cells(number_tickers + 1, 12).Value = total_stock_volume
            
            ' Set total stock volume back to 0 when we get to a different ticker in the list.
            total_stock_volume = 0
        End If
        
    Next i
    
    ' Add section to display greatest percent increase, greatest percent decrease, and greatest total volume for each year.
    Range("O2").Value = "Greatest % Increase"
    Range("O3").Value = "Greatest % Decrease"
    Range("O4").Value = "Greatest Total Volume"
    Range("P1").Value = "Ticker"
    Range("Q1").Value = "Value"
    
    ' Get the last row
    lastRowState = ws.Cells(Rows.Count, "I").End(xlUp).Row
    
    ' Initialize variables and set values of variables initially to the first row in the list.
    greatest_percent_increase = Cells(2, 11).Value
    greatest_percent_increase_ticker = Cells(2, 9).Value
    greatest_percent_decrease = Cells(2, 11).Value
    greatest_percent_decrease_ticker = Cells(2, 9).Value
    greatest_stock_volume = Cells(2, 12).Value
    greatest_stock_volume_ticker = Cells(2, 9).Value
    
    
    ' skipping the header row, loop through the list of tickers.
    For i = 2 To lastRowState
    
        ' Find the ticker with the greatest percent increase.
        If Cells(i, 11).Value > greatest_percent_increase Then
            greatest_percent_increase = Cells(i, 11).Value
            greatest_percent_increase_ticker = Cells(i, 9).Value
        End If
        
        ' Find the ticker with the greatest percent decrease.
        If Cells(i, 11).Value < greatest_percent_decrease Then
            greatest_percent_decrease = Cells(i, 11).Value
            greatest_percent_decrease_ticker = Cells(i, 9).Value
        End If
        
        ' Find the ticker with the greatest stock volume.
        If Cells(i, 12).Value > greatest_stock_volume Then
            greatest_stock_volume = Cells(i, 12).Value
            greatest_stock_volume_ticker = Cells(i, 9).Value
        End If
        
    Next i
    
    ' Add the values for greatest percent increase, decrease, and stock volume to each worksheet.
    Range("P2").Value = Format(greatest_percent_increase_ticker, "Percent")
    Range("Q2").Value = Format(greatest_percent_increase, "Percent")
    Range("P3").Value = Format(greatest_percent_decrease_ticker, "Percent")
    Range("Q3").Value = Format(greatest_percent_decrease, "Percent")
    Range("P4").Value = greatest_stock_volume_ticker
    Range("Q4").Value = greatest_stock_volume
    
Next ws


End Sub
