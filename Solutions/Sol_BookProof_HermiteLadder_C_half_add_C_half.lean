-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.C_half_add_C_half
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    (C (1 / 2 : ℂ) : MvPolynomial (Fin d) ℂ) + C (1 / 2 : ℂ) = 1 := by

  rw [← C_add]
  norm_num
