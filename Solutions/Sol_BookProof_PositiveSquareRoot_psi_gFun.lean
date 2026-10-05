-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.psi_gFun
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_den_pos
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {t : ℝ} (ht : t ∈ Set.Icc (0 : ℝ) 1) : psiFun (gFun t) = t := by

  obtain ⟨ht0, ht1⟩ := ht
  have hd : 0 < 1 - t - t + t * t + t * t := den_pos t
  have hdne : (1 - t - t + t * t + t * t) ≠ 0 := ne_of_gt hd
  have hsd : 0 < Real.sqrt (1 - t - t + t * t + t * t) := Real.sqrt_pos.2 hd
  have hs : Real.sqrt (1 - t - t + t * t + t * t) ≠ 0 := ne_of_gt hsd
  have hsq : Real.sqrt (1 - t - t + t * t + t * t) ^ 2 = 1 - t - t + t * t + t * t :=
    Real.sq_sqrt hd.le
  have h1 : Real.sqrt (gFun t) = t / Real.sqrt (1 - t - t + t * t + t * t) := by
    have hrw : gFun t = (t / Real.sqrt (1 - t - t + t * t + t * t)) ^ 2 := by
      rw [div_pow, hsq, gFun, sq]
    rw [hrw]
    exact Real.sqrt_sq (by positivity)
  have h2 : Real.sqrt (1 - gFun t) = (1 - t) / Real.sqrt (1 - t - t + t * t + t * t) := by
    have hval : 1 - gFun t = (1 - t) * (1 - t) / (1 - t - t + t * t + t * t) := by
      rw [gFun, eq_div_iff hdne, sub_mul, div_mul_cancel₀ _ hdne]
      ring
    have hrw : 1 - gFun t = ((1 - t) / Real.sqrt (1 - t - t + t * t + t * t)) ^ 2 := by
      rw [div_pow, hsq, hval, sq]
    rw [hrw]
    refine Real.sqrt_sq ?_
    have h1t : (0:ℝ) ≤ 1 - t := by linarith
    positivity
  rw [psiFun, h1, h2, ← add_div, show t + (1 - t) = 1 by ring, one_div, div_div,
    mul_inv_cancel₀ hs, div_one]
