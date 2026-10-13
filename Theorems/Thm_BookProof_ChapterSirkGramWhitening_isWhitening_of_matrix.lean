-- Generated from ChapterSirkGramWhitening.lean — 
theorem BookProof.ChapterSirkGramWhitening.isWhitening_of_matrix {m : ℕ} (w : Fin m → E) {M : Matrix (Fin m) (Fin m) ℂ}
    (hM : IsWhiteningMatrix w M) :
    IsWhitening w (Matrix.toEuclideanCLM (𝕜 := ℂ) M) := by sorry
