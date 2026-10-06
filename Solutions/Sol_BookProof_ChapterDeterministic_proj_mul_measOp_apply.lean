-- Generated from ChapterDeterministic.lean — solution of BookProof.ChapterDeterministic.proj_mul_measOp_apply
import Mathlib
import Definitions.Def_ChapterDeterministic
open BookProof.ChapterDeterministic



open scoped BigOperators
open Finset Matrix
open BookProof.ChapterReconstruct BookProof.ChapterTimeTranslation


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : Matrix (Fin n) (Fin n) ℂ) (a b i j : Fin n) :
    (proj a * measOp U b) i j =
      if i = a then U a b * (starRingEnd ℂ) (U j b) else 0 := by

  by_cases hij : i = a <;> simp only [mul_apply, ↓reduceIte, hij];
  · unfold proj measOp; simp only [of_apply, true_and, ite_mul, one_mul, zero_mul, sum_ite_eq',
      mem_univ, ↓reduceIte]  ;
    convert measOp_apply U b a j using 1; rfl
  · exact Finset.sum_eq_zero fun k hk => by unfold proj; aesop;
