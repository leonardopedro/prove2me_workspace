-- Generated from ChapterFockDiagonalGapChain.lean — solution of BookProof.FockDiagonalGapChain.norm_sq_eq_sum
import Mathlib
import Definitions.Def_ChapterFockDiagonalGapChain
import Theorems.Thm_BookProof_FockDiagonalGapChain_conj_mul_ofReal
import Theorems.Thm_BookProof_FockDiagonalGapChain_inner_self_ofReal
import Theorems.Thm_BookProof_FockDiagonalGapChain_coe_eq_linearCombination
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
    ‖(x : F)‖ ^ 2 = ∑ i ∈ ((modeBasis b).repr x).support, ‖(modeBasis b).repr x i‖ ^ 2 := by

  have h : ((‖(x : F)‖ ^ 2 : ℝ) : ℂ)
      = ((∑ i ∈ ((modeBasis b).repr x).support, ‖(modeBasis b).repr x i‖ ^ 2 : ℝ) : ℂ) := by
    have h1 : (inner ℂ (x : F) (x : F) : ℂ) = ((‖(x : F)‖ ^ 2 : ℝ) : ℂ) :=
      inner_self_ofReal (x : F)
    rw [← h1, coe_eq_linearCombination b x, b.orthonormal.inner_finsupp_eq_sum_left]
    simp only [Finsupp.sum]
    push_cast
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [conj_mul_ofReal]
    push_cast
    ring
  exact_mod_cast h
