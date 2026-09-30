-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.dGamma_essentiallySelfAdjointOn_core_w
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_wSym_nonneg
import Theorems.Thm_BookProof_FockWeightedSchur_wcomm_nonneg
import Theorems.Thm_BookProof_FockWeightedSchur_dGammaOp_coreRelBound_w
import Theorems.Thm_BookProof_FockWeightedSchur_dGammaOp_commForm_bound_w
open BookProof.FockWeightedSchur














open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

















variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hw : ∀ k, 1 ≤ w k) (hherm : IsHermCol col)
    (hrow : WRowBound w col K) (hcolg : WColBound w col K) (hK0 : 0 ≤ K)
    (hBg : WCommBound w col B) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp col) :=
  essentiallySelfAdjointOn_finiteModes_of_core_bounds (wSym w) (fun α => wSym_nonneg α)
      (dGammaOp col) K B (wcomm_nonneg hw hBg) (fun u v => dGammaOp_symmetricOn hherm u v)
      (dGammaOp_coreRelBound_w hw hherm hrow hcolg hK0) (dGammaOp_commForm_bound_w hw hherm hBg)
