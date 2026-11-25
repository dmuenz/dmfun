# gtable_show_grobs works

    Code
      gtable_show_grobs(gtable::gtable())
    Message
      i `x` has no grobs so there is nothing to draw.

# gtable_show_grobs errors correctly

    Code
      gtable_show_grobs(1)
    Condition
      Error in `gtable::as.gtable()`:
      ! Can't convert a number to a <gtable>.

---

    Code
      gtable_show_grobs(p, color = "waka")
    Condition
      Error in `gtable_show_grobs()`:
      ! `color`: invalid color name 'waka'

---

    Code
      gtable_show_grobs(p, fill = "waka")
    Condition
      Error in `gtable_show_grobs()`:
      ! `fill`: invalid color name 'waka'

---

    Code
      gtable_show_grobs(p, fontsize = -1)
    Condition
      Error in `gtable_show_grobs()`:
      ! `fontsize` must be a number larger than or equal to 0, not the number -1.

---

    Code
      gtable_show_grobs(p, labels = -1)
    Condition
      Error in `gtable_show_grobs()`:
      ! `labels` must be `TRUE` or `FALSE` or a regex string, not the number -1.

---

    Code
      gtable_show_grobs(p, show_zeroGrobs = -1)
    Condition
      Error in `gtable_show_grobs()`:
      ! `show_zeroGrobs` must be `TRUE` or `FALSE`, not the number -1.

