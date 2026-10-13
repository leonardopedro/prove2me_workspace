-- Generated from ChapterScalaronOuterFockFL.lean — 
theorem BookProof.ScalaronOuterFockFL.secHam_supp {P : Finset ι} {x : secCore (ι := ι)}
    (hP1 : ∀ a, a ∉ P → (x : Sec ι) a = 0)
    (hP2 : ∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (x : Sec ι) b = 0) (a : ι) (ha : a ∉ P) :
    (secHam W Q x : Sec ι) a = 0 := by sorry
