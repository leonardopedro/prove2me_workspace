-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.dGamma_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_numSym_nonneg
import Theorems.Thm_BookProof_FockSchur_dGammaOp_coreRelBound
import Theorems.Thm_BookProof_FockSchur_dGammaOp_commForm_zero
import Theorems.Thm_BookProof_CoreBounds_essentiallySelfAdjointOn_finiteModes_of_core_bounds_comm
import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_symmetricOn
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hK : SchurBound col K) (hherm : IsHermCol col)
    (hK0 : 0 ≤ K) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp col) := by

  refine essentiallySelfAdjointOn_finiteModes_of_core_bounds_comm numSym numSym_nonneg
    (dGammaOp col) K ?_ (dGammaOp_coreRelBound hK hherm hK0) (dGammaOp_commForm_zero hherm)
  intro u v
  exact dGammaOp_symmetricOn hherm u v
