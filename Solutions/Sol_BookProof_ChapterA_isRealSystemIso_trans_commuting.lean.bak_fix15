-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.isRealSystemIso_trans_commuting
import Mathlib
import Definitions.Def_ChapterA2e
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} {N : System ℂ W}
    {β : V ≃ₗᵢ[ℝ] W} (hβ : IsRealSystemIso M N β) {U : W ≃ₗᵢ[ℝ] W}
    (hU : RealCommutes N (betaR U)) : IsRealSystemIso M N (β.trans U) := by

  -- On each `m ∈ M`, conjugation by `β.trans U` agrees with conjugation by `β`.
  have hkey : ∀ m ∈ M.ops, conjClmR β (m.restrictScalars ℝ)
      = conjClmR (β.trans U) (m.restrictScalars ℝ) := by
    intro m hm
    -- `conjClmR β (realify m) = realify n` for some `n ∈ N`; `U` fixes it.
    have hmem : conjClmR β (m.restrictScalars ℝ) ∈
        (fun n : W →L[ℂ] W => n.restrictScalars ℝ) '' N.ops := by
      rw [hβ]; exact ⟨m, hm, rfl⟩
    obtain ⟨n, hn, hneq⟩ := hmem
    have hnw : ∀ y, β ((m.restrictScalars ℝ) (β.symm y)) = n y := by
      intro y
      have h0 : conjClmR β (m.restrictScalars ℝ) y = n y := by rw [← hneq]; rfl
      rwa [conjClmR_apply] at h0
    have hUcomm : ∀ y, U (n y) = n (U y) := fun y => hU n hn y
    ext w
    rw [conjClmR_apply, conjClmR_apply,
      (show (β.trans U).symm w = β.symm (U.symm w) by
        apply (β.trans U).injective
        rw [LinearIsometryEquiv.apply_symm_apply, LinearIsometryEquiv.trans_apply,
          LinearIsometryEquiv.apply_symm_apply, LinearIsometryEquiv.apply_symm_apply]),
      LinearIsometryEquiv.trans_apply]
    -- RHS : U (β (realm (β.symm (U.symm w)))) ; LHS : β (realm (β.symm w))
    rw [hnw w, hnw (U.symm w), hUcomm, LinearIsometryEquiv.apply_symm_apply]
  unfold IsRealSystemIso
  rw [hβ]
  exact Set.image_congr (fun m hm => hkey m hm)
