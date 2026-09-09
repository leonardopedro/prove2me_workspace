-- Generated from ChapterSirkRestart.lean — theorem BookProof.ChapterSirkRestart.brst_leakage_zero_of_exact
import Mathlib
import Definitions.Def_ChapterSirkRestart
open BookProof.ChapterSirkRestart







noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.ChapterSirkRestart.brst_leakage_zero_of_exact (U Om : E →L[ℂ] E)
    (hcomm : Om.comp U = U.comp Om) (n : ℕ) (v : E) (hv : Om v = 0) :
    Om ((U ^ n) v) = 0 := by sorry
