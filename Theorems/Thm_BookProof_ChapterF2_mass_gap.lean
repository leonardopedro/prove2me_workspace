-- Generated from ChapterF2.lean — theorem BookProof.ChapterF2.mass_gap
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

theorem BookProof.ChapterF2.mass_gap (ψ : ℂ[X]) (hψ : ψ.coeff 0 = 0) :
    (bargmann ψ ψ).re ≤ (bargmann ψ (numberOp ψ)).re := by sorry
