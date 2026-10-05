-- Generated from ChapterStoneSeparable.lean — theorem BookProof.ChapterStoneSeparable.hasDerivAt_phaseGroup
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneConverse
import Mathlib
import Definitions.Def_ChapterStoneSeparable
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterF7
open BookProof.ChapterUnboundedPosition
open BookProof.ChapterStoneSeparable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterStoneMeasurable

theorem BookProof.ChapterStoneSeparable.hasDerivAt_phaseGroup (f : ℤ → ℝ) (x : (mulSA f).domain) :
    HasDerivAt (fun t : ℝ => (phaseGroup f).U t (x : L2Z))
      ((-Complex.I) • (mulSA f).op x) 0 := by sorry
