-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.constOnePart_symmetricOn
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockCubicQuarticStability
import Definitions.Def_ChapterFockCubicUnbounded
import Definitions.Def_ChapterFockInteractionStability
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.ScalaronFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (m : ℝ) :
    SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp (constOnePart b m)) := by

  intro x y
  simp only [constOnePart, LinearMap.coe_comp, Function.comp_apply, Submodule.subtype_apply,
    LinearMap.smul_apply, LinearMap.id_apply, Submodule.coe_smul, inner_smul_left,
    inner_smul_right, Complex.conj_ofReal]
