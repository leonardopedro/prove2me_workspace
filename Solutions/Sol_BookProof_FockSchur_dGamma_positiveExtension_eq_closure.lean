-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.dGamma_positiveExtension_eq_closure
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_dGamma_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_EsaClosure_positiveExtension_eq_closure_of_esa
import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_symmetricOn
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hK : SchurBound col K) (hherm : IsHermCol col)
    (hK0 : 0 ≤ K) {Dom : Submodule ℂ Fock} {A : Dom →ₗ[ℂ] Fock}
    (hA : IsPositiveSelfAdjointExtension (dGammaOp col) A) :
    Dom = clDom (dGammaOp col) ∧
      ∀ (x : Fock) (h : x ∈ Dom) (h' : x ∈ clDom (dGammaOp col)),
        A ⟨x, h⟩ = clExt (dGammaOp col) finiteOccupation_dense
          (dGammaOp_symmetricOn hherm) ⟨x, h'⟩ :=
  positiveExtension_eq_closure_of_esa finiteOccupation_dense (dGammaOp_symmetricOn hherm)
      (dGamma_essentiallySelfAdjointOn_core hK hherm hK0) hA
