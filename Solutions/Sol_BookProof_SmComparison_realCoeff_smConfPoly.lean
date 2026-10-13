-- Generated from ChapterSmComparison.lean — solution of BookProof.SmComparison.realCoeff_smConfPoly
import Mathlib
import Definitions.Def_ChapterSmComparison
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_mul
import Theorems.Thm_BookProof_YangMillsHermite_realCoeff_X
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterWallEsaBddBelow
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
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
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.SmOneParticle
open BookProof.YangMillsHermite

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
