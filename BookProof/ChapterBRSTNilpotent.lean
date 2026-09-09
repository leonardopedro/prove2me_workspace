import Mathlib

/-!
# Chapter *"Quantization due to time-evolution: Yang-Mills and Classical Statistical Field Theory"*,
§*"Pure SU(3) Yang-Mills theory"*: nilpotency of the BRST charge

This file formalizes the central algebraic fact behind the book's BRST/gauge
programme (`book.tex` lines ~7050 and ~7343): the **nilpotency of the BRST
charge**

  `Ω(x) = π^μ_a ∂_μ ψ†_a − π^μ_a f_{abc} A_{μ b} ψ†_c − (i/2) f_{abc} ψ†_a ψ†_b ψ_c`,

`Ω² = 0`, which is what makes the BRST cohomology (hence the physical /
gauge-invariant algebra that the book proposes as the definition of Quantum
Yang-Mills) well defined.

We isolate the **cubic ghost term**, the only part whose nilpotency requires the
non-abelian structure of the gauge group, and prove that it squares to zero.
Concretely: in any associative `ℝ`-algebra `R`, given

* ghost creation operators `χ : Fin n → R` (the book's `ψ†_a`) and annihilation
  operators `β : Fin n → R` (the book's `ψ_a`) satisfying the **canonical
  anticommutation relations**
  `{χ_a, χ_b} = 0`, `{β_a, β_b} = 0`, `{β_a, χ_b} = δ_{ab}`, and
* real structure constants `f : Fin n → Fin n → Fin n → ℝ` that are
  **antisymmetric** in their first two indices and satisfy the **Jacobi
  identity** `∑_e (f_{abe} f_{ecg} + f_{bce} f_{eag} + f_{cae} f_{ebg}) = 0`
  (both proved for the SU(N) generators in `ChapterYangMillsSU3.lean`),

the cubic ghost charge

  `Q = ∑_{a,b,e} f_{abe} · (χ_a χ_b β_e)`

satisfies `Q · Q = 0` (`brst_charge_nilpotent`).

The proof normal-orders `Q²`: pushing the middle annihilation operator through
the two creation operators (`beta_move`) splits `Q²` into a **purely quartic**
ghost term that vanishes by fermionic antisymmetry alone (`quartic_term_zero`,
using `chi_swap4`) and two **contracted** terms that combine and vanish by the
Jacobi identity (`contracted_terms_zero`).
-/

namespace BookProof.BRSTNilpotent

variable {R : Type*} [Ring R] [Algebra ℝ R]
variable {n : ℕ}

/-- Canonical anticommutation relations for the ghost creation (`χ`, i.e. `ψ†`)
and annihilation (`β`, i.e. `ψ`) operators. -/
structure GhostCAR (χ β : Fin n → R) : Prop where
  /-- creation operators anticommute: `{χ_a, χ_b} = 0`. -/
  chichi : ∀ a b, χ a * χ b + χ b * χ a = 0
  /-- annihilation operators anticommute: `{β_a, β_b} = 0`. -/
  betabeta : ∀ a b, β a * β b + β b * β a = 0
  /-- mixed relation: `{β_a, χ_b} = δ_{ab}·1`. -/
  betachi : ∀ a b, β a * χ b + χ b * β a = if a = b then 1 else 0

/-- The cubic ghost part of the BRST charge,
`Q = ∑_{a,b,e} f_{abe} · (χ_a · χ_b · β_e)`. -/
noncomputable def Q (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R) : R :=
  ∑ a, ∑ b, ∑ e, f a b e • (χ a * χ b * β e)

omit [Algebra ℝ R] in
/-
**Normal ordering of a single annihilation operator.** Pushing `β_e` past a
pair of creation operators produces two contraction terms and a normal-ordered
remainder.
-/
lemma beta_move (χ β : Fin n → R) (hCAR : GhostCAR χ β) (e d g : Fin n) :
    β e * (χ d * χ g)
      = (if e = d then χ g else 0) - (if e = g then χ d else 0) + χ d * χ g * β e := by
  have h_combined : β e * (χ d * χ g) = (β e * χ d) * χ g := by
    rw [ mul_assoc ];
  convert congr_arg ( · * χ g ) ( show β e * χ d = ( if e = d then 1 else 0 ) - χ d * β e from ?_ )
                        using 1;
  · have := hCAR.betachi e g; simp_all only [mul_assoc, sub_mul, ite_mul, one_mul, zero_mul] ;
    split_ifs <;>
      simp_all only [← eq_sub_iff_add_eq', sub_self, zero_add, ↓reduceIte, sub_zero, zero_sub,
        mul_neg, sub_sub_cancel_left, sub_neg_eq_add];
    · rw [ mul_sub, mul_one ];
    · grind;
  · exact eq_sub_of_add_eq ( hCAR.betachi e d )

omit [Algebra ℝ R] in
/-
**Four creation operators can be reordered in pairs** (with sign `+1`):
`χ_a χ_b χ_c χ_d = χ_c χ_d χ_a χ_b`, since moving one anticommuting pair past
another is an even permutation.
-/
lemma chi_swap4 (χ β : Fin n → R) (hCAR : GhostCAR χ β) (a b c d : Fin n) :
    χ a * χ b * χ c * χ d = χ c * χ d * χ a * χ b := by
  -- By anticommuting χa past χc and χd, we get another negative sign.
  have h_acd : χ a * (χ c * χ d) = (χ c * χ d) * χ a := by
    have := hCAR.chichi a c;      have := hCAR.chichi a d;      have := hCAR.chichi c d; simp_all [
        mul_assoc, ← eq_sub_iff_add_eq ] ;
    simp_all [ ← mul_assoc ];
    simp_all [ mul_assoc ];
  have h_comm : χ b * (χ c * χ d) = (χ c * χ d) * χ b := by
    simp_all [ ← mul_assoc ];
    have := hCAR.chichi b c;      have := hCAR.chichi b d; simp_all [ mul_assoc,
        add_eq_zero_iff_eq_neg ] ;
  grind

omit [Algebra ℝ R] in
/-
**Cyclic rotation of three creation operators** (sign `+1`):
`χ_a χ_b χ_c = χ_b χ_c χ_a`, a cyclic permutation of three anticommuting
elements being an even permutation.
-/
lemma chi_cyc3 (χ β : Fin n → R) (hCAR : GhostCAR χ β) (a b c : Fin n) :
    χ a * χ b * χ c = χ b * χ c * χ a := by
  have h1 : χ a * χ b = - (χ b * χ a) := by
    exact eq_neg_of_add_eq_zero_left ( hCAR.chichi a b )
  have h2 : χ a * χ c = - (χ c * χ a) := by
    exact eq_neg_of_add_eq_zero_left ( hCAR.chichi a c );
  simp [ mul_assoc, h1, h2 ]

/-
**The purely quartic ghost term vanishes.**  The fully normal-ordered piece
of `Q²`, `∑ f_{abe} f_{dgh} · (χ_a χ_b χ_d χ_g β_e β_h)`, is antisymmetric under
exchanging the two `Q`-factors (even sign on the four `χ`'s, odd sign on the two
`β`'s), hence equals its own negative and so is zero.
-/
lemma quartic_term_zero (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R)
    (hCAR : GhostCAR χ β) :
    (∑ a, ∑ b, ∑ e, ∑ d, ∑ g, ∑ h,
      (f a b e * f d g h) • (χ a * χ b * χ d * χ g * β e * β h)) = 0 := by
  by_contra h_nonzero;
  -- Reindex the sum by swapping the two index-triples `(a,b,e) ↔ (d,g,h)`.
  have h_reindex : ∑ a : Fin n,    ∑ b : Fin n,    ∑ e : Fin n,    ∑ d : Fin n,    ∑ g : Fin n,    ∑
      h : Fin n,    (f a b e * f d g h) • (χ a * χ b * χ d * χ g * β e * β h) = ∑ a : Fin n,    ∑ b
          : Fin n,    ∑ e : Fin n,    ∑ d : Fin n,    ∑ g : Fin n, ∑ h : Fin n, (f a b e * f d g h)
              • (χ d * χ g * χ a * χ b * β h * β e) := by
    simp only [Finset.sum_sigma'];
    apply Finset.sum_bij (fun x _ => ⟨x.snd.snd.snd.fst, x.snd.snd.snd.snd.fst,
        x.snd.snd.snd.snd.snd, x.fst, x.snd.fst, x.snd.snd.fst⟩);
    · simp;
    · grind;
    · simp only [Finset.univ_sigma_univ, Finset.mem_univ, exists_const, Sigma.exists, forall_const];
      exact fun b => ⟨ b.2.2.2.1, b.2.2.2.2.1, b.2.2.2.2.2, b.1, b.2.1, b.2.2.1, rfl ⟩;
    · simp [ mul_assoc, mul_comm ];
  -- Simplify the summand using the properties of the ghost operators.
  have h_simplify : ∀ a b e d g h : Fin n,    (f a b e * f d g h) • (χ d * χ g * χ a * χ b * β h * β
      e) = -(f a b e * f d g h) • (χ a * χ b * χ d * χ g * β e * β h) := by
    intro a b e d g h
    have h_simplify : β h * β e = - (β e * β h) := by
      exact eq_neg_of_add_eq_zero_left ( hCAR.betabeta _ _ );
    simp [ mul_assoc, h_simplify ];
    simp only [← mul_assoc, chi_swap4 χ β hCAR];
  simp only [h_simplify] at h_reindex;
  simp only [neg_smul, Finset.sum_neg_distrib] at h_reindex;
  rw [ eq_neg_iff_add_eq_zero ] at h_reindex;
  simp [ ← two_smul ℝ, h_nonzero ] at h_reindex

/-
**The contracted terms vanish by the Jacobi identity.**  The two terms
produced by contracting the middle `β` against the second pair of `χ`'s combine
to `2·∑_{a,b,g,h} (∑_e f_{abe} f_{egh}) · (χ_a χ_b χ_g β_h)`; contracting the
totally-antisymmetric `χ_a χ_b χ_g` against the coefficient antisymmetrizes it,
which is exactly the Jacobi combination and so vanishes.
-/
lemma contracted_terms_zero (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R)
    (hCAR : GhostCAR χ β)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    (∑ a, ∑ b, ∑ e, ∑ g, ∑ h,
      (f a b e * f e g h) • (χ a * χ b * χ g * β h)) = 0 := by
  simp only [Finset.sum_add_distrib] at hjac;
  -- By combining the results from the three sums, we conclude that the entire expression is zero.
  have h_combined : ∑ a, ∑ b, ∑ g, ∑ h, (∑ e, f a b e * f e g h) • (χ a * χ b * χ g * β h) =
    ∑ a, ∑ b, ∑ g, ∑ h, (∑ e, f b g e * f e a h) • (χ a * χ b * χ g * β h) := by
      simp only [← Finset.sum_product'];
      apply Finset.sum_bij (fun x _ => (x.2.2.1, x.1, x.2.1, x.2.2.2));
      · grind;
      · grind;
      · simp;
      · intro a ha
        simp [ mul_assoc, chi_cyc3 χ β hCAR ];
  have h_combined2 : ∑ a, ∑ b, ∑ g, ∑ h, (∑ e, f a b e * f e g h) • (χ a * χ b * χ g * β h) =
    ∑ a, ∑ b, ∑ g, ∑ h, (∑ e, f g a e * f e b h) • (χ a * χ b * χ g * β h) := by
      refine Finset.sum_comm.trans ( Finset.sum_congr rfl fun _ _ => Finset.sum_comm.trans (
          Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => ?_ ) );
      rw [ chi_cyc3 χ β hCAR ];
  have h_combined3 : ∑ a, ∑ b, ∑ g, ∑ h, (∑ e, f a b e * f e g h) • (χ a * χ b * χ g * β h) +
    ∑ a, ∑ b, ∑ g, ∑ h, (∑ e, f b g e * f e a h) • (χ a * χ b * χ g * β h) +
    ∑ a, ∑ b, ∑ g, ∑ h, (∑ e, f g a e * f e b h) • (χ a * χ b * χ g * β h) = 0 := by
      simp only [← Finset.sum_add_distrib];
      refine Finset.sum_eq_zero fun a ha => Finset.sum_eq_zero fun b hb => Finset.sum_eq_zero fun c
          hc => Finset.sum_eq_zero fun d hd => ?_;
      rw [ ← add_smul, ← add_smul, hjac a b c d, zero_smul ];
  convert congr_arg ( fun x : R => ( 1 / 3 : ℝ ) • x ) h_combined3 using 1 <;> norm_num [ ←
      Finset.sum_smul, ← Finset.smul_sum ];
  rw [ ← h_combined, ← h_combined2 ] ; ring;
  norm_num [ ← add_smul ];
  simp only [Finset.sum_smul];
  exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_comm.trans (
      Finset.sum_congr rfl fun _ _ => Finset.sum_comm )

/-
**Nilpotency of the (cubic) BRST charge, `Q² = 0`.**  Given the ghost
canonical anticommutation relations and structure constants that are
antisymmetric in their first two indices and satisfy the Jacobi identity, the
cubic ghost part of the BRST charge is nilpotent — the property that makes the
BRST cohomology, and hence the book's definition of the gauge-invariant
(physical) algebra of Quantum Yang-Mills, well defined.
-/
theorem brst_charge_nilpotent (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R)
    (hCAR : GhostCAR χ β)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    Q f χ β * Q f χ β = 0 :=
  by
  -- Apply the definitions of `Q` and `beta_move` to expand `Q * Q`.
  have h_expand : Q f χ β * Q f χ β = ∑ a,    ∑ b, ∑ e, ∑ d, ∑ g, ∑ h, (f a b e * f d g h) • (χ a *
      χ b * β e * χ d * χ g * β h) := by
    unfold Q;
    simp only [Finset.sum_mul _ _ _, Finset.mul_sum, mul_smul_comm, Algebra.smul_mul_assoc,
        smul_smul];
    ac_rfl;
  -- Apply `beta_move` to rewrite each term in the expansion.
  have h_rewrite : ∀ a b e d g h,    χ a * χ b * β e * χ d * χ g * β h = (if e = d then χ a * χ b *
      χ g * β h else 0) - (if e = g then χ a * χ b * χ d * β h else 0) + χ a * χ b * χ d * χ g * β e
          * β h := by
    intro a b e d g h;
    convert congr_arg ( fun x => χ a * χ b * x * β h ) ( beta_move χ β hCAR e d g ) using 1 <;> simp
        [ mul_assoc ];
    simp [ mul_add, add_mul, mul_assoc, sub_mul, mul_sub ];
  -- Substitute the rewritten terms back into the expansion.
  have h_substitute : Q f χ β * Q f χ β = (∑ a, ∑ b, ∑ e, ∑ g, ∑ h, (f a b e * f e g h) • (χ a * χ b
      * χ g * β h)) - (∑ a, ∑ b, ∑ e, ∑ d, ∑ h, (f a b e * f d e h) • (χ a * χ b * χ d * β h)) + (∑
          a, ∑ b, ∑ e, ∑ d, ∑ g, ∑ h, (f a b e * f d g h) • (χ a * χ b * χ d * χ g * β e * β h)) :=
              by
    rw [ h_expand ];
    simp only [h_rewrite, smul_add, smul_sub, Finset.sum_add_distrib];
    simp ;
  -- Apply the contracted_terms_zero lemma to the second term.
  have h_contracted : ∑ a,    ∑ b,    ∑ e,    ∑ d,    ∑ h,    (f a b e * f d e h) • (χ a * χ b * χ d
      * β h) = -∑ a,    ∑ b, ∑ e, ∑ g, ∑ h, (f a b e * f e g h) • (χ a * χ b * χ g * β h) := by
    simp only [← Finset.sum_neg_distrib];
    refine Finset.sum_congr rfl fun a ha => Finset.sum_congr rfl fun b hb => Finset.sum_congr rfl
        fun e he => Finset.sum_congr rfl fun d hd => Finset.sum_congr rfl fun h hh => ?_;
    rw [ hf12 d e h ] ; ring;
    rw [ neg_smul ];
  convert h_substitute using 1;
  rw [ h_contracted, sub_neg_eq_add, add_assoc, quartic_term_zero f χ β hCAR ];
  rw [ contracted_terms_zero f χ β hCAR hjac, zero_add, zero_add ]

end BookProof.BRSTNilpotent
