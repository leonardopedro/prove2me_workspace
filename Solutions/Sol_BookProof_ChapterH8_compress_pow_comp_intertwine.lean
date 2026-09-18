-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.compress_pow_comp_intertwine
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_compress_comp_intertwine
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J)
    (hVm : (adjoint Vm).comp Vm = ContinuousLinearMap.id ℂ G)
    (hJJ : (adjoint J).comp J = ContinuousLinearMap.id ℂ F)
    (hinvn : ∀ x : F, ∃ y : F, X (Vn x) = Vn y) (k : ℕ) :
    ((compress Vm X) ^ k).comp J = J.comp ((compress Vn X) ^ k) := by

  have hstep := compress_comp_intertwine Vn Vm J X hJ hVm hJJ hinvn
  induction k with
  | zero => ext x; simp
  | succ k ih =>
    ext x
    have h1 : ((compress Vm X) ^ (k + 1)) (J x)
        = ((compress Vm X) ^ k) ((compress Vm X) (J x)) := by
      rw [pow_succ]
      rfl
    have h2 : J (((compress Vn X) ^ (k + 1)) x)
        = J (((compress Vn X) ^ k) ((compress Vn X) x)) := by
      rw [pow_succ]
      rfl
    have hs : (compress Vm X) (J x) = J ((compress Vn X) x) :=
      congrArg (fun f : F →L[ℂ] G => f x) hstep
    have hi := congrArg (fun f : F →L[ℂ] G => f ((compress Vn X) x)) ih
    simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at hi ⊢
    rw [h1, h2, hs, hi]
