import Mathlib

/-!
# Chapter D — Aligned deep learning as a random sampling method

This file formalizes the one crisp mathematical statement of Chapter D of
`book.tex` (see `FORMALIZATION_ROADMAP.md` §D.1): *almost all functions are
uncomputable*, in the precise form **computable ⇒ countable ⇒ null**.
-/

open MeasureTheory

namespace BookProof.ChapterD

/-
**Chapter D.1 (countability).** The set of computable functions `ℕ → ℕ`
is countable.
-/
theorem computable_countable : {f : ℕ → ℕ | Computable f}.Countable := by
  convert Cardinal.mk_le_aleph0_iff.mp _;
  simp +zetaDelta at *

/-
**Chapter D.1 (countability, Boolean form).** The set of computable
predicates `ℕ → Bool` is countable.
-/
theorem computable_bool_countable : {f : ℕ → Bool | Computable f}.Countable := by
  convert computable_countable;
  constructor <;> intro h;
  · convert computable_countable;
  · convert h.preimage _;
    rotate_left;
    focus (exact fun f n => if f n = Bool.true then 1 else 0);
    · refine fun f g hfg => funext fun n => ?_
      have hn := congr_fun hfg n
      cases hf : f n <;> cases hg : g n <;> simp [hf, hg] at hn ⊢
    · ext;
      constructor <;> intro h;
      · convert Computable.cond h ( Computable.const 1 ) ( Computable.const 0 ) using 1;
        grind;
      · convert Computable.of_eq _ _;
        focus
          (exact fun n => Nat.recOn ( ‹ℕ → Bool› n |> fun x => if x = Bool.true then 1 else 0 )
            Bool.false fun _ _ => Bool.true);
        · convert Computable.nat_casesOn _ _ _;
          · exact h;
          · exact Computable.const Bool.false;
          · exact Computable.const Bool.true;
        · aesop

/-
**Chapter D.1 (negligibility).** Under any atomless (`NoAtoms`) measure on the
space of functions `ℕ → ℕ`, the set of computable functions is null: almost every
function is uncomputable.
-/
theorem computable_null (μ : Measure (ℕ → ℕ)) [NoAtoms μ] :
    μ {f : ℕ → ℕ | Computable f} = 0 := by
  convert computable_countable.measure_zero μ

/-
**Chapter D.1 (negligibility, Boolean form).** Under any atomless measure on
`ℕ → Bool`, the set of computable predicates is null.
-/
theorem computable_bool_null (μ : Measure (ℕ → Bool)) [NoAtoms μ] :
    μ {f : ℕ → Bool | Computable f} = 0 := by
  convert Set.Countable.measure_zero _ μ;
  convert computable_bool_countable

end BookProof.ChapterD
