-- Generated from ChapterSqueezedGaussStates.lean — solution of BookProof.SqueezedGaussStates.op_squeezeState
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Theorems.Thm_BookProof_SqueezedGaussStates_sqCoef_top_succ
import Theorems.Thm_BookProof_SqueezedGaussStates_coordCombo_smul_add
import Theorems.Thm_BookProof_SqueezedGaussStates_X_mul_coordCombo_even
import Theorems.Thm_BookProof_SqueezedGaussStates_pderiv_coordCombo_even
open BookProof.SqueezedGaussStates




open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (α γ v : ℝ) (M : ℕ) :
    ((α : ℝ) : ℂ) • (X i * squeezeState i v M)
        + ((γ : ℝ) : ℂ) • pderiv i (squeezeState i v M)
      = coordCombo i (opCoef α γ v M) 1 M := by

  rw [squeezeState, X_mul_coordCombo_even i _ M (sqCoef_top_succ v M),
    pderiv_coordCombo_even i _ M (sqCoef_top_succ v M), coordCombo_smul_add]
  rfl
