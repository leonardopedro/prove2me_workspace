-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.norm_creVec_le
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_l2norm_sq
import Theorems.Thm_BookProof_FockPairPerturbation_norm_creVec_sq
import Theorems.Thm_BookProof_FockFieldPerturbation_l2norm_nonneg
import Theorems.Thm_BookProof_FockFieldPerturbation_norm_annVec_le
import Theorems.Thm_BookProof_FockFieldPerturbation_numberQuad_nonneg
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (g : ℕ →₀ ℂ) (u : FockAlg) :
    ‖toLp (creVec g u)‖ ≤ l2norm g * Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2) := by

  have hNq : 0 ≤ numberQuad u := numberQuad_nonneg u
  have hg : 0 ≤ l2norm g := l2norm_nonneg g
  have hid := norm_creVec_sq g u
  have hann := norm_annVec_le g u
  have hsq : Real.sqrt (numberQuad u) ^ 2 = numberQuad u := Real.sq_sqrt hNq
  have hsq2 : Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2) ^ 2 = numberQuad u + ‖toLp u‖ ^ 2 :=
    Real.sq_sqrt (by positivity)
  have hannsq : ‖toLp (annVec g u)‖ ^ 2 ≤ l2sq g * numberQuad u := by
    have h0 : 0 ≤ ‖toLp (annVec g u)‖ := norm_nonneg _
    have := l2norm_sq g
    nlinarith [Real.sqrt_nonneg (numberQuad u)]
  have hle : ‖toLp (creVec g u)‖ ^ 2
      ≤ (l2norm g * Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2)) ^ 2 := by
    rw [mul_pow, hsq2, l2norm_sq]
    nlinarith [l2sq_nonneg g, sq_nonneg (‖toLp u‖)]
  have hrhs : 0 ≤ l2norm g * Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2) := by positivity
  nlinarith [norm_nonneg (toLp (creVec g u))]
