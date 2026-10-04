-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.annPoly_eq_coreD
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterA4
open BookProof.HermiteProductBasis
open BookProof.QgHermiteFriedrichs
open BookProof.HermiteLadder

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section


theorem BookProof.HermiteLadder.annPoly_eq_coreD (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    annPoly i p = coreD i p + C (1 / 2 : ℂ) * (X i * p) := by sorry
