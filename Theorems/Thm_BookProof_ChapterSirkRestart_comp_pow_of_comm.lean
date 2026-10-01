-- Generated from ChapterSirkRestart.lean — theorem BookProof.ChapterSirkRestart.comp_pow_of_comm
import Mathlib
import Definitions.Def_ChapterSirkRestart
open BookProof.ChapterSirkRestart

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

 leakage -/

theorem BookProof.ChapterSirkRestart.comp_pow_of_comm (U Om : E →L[ℂ] E) (hcomm : Om.comp U = U.comp Om) (n : ℕ) :
    Om.comp (U ^ n) = (U := by sorry
