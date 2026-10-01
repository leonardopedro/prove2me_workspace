-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.bornRecover_mono
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]


open scoped BigOperators Matrix TensorProduct



h]

theorem BookProof.ChapterContinuityUnitary.bornRecover_mono (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    {B C : Finset (ZMod N)} (h : B ⊆ C) :
    bornRecover v t psi B ≤ bornRecover v t psi C :=
  Finset.sum_le_sum_of_subset_of_nonneg h fun _ _ _ => by positivity

/-- A unitary matrix preserves the `ℓ²` mass of a vector. -/
theorem unitary_preserves_normSq {n : Type*} [Fintype n] := by sorry
