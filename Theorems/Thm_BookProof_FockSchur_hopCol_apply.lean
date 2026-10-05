-- Generated from ChapterFockSchurEsa.lean — theorem BookProof.FockSchur.hopCol_apply
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}



open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

theorem BookProof.FockSchur.hopCol_apply (k j : ℕ) : (hopCol k) j = if j = k + 1 ∨ k = j + 1 then 1 else 0 := by sorry
