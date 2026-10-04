-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.inner_reduces_to_head
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis
open BookProof.ChapterSolovay


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.inner_reduces_to_head (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (Ψ₁ Ψ₂ : _root_.OuterWaveFunction N headDist)
    (hcyl₁ : _root_.dependsOnlyOnHead (Ψ₁ : _root_.InnerSpace N → ℂ))
    (hcyl₂ : _root_.dependsOnlyOnHead (Ψ₂ : _root_.InnerSpace N → ℂ)) :
    inner ℂ Ψ₁ Ψ₂ = ∫ x : _root_.InnerHead N, star (Ψ₁ (x, 0)) * (Ψ₂ (x, 0)) ∂headDist := by sorry
