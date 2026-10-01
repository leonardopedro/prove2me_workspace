-- Generated from ChapterH8Bases.lean — solution of BookProof.ChapterH8.krylov_li_of_le
import Mathlib
import Definitions.Def_ChapterH8Bases
import Theorems.Thm_BookProof_ChapterH8_li_Fin_of_le
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

set_option maxHeartbeats 1000000 in
 in
theorem solution {H : E →ₗ[ℂ] E} {v : E} {m n : ℕ} (hmn : m ≤ n)
    (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v)) :
    LinearIndependent ℂ (fun i : Fin m => (H ^ (i : ℕ)) v) :=
  li_Fin_of_le (fun :=
   k : ℕ => (H ^ k) v) hmn hli
  
  omit [CompleteSpace
