-- Generated from ChapterSirkGramWhitening.lean — 
theorem BookProof.ChapterSirkGramWhitening.isWhitening_one_of_orthonormal {m : ℕ} {w : Fin m → E} (hw : Orthonormal ℂ w) :
    IsWhitening w (Matrix.toEuclideanCLM (𝕜 := ℂ) (1 : Matrix (Fin m) (Fin m) ℂ)) := by sorry
