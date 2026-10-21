-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradedHamiltonianB_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedFriedrichs_gradedHamiltonian_quadForm_nonneg
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {ε : ℕ ≃ GConf} {colB colF : ℕ → (ℕ →₀ ℂ)}
    (hb : IsPosCol colB) (hf : IsPosCol colF) (x : finiteModeDomain (l2BasisN ε)) :
    0 ≤ quadForm (gradedHamiltonianB ε colB colF) x :=
  gradedHamiltonian_quadForm_nonneg hb hf
      (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε) x)
