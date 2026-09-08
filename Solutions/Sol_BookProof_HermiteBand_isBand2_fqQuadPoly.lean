-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.isBand2_fqQuadPoly
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Theorems.Thm_BookProof_HermiteBand_Band_add
import Theorems.Thm_BookProof_HermiteBand_Band_smul
import Theorems.Thm_BookProof_HermiteBand_IsBand1_add
import Theorems.Thm_BookProof_HermiteBand_IsBand2_add
import Theorems.Thm_BookProof_HermiteBand_IsBand1_smul
import Theorems.Thm_BookProof_HermiteBand_IsBand2_smul
import Theorems.Thm_BookProof_HermiteBand_IsBand1_sum
import Theorems.Thm_BookProof_HermiteBand_IsBand2_sum
import Theorems.Thm_BookProof_HermiteBand_isBand1_mulXPoly
import Theorems.Thm_BookProof_HermiteBand_isBand1_momPoly
import Theorems.Thm_BookProof_HermiteBand_isBand2_weylProd
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

























open BookProof.NavierStokesFlow.DifferentialL2 BookProof.FullQuadratic

set_option maxHeartbeats 1000000 in
theorem solution (P Q S : Fin d → Fin d → ℝ) : IsBand2 (fqQuadPoly P Q S) := by

  rw [fqQuadPoly]
  refine IsBand2.sum _ _ fun i _ => IsBand2.sum _ _ fun j _ => ?_
  refine IsBand2.add (IsBand2.add ?_ ?_) ?_
  · exact IsBand2.smul _ (isBand2_weylProd (isBand1_momPoly i) (isBand1_momPoly j))
  · exact IsBand2.smul _ (isBand2_weylProd (isBand1_mulXPoly i) (isBand1_mulXPoly j))
  · exact IsBand2.smul _ (isBand2_weylProd (isBand1_mulXPoly i) (isBand1_momPoly j))
