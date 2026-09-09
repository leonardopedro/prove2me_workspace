import Mathlib
import BookProof.ChapterLorentzGroup
import BookProof.ChapterLorentzOrthochronous

/-!
# Chapter "Real representations, CPT theorem …", §"On the Lorentz, SL(2,C) and Pin(3,1) groups":
the coset / semidirect decomposition `O(1,3) = Δ ⋉ SO⁺(1,3)`

This file continues Waves 78–79 (`ChapterLorentzGroup.lean`,
`ChapterLorentzOrthochronous.lean`, Note 43) with the next self-contained claim
of the same **Note 43** (`book.tex` line ~5366).  Wave 78 built the discrete
Klein-four subgroup `Δ = {1, η, -η, -1}` and Wave 79 the proper orthochronous
normal subgroup `SO⁺(1,3)`; the book asserts that these assemble into the full
group as a semidirect product:

> `O(1,3) = Δ ⋉ SO⁺(1,3)`: every Lorentz transformation is uniquely a product of
> one of the four discrete parity/time-reversal generators and a proper
> orthochronous transformation.

Concretely, `Δ` is a complete and irredundant set of coset representatives for
the normal subgroup `SO⁺(1,3)`, so the quotient `O(1,3)/SO⁺(1,3) ≅ Δ` is the
Klein four-group of the four connected components of `O(1,3)`, indexed by
`(det λ, sign λ⁰₀) ∈ {±1} × {±1}`.

Everything here uses **only** the Minkowski metric `η = diag(1,-1,-1,-1)` and the
groups from `BookProof.LorentzGroup` / `BookProof.LorentzOrthochronous`; there are
no gamma / Majorana matrices (staying off both the gravity and the
Hankel–Majorana lines).

Results:
* `delta_mul_time` — for `δ ∈ Δ` (a diagonal matrix), `(δ * m)⁰₀ = δ⁰₀ · m⁰₀`;
* `lorentz_delta_decomp` — **existence**: every `λ ∈ O(1,3)` factors as
  `λ = δ * s` with `δ ∈ Δ` and `s ∈ SO⁺(1,3)`;
* `lorentz_delta_decomp_unique` — **uniqueness**: the factors are determined by
  `λ` (so `Δ` is an irredundant transversal of `SO⁺(1,3)`).
-/

namespace BookProof.LorentzDecomp

open Matrix
open BookProof.LorentzGroup
open BookProof.LorentzOrthochronous

/-
For a discrete generator `δ ∈ Δ` (which is diagonal) the time component of a
product factors: `(δ * m)⁰₀ = δ⁰₀ · m⁰₀`.
-/
theorem delta_mul_time {δ : Matrix (Fin 4) (Fin 4) ℝ} (hδ : δ ∈ Delta)
    (m : Matrix (Fin 4) (Fin 4) ℝ) : (δ * m) 0 0 = δ 0 0 * m 0 0 := by
  rcases hδ with ( rfl | rfl | rfl | rfl ) <;> norm_num [ Fin.sum_univ_succ, Fin.prod_univ_succ ];
  · simp [ eta, Matrix.mul_apply ];
    simp [ Fin.sum_univ_succ ];
  · unfold eta; norm_num [ Fin.sum_univ_succ, Fin.prod_univ_succ ] ;
    simp [ Matrix.vecMul ];
    rfl

