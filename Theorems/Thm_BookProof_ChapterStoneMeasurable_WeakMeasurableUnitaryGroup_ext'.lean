-- Generated from ChapterStoneTheorem.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.ext'
import Mathlib
import Definitions.Def_ChapterStoneTheorem
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable [TopologicalSpace.SeparableSpace H]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]


open scoped InnerProductSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.ext' :
    ∀ {G G' : WeakMeasurableUnitaryGroup H}, (∀ t, G.U t = G'.U t) → G = G' := by sorry
