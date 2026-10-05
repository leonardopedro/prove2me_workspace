-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.fermCre_comp_self
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_car_fermCre_fermCre
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermAlg) : fermCre j (fermCre j u) = 0 := by

  have h := car_fermCre_fermCre j j u
  have : (2 : ℂ) • fermCre j (fermCre j u) = 0 := by
    rw [two_smul]; exact h
  simpa using this
