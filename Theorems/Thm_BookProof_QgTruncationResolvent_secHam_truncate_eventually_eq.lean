-- Generated from ChapterQgTruncationResolvent.lean — 
theorem BookProof.QgTruncationResolvent.secHam_truncate_eventually_eq (Λ : ℕ → Set ι)
    (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) (x : secCore (ι := ι)) :
    ∀ᶠ n in atTop, secHam W (truncModes Q (Λ n)) x = secHam W Q x := by sorry
