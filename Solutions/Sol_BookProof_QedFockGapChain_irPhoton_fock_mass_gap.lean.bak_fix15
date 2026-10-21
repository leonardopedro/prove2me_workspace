-- Generated from ChapterQedFockGapChain.lean — solution of BookProof.QedFockGapChain.irPhoton_fock_mass_gap
import Mathlib
import Definitions.Def_ChapterQedFockGapChain
import Theorems.Thm_BookProof_QedFockGapChain_irPhotonDispersion_ge
import Theorems.Thm_BookProof_FockDiagonalGapChain_diag_fock_mass_gap
open BookProof.QedFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FarisLavine
open BookProof.HermiteGalerkin BookProof.HermiteCore
open BookProof.FockDiagonalGapChain BookProof.YangMillsFriedrichs
open MeasureTheory


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {mu : ℝ} (hmu : 0 < mu) (p : ℕ → ℝ) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension
          (dGammaOp (opCol hermiteBasis
            (diagOnePart hermiteBasis (irPhotonDispersion mu p)))) A) ∧
      dGamma (opCol hermiteBasis (diagOnePart hermiteBasis (irPhotonDispersion mu p))) vac
          = 0 ∧
      (∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma
              (opCol hermiteBasis
                (diagOnePart hermiteBasis (irPhotonDispersion mu p))) u)) : ℂ).re) ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma
            (opCol hermiteBasis
              (diagOnePart hermiteBasis (irPhotonDispersion mu p))) u)) : ℂ).re := diag_fock_mass_gap hermiteBasis (irPhotonDispersion mu p) hmu (irPhotonDispersion_ge mu p)
