-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.rc2_nonneg
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset
open BookProof.HermiteCarleman

noncomputable section


theorem BookProof.CarlemanTwoStep.rc2_nonneg (a : Fin d →₀ ℕ) (i : Fin d) : 0 ≤ rc2 a i := by sorry
