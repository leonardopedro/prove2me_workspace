-- Generated from ChapterSmFarisLavine.lean — solution of BookProof.SmFarisLavine.sm_h_esa_of_comparison_esa
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Theorems.Thm_BookProof_SmFarisLavine_sm_h_esa_of_graph_core
import Theorems.Thm_BookProof_SmFarisLavine_isGraphCore_of_esa
open BookProof.SmFarisLavine




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) {c0 : ℝ} (hc0 : 0 ≤ c0)
    (hN : EssentiallySelfAdjointOn (polyGaussCore (d := 163)) (smFlN P c0)) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 163)) (smHamiltonian P) :=
  sm_h_esa_of_graph_core P hc0
      (isGraphCore_of_esa (smFlPosSymOp P hc0) polyGaussCore_dense hN)
