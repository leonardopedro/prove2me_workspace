-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.res_re_inner_nonneg
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_res_mem
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_nonneg
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
theorem solution (hT : IsNonnegSelfAdjoint T) (x : F) : 0 ≤ rayleighVal (res hT) x := by

  have hre : 0 ≤ (inner ℂ (res hT x) (x - res hT x) : ℂ).re := hT.nonneg _ (res_mem hT x)
  have hsplit : (inner ℂ (res hT x) (x - res hT x) : ℂ).re
      = (inner ℂ (res hT x) x : ℂ).re - ‖res hT x‖ ^ 2 := by
    rw [inner_sub_right, Complex.sub_re, inner_self_eq_norm_sq_to_K]
    norm_cast
  have hsymm : (inner ℂ x (res hT x) : ℂ).re = (inner ℂ (res hT x) x : ℂ).re := by
    rw [← inner_conj_symm, Complex.conj_re]
  have hnn : (0:ℝ) ≤ ‖res hT x‖ ^ 2 := sq_nonneg _
  rw [rayleighVal, hsymm]
  linarith [hsplit ▸ hre]
