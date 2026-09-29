-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.compress_aeval_comp_intertwine
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_compress_pow_comp_intertwine
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y) (p : Polynomial ℂ) :
    (Polynomial.aeval (compress Vm X) p).comp J
      = J.comp (Polynomial.aeval (compress Vn X) p) := by

  induction p using Polynomial.induction_on' with
  | add p q hp hq =>
      simp [map_add, ContinuousLinearMap.add_comp, ContinuousLinearMap.comp_add, hp, hq]
  | monomial k c =>
      have h := compress_pow_comp_intertwine Vn Vm J X hJ hVm hJJ hinvn k
      ext x
      have hx := congrArg (fun f : F →L[ℂ] G => f x) h
      simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at hx
      simp only [Polynomial.aeval_monomial, ContinuousLinearMap.coe_comp', Function.comp_apply,
        ContinuousLinearMap.mul_apply]
      rw [hx]
      simp [Algebra.algebraMap_eq_smul_one]
