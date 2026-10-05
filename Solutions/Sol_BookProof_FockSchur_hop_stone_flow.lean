-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.hop_stone_flow
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_isHermCol_hopCol
import Theorems.Thm_BookProof_FockSchur_schurBound_hopCol
import Theorems.Thm_BookProof_FockSchur_dGamma_stone_flow
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (T : UnboundedSelfAdjoint Fock) (U : ℝ → (Fock →L[ℂ] Fock)),
      IsSelfAdjointExtension (dGammaOp hopCol) T.op ∧ IsStoneFlow T U := dGamma_stone_flow schurBound_hopCol isHermCol_hopCol (by norm_num)
