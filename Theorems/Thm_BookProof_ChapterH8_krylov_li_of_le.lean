-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.krylov_li_of_le
import Mathlib
import Definitions.Def_ChapterH8Bases
open BookProof.ChapterH8

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

 in
theorem BookProof.ChapterH8.krylov_li_of_le {H : E →ₗ[ℂ] E} {v : E} {m n : ℕ} (hmn : m ≤ n)
    (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v)) :
    LinearIndependent ℂ (fun i : Fin m => (H ^ (i : ℕ)) v) :=
  li_Fin_of_le (fun := by sorry
