-- Generated from ChapterFockDifferingBasesEsa.lean — 
theorem BookProof.FockDifferingBases.sumOfTwo_essentiallySelfAdjointOn_core (lam₁ lam₂ : ℝ) (v₁ v₂ : ι → ℂ)
    (hv₁ : Summable fun p => ‖v₁ p‖) (hv₂ : Summable fun p => ‖v₂ p‖) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((exchangeH (ω := fun _ : ι => (0 : ℝ)) (fun _ => le_rfl)
          (fun z : Fin 2 × ι × ι => z.2.1) (fun z => z.2.2)
          (specAmp ![lam₁, lam₂] ![v₁, v₂])
          (summable_specAmp (summable_pairData hv₁ hv₂)
            (summable_specGate_of_finite _ _))).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig (fun _ : ι => (0 : ℝ)))))) := by sorry
