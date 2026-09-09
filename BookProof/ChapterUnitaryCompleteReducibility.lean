import Mathlib

/-!
# The unitarian trick: complete reducibility of unitary representations

`BookProof.ChapterA3w` takes **Weyl's complete-reducibility theorem** as an
`EXTERNAL` named hypothesis, because for the *non-compact* group `SL(2,ℂ)` it is
genuinely unavailable in Mathlib.  For **unitary** representations the theorem is
elementary — it is Weyl's *unitarian trick* — and this file proves it outright,
with no external input:

* `orthogonal_isInvariant` — the orthogonal complement of an invariant subspace
  of a unitary representation is invariant (valid in any complex inner-product
  space, any group);
* `unitary_complete_reducibility` — in finite dimensions every invariant subspace
  therefore has an invariant complement, namely its orthogonal complement;
* `exists_irreducible_invariant_le` — every nonzero invariant subspace contains an
  irreducible one (a minimal nonzero invariant subspace);
* `exists_irreducible_decomposition` — every invariant subspace is the join of a
  finite list of irreducible invariant subspaces, so a finite-dimensional unitary
  representation is a sum of irreducibles.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterUnitaryCompleteReducibility

open Submodule

variable {G : Type*} [Group G] {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

/-- A subspace `W` is **invariant** under the unitary representation `ρ` iff every
`ρ g` maps `W` into itself. -/
def IsInvariant (ρ : G →* (V ≃ₗᵢ[ℂ] V)) (W : Submodule ℂ V) : Prop :=
  ∀ g : G, ∀ x ∈ W, ρ g x ∈ W

/-- An invariant subspace is **irreducible** iff it is nonzero and its only
invariant subspaces are `⊥` and itself. -/
def IsIrreducibleInvariant (ρ : G →* (V ≃ₗᵢ[ℂ] V)) (W : Submodule ℂ V) : Prop :=
  IsInvariant ρ W ∧ W ≠ ⊥ ∧ ∀ U ≤ W, IsInvariant ρ U → U = ⊥ ∨ U = W

theorem isInvariant_top (ρ : G →* (V ≃ₗᵢ[ℂ] V)) : IsInvariant ρ (⊤ : Submodule ℂ V) :=
  fun _ _ _ => trivial

theorem isInvariant_bot (ρ : G →* (V ≃ₗᵢ[ℂ] V)) : IsInvariant ρ (⊥ : Submodule ℂ V) := by
  intro g x hx
  rw [Submodule.mem_bot] at hx ⊢
  rw [hx, map_zero]

/-- **Invariance is stable under the inverse.**  Since `ρ g` is a linear isometry
*equivalence*, an invariant subspace is mapped onto itself, so it is also
invariant under `(ρ g)⁻¹`. -/
theorem inv_mem_of_isInvariant {ρ : G →* (V ≃ₗᵢ[ℂ] V)} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) (g : G) {x : V} (hx : x ∈ W) : (ρ g).symm x ∈ W := by
  have h : ρ g⁻¹ x ∈ W := hW g⁻¹ x hx
  have hsymm : (ρ g).symm x = ρ g⁻¹ x := by simp [map_inv]
  rwa [hsymm]

/-- **The unitarian trick.**  The orthogonal complement of an invariant subspace of
a unitary representation is invariant. -/
theorem orthogonal_isInvariant {ρ : G →* (V ≃ₗᵢ[ℂ] V)} {W : Submodule ℂ V}
    (hW : IsInvariant ρ W) : IsInvariant ρ Wᗮ := by
  intro g y hy
  rw [Submodule.mem_orthogonal]
  intro x hx
  have hx' : (ρ g).symm x ∈ W := inv_mem_of_isInvariant hW g hx
  have := hy ((ρ g).symm x) hx'
  calc inner ℂ x (ρ g y) = inner ℂ (ρ g ((ρ g).symm x)) (ρ g y) := by
        rw [LinearIsometryEquiv.apply_symm_apply]
    _ = inner ℂ ((ρ g).symm x) y := LinearIsometryEquiv.inner_map_map _ _ _
    _ = 0 := this

/-- **Complete reducibility of a finite-dimensional unitary representation.**
Every invariant subspace has an invariant complement — its orthogonal
complement.  This is the conclusion that `ChapterA3w` has to assume for
`SL(2,ℂ)`; for unitary representations it is a theorem. -/
theorem unitary_complete_reducibility [FiniteDimensional ℂ V]
    {ρ : G →* (V ≃ₗᵢ[ℂ] V)} {W : Submodule ℂ V} (hW : IsInvariant ρ W) :
    ∃ W' : Submodule ℂ V, IsInvariant ρ W' ∧ IsCompl W W' :=
  ⟨Wᗮ, orthogonal_isInvariant hW, Submodule.isCompl_orthogonal_of_hasOrthogonalProjection⟩

