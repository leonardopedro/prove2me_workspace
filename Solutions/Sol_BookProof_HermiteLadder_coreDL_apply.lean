-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.coreDL_apply
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal
open BookProof.QgHermiteFriedrichs

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin d) (p : MvPolynomial (Fin d) ℂ) : coreDL j p = coreD j p := rfl
