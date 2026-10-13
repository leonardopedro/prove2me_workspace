-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.hop_stone_flow
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_isHermCol_hopCol
import Theorems.Thm_BookProof_FockSchur_schurBound_hopCol
import Theorems.Thm_BookProof_FockSchur_dGamma_stone_flow
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs
open BookProof.EsaClosure
open BookProof.FockSecondQuantization
open BookProof.StoneBridge

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (T : UnboundedSelfAdjoint Fock) (U : ℝ → (Fock →L[ℂ] Fock)),
      IsSelfAdjointExtension (dGammaOp hopCol) T.op ∧ IsStoneFlow T U := dGamma_stone_flow schurBound_hopCol isHermCol_hopCol (by norm_num)
