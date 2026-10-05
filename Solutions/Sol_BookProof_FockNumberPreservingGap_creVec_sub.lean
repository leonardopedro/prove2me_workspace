-- Generated from ChapterFockNumberPreservingGap.lean — solution of BookProof.FockNumberPreservingGap.creVec_sub
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Theorems.Thm_BookProof_FockNumberPreservingGap_creVec_eq_sum_of_subset
open BookProof.FockNumberPreservingGap



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (v w : ℕ →₀ ℂ) (x : FockAlg) :
    creVec (v - w) x = creVec v x - creVec w x := by

  classical
  set s : Finset ℕ := (v - w).support ∪ (v.support ∪ w.support) with hs
  have h1 : (v - w).support ⊆ s := Finset.subset_union_left
  have h2 : v.support ⊆ s := fun j hj =>
    Finset.mem_union_right _ (Finset.mem_union_left _ hj)
  have h3 : w.support ⊆ s := fun j hj =>
    Finset.mem_union_right _ (Finset.mem_union_right _ hj)
  have hterm : ∀ j : ℕ, ((v - w) j) • creA j x = v j • creA j x - w j • creA j x := by
    intro j
    rw [Finsupp.sub_apply, sub_smul]
  rw [creVec_eq_sum_of_subset _ _ h1, creVec_eq_sum_of_subset _ _ h2,
    creVec_eq_sum_of_subset _ _ h3]
  simp only [hterm]
  rw [Finset.sum_sub_distrib]
