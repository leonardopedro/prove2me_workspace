-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.ghostEnergy_insert
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
theorem solution {g : ℕ → ℝ} {a : ℕ} {α : FermConf} (h : a ∉ α) :
    ghostEnergy g (insert a α) = g a + ghostEnergy g α := by

  simp [ghostEnergy, Finset.sum_insert h]
