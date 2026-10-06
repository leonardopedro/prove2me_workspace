-- Generated from ChapterFiniteArithmeticPrior.lean — theorem BookProof.ChapterFiniteArithmeticPrior.truncMul_saturates
import Mathlib
import Definitions.Def_ChapterFiniteArithmeticPrior
open BookProof.ChapterFiniteArithmeticPrior

theorem BookProof.ChapterFiniteArithmeticPrior.truncMul_saturates {B : ℕ} [NeZero B] (a b : Fin B)
    (h : ¬ (a : ℕ) * (b : ℕ) < B) :
    (((truncMul B).result a b : Fin B) : ℕ) = B - 1 := by sorry
