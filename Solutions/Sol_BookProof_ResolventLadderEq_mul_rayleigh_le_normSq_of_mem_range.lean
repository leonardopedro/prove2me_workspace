-- Generated from ChapterResolventMinMaxEquality.lean — solution of BookProof.ResolventLadderEq.mul_rayleigh_le_normSq_of_mem_range
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
    (hbd : ∀ μ ∈ spectrum ℝ A, c * (μ * (q μ * q μ)) ≤ (μ * q μ) * (μ * q μ)) (y : F) :
    c * rayleighVal A (cfc q A y) ≤ ‖A (cfc q A y)‖ ^ 2 := by

  have hAB : cfc (fun t => c * (t * (q t * q t))) A
      ≤ cfc (fun t => (t * q t) * (t * q t)) A :=
    (cfc_le_iff _ _ A (by fun_prop) (by fun_prop) hA).mpr hbd
  have hkey := re_inner_mono_of_le hAB y
  have hL : (inner ℂ y ((cfc (fun t => c * (t * (q t * q t))) A) y) : ℂ).re
      = c * rayleighVal A (cfc q A y) := by
    rw [cfc_const_mul _ _ A (by fun_prop)]
    have h2 : (inner ℂ y ((c • cfc (fun t => t * (q t * q t)) A) y) : ℂ)
        = (c : ℂ) * inner ℂ y ((cfc (fun t => t * (q t * q t)) A) y) := by
      simp [ContinuousLinearMap.smul_apply]
    rw [h2, ← inner_range_eq A hA q hq y, Complex.re_ofReal_mul, rayleighVal]
  have hcfc : cfc (fun t : ℝ => t * q t) A = A * cfc q A := by
    rw [cfc_mul (fun t : ℝ => t) q A (by fun_prop) hq.continuousOn, cfc_id' ℝ A]
  have hR : (inner ℂ y ((cfc (fun t => (t * q t) * (t * q t)) A) y) : ℂ).re
      = ‖A (cfc q A y)‖ ^ 2 := by
    have h := norm_range_eq A (fun t : ℝ => t * q t) (by fun_prop) y
    rw [hcfc] at h
    rw [← h, Complex.ofReal_re]
    rfl
  rw [hL, hR] at hkey
  exact hkey
