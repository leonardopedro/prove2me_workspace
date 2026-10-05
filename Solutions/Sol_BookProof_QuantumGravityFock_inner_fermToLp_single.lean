-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.inner_fermToLp_single
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_inner_fermToLp_of_subset
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p q : FermConf) (a b : ℂ) :
    (inner ℂ (fermToLp (Finsupp.single p a)) (fermToLp (Finsupp.single q b)) : ℂ)
      = if q = p then (starRingEnd ℂ) a * b else 0 := by

  classical
  rw [inner_fermToLp_of_subset (s := {p}) Finsupp.support_single_subset, Finset.sum_singleton,
    Finsupp.single_eq_same, Finsupp.single_apply]
  by_cases h : q = p
  · simp [h]
  · simp [h]
