-- Generated from ChapterBddBelowFiberSumEsa.lean — theorem BookProof.BddBelowFiberSumEsa.fiberSumHam_stone_flow
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterBddBelowWallEsa
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.StoneBridge
open BookProof.BddBelowFiberSumEsa



open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.BddBelowWallEsa BookProof.WallEsaSemibounded BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*}


theorem BookProof.BddBelowFiberSumEsa.fiberSumHam_stone_flow (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i))
    (hbdd : ∀ i, ∃ K : ℝ, ∀ x, -K ≤ V i x) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint (fiberSpace ι))
      (U : ℝ → (fiberSpace ι →L[ℂ] fiberSpace ι)),
      EsaClosure.IsSelfAdjointExtension (fiberSumHam V hV) T.op ∧ StoneBridge.IsStoneFlow T U := by sorry
