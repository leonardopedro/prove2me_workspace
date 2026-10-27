-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.annA_creA
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockSecondQuantization_ccr_annA_creA
import Theorems.Thm_BookProof_FockSecondQuantization_ccr_annA_creA_of_ne
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (i j : ℕ) (u : FockAlg) :
    annA i (creA j u) = creA j (annA i u) + (if i = j then u else 0) := by

  rcases eq_or_ne i j with rfl | h
  · have := ccr_annA_creA i u
    rw [if_pos rfl]
    linear_combination (norm := module) this
  · rw [if_neg h, add_zero, ccr_annA_creA_of_ne h]
