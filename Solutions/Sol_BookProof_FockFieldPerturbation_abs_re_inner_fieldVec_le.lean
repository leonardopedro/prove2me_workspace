-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.abs_re_inner_fieldVec_le
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_fieldVec_apply
import Theorems.Thm_BookProof_FockFieldPerturbation_norm_annVec_le
import Theorems.Thm_BookProof_FockFieldPerturbation_inner_creVec_annVec
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution (f : ℕ →₀ ℂ) (u : FockAlg) :
    |(inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re|
      ≤ 2 * l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by

  have hsplit : (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ)
      = inner ℂ (toLp u) (toLp (creVec f u)) + inner ℂ (toLp u) (toLp (annVec f u)) := by
    have hadd := map_add toLpL (creVec f u) (annVec f u)
    simp only [toLpL_apply] at hadd
    rw [fieldVec_apply, hadd, inner_add_right]
  have hbound : ‖toLp (annVec f u)‖ * ‖toLp u‖
      ≤ l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ :=
    mul_le_mul_of_nonneg_right (norm_annVec_le f u) (norm_nonneg _)
  have h1 : |(inner ℂ (toLp u) (toLp (creVec f u)) : ℂ).re|
      ≤ l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by
    rw [inner_creVec_annVec]
    calc |(inner ℂ (toLp (annVec f u)) (toLp u) : ℂ).re|
        ≤ ‖(inner ℂ (toLp (annVec f u)) (toLp u) : ℂ)‖ := Complex.abs_re_le_norm _
      _ ≤ ‖toLp (annVec f u)‖ * ‖toLp u‖ := norm_inner_le_norm _ _
      _ ≤ _ := hbound
  have h2 : |(inner ℂ (toLp u) (toLp (annVec f u)) : ℂ).re|
      ≤ l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by
    calc |(inner ℂ (toLp u) (toLp (annVec f u)) : ℂ).re|
        ≤ ‖(inner ℂ (toLp u) (toLp (annVec f u)) : ℂ)‖ := Complex.abs_re_le_norm _
      _ ≤ ‖toLp u‖ * ‖toLp (annVec f u)‖ := norm_inner_le_norm _ _
      _ = ‖toLp (annVec f u)‖ * ‖toLp u‖ := mul_comm _ _
      _ ≤ _ := hbound
  rw [hsplit, Complex.add_re]
  calc |(inner ℂ (toLp u) (toLp (creVec f u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (annVec f u)) : ℂ).re|
      ≤ |(inner ℂ (toLp u) (toLp (creVec f u)) : ℂ).re|
        + |(inner ℂ (toLp u) (toLp (annVec f u)) : ℂ).re| := abs_add_le _ _
    _ ≤ 2 * l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by linarith
