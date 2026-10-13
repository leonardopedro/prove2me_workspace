-- Generated from ChapterScalaronOuterFockFL.lean — 
theorem BookProof.ScalaronOuterFockFL.quadForm_secDiag_eq (x : secCore (ι := ι)) {P : Finset ι}
    (hP1 : ∀ a, a ∉ P → (x : Sec ι) a = 0) :
    quadForm (secDiag W Q) x = ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (fibOf x a) := by sorry
