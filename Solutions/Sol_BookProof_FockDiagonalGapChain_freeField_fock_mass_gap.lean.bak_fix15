-- Generated from ChapterFockDiagonalGapChain.lean — solution of BookProof.FockDiagonalGapChain.freeField_fock_mass_gap
import Mathlib
import Definitions.Def_ChapterFockDiagonalGapChain
import Theorems.Thm_BookProof_FockDiagonalGapChain_diag_fock_mass_gap
import Theorems.Thm_BookProof_FockDiagonalGapChain_freeDispersion_ge
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
theorem solution {m : ℝ} (hm : 0 < m) (p : ℕ → ℝ) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension
          (dGammaOp (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p)))) A) ∧
      dGamma (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p))) vac = 0 ∧
      (∀ u : FockAlg, u 0 = 0 →
        m * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma
              (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p))) u)) : ℂ).re) ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma
            (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p))) u)) : ℂ).re := diag_fock_mass_gap hermiteBasis (freeDispersion m p) hm (freeDispersion_ge hm.le p)
