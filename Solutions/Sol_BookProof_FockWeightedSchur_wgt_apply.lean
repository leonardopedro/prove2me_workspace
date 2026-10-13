-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.wgt_apply
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockWeightedSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization

noncomputable section

variable {w : ℕ → ℝ}

set_option maxHeartbeats 1000000 in

theorem solution (u : FockAlg) (α : Conf) : wgt w u α = (wSym w α : ℂ) * u α := rfl
