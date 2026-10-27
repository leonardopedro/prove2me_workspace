-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isPosAlg_liftFst
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_sliceFst_liftFst
import Theorems.Thm_BookProof_GradedFriedrichs_ainner_eq_sum_sliceFst
import Theorems.Thm_BookProof_GradedFriedrichs_subset_rect
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {T : Module.End ℂ (α →₀ ℂ)} (hT : IsPosAlg T) :
    IsPosAlg (liftFst (β :=
  β) T) := by
    classical
    intro u
    rw [ainner_eq_sum_sliceFst (u := u) (v := liftFst (β := β) T u)
      (subset_rect (s := u.support))]
    rw [Complex.re_sum]
    refine Finset.sum_nonneg fun b _ => ?_
    rw [sliceFst_liftFst]
    exact hT _
