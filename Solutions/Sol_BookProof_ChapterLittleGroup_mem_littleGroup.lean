-- Generated from ChapterLittleGroup.lean — solution of BookProof.ChapterLittleGroup.mem_littleGroup
import Mathlib
import Definitions.Def_ChapterLittleGroup
open BookProof.ChapterLittleGroup




variable {G : Type*} [Group G] {K : Type*}

variable {G : Type*} [Group G] {K : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {q : K → G} {l₀ : K} {g : G} :
    g ∈ littleGroup q l₀ ↔ q l₀ * g = g * q l₀ := by

  rw [littleGroup, Subgroup.mem_centralizer_iff]
  constructor
  · intro h; exact h (q l₀) rfl
  · intro h y hy
    rw [Set.mem_singleton_iff] at hy
    subst hy; exact h
