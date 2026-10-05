-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradedHamiltonianAlg_evenPart
import Mathlib
import Definitions.Def_ChapterGradedHashimoto
import Theorems.Thm_BookProof_GradedHashimoto_gradeOp_gradedHamiltonianAlg_apply
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
    gradedHamiltonianAlg colB colF (evenPart u) = evenPart (gradedHamiltonianAlg colB colF u) := by

  rw [evenPart, evenPart, map_smul, map_add, gradeOp_gradedHamiltonianAlg_apply]
