-- Generated from ChapterMackeyCocycle.lean — 
theorem BookProof.ChapterMackeyCocycle.vmap_eq_tmap {hm : ∀ g : G, Measurable fun x : X => g • x}
    {V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)} (hcov : Covariant μ hm V)
    (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ} (hwmeas : Measurable w)
    (hw : w =ᵐ[μ] ((V g (indSet μ (MeasurableSet.univ (α := X)))) : X → ℂ))
    (hdens : dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2) (f : Lp ℂ 2 μ) :
    V g f = tmap hqi g hwmeas hdens f := by sorry
