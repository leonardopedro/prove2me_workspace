-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.jwSign_erase_of_le
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_jwCount_erase_of_le
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
    jwSign j (α.erase i) = jwSign j α := by

  rw [jwSign, jwSign, jwCount_erase_of_le h]
