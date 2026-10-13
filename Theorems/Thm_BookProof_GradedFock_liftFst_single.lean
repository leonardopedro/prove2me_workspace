-- Generated from ChapterGradedFock.lean — 
theorem BookProof.GradedFock.liftFst_single (T : (α →₀ ℂ) →ₗ[ℂ] (α →₀ ℂ)) (a : α) (b : β) (c : ℂ) :
    liftFst (β := β) T (Finsupp.single (a, b) c)
      = c • otimes (T (Finsupp.single a 1)) (Finsupp.single b (1 : ℂ)) := by sorry
