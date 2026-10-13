-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.support_sliceSnd_subset
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_sliceSnd_apply
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
theorem solution {u : (α × β) →₀ ℂ} {A : Finset α} {B : Finset β}
    (hu : u.support ⊆ A ×ˢ B) (a : α) : (sliceSnd a u).support ⊆ B := by

  intro b hb
  have hne : u (a, b) ≠ 0 := by
    rw [← sliceSnd_apply]
    exact Finsupp.mem_support_iff.mp hb
  exact (Finset.mem_product.mp (hu (Finsupp.mem_support_iff.mpr hne))).2
