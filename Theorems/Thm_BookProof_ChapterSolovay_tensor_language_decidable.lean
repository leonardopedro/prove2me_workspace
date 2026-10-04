-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.tensor_language_decidable
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis
open BookProof.ChapterSolovay


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.tensor_language_decidable (N₁ N₂ : ℕ)
    (headDist : Measure (_root_.InnerHead (N₁ + N₂)))
    [IsProbabilityMeasure headDist]
    (Ψ₁ Ψ₂ : _root_.OuterWaveFunction (N₁ + N₂) headDist)
    (h₁ : _root_.dependsOnlyOnHead
      (Ψ₁ : _root_.InnerSpace (N₁ + N₂) → ℂ))
    (h₂ : _root_.dependsOnlyOnHead
      (Ψ₂ : _root_.InnerSpace (N₁ + N₂) → ℂ)) :
    inner ℂ Ψ₁ Ψ₂ =
      ∫ x, star (Ψ₁ (x, 0)) * Ψ₂ (x, 0) ∂headDist := by sorry
