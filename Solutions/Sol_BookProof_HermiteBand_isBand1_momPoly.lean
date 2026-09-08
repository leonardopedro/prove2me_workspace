-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.isBand1_momPoly
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Theorems.Thm_BookProof_HermiteBand_Band_add
import Theorems.Thm_BookProof_HermiteBand_Band_smul
import Theorems.Thm_BookProof_HermiteBand_IsBand1_add
import Theorems.Thm_BookProof_HermiteBand_IsBand2_add
import Theorems.Thm_BookProof_HermiteBand_IsBand1_smul
import Theorems.Thm_BookProof_HermiteBand_IsBand2_smul
import Theorems.Thm_BookProof_HermiteBand_isBand1_crePoly
import Theorems.Thm_BookProof_HermiteBand_isBand1_annPoly
import Theorems.Thm_BookProof_HermiteBand_momPoly_eq
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

























open BookProof.NavierStokesFlow.DifferentialL2 BookProof.FullQuadratic

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : IsBand1 (momPoly i) := by

  rw [momPoly_eq]
  exact ((isBand1_crePoly i).smul _).add ((isBand1_annPoly i).smul _)
