-- Generated from ChapterScalaronFockGapChain.lean — theorem BookProof.ScalaronFockGapChain.scalaron_fock_gap_of_field_perturbation
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterA4
open BookProof.FockSecondQuantization
open BookProof.HermiteCore
open BookProof.ScalaronFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore

theorem BookProof.ScalaronFockGapChain.scalaron_fock_gap_of_field_perturbation {alpha : ℝ} (halpha : 0 < alpha)
    {f : ℕ →₀ ℂ} (hf : 2 * l2norm f < scalaronMass alpha) {u : FockAlg} (h0 : u 0 = 0) :
    0 < scalaronMass alpha - 2 * l2norm f ∧
      (scalaronMass alpha - 2 * l2norm f) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u)
              (toLp (dGamma (opCol hermiteBasis (scalaronOnePart alpha)) u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re := by sorry
