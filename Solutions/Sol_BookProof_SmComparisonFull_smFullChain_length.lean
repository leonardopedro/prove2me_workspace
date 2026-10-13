-- Generated from ChapterSmComparisonFull.lean — solution of BookProof.SmComparisonFull.smFullChain_length
import Mathlib
import Definitions.Def_ChapterSmComparisonFull
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterSmComparison
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
open BookProof.SmComparisonFull




open BookProof.FarisLavine BookProof.TensorSumChain
open BookProof.SmComparison BookProof.ScalaronEsa
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open MeasureTheory

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : smFullFactors.length + 1 = 160 := by

  simp [smFullFactors]
