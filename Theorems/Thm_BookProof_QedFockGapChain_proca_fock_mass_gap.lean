-- Generated from ChapterQedFockGapChain.lean — theorem BookProof.QedFockGapChain.proca_fock_mass_gap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockDiagonalGapChain
import Mathlib
import Definitions.Def_ChapterQedFockGapChain
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.HermiteCore
open BookProof.YangMillsFriedrichs
open BookProof.QedFockGapChain


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FarisLavine
open BookProof.HermiteGalerkin BookProof.HermiteCore
open BookProof.FockDiagonalGapChain BookProof.YangMillsFriedrichs
open MeasureTheory


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


theorem BookProof.QedFockGapChain.proca_fock_mass_gap {m : ℝ} (hm : 0 < m) (p : ℕ → ℝ) :
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
            (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p))) u)) : ℂ).re := by sorry
