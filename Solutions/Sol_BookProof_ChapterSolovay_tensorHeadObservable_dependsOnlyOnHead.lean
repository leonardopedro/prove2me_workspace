-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.tensorHeadObservable_dependsOnlyOnHead
import Mathlib
import Definitions.Def_ChapterSolovay
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {N₁ N₂ : ℕ}
    (f₁ : _root_.InnerHead N₁ → ℂ) (f₂ : _root_.InnerHead N₂ → ℂ) :
    _root_.dependsOnlyOnHead (tensorHeadObservable f₁ f₂) := by

  refine ⟨fun h => f₁ ((headSumEquiv N₁ N₂ h).1) * f₂ ((headSumEquiv N₁ N₂ h).2), ?_⟩
  rfl
