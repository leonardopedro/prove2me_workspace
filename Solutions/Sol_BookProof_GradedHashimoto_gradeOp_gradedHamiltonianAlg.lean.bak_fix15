-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradeOp_gradedHamiltonianAlg
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedHashimoto_parityF_dGammaF
import Theorems.Thm_BookProof_GradedFock_liftFst_liftSnd_comm
import Theorems.Thm_BookProof_GradedFock_liftSnd_mul
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (colB colF : ℕ → (ℕ →₀ ℂ)) :
    gradeOp * gradedHamiltonianAlg colB colF
      = gradedHamiltonianAlg colB colF * gradeOp := by

  have hF : (parityF : Module.End ℂ FermiAlg) * dGammaF colF
      = (dGammaF colF : Module.End ℂ FermiAlg) * parityF :=
    LinearMap.ext fun u => parityF_dGammaF colF u
  have h1 : gradeOp * liftFst (β := FConf) (dGamma colB)
      = liftFst (β := FConf) (dGamma colB) * gradeOp := (liftFst_liftSnd_comm _ _).symm
  have h2 : gradeOp * liftSnd (α := Conf) (dGammaF colF)
      = liftSnd (α := Conf) (dGammaF colF) * gradeOp := by
    rw [gradeOp, liftSnd_mul, liftSnd_mul, hF]
  rw [gradedHamiltonianAlg, mul_add, add_mul, h1, h2]
