-- Generated from ChapterConservative.lean — theorem BookProof.ChapterConservative.timeEvo_mem_unitaryGroup
import Mathlib
import Definitions.Def_ChapterConservative
open BookProof.ChapterConservative

variable {n : Type*} [Fintype n] [DecidableEq n]


open scoped Matrix



theorem BookProof.ChapterConservative.timeEvo_mem_unitaryGroup (H : Matrix n n ℂ) (hH : H.IsHermitian) (t : ℝ) :
    timeEvo H t ∈ Matrix.unitaryGroup n ℂ := by sorry
