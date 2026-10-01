-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.lc2_vanish
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset
open BookProof.HermiteCarleman

noncomputable section


theorem BookProof.CarlemanTwoStep.lc2_vanish (i : Fin d) (a : Fin d →₀ ℕ) (h : a i < 2) : lc2 a i = 0 := by sorry
