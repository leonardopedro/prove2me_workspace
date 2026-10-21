-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.constOnePart_symmetricOn
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
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
theorem solution (b : HilbertBasis ℕ ℂ F) (m : ℝ) :
    SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp (constOnePart b m)) := by

  intro x y
  simp only [constOnePart, LinearMap.coe_comp, Function.comp_apply, Submodule.subtype_apply,
    LinearMap.smul_apply, LinearMap.id_apply, Submodule.coe_smul, inner_smul_left,
    inner_smul_right, Complex.conj_ofReal]
