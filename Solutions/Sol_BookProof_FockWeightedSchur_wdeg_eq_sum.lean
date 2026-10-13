-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.wdeg_eq_sum
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

theorem solution {α : Conf} {S : Finset ℕ} (h : α.support ⊆ S) :
    wdeg w α = ∑ k ∈ S, w k ^ 2 * α k :=
  Finsupp.sum_of_support_subset α h _ (by simp)
