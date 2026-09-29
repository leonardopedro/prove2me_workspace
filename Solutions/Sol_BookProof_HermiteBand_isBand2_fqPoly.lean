-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.isBand2_fqPoly
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    IsBand2 (fqPoly P Q S b b') := by

  rw [fqPoly]
  exact (isBand2_fqQuadPoly P Q S).add (isBand1_foPoly b b').toBand2
