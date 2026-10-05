-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.bilC_conj
import Mathlib
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (A M : Matrix (Fin 4) (Fin 4) ℂ) (x : Fin 4 → ℂ) :
    bilC (Aᵀ * M * A) x = bilC M (fun i => ∑ j, A i j * x j) := by

  unfold bilC; simp [ Matrix.mul_apply, Fin.sum_univ_four ] ; ring!;
