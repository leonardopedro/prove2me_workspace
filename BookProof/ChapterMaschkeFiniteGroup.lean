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

theorem rho_rho (ρ : Representation ℂ G V) (a b : G) (x : V) :
    ρ a (ρ b x) = ρ (a * b) x := by
  rw [map_mul]; rfl

/-- The **group average** of a linear map: `|G|⁻¹ ∑_g ρ(g) ∘ π ∘ ρ(g⁻¹)`. -/
noncomputable def avgProj [Fintype G] (ρ : Representation ℂ G V) (pi : V →ₗ[ℂ] V) : V →ₗ[ℂ] V :=
  (Fintype.card G : ℂ)⁻¹ • ∑ g : G, (ρ g) ∘ₗ pi ∘ₗ (ρ g⁻¹)

theorem avgProj_apply [Fintype G] (ρ : Representation ℂ G V) (pi : V →ₗ[ℂ] V) (x : V) :
    avgProj ρ pi x = (Fintype.card G : ℂ)⁻¹ • ∑ g : G, ρ g (pi (ρ g⁻¹ x)) := by
  simp [avgProj, LinearMap.sum_apply]

/-- The average of a projection onto an invariant subspace still lands in that
subspace. -/
theorem avgProj_mem [Fintype G] {ρ : Representation ℂ G V} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (pi : V →ₗ[ℂ] V) (hpi : ∀ x, pi x ∈ W) (x : V) : avgProj ρ pi x ∈ W := by
  rw [avgProj_apply]
  exact W.smul_mem _ (W.sum_mem fun g _ => hW g _ (hpi _))

/-- The average of a projection onto `W` is still the identity on `W`. -/
theorem avgProj_eq_self [Fintype G] {ρ : Representation ℂ G V} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (pi : V →ₗ[ℂ] V) (hpi : ∀ x ∈ W, pi x = x) {x : V} (hx : x ∈ W) :
    avgProj ρ pi x = x := by
  have hterm : ∀ g : G, ρ g (pi (ρ g⁻¹ x)) = x := by
    intro g
    have hmem : ρ g⁻¹ x ∈ W := hW g⁻¹ x hx
    rw [hpi _ hmem, rho_rho]
    simp
  have hcard : (Fintype.card G : ℂ) ≠ 0 := by
    exact_mod_cast Nat.cast_ne_zero.mpr (Fintype.card_ne_zero)
  rw [avgProj_apply]
  simp only [hterm, Finset.sum_const, Finset.card_univ]
  rw [← Nat.cast_smul_eq_nsmul ℂ, smul_smul, inv_mul_cancel₀ hcard, one_smul]

/-- **The averaged projection commutes with the representation.**  This is the
whole point of averaging. -/
theorem avgProj_comm [Fintype G] (ρ : Representation ℂ G V) (pi : V →ₗ[ℂ] V) (h : G) (x : V) :
    avgProj ρ pi (ρ h x) = ρ h (avgProj ρ pi x) := by
  rw [avgProj_apply, avgProj_apply, map_smul]
  congr 1
  rw [map_sum]
  refine Fintype.sum_equiv (Equiv.mulLeft h⁻¹) _ _ ?_
  intro g
  simp only [Equiv.coe_mulLeft]
  have h1 : ρ g⁻¹ (ρ h x) = ρ (g⁻¹ * h) x := rho_rho ρ _ _ _
  have h2 : ρ h (ρ (h⁻¹ * g) (pi (ρ (h⁻¹ * g)⁻¹ x)))
      = ρ (h * (h⁻¹ * g)) (pi (ρ (h⁻¹ * g)⁻¹ x)) := rho_rho ρ _ _ _
  have h3 : h * (h⁻¹ * g) = g := by group
  have h4 : (h⁻¹ * g)⁻¹ = g⁻¹ * h := by group
  rw [h1, h2, h3, h4]

/-- The averaged projection is **idempotent**: it is a genuine projection. -/
theorem avgProj_idempotent [Fintype G] {ρ : Representation ℂ G V} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (pi : V →ₗ[ℂ] V) (hpi_mem : ∀ x, pi x ∈ W)
    (hpi_id : ∀ x ∈ W, pi x = x) (x : V) :
    avgProj ρ pi (avgProj ρ pi x) = avgProj ρ pi x :=
  avgProj_eq_self hW pi hpi_id (avgProj_mem hW pi hpi_mem x)

/-- The **range of the averaged projection is exactly the invariant subspace**
`W` it was built from. -/
theorem avgProj_range_eq_W [Fintype G] {ρ : Representation ℂ G V} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (pi : V →ₗ[ℂ] V) (hpi_mem : ∀ x, pi x ∈ W)
    (hpi_id : ∀ x ∈ W, pi x = x) :
    LinearMap.range (avgProj ρ pi) = W := by
  refine le_antisymm ?_ ?_
  · rintro y ⟨x, rfl⟩
    exact avgProj_mem hW pi hpi_mem x
  · intro x hx
    exact ⟨x, avgProj_eq_self hW pi hpi_id hx⟩

