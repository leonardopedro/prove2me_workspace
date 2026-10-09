-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.const_fock_mass_gap
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Theorems.Thm_BookProof_ScalaronFockGapChain_constOnePart_quadForm
import Theorems.Thm_BookProof_ScalaronFockGapChain_constOnePart_symmetricOn
import Theorems.Thm_BookProof_ScalaronFockGapChain_const_fock_gap
import Theorems.Thm_BookProof_FockSecondQuantization_secondQuantization_friedrichs
import Theorems.Thm_BookProof_FockSecondQuantization_toLp_zero
import Theorems.Thm_toLp_injective
open BookProof.ScalaronFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) {m : ℝ} (hm : 0 < m) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (opCol b (constOnePart b m))) A) ∧
      dGamma (opCol b (constOnePart b m)) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma (opCol b (constOnePart b m)) u)) : ℂ).re := by

  obtain ⟨hvac, hgap⟩ := const_fock_gap b hm.le
  refine ⟨?_, hvac, fun u h0 hu => ?_⟩
  · refine secondQuantization_friedrichs b (constOnePart b m) (constOnePart_symmetricOn b m)
      fun x => ?_
    rw [constOnePart_quadForm]
    have : (0 : ℝ) ≤ ‖(x : F)‖ ^ 2 := sq_nonneg _
    nlinarith
  · have hnorm : 0 < ‖toLp u‖ := by
      have : toLp u ≠ 0 := fun hc => hu (toLp_injective (by simpa using hc))
      exact norm_pos_iff.mpr this
    have hquad := hgap u h0
    have hpos : 0 < m * ‖toLp u‖ ^ 2 := by positivity
    linarith
