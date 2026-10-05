-- Generated from ChapterSchurIrreducible.lean — solution of BookProof.ChapterSchurIrreducible.rangeClosure_ne_bot
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Theorems.Thm_BookProof_ChapterSchurIrreducible_mem_rangeClosure
open BookProof.ChapterSchurIrreducible



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {F : V →L[ℂ] V} (hF : F ≠ 0) : rangeClosure F ≠ ⊥ := by

  intro h
  apply hF
  ext x
  have : F x ∈ rangeClosure F := mem_rangeClosure F x
  rw [h, Submodule.mem_bot] at this
  simp [this]
