-- Generated from ChapterQgFullEliminated.lean — 
theorem BookProof.QgFullEliminated.qgElimFull_momentum_conserving (W : WallPot) (g : ℝ) (num : Mom → ℕ)
    (x : secCore (ι := EGMode)) {n : ℕ}
    (hx : ∀ a : EGMode, num a.1 ≠ n → (x : Sec EGMode) a = 0) (a : EGMode) (ha : num a.1 ≠ n) :
    (secHam W (qgElimFullModes g) x : Sec EGMode) a = 0 := by sorry
