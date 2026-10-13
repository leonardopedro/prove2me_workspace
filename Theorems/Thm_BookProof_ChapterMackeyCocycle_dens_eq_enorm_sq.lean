-- Generated from ChapterMackeyCocycle.lean — 
theorem BookProof.ChapterMackeyCocycle.dens_eq_enorm_sq {μ : Measure X} [IsFiniteMeasure μ]
    {hm : ∀ g : G, Measurable fun x : X => g • x}
    {V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)} (hcov : Covariant μ hm V) (g : G)
    {w : X → ℂ} (hwmeas : Measurable w)
    (hw : w =ᵐ[μ] ((V g (indSet μ (MeasurableSet.univ (α := X)))) : X → ℂ)) :
    dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2 := by sorry
