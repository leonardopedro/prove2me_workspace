-- Generated from ChapterWeylHamiltonian.lean — solution of BookProof.WeylHamiltonian.smul_nonneg_isPositive
import Mathlib
import Definitions.Def_ChapterWeylHamiltonian
open BookProof.WeylHamiltonian




open ContinuousLinearMap
open scoped BigOperators

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : H →L[ℂ] H) (h : T.IsPositive)
    {c : ℝ} (hc : 0 ≤ c) : ((c : ℂ) • T).IsPositive := by

  constructor
  · intro x y
    simp only [Complex.coe_smul, FunLike.coe_smul, LinearMap.smul_apply, coe_coe]
    have hinner := h.1 x y
    simp only [coe_coe, Complex.real_smul] at hinner ⊢
    calc
      inner ℂ (c • T x) y = c * inner ℂ (T x) y := by simpa using congr_arg (fun z => c • z) hinner
      _ = c * inner ℂ x (T y) := by rw [hinner]
      _ = inner ℂ x (c • T y) := by simpa using congr_arg (fun z => c • z) hinner
  · simp only [reApplyInnerSelf, Complex.coe_smul, FunLike.coe_smul, Pi.smul_apply,
      RCLike.re_t
