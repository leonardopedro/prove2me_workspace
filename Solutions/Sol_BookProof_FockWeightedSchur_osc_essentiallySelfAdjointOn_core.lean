-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.osc_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_dGamma_essentiallySelfAdjointOn_core_w
import Theorems.Thm_BookProof_FockWeightedSchur_oscW_ge_one
import Theorems.Thm_BookProof_FockWeightedSchur_isHermCol_oscCol
import Theorems.Thm_BookProof_FockWeightedSchur_wRow_oscCol
import Theorems.Thm_BookProof_FockWeightedSchur_wCol_oscCol
import Theorems.Thm_BookProof_FockWeightedSchur_wComm_oscCol
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {w : ℕ → ℝ}
variable {col : ℕ → (ℕ →₀ ℂ)} {K B : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp oscCol) :=
  dGamma_essentiallySelfAdjointOn_core_w (w := oscW) (K := 2) (B := 4) oscW_ge_one
      isHermCol_oscCol wRow_oscCol wCol_oscCol (by norm_num) wComm_oscCol
