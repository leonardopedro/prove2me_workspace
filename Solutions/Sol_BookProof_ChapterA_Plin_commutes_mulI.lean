-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.Plin_commutes_mulI
import Mathlib
import Definitions.Def_ChapterA2c
import Theorems.Thm_BookProof_ChapterA_Plin_mulI_comm
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (S : V →L[ℝ] V) (x : V) :
    Plin S (Complex.I • x) = Complex.I • Plin S x := by

  have := congr_arg (fun T => T x) (Plin_mulI_comm S)
  simpa [ContinuousLinearMap.mul_apply] using this.symm
