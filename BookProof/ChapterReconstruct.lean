import Mathlib

/-!
# Chapter "Reconstructing the classical trajectory of any isolated quantum system"
— a symmetry acts on probability distributions iff it is deterministic

This file formalizes the self-contained linear-algebra core of the section
*"Time translation is a stochastic process if and only if it is deterministic"*
(Chapter *"Reconstructing the classical trajectory of any isolated quantum
system"*, `book.tex` line ~2613).

The book's setup: a Wigner symmetry acts on the wave-function by a unitary
matrix `U` with entries `U k a`.  It observes that the induced map on the
*probability distributions* (obtained after wave-function collapse / the Born
rule) is well-defined — i.e. there is a genuine group action on distributions —
**if and only if** `U` is *deterministic*, meaning each column of `U` has at
most one nonzero entry (`U m a` and `U l a` cannot both be nonzero for `l ≠ m`).

The precise mathematical fact the book extracts (its displayed computation) is
that, for a fixed column `a`, the "off-diagonal Born sum"

```
S_a(Ψ) = ∑_{k ≠ b} conj(U k a) · Ψ k · conj(Ψ b) · U b a
```

vanishes for **every** state `Ψ` iff `conj(U m a) · U l a = 0` for all `l ≠ m`
(the determinism condition for that column).

* Forward direction: if `U` is deterministic then every off-diagonal term
  already contains the vanishing factor `conj(U k a) · U b a`.
* Backward direction: the book exhibits the witness `Ψ ∝ δ_{·m} + δ_{·l}`; a
  rigorous argument needs a second complex phase (`Ψ ∝ δ_{·m} + i δ_{·l}`) to
  kill the imaginary part as well, which is the standard polarization of a
  Hermitian form.  We use the family `Ψ = δ_{·m} + z δ_{·l}` for `z ∈ ℂ`.

We model `U` and `Ψ` as plain functions (`Fin n → Fin n → ℂ`, `Fin n → ℂ`) to
avoid matrix-API friction; no unitarity hypothesis is needed for this algebraic
equivalence, and the condition over all `Ψ` is equivalent (by homogeneity) to
the book's condition over unit vectors, recorded in `offDiag_unit_iff`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators
open Finset

namespace BookProof.ChapterReconstruct

variable {n : ℕ}

/-- A transformation `U` is *deterministic in column `a`* when that column has at
most one nonzero entry: `conj(U m a) · U l a = 0` for all `l ≠ m`. -/
def IsDeterministicCol (U : Fin n → Fin n → ℂ) (a : Fin n) : Prop :=
  ∀ l m : Fin n, l ≠ m → (starRingEnd ℂ) (U m a) * U l a = 0

/-- `U` is *deterministic* when every column has at most one nonzero entry. -/
def IsDeterministic (U : Fin n → Fin n → ℂ) : Prop :=
  ∀ a : Fin n, IsDeterministicCol U a

/-- The off-diagonal Born sum for column `a` and state `Ψ`:
`∑_{k ≠ b} conj(U k a) · Ψ k · conj(Ψ b) · U b a`. -/
noncomputable def offDiag (U : Fin n → Fin n → ℂ) (a : Fin n) (Ψ : Fin n → ℂ) : ℂ :=
  ∑ k : Fin n, ∑ b : Fin n,
    (if k = b then 0
      else (starRingEnd ℂ) (U k a) * Ψ k * (starRingEnd ℂ) (Ψ b) * U b a)

/-
The off-diagonal sum equals the full bilinear product minus its diagonal:
`S_a(Ψ) = (∑ₖ conj(U k a)·Ψ k)·(∑_b conj(Ψ b)·U b a) − ∑ₖ conj(U k a)·Ψ k·conj(Ψ k)·U k a`.
-/
theorem offDiag_eq (U : Fin n → Fin n → ℂ) (a : Fin n) (Ψ : Fin n → ℂ) :
    offDiag U a Ψ =
      (∑ k : Fin n, (starRingEnd ℂ) (U k a) * Ψ k) *
        (∑ b : Fin n, (starRingEnd ℂ) (Ψ b) * U b a) -
      ∑ k : Fin n,
        (starRingEnd ℂ) (U k a) * Ψ k * (starRingEnd ℂ) (Ψ k) * U k a := by
  simp only [offDiag, sum_mul _ _ _];
  simp [ Finset.sum_ite, Finset.filter_ne, Finset.mul_sum _ _ _, mul_assoc ]

/-
**Forward direction.** If column `a` of `U` is deterministic, the
off-diagonal Born sum vanishes for every state `Ψ`.
-/
theorem offDiag_of_isDeterministicCol (U : Fin n → Fin n → ℂ) (a : Fin n)
    (hU : IsDeterministicCol U a) (Ψ : Fin n → ℂ) : offDiag U a Ψ = 0 := by
  refine Finset.sum_eq_zero fun k hk => Finset.sum_eq_zero fun b hb => ?_;
  grind +locals

/-
**Backward direction.** If the off-diagonal Born sum vanishes for every
state `Ψ`, then column `a` of `U` is deterministic.
-/
theorem isDeterministicCol_of_offDiag (U : Fin n → Fin n → ℂ) (a : Fin n)
    (hU : ∀ Ψ : Fin n → ℂ, offDiag U a Ψ = 0) : IsDeterministicCol U a := by
  intro l m hlm
  set C := (starRingEnd ℂ) (U m a) * U l a
  have h_C_zero : C = 0 := by
    -- By hypothesis `hU`, we know that `offDiag U a Ψz = 0` for any `z : ℂ`.
    have hz : ∀ z : ℂ, (starRingEnd ℂ) z * C + z * (starRingEnd ℂ) C = 0 := by
      intro z
      have hz : offDiag U a (fun k => if k = m then 1 else if k = l then z else 0) = (starRingEnd ℂ)
          z * C + z * (starRingEnd ℂ) C := by
        rw [ offDiag_eq ];
        simp only [mul_ite, mul_one, mul_zero, sum_ite, filter_eq', mem_univ, ↓reduceIte,
          sum_singleton, filter_ne', mem_erase, ne_eq, hlm, not_false_eq_true, and_self,
          ite_mul, zero_mul, map_one] ; ring;
        rw [ Finset.sum_eq_add ( m ) ( l ) ] <;> simp only [↓reduceIte, map_one, one_mul, hlm,
                                                   sum_const_zero,
                                                   sub_zero,
                                                   zero_mul,
                                                   add_zero,
                                                   ne_eq,
                                                   hlm.symm,
                                                   not_false_eq_true,
                                                   mem_univ,
                                                   mul_eq_zero,
                                                   map_eq_zero,
                                                   and_imp,
                                                   forall_const,
                                                   not_true_eq_false,
                                                   IsEmpty.forall_iff] ; focus (ring!);
        · simp [ mul_comm ];
        · aesop;
      rw [ ← hz, hU ];
    grind +locals;
  exact h_C_zero

/-- **Per-column headline.** The off-diagonal Born sum for column `a` vanishes on
all states iff column `a` of `U` is deterministic. -/
theorem offDiag_eq_zero_iff (U : Fin n → Fin n → ℂ) (a : Fin n) :
    (∀ Ψ : Fin n → ℂ, offDiag U a Ψ = 0) ↔ IsDeterministicCol U a :=
  ⟨isDeterministicCol_of_offDiag U a, offDiag_of_isDeterministicCol U a⟩

/-- **Global headline.** The Born-rule map induced by `U` is a well-defined map
on probability distributions (the off-diagonal sum vanishes on all states and
all columns) iff `U` is deterministic (each column has at most one nonzero
entry). -/
theorem offDiag_eq_zero_iff_isDeterministic (U : Fin n → Fin n → ℂ) :
    (∀ (a : Fin n) (Ψ : Fin n → ℂ), offDiag U a Ψ = 0) ↔ IsDeterministic U := by
  constructor
  · intro h a
    exact isDeterministicCol_of_offDiag U a (h a)
  · intro h a Ψ
    exact offDiag_of_isDeterministicCol U a (h a) Ψ

/-
**Book's exact statement (unit-vector form).** Restricting to unit states
(pure density matrices) does not change the equivalence: the off-diagonal Born
sum vanishes on all unit states iff `U` is deterministic.
-/
theorem offDiag_unit_iff (U : Fin n → Fin n → ℂ) :
    (∀ (a : Fin n) (Ψ : Fin n → ℂ), (∑ k : Fin n, ‖Ψ k‖ ^ 2) = 1 →
        offDiag U a Ψ = 0) ↔ IsDeterministic U := by
  refine ⟨ fun hU => ?_, ?_ ⟩;
  · refine fun a => isDeterministicCol_of_offDiag U a ?_;
    intro Ψ
    by_cases hΨ : Ψ = 0;
    · simp [hΨ, offDiag];
    · -- Let $c = \sqrt{\sum_{k} \| \Psi_k \|^2}$.
      set c := Real.sqrt (∑ k, ‖Ψ k‖ ^ 2) with hc_def
      have hc_pos : 0 < c := by
        exact Real.sqrt_pos.mpr
          ( lt_of_lt_of_le
            ( sq_pos_of_pos
              ( norm_pos_iff.mpr ( Classical.choose_spec ( Function.ne_iff.mp hΨ ) ) ) )
            ( Finset.single_le_sum ( fun k _ => sq_nonneg ( ‖Ψ k‖ ) )
              ( Finset.mem_univ ( Classical.choose ( Function.ne_iff.mp hΨ ) ) ) ) )
      have hc_unit : ∑ k, ‖(1 / c : ℂ) * Ψ k‖ ^ 2 = 1 := by
        simp only [one_div, Complex.norm_mul, norm_inv, Complex.norm_real, Real.norm_eq_abs,
            mul_pow, inv_pow, sq_abs, ← Finset.mul_sum _ _ _];
        rw [ Real.sq_sqrt <| Finset.sum_nonneg fun _ _ => sq_nonneg _, inv_mul_cancel₀ <| ne_of_gt
            <| lt_of_le_of_ne ( Finset.sum_nonneg fun _ _ => sq_nonneg _ ) <| Ne.symm <|
                by contrapose! hΨ; ext i; simp_all  ]
      have hc_offDiag : offDiag U a ((1 / c : ℂ) • Ψ) = 0 := by
        exact hU a _ hc_unit
      have hc_offDiag_zero : offDiag U a Ψ = 0 := by
        convert congr_arg (fun x : ℂ => x * c ^ 2) hc_offDiag using 1 <;>
          norm_num [offDiag, Finset.mul_sum _ _ _, mul_assoc, mul_left_comm, mul_comm] ;
          ring_nf ; norm_num [hc_pos.ne']
      exact hc_offDiag_zero
  · exact fun h a Ψ _ => offDiag_of_isDeterministicCol U a (h a) Ψ

end BookProof.ChapterReconstruct
