-- Generated from ChapterSirkPerSystemFlowBound.lean — 
theorem BookProof.ChapterSirkPerSystemFlowBound.isSirkScheme_trivial (X : E →L[ℂ] E) (V : G →L[ℂ] E)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖) (hinvX : ∀ x : G, ∃ y : G, X (V x) = V y)
    (S : Set ℂ) (h : ℝ) (m : ℕ) :
    IsSirkScheme X V S 1 1 h m
      { qX := ContinuousLinearMap.id ℂ E, qXinv := ContinuousLinearMap.id ℂ E,
        qBinv := ContinuousLinearMap.id ℂ G, p := Polynomial.X,
        psiX := X, psiB := compress V X } := by sorry
