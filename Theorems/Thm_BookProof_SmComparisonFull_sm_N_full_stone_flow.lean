-- Generated from ChapterSmComparisonFull.lean — theorem BookProof.SmComparisonFull.sm_N_full_stone_flow
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterSmComparison
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterSmComparisonFull
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.StoneBridge
open BookProof.SmComparisonFull



open BookProof.FarisLavine BookProof.TensorSumChain
open BookProof.SmComparison BookProof.ScalaronEsa
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open MeasureTheory

noncomputable section

theorem BookProof.SmComparisonFull.sm_N_full_stone_flow :
    ∃ (G : UnboundedSelfAdjoint smFullChain.space.carrier)
      (U : ℝ → (smFullChain.space.carrier →L[ℂ] smFullChain.space.carrier)),
      IsSelfAdjointExtension smFullChain.op G.op ∧ IsStoneFlow G U := by sorry
