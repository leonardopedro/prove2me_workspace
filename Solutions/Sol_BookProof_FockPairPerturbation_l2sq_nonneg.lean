-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.l2sq_nonneg
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (g : ℕ →₀ ℂ) : 0 ≤ l2sq g := Finset.sum_nonneg fun _ _ => sq_nonneg _
