-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.posForm_cauchy_schwarz
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_sq_le_mul_of_quadratic_nonneg
import Theorems.Thm_BookProof_ResolventLadder_re_inner_symm_of_selfAdjoint
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {R : F →L[ℂ] F} (hsa : IsSelfAdjoint R)
    (hpos : ∀ x : F, 0 ≤ (inner ℂ x (R x) : ℂ).re) (x y : F) :
    ((inner ℂ x (R y) : ℂ).re) ^ 2 ≤ (inner ℂ x (R x) : ℂ).re * (inner ℂ y (R y) : ℂ).re := by

  refine sq_le_mul_of_quadratic_nonneg (hpos y) fun t => ?_
  have hsymm := re_inner_symm_of_selfAdjoint hsa x y
  have hexp : (inner ℂ (x + (t : ℂ) • y) (R (x + (t : ℂ) • y)) : ℂ).re
      = (inner ℂ x (R x) : ℂ).re + 2 * t * (inner ℂ x (R y) : ℂ).re
        + t ^ 2 * (inner ℂ y (R y) : ℂ).re := by
    rw [map_add, ContinuousLinearMap.map_smul, inner_add_left, inner_add_right, inner_add_right,
      inner_smul_left, inner_smul_right, inner_smul_left, inner_smul_right]
    simp only [Complex.add_re, Complex.mul_re, Complex.mul_im, Complex.conj_ofReal,
      Complex.ofReal_re, Complex.ofReal_im]
    rw [hsymm]
    ring
  have hnn := hpos (x + (t : ℂ) • y)
  rw [hexp] at hnn
  exact hnn
