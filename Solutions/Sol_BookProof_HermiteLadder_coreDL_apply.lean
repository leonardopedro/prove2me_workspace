-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.coreDL_apply
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin d) (p : MvPolynomial (Fin d) ℂ) : coreDL j p = coreD j p := rfl
