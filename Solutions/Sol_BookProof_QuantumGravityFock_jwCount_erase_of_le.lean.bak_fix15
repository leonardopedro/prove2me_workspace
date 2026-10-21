-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.jwCount_erase_of_le
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
theorem solution {i j : ℕ} {α : FermConf} (h : j ≤ i) :
    jwCount j (α.erase i) = jwCount j α := by

  classical
  have hfilter : (α.erase i).filter (fun x => x < j) = (α.filter (fun x => x < j)).erase i := by
    rw [Finset.filter_erase]
  rw [jwCount, jwCount, hfilter, Finset.erase_eq_of_notMem]
  intro hc
  have := (Finset.mem_filter.mp hc).2
  omega
