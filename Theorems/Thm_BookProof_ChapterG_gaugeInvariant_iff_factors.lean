-- Generated from ChapterG.lean — theorem BookProof.ChapterG.gaugeInvariant_iff_factors
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.gaugeInvariant_iff_factors {X Y Z : Type*} {π : X → Y}
    (hπ : Function.Surjective π) (f : X → Z) :
    (∀ g ∈ gaugeGroup π, ∀ x, f (g x) = f x) ↔ ∃ h : Y → Z, f = h ∘ π := by sorry
