-- Generated from ChapterSchurFiniteDim.lean — solution of BookProof.ChapterSchurFiniteDim.isSchurUnitary_of_irreducible
import Mathlib
import Definitions.Def_ChapterSchurFiniteDim
import Theorems.Thm_BookProof_ChapterSchurFiniteDim_schur_scalar_of_irreducible
open BookProof.ChapterSchurFiniteDim



open Module


open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : IsIrreducibleSystem M) :
    IsSchurUnitary M := by

  intro g hg
  obtain ⟨c, hc⟩ :=
    schur_scalar_of_irreducible M hirr (g.toLinearEquiv.toLinearMap) (fun m hm x => hg m hm x)
  have hc' : ∀ x, g x = c • x := fun x => hc x
  refine ⟨c, ?_, hc'⟩
  obtain ⟨x, hx⟩ := exists_ne (0 : V)
  have hnorm : ‖g x‖ = ‖x‖ := g.norm_map x
  rw [hc' x, norm_smul] at hnorm
  have hxpos : 0 < ‖x‖ := norm_pos_iff.2 hx
  field_simp at hnorm
  exact hnorm
