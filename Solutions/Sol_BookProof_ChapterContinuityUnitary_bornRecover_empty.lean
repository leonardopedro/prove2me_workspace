-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.bornRecover_empty
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
 ‖evolvedState v t psi z‖ ^ 2

theorem solution (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    (B : Finset (ZMod N)) : 0 ≤ bornRecover v t psi B :=
  Finset.sum_nonneg fun _ _ => by positivity

theorem bornRecover_empty (v : ZMod N → :=
  ℝ) (t : ℝ) (psi : ZMod N → ℂ) :
      bornRecover v t psi ∅ = 0 := by simp [bornRecover]
  
  /-- Finite additivity on disjoint sets. -/
  theorem bornRecover_union (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
      {B C : Finset (ZMod N)} (h : Disjoint B C) :
      bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C := by
    simp [bornRecover, Finset.sum_unio
