-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.abs_re_inner_pairVec_le
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_inner_creVec_left
import Theorems.Thm_BookProof_FockPairPerturbation_norm_creVec_le
import Theorems.Thm_BookProof_FockPairPerturbation_pairVec_apply
import Theorems.Thm_BookProof_FockFieldPerturbation_inner_creVec_annVec
import Theorems.Thm_BookProof_FockFieldPerturbation_l2norm_nonneg
import Theorems.Thm_BookProof_FockFieldPerturbation_norm_annVec_le
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (f g : ℕ →₀ ℂ) (u : FockAlg) :
    |(inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re|
      ≤ 2 * (l2norm f * l2norm g)
          * (Real.sqrt (numberQuad u) * Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2)) := by

  have hadd : ∀ a b : FockAlg, toLp (a + b) = toLp a + toLp b := fun a b => map_add toLpL a b
  have hsplit : (inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ)
      = inner ℂ (toLp u) (toLp (creVec f (creVec g u)))
        + inner ℂ (toLp u) (toLp (annVec g (annVec f u))) := by
    rw [pairVec_apply, hadd, inner_add_right]
  have hbnd : ‖toLp (annVec f u)‖ * ‖toLp (creVec g u)‖
      ≤ l2norm f * l2norm g
          * (Real.sqrt (numberQuad u) * Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2)) := by
    have h := mul_le_mul (norm_annVec_le f u) (norm_creVec_le g u) (norm_nonneg _)
      (mul_nonneg (l2norm_nonneg f) (Real.sqrt_nonneg _))
    calc ‖toLp (annVec f u)‖ * ‖toLp (creVec g u)‖
        ≤ (l2norm f * Real.sqrt (numberQuad u))
            * (l2norm g * Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2)) := h
      _ = _ := by ring
  have h1 : |(inner ℂ (toLp u) (toLp (creVec f (creVec g u))) : ℂ).re|
      ≤ l2norm f * l2norm g
          * (Real.sqrt (numberQuad u) * Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2)) := by
    rw [inner_creVec_annVec f u (creVec g u)]
    calc |(inner ℂ (toLp (annVec f u)) (toLp (creVec g u)) : ℂ).re|
        ≤ ‖(inner ℂ (toLp (annVec f u)) (toLp (creVec g u)) : ℂ)‖ := Complex.abs_re_le_norm _
      _ ≤ ‖toLp (annVec f u)‖ * ‖toLp (creVec g u)‖ := norm_inner_le_norm _ _
      _ ≤ _ := hbnd
  have h2 : |(inner ℂ (toLp u) (toLp (annVec g (annVec f u))) : ℂ).re|
      ≤ l2norm f * l2norm g
          * (Real.sqrt (numberQuad u) * Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2)) := by
    rw [← inner_creVec_left g u (annVec f u)]
    calc |(inner ℂ (toLp (creVec g u)) (toLp (annVec f u)) : ℂ).re|
        ≤ ‖(inner ℂ (toLp (creVec g u)) (toLp (annVec f u)) : ℂ)‖ := Complex.abs_re_le_norm _
      _ ≤ ‖toLp (creVec g u)‖ * ‖toLp (annVec f u)‖ := norm_inner_le_norm _ _
      _ = ‖toLp (annVec f u)‖ * ‖toLp (creVec g u)‖ := mul_comm _ _
      _ ≤ _ := hbnd
  rw [hsplit, Complex.add_re]
  calc |(inner ℂ (toLp u) (toLp (creVec f (creVec g u))) : ℂ).re
          + (inner ℂ (toLp u) (toLp (annVec g (annVec f u))) : ℂ).re|
      ≤ |(inner ℂ (toLp u) (toLp (creVec f (creVec g u))) : ℂ).re|
        + |(inner ℂ (toLp u) (toLp (annVec g (annVec f u))) : ℂ).re| := abs_add_le _ _
    _ ≤ _ := by linarith
