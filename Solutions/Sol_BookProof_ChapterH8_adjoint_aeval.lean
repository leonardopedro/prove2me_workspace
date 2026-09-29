-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.adjoint_aeval
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F) (p : Polynomial ℂ) :
    adjoint (Polynomial.aeval A p) = Polynomial.aeval (adjoint A) (p.map (starRingEnd ℂ)) := by

  induction p using Polynomial.induction_on' with
  | add p q hp hq => simp [Polynomial.map_add, hp, hq]
  | monomial k c =>
      simp [Polynomial.aeval_monomial, Algebra.algebraMap_eq_smul_one, ← star_eq_adjoint,
        star_pow, Polynomial.map_monomial]
