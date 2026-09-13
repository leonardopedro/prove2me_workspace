-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.norm_sub_smul_ge
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.HermiteGalerkin













open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {D : Submodule ℂ F}












variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) (z : ℂ) (u : F) :
    |z.im| * ‖u‖ ≤ ‖(algebraMap ℂ (F →L[ℂ] F) z - T) u‖ := by

  have h : (inner ℂ (T u) u : ℂ) = inner ℂ u (T u) :=
    (ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hT) u u
  have hsym : (inner ℂ u (T u) : ℂ).im = 0 := by
    refine Complex.conj_eq_iff_im.mp ?_
    rw [inner_conj_symm]
    exact h
  have happ : (algebraMap ℂ (F →L[ℂ] F) z - T) u = z • u - T u := by
    simp [Algebra.algebraMap_eq_smul_one]
  have hinner : (inner ℂ u ((algebraMap ℂ (F →L[ℂ] F) z - T) u) : ℂ).im = z.im * ‖u‖ ^ 2 := by
    rw [happ, inner_sub_right, inner_smul_right, inner_self_eq_norm_sq_to_K, Complex.sub_im,
      hsym, sub_zero, Complex.mul_im]
    simp [← Complex.ofReal_pow]
  have hcs : |(inner ℂ u ((algebraMap ℂ (F →L[ℂ] F) z - T) u) : ℂ).im|
      ≤ ‖u‖ * ‖(algebraMap ℂ (F →L[ℂ] F) z - T) u‖ :=
    le_trans (Complex.abs_im_le_norm _) (norm_inner_le_norm _ _)
  rw [hinner] at hcs
  rcases eq_or_lt_of_le (norm_nonneg u) with h0 | hpos
  · simp [← h0]
  · rw [abs_mul, abs_of_nonneg (by positivity : (0:ℝ) ≤ ‖u‖ ^ 2)] at hcs
    nlinarith [hcs, hpos]
