-- Generated from ChapterLittleGroup.lean — theorem BookProof.ChapterLittleGroup.mem_littleGroup
import Mathlib
import Definitions.Def_ChapterLittleGroup
open BookProof.ChapterLittleGroup



variable {G : Type*} [Group G] {K : Type*}


theorem BookProof.ChapterLittleGroup.mem_littleGroup {q : K → G} {l₀ : K} {g : G} :
    g ∈ littleGroup q l₀ ↔ q l₀ * g = g * q l₀ := by sorry
