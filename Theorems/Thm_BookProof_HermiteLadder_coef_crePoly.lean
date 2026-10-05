-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.coef_crePoly
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


theorem BookProof.HermiteLadder.coef_crePoly (i : Fin d) (b : Fin d →₀ ℕ) (p : MvPolynomial (Fin d) ℂ) :
    coef b (pgLp (crePoly i p))
      = ((Real.sqrt ((b i : ℝ)) : ℝ) : ℂ) * coef (b - Finsupp.single i 1) (pgLp p) := by sorry
