-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.inner_invCLMAt_left
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_mem
import Theorems.Thm_BookProof_PositiveSquareRoot_symm_inner
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h k : F) :
    (inner ℂ (invCLMAt hT ha h) k : ℂ) = inner ℂ h (invCLMAt hT ha k) := by

  have h1 := invCLMAt_mem hT ha h
  have h2 := invCLMAt_mem hT ha k
  set x := invCLMAt hT ha h with hxdef
  set u := invCLMAt hT ha k with hudef
  have hs : (inner ℂ (k - (a : ℂ) • u) x : ℂ) = inner ℂ u (h - (a : ℂ) • x) :=
    symm_inner hT h1 h2
  have e3 : (inner ℂ x (k - (a : ℂ) • u) : ℂ) = inner ℂ (h - (a : ℂ) • x) u := by
    have := congrArg (starRingEnd ℂ) hs
    rwa [inner_conj_symm, inner_conj_symm] at this
  have e1 : (inner ℂ x k : ℂ)
      = inner ℂ x ((a : ℂ) • u) + inner ℂ x (k - (a : ℂ) • u) := by
    rw [← inner_add_right]; congr 1; abel
  have e2 : (inner ℂ h u : ℂ)
      = inner ℂ ((a : ℂ) • x) u + inner ℂ (h - (a : ℂ) • x) u := by
    rw [← inner_add_left]; congr 1; abel
  have e4 : (inner ℂ x ((a : ℂ) • u) : ℂ) = inner ℂ ((a : ℂ) • x) u := by
    rw [inner_smul_right, inner_smul_left, Complex.conj_ofReal]
  rw [e1, e2, e3, e4]
