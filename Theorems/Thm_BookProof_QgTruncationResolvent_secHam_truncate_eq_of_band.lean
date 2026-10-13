-- Generated from ChapterQgTruncationResolvent.lean — 
theorem BookProof.QgTruncationResolvent.secHam_truncate_eq_of_band (Λ : Set ι) {x : secCore (ι := ι)} {P : Finset ι}
    (hP1 : ∀ a, a ∉ P → (x : Sec ι) a = 0)
    (hP2 : ∀ a, a ∉ P → ∀ b ∈ Q.nbr a, (x : Sec ι) b = 0)
    (hPΛ : ∀ a ∈ P, a ∈ Λ) :
    secHam W (truncModes Q Λ) x = secHam W Q x := by sorry
