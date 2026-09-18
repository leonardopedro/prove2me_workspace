-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.compress_aeval_comp
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH4_compress_pow
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hVV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (hinv : ∀ x : F, ∃ y : F, X (V x) = V y) (p : Polynomial ℂ) :
    (Polynomial.aeval X p).comp V = V.comp (Polynomial.aeval (compress V X) p) := by

  induction p using Polynomial.induction_on' with
  | add p q hp hq =>
      simp [map_add, ContinuousLinearMap.add_comp, ContinuousLinearMap.comp_add, hp, hq]
  | monomial k c =>
      have h := compress_pow V X hVV hinv k
      ext x
      have hx := congrArg (fun f : F →L[ℂ] E => f x) h
      simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at hx
      simp only [Polynomial.aeval_monomial, ContinuousLinearMap.coe_comp', Function.comp_apply,
        ContinuousLinearMap.mul_apply]
      rw [hx]
      simp [Algebra.algebraMap_eq_smul_one]
