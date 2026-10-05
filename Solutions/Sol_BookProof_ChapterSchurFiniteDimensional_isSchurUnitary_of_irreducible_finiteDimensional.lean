-- Generated from ChapterSchurFiniteDimensional.lean — solution of BookProof.ChapterSchurFiniteDimensional.isSchurUnitary_of_irreducible_finiteDimensional
import Mathlib
import Definitions.Def_ChapterSchurFiniteDimensional
import Theorems.Thm_BookProof_ChapterSchurFiniteDimensional_isSchurFull_of_irreducible_finiteDimensional
open BookProof.ChapterSchurFiniteDimensional



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : M.IsIrreducible) : IsSchurUnitary M := by

  intro g hg
  have hcomm : M.Commutes (g.toContinuousLinearEquiv.toContinuousLinearMap) := by
    intro m hm
    ext x
    have := hg m hm x
    simpa using this
  obtain ⟨c, hc⟩ :=
    isSchurFull_of_irreducible_finiteDimensional M hirr _ hcomm
  have hgx : ∀ x, g x = c • x := by
    intro x
    have := congrArg (fun T : V →L[ℂ] V => T x) hc
    simpa using this
  obtain ⟨x₀, hx₀⟩ := exists_ne (0 : V)
  have hnorm : ‖c‖ = 1 := by
    have hiso : ‖g x₀‖ = ‖x₀‖ := g.norm_map x₀
    rw [hgx x₀, norm_smul] at hiso
    have hx0 : ‖x₀‖ ≠ 0 := norm_ne_zero_iff.mpr hx₀
    field_simp at hiso
    exact hiso
  exact ⟨c, hnorm, hgx⟩
