-- Generated from ChapterFiniteArithmeticPrior.lean — theorem BookProof.ChapterFiniteArithmeticPrior.truncMul_extension_consistent
import Mathlib
import Definitions.Def_ChapterFiniteArithmeticPrior
open BookProof.ChapterFiniteArithmeticPrior

theorem BookProof.ChapterFiniteArithmeticPrior.truncMul_extension_consistent {B : ℕ} [NeZero B] {H : Type*} [Fintype H]
    (E : BayesianArithmeticExtension B H) (hE : E.known = truncMul B)
    (a b : Fin B) (h : (a : ℕ) * (b : ℕ) < B) :
    ((E.known.result a b : Fin B) : ℕ) = (a : ℕ) * (b : ℕ) ∧
      (∀ x, 0 ≤ E.prior x) ∧ ∑ x, E.prior x = 1 := by sorry
