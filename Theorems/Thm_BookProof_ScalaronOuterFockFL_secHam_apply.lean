-- Generated from ChapterScalaronOuterFockFL.lean — 
theorem BookProof.ScalaronOuterFockFL.secHam_apply (x : secCore (ι := ι)) (a : ι) :
    (secHam W Q x : Sec ι) a = W.ham (Q.sig a) (fibOf x a)
      + (∑ b ∈ Q.nbr a, Q.A a b • ((fibOf x b : ccDomain ℝ) : L2R))
      + ∑ b ∈ Q.nbr a, Q.B a b • xCc (fibOf x b) := by sorry
