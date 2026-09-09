import Mathlib
import BookProof.ChapterA
import BookProof.ChapterA1
import BookProof.ChapterA1c

/-!
# Chapter A, §A.2 — Schur systems and uniqueness of the antiisometry (work-package N2)

This file begins work-package **N2** of `FORMALIZATION_ROADMAP.md` (§A.2, the
commutant classification).  It formalizes the self-contained algebraic layer:
the **Schur property for unitaries** as a named predicate (the roadmap flags the
unitary-representation Schur lemma as an `EXTERNAL` input, so it is introduced as
a hypothesis, never an `axiom`) and **Lemma 14** — the uniqueness of the
antiisometry up to a unit phase.

* `CommutesUnitary` / `IsSchurUnitary` — a `ℂ`-linear isometric equivalence
  commuting with `M`, and the Schur property that every such is a scalar of
  modulus one.
* `antiisometry_unique_up_to_phase` (**Lemma 14**) — in a Schur system, any two
  anti-unitaries commuting with `M` differ by a unit complex phase.
* `commuting_antiUnitary_scalar_multiple` — the immediate corollary that once
  one commuting anti-unitary exists, every commuting anti-unitary is a unit
  scalar multiple of it (uniqueness of the C-conjugation up to phase).

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped ComplexConjugate InnerProductSpace

namespace BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

/-! ## The Schur property for unitaries -/

/-- A `ℂ`-linear isometric equivalence `g` **commutes with** the system `M` iff
it commutes with every `m ∈ M`. -/
def CommutesUnitary (M : System ℂ V) (g : V ≃ₗᵢ[ℂ] V) : Prop :=
  ∀ m ∈ M.ops, ∀ x, g (m x) = m (g x)

/-- **Def 13 (Schur, unitary form).**  `M` is *Schur for unitaries* iff every
`ℂ`-linear isometric equivalence commuting with `M` is a scalar of modulus one.
The roadmap flags the unitary-representation Schur lemma as an `EXTERNAL`
theorem (not available in Mathlib); it is used here only as a named hypothesis,
never an `axiom`. -/
def IsSchurUnitary (M : System ℂ V) : Prop :=
  ∀ g : V ≃ₗᵢ[ℂ] V, CommutesUnitary M g → ∃ c : ℂ, ‖c‖ = 1 ∧ ∀ x, g x = c • x

/-! ## Lemma 14 — uniqueness of the antiisometry up to phase -/

/-- **Lemma 14.**  In a Schur system `(M, V)`, any two anti-unitary operators
`θ₁, θ₂` commuting with `M` differ by a unit complex phase: `θ₂ = c · θ₁` with
`‖c‖ = 1`.

*Proof.*  The composite `g := θ₂ ∘ θ₁⁻¹` is a `ℂ`-linear isometric equivalence
(the product of two anti-unitaries is unitary) commuting with `M` (since
`θ₁⁻¹` and `θ₂` both do), hence by the Schur property `g = c` with `‖c‖ = 1`;
evaluating `g (θ₁ x) = θ₂ x = c • θ₁ x`. -/
theorem antiisometry_unique_up_to_phase (M : System ℂ V) (hSchur : IsSchurUnitary M)
    {θ₁ θ₂ : AntiUnitary V} (h₁ : CommutesAntiUnitary M θ₁) (h₂ : CommutesAntiUnitary M θ₂) :
    ∃ c : ℂ, ‖c‖ = 1 ∧ ∀ x, θ₂ x = c • θ₁ x := by
  -- `θ₁⁻¹` commutes with `M`.
  have h₁' : ∀ m ∈ M.ops, ∀ x, θ₁.symm (m x) = m (θ₁.symm x) := by
    intro m hm x
    apply θ₁.injective
    rw [θ₁.apply_symm_apply, h₁ m hm, θ₁.apply_symm_apply]
  -- `g := θ₂ ∘ θ₁⁻¹` is a `ℂ`-linear isometry commuting with `M`.
  set g : V ≃ₗᵢ[ℂ] V := θ₁.symm.trans θ₂ with hg
  have hgapp : ∀ x, g x = θ₂ (θ₁.symm x) := fun x => rfl
  have hgcomm : CommutesUnitary M g := by
    intro m hm x
    rw [hgapp, hgapp, h₁' m hm, h₂ m hm]
  obtain ⟨c, hc, hcg⟩ := hSchur g hgcomm
  refine ⟨c, hc, fun x => ?_⟩
  have := hcg (θ₁ x)
  rwa [hgapp, θ₁.symm_apply_apply] at this

/-- **Uniqueness of the C-conjugation up to phase.**  Given a fixed commuting
anti-unitary `θ₁` of a Schur system, every commuting anti-unitary `θ₂` is a unit
scalar multiple of `θ₁`. -/
theorem commuting_antiUnitary_scalar_multiple (M : System ℂ V) (hSchur : IsSchurUnitary M)
    {θ₁ θ₂ : AntiUnitary V} (h₁ : CommutesAntiUnitary M θ₁) (h₂ : CommutesAntiUnitary M θ₂) :
    ∃ c : ℂ, ‖c‖ = 1 ∧ ∀ x, θ₂ x = c • θ₁ x :=
  antiisometry_unique_up_to_phase M hSchur h₁ h₂

end BookProof.ChapterA
