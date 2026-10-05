-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.re_inner_symm_of_selfAdjoint
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {R : F →L[ℂ] F} (hsa : IsSelfAdjoint R) (x y : F) :
    (inner ℂ x (R y) : ℂ).re = (inner ℂ y (R x) : ℂ).re := by

  have h := (ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hsa) y x
  simp only [ContinuousLinearMap.coe_coe] at h
  rw [← h, ← inner_conj_symm, Complex.conj_re]
