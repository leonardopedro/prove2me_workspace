-- Generated from ChapterYangMillsAbelianNoGap.lean — solution of BookProof.YangMillsAbelianNoGap.idxA_lt
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
open BookProof.YangMillsAbelianNoGap




open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) (a : Fin 8) : ((idxA j a : Fin 99) : ℕ) < 27 := by

  have hj : (j : ℕ) < 3 := j.isLt
  have ha : (a : ℕ) < 8 := a.isLt
  simp only [idxA]
  omega
