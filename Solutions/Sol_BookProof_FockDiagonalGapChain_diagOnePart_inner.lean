-- Generated from ChapterFockDiagonalGapChain.lean — solution of BookProof.FockDiagonalGapChain.diagOnePart_inner
import Mathlib
import Definitions.Def_ChapterFockDiagonalGapChain
import Theorems.Thm_BookProof_FockDiagonalGapChain_coe_eq_linearCombination
import Theorems.Thm_BookProof_FockDiagonalGapChain_diagOnePart_coe
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
theorem solution (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) (x y : finiteModeDomain b) :
    (inner ℂ (x : F) ((diagOnePart b w y : finiteModeDomain b) : F) : ℂ)
      = ∑ i ∈ ((modeBasis b).repr y).support,
          ((w i : ℝ) : ℂ) * (starRingEnd ℂ ((modeBasis b).repr x i)) *
            ((modeBasis b).repr y i) := by

  rw [diagOnePart_coe, inner_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [inner_smul_right, coe_eq_linearCombination b x, b.orthonormal.inner_left_finsupp]
  ring
