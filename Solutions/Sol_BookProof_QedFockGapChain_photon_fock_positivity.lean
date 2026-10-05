-- Generated from ChapterQedFockGapChain.lean — solution of BookProof.QedFockGapChain.photon_fock_positivity
import Mathlib
import Definitions.Def_ChapterQedFockGapChain
import Theorems.Thm_BookProof_QedFockGapChain_photonDispersion_nonneg
import Theorems.Thm_BookProof_FockDiagonalGapChain_diag_fock_gap
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
theorem solution (p : ℕ → ℝ) :
    dGamma (opCol hermiteBasis (diagOnePart hermiteBasis (photonDispersion p))) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        (0 : ℝ) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma
              (opCol hermiteBasis (diagOnePart hermiteBasis (photonDispersion p))) u)) : ℂ).re := diag_fock_gap hermiteBasis (photonDispersion p) le_rfl (fun k => photonDispersion_nonneg p k)
