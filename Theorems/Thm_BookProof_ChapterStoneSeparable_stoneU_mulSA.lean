-- Generated from ChapterStoneSeparable.lean — theorem BookProof.ChapterStoneSeparable.stoneU_mulSA
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneConverse
import Mathlib
import Definitions.Def_ChapterStoneSeparable
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterUnboundedPosition
open BookProof.ChapterStoneSeparable


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]

theorem BookProof.ChapterStoneSeparable.stoneU_mulSA (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) :
    (mulSA f).stoneU t psi = phaseUnitary f (-t) psi := by sorry
