-- Generated from ChapterGradedFock.lean — 
theorem BookProof.GradedFock.liftSnd_single (S : (β →₀ ℂ) →ₗ[ℂ] (β →₀ ℂ)) (a : α) (b : β) (c : ℂ) :
    liftSnd (α := α) S (Finsupp.single (a, b) c)
      = c • otimes (Finsupp.single a (1 : ℂ)) (S (Finsupp.single b 1)) := by sorry
