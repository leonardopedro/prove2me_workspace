-- Generated from ChapterH7.lean — solution of BookProof.ChapterH7.generatedState_eq_generationOperator
import Mathlib
import Definitions.Def_ChapterH7
open BookProof.ChapterH7



noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (psi0 : Fin m → ℂ) :
    generatedState A (t : ℂ) psi0 = (generationOperator A t).mulVec psi0 := rfl
