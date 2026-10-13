-- Generated from ChapterSmComparisonFull.lean — solution of BookProof.SmComparisonFull.deriv_coordinate_esa
import Mathlib
import Definitions.Def_ChapterSmComparisonFull
import Theorems.Thm_BookProof_ScalaronEsa_smoothPotential_essentiallySelfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterSmComparison
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.SmComparisonFull




open BookProof.FarisLavine BookProof.TensorSumChain
open BookProof.SmComparison BookProof.ScalaronEsa
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open MeasureTheory
open BookProof.ScalaronEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (ccDomain ℝ) (opCc (fun x : ℝ => x ^ 2) contDiff_pow2) := smoothPotential_essentiallySelfAdjoint _ _
