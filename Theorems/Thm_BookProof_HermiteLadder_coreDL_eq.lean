-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.coreDL_eq
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.HermiteProductBasis
open BookProof.HermiteLadder

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section


theorem BookProof.HermiteLadder.coreDL_eq (j : Fin d) :
    coreDL j = (1 / 2 : ℂ) • annPoly j - (1 / 2 : ℂ) • crePoly j := by sorry
