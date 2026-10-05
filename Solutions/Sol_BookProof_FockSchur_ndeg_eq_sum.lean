-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.ndeg_eq_sum
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {α : Conf} {S : Finset ℕ} (h : α.support ⊆ S) : ndeg α = ∑ i ∈ S, α i := Finsupp.sum_of_support_subset α h _ (by simp)
