-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.mulL_X_eq
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal
open BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : mulL (X i : MvPolynomial (Fin d) ℂ) = annPoly i + crePoly i := by

  refine LinearMap.ext fun p => ?_
  simp
