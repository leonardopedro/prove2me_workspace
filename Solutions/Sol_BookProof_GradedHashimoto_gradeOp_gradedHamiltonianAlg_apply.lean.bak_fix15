-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradeOp_gradedHamiltonianAlg_apply
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedHashimoto_gradeOp_gradedHamiltonianAlg
open BookProof.GradedHashimoto




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (colB colF : ℕ → (ℕ →₀ ℂ)) (u : GradedAlg) :
    gradeOp (gradedHamiltonianAlg colB colF u)
      = gradedHamiltonianAlg colB colF (gradeOp u) := by

  have := congrArg (fun T : Module.End ℂ GradedAlg => T u)
    (gradeOp_gradedHamiltonianAlg colB colF)
  simpa only [Module.End.mul_apply] using this
