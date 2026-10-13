-- Generated from ChapterScalaronOuterFockFL.lean — 
theorem BookProof.ScalaronOuterFockFL.imA_le (x : secCore (ι := ι)) (P : Finset ι) :
    |(∑ a ∈ P, ∑ b ∈ P, (starRingEnd ℂ) (Q.A a b) *
        (inner ℂ ((fibOf x b : ccDomain ℝ) : L2R) (W.ham (Q.sig a) (fibOf x a)) : ℂ)).im|
      ≤ (1 / 2) * Q.K * ∑ a ∈ P, quadForm (W.ham (Q.sig a)) (fibOf x a) := by sorry
