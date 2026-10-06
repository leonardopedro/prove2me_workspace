-- Generated from ChapterFiniteArithmeticPrior.lean — solution of BookProof.ChapterFiniteArithmeticPrior.truncMul_eq_mul
import Mathlib
import Definitions.Def_ChapterFiniteArithmeticPrior
open BookProof.ChapterFiniteArithmeticPrior

set_option maxHeartbeats 1000000 in
theorem solution {B : ℕ} [NeZero B] (a b : Fin B) (h : (a : ℕ) * (b : ℕ) < B) :
    (((truncMul B).result a b : Fin B) : ℕ) = (a : ℕ) * (b : ℕ) := by

  simp [truncMul, h]
