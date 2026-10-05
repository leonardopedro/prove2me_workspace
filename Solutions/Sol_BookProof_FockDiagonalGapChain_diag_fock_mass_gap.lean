-- Generated from ChapterFockDiagonalGapChain.lean — solution of BookProof.FockDiagonalGapChain.diag_fock_mass_gap
import Mathlib
import Definitions.Def_ChapterFockDiagonalGapChain
import Theorems.Thm_BookProof_FockDiagonalGapChain_diagOnePart_symmetricOn
import Theorems.Thm_BookProof_FockDiagonalGapChain_diagOnePart_quadForm_ge
import Theorems.Thm_BookProof_FockDiagonalGapChain_diag_fock_gap
import Theorems.Thm_BookProof_FockSecondQuantization_secondQuantization_friedrichs
import Theorems.Thm_BookProof_FockSecondQuantization_toLp_zero
import Theorems.Thm_toLp_injective
open BookProof.FockDiagonalGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore BookProof.ScalaronFockGapChain
open Module


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) {m : ℝ} (hm : 0 < m)
    (hw : ∀ k, m ≤ w k) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (opCol b (diagOnePart b w))) A) ∧
      dGamma (opCol b (diagOnePart b w)) vac = 0 ∧
      (∀ u : FockAlg, u 0 = 0 →
        m * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b (diagOnePart b w)) u)) : ℂ).re) ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma (opCol b (diagOnePart b w)) u)) : ℂ).re := by

  obtain ⟨hvac, hgap⟩ := diag_fock_gap b w hm.le hw
  refine ⟨?_, hvac, hgap, fun u h0 hu => ?_⟩
  · refine secondQuantization_friedrichs b (diagOnePart b w) (diagOnePart_symmetricOn b w)
      fun x => ?_
    have h := diagOnePart_quadForm_ge b w hw x
    have hx : (0 : ℝ) ≤ ‖(x : F)‖ ^ 2 := sq_nonneg _
    nlinarith
  · have hnorm : 0 < ‖toLp u‖ := by
      have : toLp u ≠ 0 := fun hc => hu (toLp_injective (by simpa using hc))
      exact norm_pos_iff.mpr this
    have hquad := hgap u h0
    have hpos : 0 < m * ‖toLp u‖ ^ 2 := by positivity
    linarith
