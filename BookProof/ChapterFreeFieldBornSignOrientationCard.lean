import Mathlib
import BookProof.ChapterFreeFieldBornSignOrientation

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# cardinality of the orientation-preserving sign gauge

The preceding files identify the diagonal Born sign gauge with boolean sign
choices and show that a sign matrix preserves orientation exactly when its
Hamming weight is even. This file counts that subgroup. In positive dimension,
exactly half of the `2^(n+1)` diagonal sign choices preserve orientation, so the
orientation-preserving subgroup has `2^n` elements.

## Main results

* `natCard_even_flip` — there are exactly `2^n` even flip choices on `n+1`
  coordinates.
* `natCard_orientationPreserving_flip` — equivalently, exactly `2^n` choices
  have sign matrix in `SO(n+1)`.
-/

open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation

namespace BookProof.ChapterFreeFieldBornSignOrientationCard

/-- In dimension `n+1`, exactly `2^n` boolean sign choices have even weight. -/
theorem natCard_even_flip (n : ℕ) :
    Nat.card {b : Fin (n + 1) → Bool // Even (flipCount b)} = 2 ^ n := by
  rw [Nat.card_eq_fintype_card]
  rw [Fintype.card_subtype]
  have h_gen_fun : (∑ i : Fin (n + 1) → Bool, (-1 : ℝ) ^ flipCount i) = 0 := by
    have h_incl_excl :
        ∑ i : Fin (n + 1) → Bool,
            (-1 : ℝ) ^ (Finset.univ.filter fun k => i k = true).card =
          ∏ _k : Fin (n + 1), ∑ b : Bool, (-1 : ℝ) ^ (if b then 1 else 0) := by
      rw [Finset.prod_sum]
      refine Finset.sum_bij (fun i ?_ => fun k _ => i k) ?_ ?_ ?_ ?_ <;> simp only [Finset.mem_univ,
          Fintype.univ_bool, Finset.mem_pi, Finset.mem_insert, Finset.mem_singleton,
              Bool.eq_true_or_eq_false_self, imp_self, implies_true, forall_const, exists_const,
                  pow_ite, pow_one, pow_zero, Finset.prod_attach_univ]
      · simp [funext_iff]
      · exact fun b => ⟨fun k => b k (Finset.mem_univ k), rfl⟩
      · intro a
        rw [Finset.prod_ite]
        aesop
    convert h_incl_excl using 1
    norm_num [Finset.prod_const, Finset.card_univ]
  have h_eq :
      (∑ i : Fin (n + 1) → Bool, (if Even (flipCount i) then 1 else 0) : ℝ) -
          (∑ i : Fin (n + 1) → Bool, (if Odd (flipCount i) then 1 else 0) : ℝ) = 0 := by
    rw [← Finset.sum_sub_distrib]
    exact Eq.trans (Finset.sum_congr rfl fun _ _ => by aesop) h_gen_fun
  simp_all [sub_eq_iff_eq_add]
  have hcard := Finset.card_add_card_compl
    (Finset.univ.filter fun x : Fin (n + 1) → Bool => Even (flipCount x))
  simp_all [pow_succ']
  linarith

/-- Exactly half of the diagonal sign matrices in positive dimension preserve
orientation: in dimension `n+1`, there are `2^n` such boolean choices. -/
theorem natCard_orientationPreserving_flip (n : ℕ) :
    Nat.card {b : Fin (n + 1) → Bool //
      flipMatrix b ∈ Matrix.specialOrthogonalGroup (Fin (n + 1)) ℝ} = 2 ^ n := by
  convert natCard_even_flip n using 3
  exact funext fun x => by rw [flipMatrix_mem_specialOrthogonalGroup_iff]

end BookProof.ChapterFreeFieldBornSignOrientationCard
