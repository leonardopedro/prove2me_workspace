-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isSymAlg_liftFst
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
theorem solution {T : Module.End ℂ (α →₀ ℂ)} (hT : IsSymAlg T) :
    IsSymAlg (liftFst (β := by

  classical
  intro u v
  set s : Finset (α × β) :=
    (liftFst (β := β) T u).support ∪ u.support ∪ v.support ∪ (liftFst (β := β) T v).support
    with hs
  have hsub : ∀ w : (α × β) →₀ ℂ, w.support ⊆ s → w.support ⊆ (rect s).1 ×ˢ (rect s).2 :=
    fun w hw => hw.trans subset_rect
  have h1 : (liftFst (β := β) T u).support ⊆ s := by
    intro p hp; simp only [hs]; exact Finset.mem_union_left _ (Finset.mem_union_left _
      (Finset.mem_union_left _ hp))
  have h2 : u.support ⊆ s := by
    intro p hp; simp only [hs]; exact Finset.mem_union_left _ (Finset.mem_union_left _
      (Finset.mem_union_right _ hp))
  rw [ainner_eq_sum_sliceFst (hsub _ h1), ainner_eq_sum_sliceFst (hsub _ h2)]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [sliceFst_liftFst, sliceFst_liftFst, hT]
