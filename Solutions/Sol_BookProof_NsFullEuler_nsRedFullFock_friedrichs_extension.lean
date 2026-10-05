-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsRedFullFock_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_nsRedFockCore_dense
import Theorems.Thm_BookProof_NsFullEuler_nsRedFullFockHam_symmetricOn
import Theorems.Thm_BookProof_NsFullEuler_nsRedFullFockHam_quadForm_nonneg
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
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    ∃ (Dom : Submodule ℂ nsRedFockSpace) (A : Dom →ₗ[ℂ] nsRedFockSpace),
      IsPositiveSelfAdjointExtension (nsRedFullFockHam nu k) A :=
  friedrichs_extension_exists
      ⟨nsRedFockCore, nsRedFullFockHam nu k, nsRedFullFockHam_symmetricOn nu k,
        nsRedFullFockHam_quadForm_nonneg nu k⟩
      nsRedFockCore_dense
