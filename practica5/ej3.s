.data
        base:   .double     5.85
        altura: .double     13.47
        sup:    .double     69
        num2:   .double     2.0
.code
        l.d     f1, base(r0)
        l.d     f2, altura(r0)
        mul.d   f3, f2, f1
        l.d     f1, num2(r0)
        div.d   f3, f3, f1
        s.d     f3, sup(r0)
        halt