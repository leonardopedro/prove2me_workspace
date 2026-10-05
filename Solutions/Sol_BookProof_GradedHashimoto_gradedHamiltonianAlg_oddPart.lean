-- Generated from ChapterGradedHashimoto.lean — solution of BookProof.GradedHashimoto.gradedHamiltonianAlg_oddPart
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
    gradedHamiltonianAlg colB colF (oddPart u) = oddPart (gradedHamiltonianAlg colB colF u) := by

  rw [oddPart, oddPart, map_smul, map_sub, gradeOp_gradedHamiltonianAlg_apply]
