-- Generated from ChapterSmComparison.lean — solution of BookProof.SmComparison.realCoeff_smConfPoly
import Mathlib
import Definitions.Def_ChapterSmComparison
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_mul
import Theorems.Thm_BookProof_YangMillsHermite_realCoeff_X
open BookProof.SmComparison




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.ScalaronWallEsa BookProof.ScalaronEsa BookProof.WallEsaBddBelow
open BookProof.TensorSumChain BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.EsaClosure BookProof.GraphCore
open BookProof.StoneBridge BookProof.ChapterStoneResolvent
open MeasureTheory

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (s : SmConf) : RealCoeff (smConfPoly s) := by

  rcases s with (⟨a, i⟩ | ⟨k, i⟩ | a) | i | (⟨a, i, j⟩ | ⟨k, i, j⟩ | ⟨i, j⟩ | ⟨a, j⟩)
  · exact (realCoeff_X _).mul (realCoeff_X _)
  · exact (realCoeff_X _).mul (realCoeff_X _)
  · exact (realCoeff_X _).mul (realCoeff_X _)
  · exact realCoeff_X _
  · exact realCoeff_X _
  · exact realCoeff_X _
  · exact realCoeff_X _
  · exact realCoeff_X _
