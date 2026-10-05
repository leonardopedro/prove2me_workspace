-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.inner_pgLp_annPoly
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs
open BookProof.HermiteLadder

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section


theorem BookProof.HermiteLadder.inner_pgLp_annPoly (i : Fin d) (p q : MvPolynomial (Fin d) ℂ) :
    (inner ℂ (pgLp q) (pgLp (annPoly i p)) : ℂ) = inner ℂ (pgLp (crePoly i q)) (pgLp p) := by sorry
