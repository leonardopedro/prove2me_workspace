-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.inner_creVec_left
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_inner_creVec_annVec
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (g : ℕ →₀ ℂ) (v u : FockAlg) :
    (inner ℂ (toLp (creVec g v)) (toLp u) : ℂ) = inner ℂ (toLp v) (toLp (annVec g u)) := by

  have h := inner_creVec_annVec g u v
  have := congrArg (starRingEnd ℂ) h
  rwa [inner_conj_symm, inner_conj_symm] at this
