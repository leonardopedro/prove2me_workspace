-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.ainner_eq_sum_sliceFst
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_ainner_eq_sum
import Theorems.Thm_BookProof_GradedFriedrichs_sliceFst_apply
import Theorems.Thm_BookProof_GradedFriedrichs_support_sliceFst_subset
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
theorem solution {u v : (α × β) →₀ ℂ} {A : Finset α} {B : Finset β}
    (hu : u.support ⊆ A ×ˢ B) :
    ainner u v = ∑ b ∈ B, ainner (sliceFst b u) (sliceFst b v) := by

  classical
  rw [ainner_eq_sum hu v, Finset.sum_product, Finset.sum_comm]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [ainner_eq_sum (support_sliceFst_subset hu b)]
  exact Finset.sum_congr rfl fun a _ => by rw [sliceFst_apply, sliceFst_apply]
