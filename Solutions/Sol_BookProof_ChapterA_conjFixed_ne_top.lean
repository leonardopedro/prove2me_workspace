-- Generated from ChapterA1f.lean — solution of BookProof.ChapterA.conjFixed_ne_top
import Mathlib
import Definitions.Def_ChapterA1f
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial V] (θ : AntiUnitary V) : conjFixed θ ≠ ⊤ := by

  intro h
  obtain ⟨x, hx0⟩ := exists_ne (0 : V)
  have hxI : (Complex.I • x) ∈ conjFixed θ := by rw [h]; trivial
  have hx : x ∈ conjFixed θ := by rw [h]; trivial
  rw [mem_conjFixed] at hxI hx
  rw [θ.map_smulₛₗ, hx] at hxI
  -- hxI : conj I • x = I • x, i.e. -I • x = I • x
  have hI : (starRingEnd ℂ) Complex.I = -Complex.I := by simp
  rw [hI] at hxI
  have hz : Complex.I • x = 0 := by
    have e2 : Complex.I • x = -(Complex.I • x) := by
      rw [neg_smul] at hxI; linear_combination (norm := module) hxI.symm
    rw [eq_neg_iff_add_eq_zero] at e2
    have h2 : (2 : ℂ) • (Complex.I • x) = 0 := by rw [two_smul]; exact e2
    rcases smul_eq_zero.mp h2 with hh | hh
    · norm_num at hh
    · exact hh
  rcases smul_eq_zero.mp hz with hh | hh
  · simp [Complex.I_ne_zero] at hh
  · exact hx0 hh
