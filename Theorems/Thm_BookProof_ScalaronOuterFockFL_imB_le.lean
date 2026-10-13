-- Generated from ChapterScalaronOuterFockFL.lean — 
theorem BookProof.ScalaronOuterFockFL.imB_le (x : secCore (ι := ι)) (P : Finset ι) :
    |(∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.B a b) *
        (inner ℂ (xCc (fibOf x b)) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im|
      ≤ (9 / 4) * Q.K * ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (fibOf x a) := by sorry
