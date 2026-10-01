-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.momentum_hermitian
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
theorem solution : (momentum N)ᴴ = momentum N := by

  ext k j
  have h1 : (k = j + 1) ↔ (j = k - 1) := ⟨fun h => by subst h; ring, fun h => by subst h; ring⟩
  have h2 : (k = j - 1) ↔ (j = k + 1) := ⟨fun h => by subst h; ring, fun h => by subst h; ring⟩
  simp only [Matrix.conjTranspose_apply, momentum, star_add, apply_ite (star : ℂ → ℂ),
    star_zero, h1, h2]
  rw [add_comm]
  congr 1 <;> simp
