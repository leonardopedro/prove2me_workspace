import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j
import BookProof.ChapterA3n
import BookProof.ChapterA3o
import BookProof.ChapterA3p
import BookProof.ChapterA3q
import BookProof.ChapterA3r

/-!
# Chapter A, §A.3 — Note 50 / Lemma 52: dimensions of the complete-reducibility
summands at `N = 5` (the first case where the antisymmetric piece vanishes)

Source: `book.tex` §A.3, Note 50 (Weyl complete reducibility) and Lemma 52.

`ChapterA3r`/`ChapterA3s`/`ChapterA3t` computed the ranks (traces) of the
complete-reducibility projectors `{projSym N, projAnti N, projMixed N}` at
`N = 2, 3, 4`.  This file takes the next case `N = 5`, which is the **first**
where the totally antisymmetric summand `Λ⁵V` vanishes — a `4`-dimensional
space has no nonzero `5`-fold exterior power.

The base tool is a general **orbit-count** lemma.  By `ChapterA3r.trace_permMat`,
`tr (permMat σ)` counts the index tuples `a : Fin N → Fin 4` fixed by `σ`, i.e.
the tuples constant on each cycle of `σ`; there are `4^{c(σ)}` of them, where
`c(σ) = (N − Σ cycleType) + (#cycleType)` is the number of orbits of `σ`
(fixed points plus nontrivial cycles).  This is `card_fixedTuples`.

With `tr (permMat σ) = 4^{c(σ)}` in hand, the traces of the two averaged
projectors are finite sums over `S₅` of small numbers, discharged by kernel
`decide` (no `native_decide`):

* `Σ_{σ∈S₅} 4^{c(σ)} = 6720`, so `tr (projSym 5) = 6720 / 5! = 6720 / 120 = 56`
  (`= dim Sym⁵V = C(8,5)`);
* `Σ_{σ∈S₅} sgn(σ)·4^{c(σ)} = 0`, so `tr (projAnti 5) = 0` (`= dim Λ⁵V = C(4,5) = 0`);
* the mixed piece is `4⁵ − 56 − 0 = 1024 − 56 = 968`.

Everything is proved **without** the `EXTERNAL` Weyl hypothesis, `sorry`-free /
`axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`).

## Deliverables

* `card_fixedTuples` — the number of tuples fixed by `σ` is `4^{c(σ)}` (general `N`).
* `trace_permMat_pow` — `tr (permMat σ) = 4^{c(σ)}` (general `N`).
* `trace_projSym_five` — `tr (projSym 5) = 56` (`= dim Sym⁵V`).
* `trace_projAnti_five` — `tr (projAnti 5) = 0` (`= dim Λ⁵V`, vacuous exterior power).
* `trace_projMixed_five` — `tr (projMixed 5) = 968` (the mixed-symmetry piece).
* `trace_decomposition_five` — `56 + 0 + 968 = 1024 = dim (V^{⊗5})`.
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterA3u

open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

