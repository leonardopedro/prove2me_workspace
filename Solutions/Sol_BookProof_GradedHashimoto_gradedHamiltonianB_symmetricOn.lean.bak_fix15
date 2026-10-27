-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradedHamiltonianB_symmetricOn
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedFriedrichs_gradedHamiltonian_symmetricOn
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
    (hb : IsHermCol colB) (hf : IsHermCol colF) :
    SymmetricOn (finiteModeDomain (l2BasisN ε)) (gradedHamiltonianB ε colB colF) := by

  intro x y
  exact gradedHamiltonian_symmetricOn hb hf
    (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε) x)
    (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε) y)
