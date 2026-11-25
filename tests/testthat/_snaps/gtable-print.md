# gtable_print works

    Code
      gtable_print(p)
    Output
      TableGrob (16 x 13) "layout": 22 grobs
      id  z cells        name             grob                                       
       1  5 (   8,    6) spacer           zeroGrob[GRID.null.1]                      
       2  7 (   9,    6) axis-l           absoluteGrob[GRID.absoluteGrob.26]         
       3  3 (  10,    6) spacer           zeroGrob[GRID.null.1]                      
       4  6 (   8,    7) axis-t           zeroGrob[GRID.null.1]                      
       5  1 (   9,    7) panel            gTree[panel-1.gTree.17]                    
       6  9 (  10,    7) axis-b           absoluteGrob[GRID.absoluteGrob.22]         
       7  4 (   8,    8) spacer           zeroGrob[GRID.null.1]                      
       8  8 (   9,    8) axis-r           zeroGrob[GRID.null.1]                      
       9  2 (  10,    8) spacer           zeroGrob[GRID.null.1]                      
      10 10 (   7,    7) xlab-t           zeroGrob[GRID.null.1]                      
      11 11 (  11,    7) xlab-b           titleGrob[axis.title.x.bottom..titleGrob.3~
      12 12 (   9,    5) ylab-l           titleGrob[axis.title.y.left..titleGrob.33] 
      13 13 (   9,    9) ylab-r           zeroGrob[GRID.null.1]                      
      14 14 (   9,   11) guide-box-right  zeroGrob[GRID.null.1]                      
      15 15 (   9,    3) guide-box-left   zeroGrob[GRID.null.1]                      
      16 16 (  13,    7) guide-box-bottom zeroGrob[GRID.null.1]                      
      17 17 (   5,    7) guide-box-top    zeroGrob[GRID.null.1]                      
      18 18 (   9,    7) guide-box-inside zeroGrob[GRID.null.1]                      
      19 19 (   4,    7) subtitle         zeroGrob[plot.subtitle..zeroGrob.35]       
      20 20 (   3,    7) title            zeroGrob[plot.title..zeroGrob.34]          
      21 21 (  14,    7) caption          zeroGrob[plot.caption..zeroGrob.36]        
      22  0 (1-16, 1-13) background       rect[GRID.rect.37]                         

---

    Code
      gtable_print(p, zsort = TRUE)
    Output
      TableGrob (16 x 13) "layout": 22 grobs
      id  z cells        name             grob                                       
      22  0 (1-16, 1-13) background       rect[GRID.rect.71]                         
       5  1 (   9,    7) panel            gTree[panel-1.gTree.53]                    
       9  2 (  10,    8) spacer           zeroGrob[GRID.null.1]                      
       3  3 (  10,    6) spacer           zeroGrob[GRID.null.1]                      
       7  4 (   8,    8) spacer           zeroGrob[GRID.null.1]                      
       1  5 (   8,    6) spacer           zeroGrob[GRID.null.1]                      
       4  6 (   8,    7) axis-t           zeroGrob[GRID.null.1]                      
       2  7 (   9,    6) axis-l           absoluteGrob[GRID.absoluteGrob.61]         
       8  8 (   9,    8) axis-r           zeroGrob[GRID.null.1]                      
       6  9 (  10,    7) axis-b           absoluteGrob[GRID.absoluteGrob.57]         
      10 10 (   7,    7) xlab-t           zeroGrob[GRID.null.1]                      
      11 11 (  11,    7) xlab-b           titleGrob[axis.title.x.bottom..titleGrob.6~
      12 12 (   9,    5) ylab-l           titleGrob[axis.title.y.left..titleGrob.67] 
      13 13 (   9,    9) ylab-r           zeroGrob[GRID.null.1]                      
      14 14 (   9,   11) guide-box-right  zeroGrob[GRID.null.1]                      
      15 15 (   9,    3) guide-box-left   zeroGrob[GRID.null.1]                      
      16 16 (  13,    7) guide-box-bottom zeroGrob[GRID.null.1]                      
      17 17 (   5,    7) guide-box-top    zeroGrob[GRID.null.1]                      
      18 18 (   9,    7) guide-box-inside zeroGrob[GRID.null.1]                      
      19 19 (   4,    7) subtitle         zeroGrob[plot.subtitle..zeroGrob.69]       
      20 20 (   3,    7) title            zeroGrob[plot.title..zeroGrob.68]          
      21 21 (  14,    7) caption          zeroGrob[plot.caption..zeroGrob.70]        

---

    Code
      gtable_print(p, show_zeroGrobs = FALSE)
    Output
      TableGrob (16 x 13) "layout": 22 grobs
      id  z cells        name       grob                                        
       2  7 (   9,    6) axis-l     absoluteGrob[GRID.absoluteGrob.95]          
       5  1 (   9,    7) panel      gTree[panel-1.gTree.87]                     
       6  9 (  10,    7) axis-b     absoluteGrob[GRID.absoluteGrob.91]          
      11 11 (  11,    7) xlab-b     titleGrob[axis.title.x.bottom..titleGrob.98]
      12 12 (   9,    5) ylab-l     titleGrob[axis.title.y.left..titleGrob.101] 
      22  0 (1-16, 1-13) background rect[GRID.rect.105]                         
      # ℹ 16 zeroGrobs are omitted.

---

    Code
      gtable_print(p, filter = "axis")
    Output
      TableGrob (16 x 13) "layout": 22 grobs
      id z cells   name   grob                               
       2 7 ( 9, 6) axis-l absoluteGrob[GRID.absoluteGrob.129]
       4 6 ( 8, 7) axis-t zeroGrob[GRID.null.1]              
       6 9 (10, 7) axis-b absoluteGrob[GRID.absoluteGrob.125]
       8 8 ( 9, 8) axis-r zeroGrob[GRID.null.1]              
      # ℹ 18 grobs are omitted due to `filter`.

---

    Code
      gtable_print(p, filter = c("axis", "lab"))
    Output
      TableGrob (16 x 13) "layout": 22 grobs
      id  z cells   name   grob                                         
       2  7 ( 9, 6) axis-l absoluteGrob[GRID.absoluteGrob.163]          
       4  6 ( 8, 7) axis-t zeroGrob[GRID.null.1]                        
       6  9 (10, 7) axis-b absoluteGrob[GRID.absoluteGrob.159]          
       8  8 ( 9, 8) axis-r zeroGrob[GRID.null.1]                        
      10 10 ( 7, 7) xlab-t zeroGrob[GRID.null.1]                        
      11 11 (11, 7) xlab-b titleGrob[axis.title.x.bottom..titleGrob.166]
      12 12 ( 9, 5) ylab-l titleGrob[axis.title.y.left..titleGrob.169]  
      13 13 ( 9, 9) ylab-r zeroGrob[GRID.null.1]                        
      # ℹ 14 grobs are omitted due to `filter`.

# gtable_print errors correctly

    Code
      gtable_print(1)
    Condition
      Error in `gtable::as.gtable()`:
      ! Can't convert a number to a <gtable>.

---

    Code
      gtable_print(p, zsort = 1)
    Condition
      Error in `gtable_print()`:
      ! `zsort` must be `TRUE` or `FALSE`, not the number 1.

---

    Code
      gtable_print(p, show_zeroGrobs = 1)
    Condition
      Error in `gtable_print()`:
      ! `show_zeroGrobs` must be `TRUE` or `FALSE`, not the number 1.

---

    Code
      gtable_print(p, filter = 1)
    Condition
      Error in `gtable_print()`:
      ! `filter` must be a character vector or `NULL`, not the number 1.

