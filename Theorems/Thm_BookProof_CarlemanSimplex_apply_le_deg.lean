-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.apply_le_deg
import Definitions.Def_ChapterHermiteCarlemanEsaPromoted
import Definitions.Def_ChapterCarlemanTwoStepPromoted
import Mathlib
import Definitions.Def_ChapterCarlemanSimplexPromoted
import Definitions.Def_ChapterGaussCoreQuadBounds
open BookProof.CarlemanSimplex



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}


theorem BookProof.CarlemanSimplex.apply_le_deg (a : Fin d →₀ ℕ) (i : Fin d) : a i ≤ deg a := by sorry
