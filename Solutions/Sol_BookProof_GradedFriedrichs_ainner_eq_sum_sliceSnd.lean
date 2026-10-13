-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.ainner_eq_sum_sliceSnd
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_ainner_eq_sum
import Theorems.Thm_BookProof_GradedFriedrichs_sliceSnd_apply
import Theorems.Thm_BookProof_GradedFriedrichs_support_sliceSnd_subset
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
    ainner u v = ∑ a ∈ A, ainner (sliceSnd a u) (sliceSnd a v) := by

  classical
  rw [ainner_eq_sum hu v]
  rw [Finset.sum_product]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [ainner_eq_sum (support_sliceSnd_subset hu a)]
  exact Finset.sum_congr rfl fun b _ => by rw [sliceSnd_apply, sliceSnd_apply]
