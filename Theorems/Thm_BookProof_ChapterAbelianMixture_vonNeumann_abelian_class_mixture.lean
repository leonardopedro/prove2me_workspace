-- Generated from ChapterAbelianMixture.lean — 
theorem BookProof.ChapterAbelianMixture.vonNeumann_abelian_class_mixture :
    (multOp (μ := mixtureMeasure) (fun _ : ℝ => (1 : ℂ)) memLp_top_one
        = ContinuousLinearMap.id ℂ (Lp ℂ 2 mixtureMeasure)) ∧
    (∀ (φ ψ : ℝ → ℂ) (hφ : MemLp φ ⊤ mixtureMeasure) (hψ : MemLp ψ ⊤ mixtureMeasure),
      (multOp φ hφ).comp (multOp ψ hψ) = (multOp ψ hψ).comp (multOp φ hφ)) ∧
    (∀ (φ ψ : ℝ → ℂ) (hφ : MemLp φ ⊤ mixtureMeasure) (hψ : MemLp ψ ⊤ mixtureMeasure),
      (multOp φ hφ).comp (multOp ψ hψ)
        = multOp (fun x => φ x * ψ x) (memLp_top_mul hφ hψ)) ∧
    (∀ (φ : ℝ → ℂ) (hφ : MemLp φ ⊤ mixtureMeasure) (f g : Lp ℂ 2 mixtureMeasure),
      inner ℂ (multOp φ hφ f) g
        = inner ℂ f (multOp (fun x => (starRingEnd ℂ) (φ x)) (memLp_top_conj hφ) g)) ∧
    (∀ (φ : ℝ → ℂ) (hφ : MemLp φ ⊤ mixtureMeasure), multOp φ hφ = 0 ↔ φ =ᵐ[mixtureMeasure] 0) := by sorry
