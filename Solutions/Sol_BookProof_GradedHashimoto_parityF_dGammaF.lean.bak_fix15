-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.parityF_dGammaF
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedHashimoto_modesF_parityF
import Theorems.Thm_BookProof_GradedHashimoto_parityF_creVecF
import Theorems.Thm_BookProof_FermionFock_dGammaF_eq_sum
import Theorems.Thm_BookProof_FermionFock_parityF_annF
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u : FermiAlg) :
    parityF (dGammaF col u) = dGammaF col (parityF u) := by

  classical
  rw [dGammaF_eq_sum col (K := modesF u) (Finset.Subset.refl _),
    dGammaF_eq_sum col (K := modesF u) (modesF_parityF u), map_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [parityF_creVecF, parityF_annF, map_neg, neg_neg]
