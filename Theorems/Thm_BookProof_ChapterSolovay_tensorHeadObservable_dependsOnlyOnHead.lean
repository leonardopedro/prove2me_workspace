-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.tensorHeadObservable_dependsOnlyOnHead
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
open PhysMeasureBasis
open BookProof.ChapterSolovay


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.tensorHeadObservable_dependsOnlyOnHead {N₁ N₂ : ℕ}
    (f₁ : _root_.InnerHead N₁ → ℂ) (f₂ : _root_.InnerHead N₂ → ℂ) :
    _root_.dependsOnlyOnHead (tensorHeadObservable f₁ f₂) := by sorry
