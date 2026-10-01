-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.rc1_nonneg
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset
open BookProof.HermiteCarleman

noncomputable section


theorem BookProof.CarlemanTwoStep.rc1_nonneg (a : Fin d →₀ ℕ) (i : Fin d) : 0 ≤ rc1 a i := by sorry
