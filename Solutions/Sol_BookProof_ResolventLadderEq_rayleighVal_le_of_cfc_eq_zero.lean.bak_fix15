-- Generated from ChapterResolventMinMaxEquality.lean — solution of BookProof.ResolventLadderEq.rayleighVal_le_of_cfc_eq_zero
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
open BookProof.ResolventLadderEq



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.MinMaxSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    (q : ℝ → ℝ) (hq : Continuous q) (c : ℝ)
    (hbd : ∀ μ ∈ spectrum ℝ A, μ ≤ c + μ * q μ) {x : F} (hx : cfc q A x = 0) :
    rayleighVal A x ≤ c * ‖x‖ ^ 2 := by

  have hle : cfc (fun t : ℝ => t) A ≤ cfc (fun t : ℝ => c + t * q t) A :=
    (cfc_le_iff _ _ A (by fun_prop) (by fun_prop) hA).mpr hbd
  rw [cfc_id' ℝ A, cfc_add A (fun _ : ℝ => c) (fun t : ℝ => t * q t) (by fun_prop) (by fun_prop),
    cfc_mul (fun t : ℝ => t) q A (by fun_prop) hq.continuousOn, cfc_id' ℝ A,
    cfc_const (R := ℝ) c A] at hle
  have hkey := re_inner_mono_of_le hle x
  have hval : ((algebraMap ℝ (F →L[ℂ] F)) c + A * cfc q A) x = (c : ℂ) • x := by
    simp [Algebra.algebraMap_eq_smul_one, hx]
  rw [hval, inner_smul_right, inner_self_eq_norm_sq_to_K] at hkey
  simpa [rayleighVal, ← Complex.ofReal_pow, ← Complex.ofReal_mul] using hkey
