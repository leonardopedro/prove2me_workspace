import Mathlib
import BookProof.ChapterA
import BookProof.ChapterA2

/-!
# Schur's lemma in finite dimensions

`BookProof.ChapterA2` introduces the Schur property for unitaries
(`IsSchurUnitary`) as a *named hypothesis*, because the general
unitary-representation Schur lemma is not available in Mathlib.

This file discharges that hypothesis in the **finite-dimensional complex** case,
where it is a theorem rather than an external input:

* `schur_scalar_of_irreducible` — a linear endomorphism of a nonzero
  finite-dimensional complex space which commutes with an irreducible system of
  operators is a scalar;
* `isSchurUnitary_of_irreducible` — consequently, every irreducible system on a
  nonzero finite-dimensional complex inner-product space *is* Schur for
  unitaries, so `BookProof.ChapterA2`'s hypothesis holds automatically there.

The proof is the classical one: over `ℂ` the commuting operator has an
eigenvalue (algebraic closedness plus finite dimension), its eigenspace is
invariant under the system and nonzero, hence everything, so the operator is the
corresponding scalar.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Module

namespace BookProof.ChapterSchurFiniteDim

open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

/-- **Irreducibility of a system.**  The only subspaces invariant under every
operator of the system are `⊥` and `⊤`. -/
def IsIrreducibleSystem (M : System ℂ V) : Prop :=
  ∀ W : Submodule ℂ V, (∀ m ∈ M.ops, ∀ x ∈ W, m x ∈ W) → W = ⊥ ∨ W = ⊤

/-- **Schur's lemma, finite-dimensional complex form.**  Any linear
endomorphism commuting with an irreducible system of operators on a nonzero
finite-dimensional complex space is a scalar. -/
theorem schur_scalar_of_irreducible [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : IsIrreducibleSystem M) (f : V →ₗ[ℂ] V)
    (hf : ∀ m ∈ M.ops, ∀ x, f (m x) = m (f x)) :
    ∃ c : ℂ, ∀ x, f x = c • x := by
  obtain ⟨c, hc⟩ := Module.End.exists_eigenvalue f
  refine ⟨c, ?_⟩
  have hne : Module.End.eigenspace f c ≠ ⊥ := hc
  have hinv : ∀ m ∈ M.ops, ∀ x ∈ Module.End.eigenspace f c,
      m x ∈ Module.End.eigenspace f c := by
    intro m hm x hx
    rw [Module.End.mem_eigenspace_iff] at hx ⊢
    rw [hf m hm x, hx, map_smul]
  rcases hirr _ hinv with h | h
  · exact absurd h hne
  · intro x
    have hx : x ∈ Module.End.eigenspace f c := by rw [h]; trivial
    rw [Module.End.mem_eigenspace_iff] at hx
    exact hx

/-- **The Schur property holds for irreducible finite-dimensional systems.**
This discharges the `EXTERNAL` hypothesis `IsSchurUnitary` of
`BookProof.ChapterA2` in finite dimensions: a unitary commuting with an
irreducible system is multiplication by a unit-modulus scalar. -/
theorem isSchurUnitary_of_irreducible [FiniteDimensional ℂ V] [Nontrivial V]
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

end BookProof.ChapterSchurFiniteDim
