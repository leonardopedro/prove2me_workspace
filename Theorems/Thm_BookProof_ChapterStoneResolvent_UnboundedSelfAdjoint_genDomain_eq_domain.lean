-- Generated from ChapterStoneTheorem.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.genDomain_eq_domain
import Mathlib
import Definitions.Def_ChapterStoneTheorem
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable [TopologicalSpace.SeparableSpace H]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]


open scoped InnerProductSpace


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.genDomain_eq_domain (T : UnboundedSelfAdjoint H) :
    T.stoneGroup.genDomain = T.domain := by sorry
