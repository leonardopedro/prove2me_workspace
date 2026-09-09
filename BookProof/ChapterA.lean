import Mathlib

/-!
# Chapter A — Systems on real and complex Hilbert spaces (foundational core)

This file formalizes the self-contained foundational core of Chapter A of
`book.tex` (see `FORMALIZATION_ROADMAP.md` §A.0–A.2): the notion of a **system**
`(M, V)`, its commutant, subsystems and irreducibility, normal systems, and the
two elementary high-value results the roadmap marks "do in Lean directly":

* **Lemma 26** — for a *normal* system, the orthogonal complement of a subsystem
  is again a subsystem.
* **Lemma 27** — a **Schur** normal system (one whose self-adjoint commuting
  operators are all scalars) is *irreducible*.

The genuinely external representation-theoretic inputs (Schur for unitary /
imprimitivity representations, Weyl complete reducibility, Mackey imprimitivity,
Wigner little-group theory, Pauli's fundamental theorem) are, per the roadmap,
introduced as *named hypotheses* where used — never as `axiom`s.  Here the "Schur"
property is taken as an explicit hypothesis of Lemma 27, matching Def. 13.
-/

open scoped ComplexConjugate InnerProductSpace

namespace BookProof.ChapterA

/-- **Def 1 (System).** A system `(M, V)`: a set `M` of bounded endomorphisms of a
Hilbert space `V` over `𝔽`. -/
structure System (𝔽 : Type*) [RCLike 𝔽] (V : Type*) [NormedAddCommGroup V]
    [InnerProductSpace 𝔽 V] [CompleteSpace V] where
  /-- The set of bounded operators comprising the system. -/
  ops : Set (V →L[𝔽] V)

namespace System

variable {𝔽 : Type*} [RCLike 𝔽] {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace 𝔽 V] [CompleteSpace V]

/-- An operator `S` **commutes with** the system `M` iff it commutes with every
`m ∈ M` (composition is `*` in the endomorphism ring). -/
def Commutes (M : System 𝔽 V) (S : V →L[𝔽] V) : Prop :=
  ∀ m ∈ M.ops, S * m = m * S

/-- **Def 24 (normal system).** `M` is **normal** iff it is closed under the
adjoint `†`. -/
def IsNormal (M : System 𝔽 V) : Prop :=
  ∀ m ∈ M.ops, ContinuousLinearMap.adjoint m ∈ M.ops

/-- **Def 7 (subsystem).** A closed subspace `W` is a **subsystem** of `(M, V)`
iff it is invariant under every `m ∈ M`. -/
def IsSubsystem (M : System 𝔽 V) (W : Submodule 𝔽 V) : Prop :=
  IsClosed (W : Set V) ∧ ∀ m ∈ M.ops, ∀ w ∈ W, m w ∈ W

/-- **Def 7 (irreducibility).** `(M, V)` is **irreducible** iff its only
subsystems are `⊥` and `⊤`. -/
def IsIrreducible (M : System 𝔽 V) : Prop :=
  ∀ W : Submodule 𝔽 V, IsSubsystem M W → W = ⊥ ∨ W = ⊤

/-
**Lemma 26.** For a *normal* system `M`, the orthogonal complement of a
subsystem is a subsystem.
-/
theorem orthogonal_isSubsystem (M : System 𝔽 V) (hM : IsNormal M)
    {W : Submodule 𝔽 V} (hW : IsSubsystem M W) : IsSubsystem M Wᗮ := by
  refine ⟨ ?_, ?_ ⟩;
  · exact Submodule.isClosed_orthogonal W
  · intro m hm w hw v hv; have := hM m hm; simp_all only [Submodule.mem_orthogonal'] ;
    rw [ ← ContinuousLinearMap.adjoint_inner_left ];
    rw [ ← inner_conj_symm, hw _ ( hW.2 _ this _ hv ) ] ; simp

/-
**Lemma 27.** A **Schur** normal system is irreducible.  Here the Schur
hypothesis (Def. 13: the algebra of self-adjoint operators commuting with `M`
is `𝔽`) is stated directly: every self-adjoint operator commuting with `M` is a
scalar multiple of the identity.
-/
theorem schur_normal_irreducible (M : System 𝔽 V) (hM : IsNormal M)
    (hSchur : ∀ S : V →L[𝔽] V, M.Commutes S → IsSelfAdjoint S →
      ∃ c : 𝔽, S = c • (1 : V →L[𝔽] V)) :
    IsIrreducible M := by
  intro W hW
  obtain ⟨hW_subsystem, hW_closed⟩ := hW
  have hW_orthogonal : IsClosed (Wᗮ : Set V) ∧ ∀ m ∈ M.ops, ∀ w ∈ Wᗮ, m w ∈ Wᗮ := by
    convert orthogonal_isSubsystem M hM ⟨ hW_subsystem, hW_closed ⟩ using 1;
  obtain ⟨c, hc⟩ := hSchur (W.starProjection) (by
  intro m hm;    ext v; simp only [ContinuousLinearMap.coe_mul, Function.comp_apply]  ;  have
      h_decomp : m v = m (W.starProjection v) + m (v -
      W.starProjection v) := by
    rw [ ← map_add, add_sub_cancel ];
  have h_comm : W.starProjection (m (v - W.starProjection v)) = 0 := by
    have h_comm : m (v - W.starProjection v) ∈ Wᗮ := by
      exact hW_orthogonal.2 m hm _ ( Submodule.sub_starProjection_mem_orthogonal v );
    exact (Submodule.starProjection_apply_eq_zero_iff W).mpr h_comm
  rw [ h_decomp, map_add, h_comm, add_zero ];
  exact Submodule.starProjection_eq_self_iff.mpr ( hW_closed m hm _ ( Submodule.coe_mem _ ) )) (by
  grind +suggestions);
  by_cases hc0 : c = 0;
  · simp_all only [zero_smul, Submodule.eq_bot_iff];
    left;
    intro x hx;      replace hc := congr_arg ( fun f => f x ) hc;      simp_all  ;
    rw [ Submodule.starProjection_eq_self_iff.mpr hx ] at hc ; aesop;
  · have hW_top : ∀ v : V, v ∈ W := by
      intro v
      have hv : v = (c⁻¹ • W.starProjection) v := by
        simp [ hc, hc0 ];
      exact hv.symm ▸ Submodule.smul_mem _ _ ( Submodule.coe_mem _ );
    exact Or.inr ( eq_top_iff.mpr fun v _ => hW_top v )

end System

end BookProof.ChapterA
