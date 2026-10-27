-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.fourierAdvect_smul
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_fourierMomentum_smul
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (k : Fin 3 → ℝ) (i : Fin 3) :
    fourierAdvect (t • k) i = C ((t : ℝ) : ℂ) * fourierAdvect k i := by

  rw [fourierAdvect, fourierAdvect, fourierMomentum_smul]
  ring
