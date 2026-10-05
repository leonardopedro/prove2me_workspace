-- Generated from ChapterF2.lean — theorem BookProof.ChapterF2.bargmann_self_re
import Definitions.Def_ChapterF1
import Mathlib
import Definitions.Def_ChapterF2
open BookProof.ChapterF2


open Polynomial Finset
open scoped BigOperators


open BookProof.ChapterF1

noncomputable section

theorem BookProof.ChapterF2.bargmann_self_re (p : ℂ[X]) :
    (bargmann p p).re = ∑ n ∈ p.support, (n.factorial : ℝ) * Complex.normSq (p.coeff n) := by sorry
