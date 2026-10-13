-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isPosAlg_liftSnd
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_sliceSnd_liftSnd
import Theorems.Thm_BookProof_GradedFriedrichs_ainner_eq_sum_sliceSnd
import Theorems.Thm_BookProof_GradedFriedrichs_subset_rect
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in

theorem solution {S : Module.End ℂ (β →₀ ℂ)} (hS : IsPosAlg S) :
    IsPosAlg (liftSnd (α := α) S) := by
  classical
  intro u
  rw [ainner_eq_sum_sliceSnd (u := u) (v := liftSnd (α := α) S u)
    (subset_rect (s := u.support))]
  rw [Complex.re_sum]
  refine Finset.sum_nonneg fun a _ => ?_
  rw [sliceSnd_liftSnd]
  exact hS _
