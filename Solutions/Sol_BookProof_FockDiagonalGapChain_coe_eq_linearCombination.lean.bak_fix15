-- Generated from ChapterFockDiagonalGapChain.lean — solution of BookProof.FockDiagonalGapChain.coe_eq_linearCombination
import Mathlib
import Definitions.Def_ChapterFockDiagonalGapChain
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
theorem solution (b : HilbertBasis ℕ ℂ F) (x : finiteModeDomain b) :
    (x : F) = Finsupp.linearCombination ℂ (⇑b) ((modeBasis b).repr x) := by

  calc (x : F)
      = ((Finsupp.linearCombination ℂ (⇑(modeBasis b)) ((modeBasis b).repr x) :
          finiteModeDomain b) : F) := by
        rw [(modeBasis b).linearCombination_repr x]
    _ = Finsupp.linearCombination ℂ (⇑b) ((modeBasis b).repr x) := by
        simp only [Finsupp.linearCombination_apply, Finsupp.sum,
          AddSubmonoidClass.coe_finset_sum, Submodule.coe_smul, modeBasis_coe]