/-
**Existence of the `Δ ⋉ SO⁺(1,3)` decomposition.** Every Lorentz matrix
factors as `δ * s` with `δ ∈ Δ` one of the four discrete parity/time-reversal
generators and `s ∈ SO⁺(1,3)` proper orthochronous.
-/
theorem lorentz_delta_decomp {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    ∃ δ ∈ Delta, ∃ s, IsProperOrthochronous s ∧ l = δ * s := by
  -- By definition of `Delta`, we know that `l 0 0 ≠ 0`.
  have h_det : l.det = 1 ∨ l.det = -1 := by
    exact sq_eq_one_iff.mp ( by simpa using BookProof.LorentzGroup.lorentz_det_sq_one h )
  have h_time : l 0 0 ≠ 0 := by
    grind +suggestions;
  rcases h_det with h_det | h_det <;> rcases lt_or_gt_of_ne h_time with h_time | h_time;
  · refine ⟨ -1, ?_, -1 * l, ?_, ?_ ⟩ <;> norm_num [ Delta ];
    exact ⟨ isLorentz_neg h, by norm_num [ h_det, Matrix.det_neg ],
      by simpa using neg_pos.mpr h_time ⟩;
  · exact ⟨ 1, by simp [ Delta ], l, ⟨ h, h_det, h_time ⟩, by norm_num ⟩;
  · refine ⟨ -eta, ?_, -eta * l, ?_, ?_ ⟩ <;> norm_num [ Delta ];
    · constructor;
      · convert isLorentz_neg ( isLorentz_mul ( isLorentz_eta ) h ) using 1;
      · norm_num [ Matrix.det_neg, h_det ];
        exact ⟨ by rw [ eta_det ] ; norm_num, by rw [ show ( eta * l ) 0 0 = eta 0 0 * l 0 0
                                                 by exact delta_mul_time (
                                                     by norm_num [ Delta ] ) l ] ; norm_num [ eta ]
                                                         ; linarith ⟩;
    · simp [ ← Matrix.mul_assoc, eta_mul_self ];
  · refine ⟨ eta, ?_, eta * l, ?_, ?_ ⟩ <;> norm_num [ Delta ];
    · refine ⟨ ?_, ?_, ?_ ⟩;
      · exact isLorentz_mul ( isLorentz_eta ) h;
      · rw [ Matrix.det_mul, eta_det, h_det ] ; norm_num;
      · unfold eta; norm_num [ Fin.sum_univ_succ, Matrix.mul_apply ] ; linarith!;
    · rw [ ← Matrix.mul_assoc, eta_mul_self, Matrix.one_mul ]

/-
**Uniqueness of the `Δ ⋉ SO⁺(1,3)` decomposition.** The discrete factor and
the proper orthochronous factor are uniquely determined, so `Δ` is an
irredundant set of coset representatives for `SO⁺(1,3)`.
-/
theorem lorentz_delta_decomp_unique
    {δ₁ δ₂ s₁ s₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (hδ₁ : δ₁ ∈ Delta) (hδ₂ : δ₂ ∈ Delta)
    (hs₁ : IsProperOrthochronous s₁) (hs₂ : IsProperOrthochronous s₂)
    (heq : δ₁ * s₁ = δ₂ * s₂) : δ₁ = δ₂ ∧ s₁ = s₂ :=
  by
  -- First, prove that δ₁ = δ₂.
  have hδ : δ₁ = δ₂ := by
    have hdet : δ₁.det = δ₂.det := by
      apply_fun Matrix.det at heq;
      simp_all [ IsProperOrthochronous ]
    have htime : δ₁ 0 0 * s₁ 0 0 = δ₂ 0 0 * s₂ 0 0 := by
      convert congr_arg ( fun m : Matrix ( Fin 4 ) ( Fin 4 ) ℝ => m 0 0 ) heq using 1 <;>
        simp only [Fin.isValue, mul_apply];
      · convert delta_mul_time hδ₁ s₁ |> Eq.symm using 1;
      · convert delta_mul_time hδ₂ s₂ |> Eq.symm using 1;
    rcases hδ₁ with ( rfl | rfl | rfl | rfl ) <;> rcases hδ₂ with ( rfl | rfl | rfl | rfl ) <;>
        norm_num at hdet htime ⊢;
    all_goals norm_num [ eta_det, Matrix.det_neg ] at hdet;
    · linarith [ hs₁.2.2, hs₂.2.2 ];
    · norm_num [ eta ] at htime;
      linarith [ hs₁.2.2, hs₂.2.2 ];
    · unfold eta at * ; norm_num at * ; linarith [ hs₁.2.2, hs₂.2.2 ];
    · linarith [ hs₁.2.2, hs₂.2.2 ];
  simp_all ;
  -- Since δ₂ is invertible, we can multiply both sides of the equation δ₂ * s₁ = δ₂ * s₂ by δ₂⁻¹ to
  -- get s₁ = s₂.
  have h_inv : Invertible δ₂ := by
    convert Matrix.invertibleOfDetInvertible δ₂;
    convert invertibleOfNonzero _;
    exact lorentz_det_ne_zero ( delta_subset_lorentz _ hδ₂ );
  simpa using congr_arg ( fun x => δ₂⁻¹ * x ) heq

end BookProof.LorentzDecomp
