-- Generated from ChapterQgFullEliminated.lean — 
theorem BookProof.QgFullEliminated.qgElimFull_number_conserving (W : WallPot) (g : ℝ) {num : EGMode → ℕ}
    (hnum : ∀ a b : EGMode, b.1 = a.1 → num b = num a) (x : secCore (ι := EGMode)) {n : ℕ}
    (hx : ∀ a, num a ≠ n → (x : Sec EGMode) a = 0) (a : EGMode) (ha : num a ≠ n) :
    (secHam W (qgElimFullModes g) x : Sec EGMode) a = 0 := by sorry
