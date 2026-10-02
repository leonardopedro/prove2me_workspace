-- Generated from ChapterH8Bases.lean — solution of BookProof.ChapterH8.li_Fin_of_le
import Mathlib
import Definitions.Def_ChapterH8Bases
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (f : ℕ → E) {m n : ℕ} (hmn : m ≤ n)
    (hli : LinearIndependent ℂ (fun i : Fin n => f i)) :
    LinearIndependent ℂ (fun i : Fin m => f i) := by

  have h := hli.comp (Fin.castLE hmn) (Fin.castLE_injective hmn)
  exact h
