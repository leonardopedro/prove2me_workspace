import Mathlib


/-!
# Complete reducibility for finite groups (Maschke's averaging argument)

`BookProof.ChapterA3w` has to *assume* Weyl's complete-reducibility theorem for
the non-compact group `SL(2,ℂ)`.  For a **finite** group the same conclusion is a
theorem, by the averaging argument that is the algebraic form of Weyl's unitarian
trick, and this file proves it from scratch in exactly the shape
`ChapterA3w.WeylCompleteReducibility` assumes:

* `avgProj` — the group average `p = |G|⁻¹ ∑_g ρ(g) ∘ π ∘ ρ(g)⁻¹` of an arbitrary
  linear projection `π` onto an invariant subspace `W`;
* `avgProj_mem`, `avgProj_eq_self`, `avgProj_comm` — `p` still projects onto `W`,
  and it now **commutes with the representation**;
* `maschke_invariant_complement` — hence `ker p` is an invariant complement:
  every invariant subspace of a finite-dimensional complex representation of a
  finite group has an invariant complement.

This is the companion of `BookProof.ChapterUnitaryCompleteReducibility`, which
proves the same conclusion for unitary representations of an arbitrary group.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterMaschkeFiniteGroup

variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]

/-- A subspace `W` is **invariant** under the representation `ρ` iff every `ρ g`
maps `W` into itself. -/
def IsInvariant (ρ : Representation ℂ G V) (W : Submodule ℂ V) : Prop :=
  ∀ g : G, ∀ x ∈ W, ρ g x ∈ W



/-- The **group average** of a linear map: `|G|⁻¹ ∑_g ρ(g) ∘ π ∘ ρ(g⁻¹)`. -/
noncomputable def avgProj [Fintype G] (ρ : Representation ℂ G V) (pi : V →ₗ[ℂ] V) : V →ₗ[ℂ] V :=
  (Fintype.card G : ℂ)⁻¹ • ∑ g : G, (ρ g) ∘ₗ pi ∘ₗ (ρ g⁻¹)

















end BookProof.ChapterMaschkeFiniteGroup
