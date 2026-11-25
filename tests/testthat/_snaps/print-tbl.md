# print_tbl works

    Code
      print_tbl(x)
    Output
      # A tibble: 2 x 2
        name    age
      * <chr> <dbl>
      1 Alice    30
      2 Bob      40

---

    Code
      print_tbl(x, show_types = FALSE)
    Output
      # A tibble: 2 x 2
        name  age
      1 Alice  30
      2 Bob    40

---

    Code
      print_tbl(x, show_rowid = FALSE)
    Output
      # A tibble: 2 x 2
      name    age
      <chr> <dbl>
      Alice    30
      Bob      40

---

    Code
      print_tbl(x, show_header = FALSE)
    Output
        name    age
      * <chr> <dbl>
      1 Alice    30
      2 Bob      40

---

    Code
      print_tbl(x, n = 1)
    Output
      # A tibble: 2 x 2
        name    age
      * <chr> <dbl>
      1 Alice    30
      # i 1 more row

# print_tbl errors correctly

    Code
      print_tbl(mean)
    Condition
      Error in `as.data.frame.default()`:
      ! cannot coerce class '"function"' to a data.frame

---

    Code
      print_tbl(x, show_types = 1)
    Condition
      Error in `print_tbl()`:
      ! `show_types` must be `TRUE` or `FALSE`, not the number 1.

---

    Code
      print_tbl(x, show_rowid = 1)
    Condition
      Error in `print_tbl()`:
      ! `show_rowid` must be `TRUE` or `FALSE`, not the number 1.

---

    Code
      print_tbl(x, show_header = 1)
    Condition
      Error in `print_tbl()`:
      ! `show_header` must be `TRUE` or `FALSE`, not the number 1.

