-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.hamPolyL_apply
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
open BookProof.HermiteLadder



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteLadder.hamPolyL_apply (S : Finset (Fin d)) (q p : MvPolynomial (Fin d) ℂ) :
    hamPolyL S q p = kinPolyS S p + q * p := by sorry
