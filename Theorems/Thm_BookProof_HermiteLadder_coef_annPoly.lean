-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.coef_annPoly
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



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteLadder.coef_annPoly (i : Fin d) (b : Fin d →₀ ℕ) (p : MvPolynomial (Fin d) ℂ) :
    coef b (pgLp (annPoly i p))
      = ((Real.sqrt ((b i : ℝ) + 1) : ℝ) : ℂ) * coef (b + Finsupp.single i 1) (pgLp p) := by sorry
