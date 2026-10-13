-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteInner_eq
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hermiteInner_succ_zero
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in

theorem solution (m n : ℕ) :
    hermiteInner m n = if m = n then (n.factorial : ℝ) * Real.sqrt (2 * Real.pi) else 0 := by
  induction m generalizing n with
  | zero =>
    cases n with
    | zero => simpa using hermiteInner_zero_zero
    | succ n =>
      rw [hermiteInner_comm, hermiteInner_succ_zero]
      simp
  | succ m ih =>
    cases n with
    | zero => simpa using hermiteInner_succ_zero m
    | succ n =>
      rw [hermiteInner_succ_succ, ih n]
      by_cases h : m = n
      · subst h
        simp [Nat.factorial_succ]
        ring
      · simp [h]
