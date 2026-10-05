-- Generated from ChapterF2.lean — theorem BookProof.ChapterF2.numberOp_coeff
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

theorem BookProof.ChapterF2.numberOp_coeff (p : ℂ[X]) (n : ℕ) :
    (numberOp p).coeff n = (n : ℂ) * p.coeff n := by sorry
