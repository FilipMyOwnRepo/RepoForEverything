import xlwings as xw

# Definiši matricu
mat1 = [
    [1, 2, 3],
    [1, 2, 3]
]

with xw.App(visible=True) as app:
    wb = app.books.add()
    
    sh = wb.sheets[0]
    
    sh.range('A1').value = mat1
    
    wb.save('nsg.xlsx')
    wb.close()
