-- Generated from ChapterFockDifferingBasesEsa.lean — 
theorem BookProof.FockDifferingBases.nestedFock_essentiallySelfAdjointOn_core {ι₀ : Type*} {lam : κ → ℝ}
    {v : κ → Idx ι₀ → ℂ} (hv : ∀ k, Summable fun p => ‖v k p‖)
    (hlam : Summable fun k => |lam k| * (∑' p, ‖v k p‖) ^ 2) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx (Idx ι₀)))
      ((exchangeH (ω := fun _ : Idx ι₀ => (0 : ℝ)) (fun _ => le_rfl)
          (fun z : κ × Idx ι₀ × Idx ι₀ => z.2.1) (fun z => z.2.2) (specAmp lam v)
          (summable_specAmp hv hlam)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig (fun _ : Idx ι₀ => (0 : ℝ)))))) := by sorry
