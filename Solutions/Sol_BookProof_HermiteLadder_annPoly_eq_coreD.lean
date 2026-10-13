-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.annPoly_eq_coreD
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteProductBasis_annPoly_apply
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal
open BookProof.HermiteProductBasis
open BookProof.QgHermiteFriedrichs

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    annPoly i p = coreD i p + C (1 / 2 : ℂ) * (X i * p) := by

  rw [annPoly_apply, coreD]
  ring
