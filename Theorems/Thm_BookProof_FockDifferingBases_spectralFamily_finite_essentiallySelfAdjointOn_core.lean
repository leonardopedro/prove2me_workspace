-- Generated from ChapterFockDifferingBasesEsa.lean — 
theorem BookProof.FockDifferingBases.spectralFamily_finite_essentiallySelfAdjointOn_core [Finite κ] {lam : κ → ℝ}
    {v : κ → ι → ℂ} (hv : ∀ k, Summable fun p => ‖v k p‖) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((exchangeH (ω := fun _ : ι => (0 : ℝ)) (fun _ => le_rfl)
          (fun z : κ × ι × ι => z.2.1) (fun z => z.2.2) (specAmp lam v)
          (summable_specAmp hv (summable_specGate_of_finite lam v))).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig (fun _ : ι => (0 : ℝ)))))) := by sorry
