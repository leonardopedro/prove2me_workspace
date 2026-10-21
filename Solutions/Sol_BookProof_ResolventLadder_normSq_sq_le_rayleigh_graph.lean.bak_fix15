-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.normSq_sq_le_rayleigh_graph
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_normSq_sq_le_rayleigh_mul
import Theorems.Thm_BookProof_ResolventLadder_res_eq_of_mem
import Theorems.Thm_BookProof_ResolventLadder_res_isSelfAdjoint
import Theorems.Thm_BookProof_ResolventLadder_res_re_inner_nonneg
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) {y z : F} (hyz : (y, z) ∈ T) :
    ‖y‖ ^ 4 ≤ (‖y‖ ^ 2 + (inner ℂ y z : ℂ).re) * rayleighVal (res hT) y := by

  have hx : res hT (y + z) = y := res_eq_of_mem hT hyz
  have hmain := normSq_sq_le_rayleigh_mul (res_isSelfAdjoint hT) (res_re_inner_nonneg hT) (y + z)
  rw [hx] at hmain
  have hA : rayleighVal (res hT) (y + z) = ‖y‖ ^ 2 + (inner ℂ y z : ℂ).re := by
    rw [rayleighVal, hx, inner_add_left, Complex.add_re, inner_self_eq_norm_sq_to_K]
    have hzy : (inner ℂ z y : ℂ).re = (inner ℂ y z : ℂ).re := by
      rw [← inner_conj_symm, Complex.conj_re]
    rw [hzy]
    norm_cast
  rw [hA] at hmain
  exact hmain
