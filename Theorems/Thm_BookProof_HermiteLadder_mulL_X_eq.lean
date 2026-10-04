-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.mulL_X_eq
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterA4
open BookProof.HermiteProductBasis
open BookProof.HermiteLadder

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section


theorem BookProof.HermiteLadder.mulL_X_eq (i : Fin d) : mulL (X i : MvPolynomial (Fin d) ℂ) = annPoly i + crePoly i := by sorry
