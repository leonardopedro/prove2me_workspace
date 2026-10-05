-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.jwCount_erase_of_lt
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
theorem solution {i j : ℕ} {α : FermConf} (h : i < j) (hi : i ∈ α) :
    jwCount j α = jwCount j (α.erase i) + 1 := by

  classical
  have hfilter : (α.erase i).filter (fun x => x < j) = (α.filter (fun x => x < j)).erase i := by
    rw [Finset.filter_erase]
  rw [jwCount, jwCount, hfilter, Finset.card_erase_of_mem (Finset.mem_filter.mpr ⟨hi, h⟩)]
  have : 1 ≤ (α.filter (fun x => x < j)).card :=
    Finset.card_pos.mpr ⟨i, Finset.mem_filter.mpr ⟨hi, h⟩⟩
  omega
