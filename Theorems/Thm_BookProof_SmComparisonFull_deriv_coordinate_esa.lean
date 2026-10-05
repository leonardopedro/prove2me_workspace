-- Generated from ChapterSmComparisonFull.lean — theorem BookProof.SmComparisonFull.deriv_coordinate_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterSmComparison
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterSmComparisonFull
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronEsa
open BookProof.SmComparisonFull



open BookProof.FarisLavine BookProof.TensorSumChain
open BookProof.SmComparison BookProof.ScalaronEsa
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open MeasureTheory

noncomputable section

theorem BookProof.SmComparisonFull.deriv_coordinate_esa :
    EssentiallySelfAdjointOn (ccDomain ℝ) (opCc (fun x : ℝ => x ^ 2) contDiff_pow2) := by sorry
