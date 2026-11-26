# debug_print works

    Code
      debug_print(1:5)
    Output
      ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
      Printing 1:5
      --------
      [1] 1 2 3 4 5
      ____________________

---

    Code
      debug_print(1:5, note = "Hi!")
    Output
      ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
      Printing 1:5
      Note: Hi!
      --------
      [1] 1 2 3 4 5
      ____________________

---

    Code
      my_sum1(1:5)
    Output
      ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
      Printing x
          from my_sum1()
      --------
      [1] 1 2 3 4 5
      ____________________
      [1] 15

---

    Code
      my_sum2(1:5)
    Output
      ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
      Printing y
          from my_sum2() -> do_nothing()
      --------
      [1] 1 2 3 4 5
      ____________________
      [1] 15

---

    Code
      add1(1:2)
    Output
      ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
      Printing x_i
          from add1() -> sapply()
      --------
      [1] 1
      ____________________
      ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
      Printing x_i
          from add1() -> sapply()
      --------
      [1] 2
      ____________________
      [1] 2 3

# debug_print errors correctly

    Code
      debug_print(1:5, note = mean)
    Condition
      Error in `debug_print()`:
      ! `note` must be `NULL` or coercible to character, not a function.

