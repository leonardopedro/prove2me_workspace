-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.redHam_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) :
    ∃ (Dom : Submodule ℂ (L2d (n * 6))) (A : Dom →ₗ[ℂ] L2d (n * 6)),
      IsPositiveSelfAdjointExtension (redHam nu k n) A :=
  friedrichs_extension_exists
      ⟨polyGaussCore, redHam nu k n, redHam_symmetricOn nu k n,
        redHam_quadForm_nonneg nu k n⟩
      polyGaussCore_dense