/-- **Maschke's theorem (complete reducibility for finite groups).**  Every
invariant subspace of a finite-dimensional complex representation of a finite
group has an invariant complement.  This is the exact conclusion that
`ChapterA3w.WeylCompleteReducibility` assumes for `SL(2,ℂ)`, here *proved* for
finite groups. -/
theorem maschke_invariant_complement [Finite G] [FiniteDimensional ℂ V]
    (ρ : Representation ℂ G V) (W : Submodule ℂ V) (hW : IsInvariant ρ W) :
    ∃ W' : Submodule ℂ V, IsInvariant ρ W' ∧ IsCompl W W' := by
  classical
  letI : Fintype G := Fintype.ofFinite G
  obtain ⟨W₀, hW₀⟩ := Submodule.exists_isCompl W
  set pi : V →ₗ[ℂ] V := W.subtype ∘ₗ W.linearProjOfIsCompl W₀ hW₀ with hpidef
  have hpi_mem : ∀ x, pi x ∈ W := fun x => (W.linearProjOfIsCompl W₀ hW₀ x).2
  have hpi_id : ∀ x ∈ W, pi x = x := by
    intro x hx
    simp [hpidef, Submodule.linearProjOfIsCompl_apply_left hW₀ ⟨x, hx⟩]
  set p : V →ₗ[ℂ] V := avgProj ρ pi with hpdef
  have hp_mem : ∀ x, p x ∈ W := avgProj_mem hW pi hpi_mem
  have hp_id : ∀ x ∈ W, p x = x := fun x hx => avgProj_eq_self hW pi hpi_id hx
  refine ⟨LinearMap.ker p, ?_, ?_⟩
  · intro g x hx
    have : p (ρ g x) = ρ g (p x) := avgProj_comm ρ pi g x
    simp only [LinearMap.mem_ker] at hx ⊢
    rw [this, hx, map_zero]
  · constructor
    · rw [disjoint_iff_inf_le]
      intro x hx
      have hx1 : x ∈ W := hx.1
      have hx2 : p x = 0 := hx.2
      rw [hp_id x hx1] at hx2
      simp [hx2]
    · rw [codisjoint_iff_le_sup]
      intro x _
      have hpx : p x ∈ W := hp_mem x
      have hker : x - p x ∈ LinearMap.ker p := by
        simp only [LinearMap.mem_ker, map_sub]
        rw [hp_id _ hpx, sub_self]
      have : x = p x + (x - p x) := by abel
      rw [this]
      exact Submodule.add_mem_sup hpx hker

/-- **Maschke's theorem, packaged as a decomposition.**  For every invariant
subspace `W` of a finite-dimensional complex representation of a finite group
there are an invariant complement `W'` and an *equivariant projection* `p` onto
`W` along `W'`: `p` is idempotent, its range is `W`, its kernel is `W'`, and it
commutes with the representation.  This is the book's phrasing "every invariant
subspace is a direct summand", with the intertwining projection exhibited. -/
theorem maschke_decomposition [Finite G] [FiniteDimensional ℂ V]
    (ρ : Representation ℂ G V) (W : Submodule ℂ V) (hW : IsInvariant ρ W) :
    ∃ (W' : Submodule ℂ V) (p : V →ₗ[ℂ] V),
      IsInvariant ρ W' ∧ IsCompl W W' ∧ (∀ x, p (p x) = p x) ∧
        LinearMap.range p = W ∧ LinearMap.ker p = W' ∧
        (∀ (g : G) (x : V), p (ρ g x) = ρ g (p x)) := by
  classical
  letI : Fintype G := Fintype.ofFinite G
  obtain ⟨W₀, hW₀⟩ := Submodule.exists_isCompl W
  set pi : V →ₗ[ℂ] V := W.subtype ∘ₗ W.linearProjOfIsCompl W₀ hW₀ with hpidef
  have hpi_mem : ∀ x, pi x ∈ W := fun x => (W.linearProjOfIsCompl W₀ hW₀ x).2
  have hpi_id : ∀ x ∈ W, pi x = x := by
    intro x hx
    simp [hpidef, Submodule.linearProjOfIsCompl_apply_left hW₀ ⟨x, hx⟩]
  set p : V →ₗ[ℂ] V := avgProj ρ pi with hpdef
  have hp_mem : ∀ x, p x ∈ W := avgProj_mem hW pi hpi_mem
  have hp_id : ∀ x ∈ W, p x = x := fun x hx => avgProj_eq_self hW pi hpi_id hx
  have hp_comm : ∀ (g : G) (x : V), p (ρ g x) = ρ g (p x) := avgProj_comm ρ pi
  refine ⟨LinearMap.ker p, p, ?_, ?_, ?_, ?_, rfl, hp_comm⟩
  · intro g x hx
    simp only [LinearMap.mem_ker] at hx ⊢
    rw [hp_comm g x, hx, map_zero]
  · constructor
    · rw [disjoint_iff_inf_le]
      intro x hx
      have hx2 : p x = 0 := hx.2
      rw [hp_id x hx.1] at hx2
      simp [hx2]
    · rw [codisjoint_iff_le_sup]
      intro x _
      have hpx : p x ∈ W := hp_mem x
      have hker : x - p x ∈ LinearMap.ker p := by
        simp only [LinearMap.mem_ker, map_sub]
        rw [hp_id _ hpx, sub_self]
      have hsplit : x = p x + (x - p x) := by abel
      rw [hsplit]
      exact Submodule.add_mem_sup hpx hker
  · exact fun x => hp_id _ (hp_mem x)
  · exact avgProj_range_eq_W hW pi hpi_mem hpi_id

end BookProof.ChapterMaschkeFiniteGroup
