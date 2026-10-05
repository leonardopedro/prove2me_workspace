-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.jw_swap_insert
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_jwSign_insert_of_lt
import Theorems.Thm_BookProof_QuantumGravityFock_jwSign_insert_of_le
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {j k : ℕ} (h : j ≠ k) {α : FermConf} (hj : j ∉ α) (hk : k ∉ α) :
    jwSign j α * jwSign k (insert j α) = - (jwSign k α * jwSign j (insert k α)) := by

  rcases lt_or_gt_of_ne h with hlt | hgt
  · rw [jwSign_insert_of_lt hlt hj, jwSign_insert_of_le (le_of_lt hlt)]; ring
  · rw [jwSign_insert_of_le (le_of_lt hgt), jwSign_insert_of_lt hgt hk]; ring
