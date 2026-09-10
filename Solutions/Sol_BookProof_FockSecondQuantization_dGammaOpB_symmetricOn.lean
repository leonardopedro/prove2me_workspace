-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.dGammaOpB_symmetricOn
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_symmetricOn
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

















































































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]











open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {ε : ℕ ≃ Conf} {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) :
    SymmetricOn (finiteModeDomain (fockBasisN ε)) (dGammaOpB ε col) := by

  intro x y
  exact dGammaOp_symmetricOn hherm
    (LinearEquiv.ofEq _ _ (finiteModeDomain_fockBasisN ε) x)
    (LinearEquiv.ofEq _ _ (finiteModeDomain_fockBasisN ε) y)
