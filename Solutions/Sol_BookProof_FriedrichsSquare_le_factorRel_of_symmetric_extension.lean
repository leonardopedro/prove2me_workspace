-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.le_factorRel_of_symmetric_extension
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Theorems.Thm_BookProof_ClosureUniqueness_mem_adjGraph_iff
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {A : D →ₗ[ℂ] F} (hsym : SymmetricOn D A)
    {hstab : ∀ v : D, (A v : F) ∈ D} {R : Submodule ℂ (F × F)}
    (hext : ∀ v : D, ((v : F), sqOp A hstab v) ∈ R)
    (hRsym : ∀ p ∈ R, ∀ q ∈ R, (inner ℂ p.2 q.1 : ℂ) = inner ℂ p.1 q.2)
    (hdom : ∀ p ∈ R, p.1 ∈ clDom A) : R ≤ factorRel A := by

  intro p hp
  obtain ⟨x', hx'⟩ := mem_clDom_iff.1 (hdom p hp)
  refine ⟨x', hx', ?_⟩
  rw [mem_adjGraph_iff]
  intro v
  have h1 : (inner ℂ x' ((A v : F)) : ℂ) = inner ℂ p.1 (sqOp A hstab v) :=
    clGraph_inner hsym hx' ⟨(A v : F), hstab v⟩
  have h2 : (inner ℂ p.2 (v : F) : ℂ) = inner ℂ p.1 (sqOp A hstab v) :=
    hRsym p hp ((v : F), sqOp A hstab v) (hext v)
  have h3 : (inner ℂ x' ((A v : F)) : ℂ) = inner ℂ p.2 (v : F) := by
    rw [h1, h2]
  have h4 := congrArg (starRingEnd ℂ) h3
  rw [inner_conj_symm, inner_conj_symm] at h4
  exact h4
