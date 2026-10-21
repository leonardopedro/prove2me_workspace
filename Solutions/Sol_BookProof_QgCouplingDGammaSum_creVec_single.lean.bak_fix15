-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.creVec_single
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_creVec_eq_sum
import Theorems.Thm_BookProof_FockSecondQuantization_creVec_apply
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (z : ℂ) (x : FockAlg) :
    creVec (Finsupp.single k z) x = z • creA k x := by

  classical
  rcases eq_or_ne z 0 with hz | hz
  · simp [hz, creVec_apply]
  · rw [creVec_eq_sum (L := {k}) (by simp [Finsupp.support_single_ne_zero k hz])]
    simp
