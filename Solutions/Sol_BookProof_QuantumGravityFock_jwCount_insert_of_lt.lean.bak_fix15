-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.jwCount_insert_of_lt
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {i j : ℕ} {α : FermConf} (h : i < j) (hi : i ∉ α) :
    jwCount j (insert i α) = jwCount j α + 1 := by

  classical
  rw [jwCount, jwCount, Finset.filter_insert, if_pos h, Finset.card_insert_of_notMem]
  exact fun hc => hi (Finset.mem_of_mem_filter _ hc)
