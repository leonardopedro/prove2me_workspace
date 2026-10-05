-- Generated from ChapterScalaronFockGapChain.lean — theorem BookProof.ScalaronFockGapChain.const_fock_gap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockCubicQuarticStability
import Definitions.Def_ChapterFockCubicUnbounded
import Definitions.Def_ChapterFockInteractionStability
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.ScalaronFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore

theorem BookProof.ScalaronFockGapChain.const_fock_gap (b : HilbertBasis ℕ ℂ F) {m : ℝ} (hm : 0 ≤ m) :
    dGamma (opCol b (constOnePart b m)) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        m * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b (constOnePart b m)) u)) : ℂ).re := by sorry
