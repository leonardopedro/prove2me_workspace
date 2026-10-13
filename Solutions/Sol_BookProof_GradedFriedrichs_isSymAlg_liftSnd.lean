-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isSymAlg_liftSnd
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

theorem solution {S : Module.End ℂ (β →₀ ℂ)} (hS : IsSymAlg S) :
    IsSymAlg (liftSnd (α := α) S) := by
  classical
  intro u v
  set s : Finset (α × β) :=
    (liftSnd (α := α) S u).support ∪ u.support ∪ v.support ∪ (liftSnd (α := α) S v).support
    with hs
  have hsub : ∀ w : (α × β) →₀ ℂ, w.support ⊆ s → w.support ⊆ (rect s).1 ×ˢ (rect s).2 :=
    fun w hw => hw.trans subset_rect
  have h1 : (liftSnd (α := α) S u).support ⊆ s := by
    intro p hp; simp only [hs]; exact Finset.mem_union_left _ (Finset.mem_union_left _
      (Finset.mem_union_left _ hp))
  have h2 : u.support ⊆ s := by
    intro p hp; simp only [hs]; exact Finset.mem_union_left _ (Finset.mem_union_left _
      (Finset.mem_union_right _ hp))
  rw [ainner_eq_sum_sliceSnd (hsub _ h1), ainner_eq_sum_sliceSnd (hsub _ h2)]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [sliceSnd_liftSnd, sliceSnd_liftSnd, hS]
