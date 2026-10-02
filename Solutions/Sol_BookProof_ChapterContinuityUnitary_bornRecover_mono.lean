-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.bornRecover_mono
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
h]

theorem solution (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    {B C : Finset (ZMod N)} (h : B ⊆ C) :
    bornRecover v t psi B ≤ bornRecover v t psi C :=
  Finset.sum_le_sum_of_subset_of_nonneg h fun _ _ _ => by positivity

/-- A unitary matrix preserves the `ℓ²` mass of a vector. -/
theorem unitary_preserves_normSq {n : Type*} [Fintype n] :=
  [DecidableEq n]
      (U : Matrix n n ℂ) (hU : Uᴴ * U = 1) (psi : n → ℂ) :
      ∑ a, ‖(U *ᵥ psi) a‖ ^ 2 = ∑ a, ‖psi a‖ ^ 2 := by
    have expand : ∀
