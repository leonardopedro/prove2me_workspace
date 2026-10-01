-- Generated from ChapterStoneTheorem.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.ext'
import Mathlib
import Definitions.Def_ChapterStoneTheorem
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution :
    ∀ {G G' : WeakMeasurableUnitaryGroup H}, (∀ t, G.U t = G'.U t) → G = G'
| ⟨_, _, _, _, _⟩, ⟨_, _, _, _, _⟩, h => by
      simp only [WeakMeasurableUnitaryGroup.mk.injEq]
      exact funext h
