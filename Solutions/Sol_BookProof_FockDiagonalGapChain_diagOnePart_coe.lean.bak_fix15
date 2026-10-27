-- Generated from ChapterFockDiagonalGapChain.lean — solution of BookProof.FockDiagonalGapChain.diagOnePart_coe
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
theorem solution (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) (x : finiteModeDomain b) :
    ((diagOnePart b w x : finiteModeDomain b) : F)
      = ∑ i ∈ ((modeBasis b).repr x).support,
          (((w i : ℝ) : ℂ) * ((modeBasis b).repr x i)) • b i := by

  rw [diagOnePart, Basis.constr_apply, Finsupp.sum, AddSubmonoidClass.coe_finset_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Submodule.coe_smul, Submodule.coe_smul, modeBasis_coe, smul_smul,
    mul_comm ((modeBasis b).repr x i) (((w i : ℝ) : ℂ))]
