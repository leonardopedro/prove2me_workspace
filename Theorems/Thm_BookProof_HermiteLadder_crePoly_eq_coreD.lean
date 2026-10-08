-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.crePoly_eq_coreD
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.HermiteProductBasis
open BookProof.QgHermiteFriedrichs
open BookProof.HermiteLadder



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteLadder.crePoly_eq_coreD (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    crePoly i p = C (1 / 2 : ℂ) * (X i * p) - coreD i p := by sorry
