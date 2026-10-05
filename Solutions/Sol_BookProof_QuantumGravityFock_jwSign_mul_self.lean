-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.jwSign_mul_self
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
theorem solution (j : ℕ) (α : FermConf) : jwSign j α * jwSign j α = 1 := by

  rw [jwSign, ← pow_add]
  rcases Nat.even_or_odd (jwCount j α) with he | ho
  · rw [Even.neg_one_pow (he.add he)]
  · rw [Even.neg_one_pow (ho.add_odd ho)]
