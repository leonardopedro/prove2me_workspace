-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.numberQuad_nonneg
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_numberQuad_eq_sum
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution (u : FockAlg) : 0 ≤ numberQuad u := by

  rw [numberQuad_eq_sum (K := modes u) subset_rfl]
  exact Finset.sum_nonneg fun k _ => sq_nonneg _
