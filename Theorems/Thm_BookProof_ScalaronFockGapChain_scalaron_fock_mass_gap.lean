-- Generated from ChapterScalaronFockGapChain.lean — theorem BookProof.ScalaronFockGapChain.scalaron_fock_mass_gap
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterA4
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.HermiteCore
open BookProof.YangMillsFriedrichs
open BookProof.ScalaronFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore

theorem BookProof.ScalaronFockGapChain.scalaron_fock_mass_gap {alpha : ℝ} (halpha : 0 < alpha) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (opCol hermiteBasis (scalaronOnePart alpha)))
          A) ∧
      dGamma (opCol hermiteBasis (scalaronOnePart alpha)) vac = 0 ∧
      (∀ u : FockAlg, u 0 = 0 →
        scalaronMass alpha * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u)
              (toLp (dGamma (opCol hermiteBasis (scalaronOnePart alpha)) u)) : ℂ).re) ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u)
            (toLp (dGamma (opCol hermiteBasis (scalaronOnePart alpha)) u)) : ℂ).re := by sorry
