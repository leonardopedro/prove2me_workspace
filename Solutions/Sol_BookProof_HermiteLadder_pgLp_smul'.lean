-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.pgLp_smul'
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
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (p : MvPolynomial (Fin d) ℂ) : pgLp (c • p) = c • pgLp p := by

  rw [← HermiteProductCore.pgMap_apply, map_smul]
  rfl
