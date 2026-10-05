-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.superBracket_fermAnn_fermCre
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_car_fermAnn_fermCre
import Theorems.Thm_BookProof_QuantumGravityFock_superBracket_odd_odd
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) :
    superBracket 1 1 (fermAnn j) (fermCre j) = LinearMap.id := by

  refine LinearMap.ext fun u => ?_
  rw [superBracket_odd_odd, car_fermAnn_fermCre]
  rfl
