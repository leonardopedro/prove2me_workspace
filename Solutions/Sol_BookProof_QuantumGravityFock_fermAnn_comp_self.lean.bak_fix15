-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.fermAnn_comp_self
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_car_fermAnn_fermAnn
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermAlg) : fermAnn j (fermAnn j u) = 0 := by

  have h := car_fermAnn_fermAnn j j u
  have : (2 : ℂ) • fermAnn j (fermAnn j u) = 0 := by
    rw [two_smul]; exact h
  simpa using this
