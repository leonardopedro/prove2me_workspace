-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.parityF_creVecF
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_FermionFock_creVecF_apply
import Theorems.Thm_BookProof_FermionFock_parityF_creF
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (v : ℕ →₀ ℂ) (x : FermiAlg) :
    parityF (creVecF v x) = - creVecF v (parityF x) := by

  rw [creVecF_apply, map_sum, creVecF_apply, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun j _ => by rw [map_smul, parityF_creF, smul_neg]
