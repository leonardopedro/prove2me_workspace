-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.lc1_shift
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset
open BookProof.HermiteCarleman

noncomputable section


theorem BookProof.CarlemanTwoStep.lc1_shift (i : Fin d) (a : Fin d →₀ ℕ) :
    lc1 (a + Finsupp.single i 1) i = rc1 a i := by sorry