/-
An invariant tuple is constant along the `σ`-orbit: `a ((σ^k) x) = a x`.
-/
theorem invariant_apply_zpow {N : ℕ} {σ : Equiv.Perm (Fin N)} {a : Idx N}
    (ha : a ∘ σ = a) (k : ℤ) (x : Fin N) : a ((σ ^ k) x) = a x := by
  rcases k with ( _ | k ) <;> simp_all only [funext_iff, Function.comp_apply, Int.ofNat_eq_natCast,
      zpow_natCast, zpow_negSucc, Equiv.Perm.coe_inv];
  · induction ‹ℕ› <;> simp_all [ pow_succ', Equiv.Perm.mul_apply ];
  · induction k generalizing x with
    | zero => ?_
    | succ k ih => ?_
    all_goals simp_all only [zero_add, pow_succ', pow_zero, mul_one]
    · grind;
    · convert ih ( σ⁻¹ x ) using 1;
      rw [ ← ha ( σ⁻¹ x ) ] ; simp

/-- An invariant tuple takes the same value on elements in the same cycle. -/
theorem invariant_sameCycle {N : ℕ} {σ : Equiv.Perm (Fin N)} {a : Idx N}
    (ha : a ∘ σ = a) {x y : Fin N} (h : σ.SameCycle x y) : a x = a y := by
  obtain ⟨k, hk⟩ := h
  rw [← hk, invariant_apply_zpow ha]

/-
**Orbit count of the fixed tuples.**  The number of index tuples
`a : Fin N → Fin 4` fixed by `σ` (`a ∘ σ = a`) equals `4^{c(σ)}`, where
`c(σ) = (N − Σ cycleType σ) + #(cycleType σ)` is the number of orbits of `σ`
(its fixed points together with its nontrivial cycles).  A tuple is fixed by `σ`
iff it is constant on every orbit, so the fixed tuples are in bijection with
functions from the set of orbits into `Fin 4`.
-/
set_option maxHeartbeats 1000000 in
-- the proof below is a large finite computation; the default heartbeat budget
-- is not enough to elaborate it
theorem card_fixedTuples {N : ℕ} (σ : Equiv.Perm (Fin N)) :
    (Finset.univ.filter (fun a : Idx N => a ∘ σ = a)).card
      = 4 ^ ((N - σ.cycleType.sum) + σ.cycleType.card) := by
  -- Let's simplify the goal using the fact that multiplication by a constant out of the exponent
  -- results in the same exponent.
  set c := (N - σ.cycleType.sum + σ.cycleType.card) with hc_def
  have h_card : (Finset.univ.filter (fun a : Fin N → Fin 4 => a ∘ σ = a)).card = 4 ^ c := by
    have h_card : (Finset.univ.filter (fun a : Fin N → Fin 4 => a ∘ σ = a)).card = Fintype.card {a :
        Fin N → Fin 4 // a ∘ σ = a} := by
      rw [ Fintype.subtype_card ];
    rw [ h_card ];
    convert Fintype.card_congr ( show { a : Fin N → Fin 4 // a ∘ σ = a } ≃ ( { x : Fin N // σ x = x
        } ⊕ { c : Equiv.Perm ( Fin N ) // c ∈ σ.cycleFactorsFinset } → Fin 4 ) from ?_ ) using 1;
    · simp? +zetaDelta at *;
      rw [ show Fintype.card { x // σ x = x } = N - σ.cycleType.sum from ?_, show
          σ.cycleFactorsFinset.card = σ.cycleType.card from ?_ ];
      · rw [ Equiv.Perm.cycleType_def ];
        simp [ Function.comp ];
      · have := Equiv.Perm.sum_cycleType σ; simp_all only [Fintype.card_subtype] ;
        rw [ show ( Finset.univ.filter fun x => σ x = x ) = Finset.univ \ σ.support from ?_,
            Finset.card_sdiff ] <;> aesop;
    · refine Equiv.ofBijective ( fun a => Sum.elim ( fun x => a.val x ) ( fun c => a.val (
        c.val.support.min' <| Finset.nonempty_of_ne_empty <| by
        intro h; have := c.2; simp_all [ Equiv.Perm.mem_cycleFactorsFinset_iff ] ; ) ) ) ⟨ ?_, ?_ ⟩
      all_goals generalize_proofs at *;
      · intro a b h; ext x; by_cases hx : σ x = x <;> simp_all only [funext_iff,
          Function.comp_apply, Sum.forall, Sum.elim_inl, Subtype.forall, Sum.elim_inr] ;
        have h_cycle : σ.cycleOf x ∈ σ.cycleFactorsFinset := by
          simp only [Equiv.Perm.mem_cycleFactorsFinset_iff, Equiv.Perm.mem_support, ne_eq];
          refine ⟨ ?_, ?_ ⟩
          all_goals generalize_proofs at *;
          · exact Equiv.Perm.isCycle_cycleOf _ hx;
          · simp [ Equiv.Perm.cycleOf_apply ];
            tauto
        generalize_proofs at *;
        have h_cycle_eq : σ.SameCycle x (σ.cycleOf x |>.support.min' <| Finset.nonempty_of_ne_empty
            <| by
          grind) := by
          have h_cycle_eq : ∀ y ∈ (σ.cycleOf x).support, σ.SameCycle x y := by
            intro y hy;              have := Equiv.Perm.mem_support.mp ( show y ∈ ( σ.cycleOf x
                ).support from by aesop ) ;              simp_all [ Equiv.Perm.mem_support,
                                  Equiv.Perm.cycleOf_apply ] ;
          generalize_proofs at *;
          exact h_cycle_eq _ <| Finset.min'_mem _ _
        generalize_proofs at *;
        grind +suggestions;
      · intro g;
        refine ⟨ ⟨ fun x => if hx : σ x = x then g ( Sum.inl ⟨ x, hx ⟩ ) else g ( Sum.inr ⟨
            σ.cycleOf x, ?_ ⟩ ), ?_ ⟩, ?_ ⟩ <;> simp_all only [funext_iff, Function.comp_apply,
                Subtype.forall, EmbeddingLike.apply_eq_iff_eq, Equiv.Perm.cycleOf_self_apply,
                    implies_true, Subtype.coe_eta, Sum.forall, Sum.elim_inl, dite_eq_left_iff,
                        not_true_eq_false, IsEmpty.forall_iff, Sum.elim_inr, true_and];
        all_goals generalize_proofs at *;
        · simp only [Equiv.Perm.mem_cycleFactorsFinset_iff, Equiv.Perm.mem_support, ne_eq];
          refine ⟨ ?_, ?_ ⟩;
          · exact Equiv.Perm.isCycle_cycleOf _ ( by aesop );
          · intro a ha; simp_all [ Equiv.Perm.cycleOf_apply ] ;
        · intro a ha; split_ifs <;> simp_all only [SetLike.coe_mem, implies_true,
            Equiv.Perm.mem_cycleFactorsFinset_iff, Equiv.Perm.mem_support, ne_eq, not_false_eq_true,
                and_self, forall_and_index] ;
          · have := Equiv.Perm.mem_cycleFactorsFinset_iff.mp ha; simp_all [ Equiv.Perm.IsCycle ] ;
            have := Finset.min'_mem ( a.support ) ; simp_all [ Equiv.Perm.mem_support ] ;
            grind;
          · congr! 2;
            exact Subtype.ext <| Equiv.Perm.mem_cycleFactorsFinset_iff.mp ha |>.2 |> fun h => by
              have h_cycle_eq : ∀ x ∈ a.support, σ.cycleOf x = a :=
                fun x hx => (Equiv.Perm.cycle_is_cycleOf hx ha).symm
              exact h_cycle_eq _ ( Finset.min'_mem _ <| by solve_by_elim );
  convert h_card using 1

/-- **Trace of a braiding matrix, orbit-count form.**  `tr (permMat σ) = 4^{c(σ)}`. -/
theorem trace_permMat_pow {N : ℕ} (σ : Equiv.Perm (Fin N)) :
    Matrix.trace (permMat σ)
      = ((4 ^ ((N - σ.cycleType.sum) + σ.cycleType.card) : ℕ) : ℂ) := by
  rw [trace_permMat, card_fixedTuples]

set_option maxRecDepth 100000 in
/-- **Dimension of `Sym⁵V`.**  The symmetric-fifth-power projector has rank `56`. -/
theorem trace_projSym_five : Matrix.trace (projSym 5) = 56 := by
  unfold projSym; norm_num;
  rw [ Finset.sum_congr rfl fun x _ => trace_permMat_pow x ] ; norm_cast;
  field_simp;
  exact mod_cast by decide

set_option maxRecDepth 100000 in
/-- **Dimension of `Λ⁵V`.**  The antisymmetric-fifth-power projector has rank `0`:
a `4`-dimensional space has no nonzero `5`-fold exterior power. -/
theorem trace_projAnti_five : Matrix.trace (projAnti 5) = 0 := by
  unfold projAnti;
  simp [signC, trace_permMat_pow];
  norm_cast

/-- **Dimension of the mixed-symmetry piece at `N = 5`.**  Its projector has
rank `968 = 1024 − 56 − 0`. -/
theorem trace_projMixed_five : Matrix.trace (projMixed 5) = 968 := by
  unfold projMixed; norm_num;
  rw [ trace_projSym_five, trace_projAnti_five ] ; norm_num

/-- **Dimension count of the complete-reducibility decomposition** at `N = 5`:
`dim Sym⁵V + dim Λ⁵V + dim(mixed) = 56 + 0 + 968 = 1024 = dim (V^{⊗5})`. -/
theorem trace_decomposition_five :
    Matrix.trace (projSym 5) + Matrix.trace (projAnti 5)
        + Matrix.trace (projMixed 5) = 1024 := by
  rw [trace_projSym_five, trace_projAnti_five, trace_projMixed_five]
  norm_num

end BookProof.ChapterA3u
