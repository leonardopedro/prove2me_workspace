-- Generated from ChapterF2.lean — theorem BookProof.ChapterF2.bargmann_numberOp_re
import Definitions.Def_ChapterF1
import Mathlib
import Definitions.Def_ChapterF2
import Definitions.Def_ChapterGhostField
open BookProof.GhostField
open BookProof.ChapterF2


open Polynomial Finset
open scoped BigOperators


open BookProof.ChapterF1

noncomputable section

theorem BookProof.ChapterF2.bargmann_numberOp_re (p : ℂ[X]) :
    (bargmann p (numberOp p)).re
      = ∑ n ∈ p.support, ((n : ℝ) * n.factorial) * Complex.normSq (p.coeff n) := by sorry
