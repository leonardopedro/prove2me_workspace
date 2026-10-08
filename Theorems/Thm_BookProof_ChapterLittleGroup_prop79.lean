-- Generated from ChapterLittleGroup.lean — theorem BookProof.ChapterLittleGroup.prop79
import Mathlib
import Definitions.Def_ChapterLittleGroup
open BookProof.ChapterLittleGroup



variable {G : Type*} [Group G] {K : Type*}


theorem BookProof.ChapterLittleGroup.prop79 (q : K → G) (hq : Function.Injective q) (l₀ : K)
    (α : K → G) (Λ : G → K → K)
    (hα : ∀ k, α k * q l₀ * (α k)⁻¹ = q k)
    (hΛ : ∀ (S : G) (k : K), S * q k * S⁻¹ = q (Λ S k))
    (k : K) :
    Hset α Λ k = (littleGroup q l₀ : Set G) := by sorry
