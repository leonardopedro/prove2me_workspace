-- Generated from ChapterSchurIrreducible.lean — solution of BookProof.ChapterSchurIrreducible.rangeClosure_ne_top
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Theorems.Thm_BookProof_ChapterSchurIrreducible_rangeClosure_le_ker
open BookProof.ChapterSchurIrreducible



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {F G : V →L[ℂ] V} (hG : G ≠ 0) (h : G * F = 0) :
    rangeClosure F ≠ ⊤ := by

  intro htop
  apply hG
  ext x
  have hx : x ∈ rangeClosure F := by rw [htop]; trivial
  have := rangeClosure_le_ker h hx
  simpa using this
