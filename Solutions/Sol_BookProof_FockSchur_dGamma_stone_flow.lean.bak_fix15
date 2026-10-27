-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.dGamma_stone_flow
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_dGamma_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_symmetricOn
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hK : SchurBound col K) (hherm : IsHermCol col) (hK0 : 0 ≤ K) :
    ∃ (T : UnboundedSelfAdjoint Fock) (U : ℝ → (Fock →L[ℂ] Fock)),
      IsSelfAdjointExtension (dGammaOp col) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ finiteOccupation_dense (dGammaOp_symmetricOn hherm)
      (dGamma_essentiallySelfAdjointOn_core hK hherm hK0)
