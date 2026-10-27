-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.tendsto_smul_resAt
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_tendsto_smul_invCLMAt
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (h : F) :
    Filter.Tendsto (fun n : ℕ => (((n : ℝ) + 1 : ℝ) : ℂ) • resAt hT n h) Filter.atTop
      (nhds h) := by

  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨A, hA, hbound⟩ := tendsto_smul_invCLMAt hT hsv h hε
  refine ⟨⌈A⌉₊, fun n hn => ?_⟩
  have hc : (0 : ℝ) < (n : ℝ) + 1 := by positivity
  have hAc : A ≤ (n : ℝ) + 1 := by
    have h1 : A ≤ (⌈A⌉₊ : ℝ) := Nat.le_ceil A
    have h2 : ((⌈A⌉₊ : ℕ) : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
    linarith
  rw [dist_eq_norm]
  exact hbound ((n : ℝ) + 1) hc hAc
