-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.normSq_sq_le_rayleigh_mul
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_posForm_cauchy_schwarz
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
    (hpos : ∀ x : F, 0 ≤ (inner ℂ x (R x) : ℂ).re) (x : F) :
    ‖R x‖ ^ 4 ≤ rayleighVal R x * rayleighVal R (R x) := by

  have hmid : (inner ℂ x (R (R x)) : ℂ).re = ‖R x‖ ^ 2 := by
    have h := (ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hsa) x (R x)
    simp only [ContinuousLinearMap.coe_coe] at h
    rw [← h, inner_self_eq_norm_sq_to_K]
    norm_cast
  have h := posForm_cauchy_schwarz hsa hpos x (R x)
  rw [hmid] at h
  calc ‖R x‖ ^ 4 = (‖R x‖ ^ 2) ^ 2 := by ring
    _ ≤ rayleighVal R x * rayleighVal R (R x) := h
