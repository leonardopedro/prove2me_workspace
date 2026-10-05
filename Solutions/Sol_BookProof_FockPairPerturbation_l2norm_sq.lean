-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.l2norm_sq
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_l2sq_nonneg
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (g : ℕ →₀ ℂ) : l2norm g ^ 2 = l2sq g := Real.sq_sqrt (l2sq_nonneg g)
