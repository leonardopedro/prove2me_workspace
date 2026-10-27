-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.superBracket_fermCre_fermCre
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_car_fermCre_fermCre
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
theorem solution (j k : ℕ) :
    superBracket 1 1 (fermCre j) (fermCre k) = 0 := by

  refine LinearMap.ext fun u => ?_
  rw [superBracket_odd_odd, car_fermCre_fermCre]
  rfl
