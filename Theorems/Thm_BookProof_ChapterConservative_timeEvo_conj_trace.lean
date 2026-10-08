-- Generated from ChapterConservative.lean — theorem BookProof.ChapterConservative.timeEvo_conj_trace
import Mathlib
import Definitions.Def_ChapterConservative
open BookProof.ChapterConservative


open scoped Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]


theorem BookProof.ChapterConservative.timeEvo_conj_trace (H : Matrix n n ℂ) (hH : H.IsHermitian) (t : ℝ)
    (ρ : Matrix n n ℂ) :
    (timeEvo H t * ρ * (timeEvo H t)ᴴ).trace = ρ.trace := by sorry
