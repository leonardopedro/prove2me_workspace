-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.support_parityF
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (u : FermiAlg) : (parityF u).support ⊆ u.support := by

  intro S hS
  rw [Finsupp.mem_support_iff] at hS ⊢
  intro h
  exact hS (by rw [parityF_apply, h, mul_zero])
