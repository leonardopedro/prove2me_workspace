-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.support_sliceFst_subset
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Theorems.Thm_BookProof_GradedFriedrichs_sliceFst_apply
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
    (hu : u.support ⊆ A ×ˢ B) (b : β) : (sliceFst b u).support ⊆ A := by

  intro a ha
  have hne : u (a, b) ≠ 0 := by
    rw [← sliceFst_apply]
    exact Finsupp.mem_support_iff.mp ha
  exact (Finset.mem_product.mp (hu (Finsupp.mem_support_iff.mpr hne))).1
