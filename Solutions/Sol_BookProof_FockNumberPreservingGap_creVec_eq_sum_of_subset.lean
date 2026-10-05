-- Generated from ChapterFockNumberPreservingGap.lean — solution of BookProof.FockNumberPreservingGap.creVec_eq_sum_of_subset
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Theorems.Thm_BookProof_FockSecondQuantization_creVec_apply
open BookProof.FockNumberPreservingGap



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (v : ℕ →₀ ℂ) (x : FockAlg) {s : Finset ℕ}
    (h : v.support ⊆ s) : creVec v x = ∑ j ∈ s, v j • creA j x := by

  rw [creVec_apply]
  exact Finset.sum_subset h fun j _ hj => by
    rw [Finsupp.notMem_support_iff.mp hj, zero_smul]