/-- Every nonzero invariant subspace of a finite-dimensional unitary representation
contains an **irreducible** invariant subspace: choose one of minimal positive
dimension. -/
theorem exists_irreducible_invariant_le [FiniteDimensional ℂ V]
    {ρ : G →* (V ≃ₗᵢ[ℂ] V)} {U : Submodule ℂ V} (hU : IsInvariant ρ U) (hUne : U ≠ ⊥) :
    ∃ W ≤ U, IsIrreducibleInvariant ρ W := by
  classical
  -- Among all nonzero invariant subspaces contained in `U`, pick one of least rank.
  have hne : ∃ n : ℕ, ∃ W : Submodule ℂ V,
      W ≤ U ∧ IsInvariant ρ W ∧ W ≠ ⊥ ∧ Module.finrank ℂ W = n :=
    ⟨Module.finrank ℂ U, U, le_rfl, hU, hUne, rfl⟩
  obtain ⟨W, hWU, hWinv, hWne, hWrank⟩ := Nat.find_spec hne
  refine ⟨W, hWU, hWinv, hWne, ?_⟩
  intro Z hZW hZinv
  by_cases hZ : Z = ⊥
  · exact Or.inl hZ
  · right
    have hZU : Z ≤ U := hZW.trans hWU
    have hle : Module.finrank ℂ Z ≤ Module.finrank ℂ W := Submodule.finrank_mono hZW
    have hmin : Nat.find hne ≤ Module.finrank ℂ Z :=
      Nat.find_min' hne ⟨Z, hZU, hZinv, hZ, rfl⟩
    have : Module.finrank ℂ Z = Module.finrank ℂ W := le_antisymm hle (hWrank ▸ hmin)
    exact Submodule.eq_of_le_of_finrank_eq hZW this

/-- **Decomposition into irreducibles.**  Every invariant subspace of a
finite-dimensional unitary representation is the join of a finite list of
irreducible invariant subspaces.  In particular (taking `U = ⊤`) the whole
representation is a sum of irreducibles. -/
theorem exists_irreducible_decomposition [FiniteDimensional ℂ V]
    {ρ : G →* (V ≃ₗᵢ[ℂ] V)} (U : Submodule ℂ V) (hU : IsInvariant ρ U) :
    ∃ L : List (Submodule ℂ V),
      (∀ W ∈ L, W ≤ U ∧ IsIrreducibleInvariant ρ W) ∧
        L.foldr (· ⊔ ·) ⊥ = U := by
  classical
  induction hn : Module.finrank ℂ U using Nat.strong_induction_on generalizing U with
  | _ n ih =>
    by_cases hUbot : U = ⊥
    · exact ⟨[], by simp, by simp [hUbot]⟩
    obtain ⟨W, hWU, hWirr⟩ := exists_irreducible_invariant_le hU hUbot
    have hWinv : IsInvariant ρ W := hWirr.1
    have hWne : W ≠ ⊥ := hWirr.2.1
    have hcompl : IsCompl W Wᗮ :=
      Submodule.isCompl_orthogonal_of_hasOrthogonalProjection
    set U' : Submodule ℂ V := U ⊓ Wᗮ with hU'def
    have hU'inv : IsInvariant ρ U' := by
      intro g x hx
      exact ⟨hU g x hx.1, orthogonal_isInvariant hWinv g x hx.2⟩
    have hsup : W ⊔ U' = U := by
      apply le_antisymm
      · exact sup_le hWU inf_le_left
      · intro u hu
        have hmem : u ∈ W ⊔ Wᗮ := by rw [hcompl.sup_eq_top]; trivial
        obtain ⟨w, hw, z, hz, rfl⟩ := Submodule.mem_sup.1 hmem
        have hwU : w ∈ U := hWU hw
        have hzU : z ∈ U := by
          have hz' : z = (w + z) - w := by abel
          rw [hz']
          exact U.sub_mem hu hwU
        exact Submodule.mem_sup.2 ⟨w, hw, z, ⟨hzU, hz⟩, rfl⟩
    have hdisj : W ⊓ U' = ⊥ := by
      have hle : W ⊓ U' ≤ W ⊓ Wᗮ := inf_le_inf_left W inf_le_right
      rw [hcompl.inf_eq_bot] at hle
      exact le_bot_iff.1 hle
    have hWpos : 0 < Module.finrank ℂ W :=
      Module.finrank_pos_iff.2 (Submodule.nontrivial_iff_ne_bot.2 hWne)
    have hrank : Module.finrank ℂ W + Module.finrank ℂ U' = Module.finrank ℂ U := by
      have := Submodule.finrank_sup_add_finrank_inf_eq W U'
      rw [hsup, hdisj] at this
      simpa using this.symm
    have hlt : Module.finrank ℂ U' < n := by omega
    obtain ⟨L, hL, hLsup⟩ := ih _ hlt U' hU'inv rfl
    refine ⟨W :: L, ?_, ?_⟩
    · intro Z hZ
      rcases List.mem_cons.1 hZ with rfl | hZL
      · exact ⟨hWU, hWirr⟩
      · exact ⟨(hL Z hZL).1.trans inf_le_left, (hL Z hZL).2⟩
    · simp [hLsup, hsup]

end BookProof.ChapterUnitaryCompleteReducibility
