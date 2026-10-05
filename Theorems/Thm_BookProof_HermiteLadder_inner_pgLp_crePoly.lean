-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.inner_pgLp_crePoly
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.HermiteLadder

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section


theorem BookProof.HermiteLadder.inner_pgLp_crePoly (i : Fin d) (p q : MvPolynomial (Fin d) ℂ) :
    (inner ℂ (pgLp q) (pgLp (crePoly i p)) : ℂ) = inner ℂ (pgLp (annPoly i q)) (pgLp p) := by sorry
