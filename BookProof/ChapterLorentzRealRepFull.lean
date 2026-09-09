import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterPinOmega
import BookProof.ChapterLorentzRealRep
import BookProof.ChapterLorentzRealRepSum

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"On the Lorentz, SL(2,C) and Pin(3,1) groups", **Lemma 52** — the complete
orthogonal decomposition of the `16`-dimensional matrix algebra

Continuing `BookProof.ChapterLorentzRealRep` and
`BookProof.ChapterLorentzRealRepSum` (Lemma 52, `book.tex` line ~5560), which
built the three explicit real representation spaces of `SL(2,C)` inside the `4×4`
Majorana matrix model and showed they are mutually orthogonal (dimensions
`4 + 6 + 4 = 14`).

This file exhibits the **remaining two-dimensional summand** and thereby the
*complete* orthogonal decomposition of the full `16`-dimensional real matrix
algebra `Matrix (Fin 4) (Fin 4) ℝ`.  The missing directions are exactly the two
"discrete" Majorana matrices that generate the covering group `Ω`:

* `WTwo` — the real span of `{iγ⁰, γ⁰γ⁵}` (dimension `2`), the directions along
  which the discrete Pin subgroup `Ω = {±1, ±iγ⁰, ±γ⁰γ⁵, ±iγ⁵}` acts.

We prove:

* **conjugation invariance** `conj_inv_two` — conjugation by every `S ∈ Ω` maps
  each basis matrix of `WTwo` to `±` a basis matrix (a signed permutation),
  decidably over `ℤ`, and the `Submodule` form `WTwo_invariant`;
* **mutual orthogonality** — `WTwo` is Frobenius-orthogonal to `WHalf`, `W10`
  and `WPs` (`gram_two_halfR`/`gram_two_10R`/`gram_two_PsR`);
* **the concatenated `16`-element basis** `bFull`/`bFullR`, whose Frobenius Gram
  matrix is `4·I` (`gram_fullR`), hence `bFullR_linearIndependent`;
* **the complete decomposition** `span_bFullR_eq`
  (`span (range bFullR) = WHalf ⊔ W10 ⊔ WPs ⊔ WTwo`),
  `decomposition_top` (this fourfold sum is *all* of `Matrix (Fin 4) (Fin 4) ℝ`),
  and the headline `finrank_full_eq_add`
  (`16 = dim WHalf + dim W10 + dim WPs + dim WTwo = 4 + 6 + 4 + 2`), certifying
  the complete internal direct sum.

As requested this stays **off the gravity line** and **off the Hankel-transform
line** (only the concrete Majorana matrices of `ChapterA3`, the discrete group
`Ω` of `ChapterPinOmega`, and the representation spaces of
`ChapterLorentzRealRep` are used).

Everything is `sorry`-free and `axiom`-free.
-/

open Matrix

namespace BookProof.ChapterLorentzRealRepFull

open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

/-! ## The remaining two-element basis (integer model) -/

/-- Basis of the remaining representation space: `iγ⁰, γ⁰γ⁵`.
(Recall `γ^μ = -i(iγ^μ)`, so `γ⁰γ⁵ = -(iγ⁰)(iγ⁵)` is integral.) -/
def w2 : Fin 2 → Matrix (Fin 4) (Fin 4) ℤ
  | 0 => mgammaZ 0
  | 1 => -(mgammaZ 0 * mgamma5Z)

/-- Signed basis (`{±w2ᵢ}`) of the remaining representation space. -/
def SW2 : Finset (Matrix (Fin 4) (Fin 4) ℤ) :=
  (Finset.univ.image w2) ∪ (Finset.univ.image fun i => -w2 i)

/-- The remaining basis has two distinct elements. -/
theorem card_two : (Finset.univ.image w2).card = 2 := by decide

/-! ## Conjugation invariance (signed-permutation form), over `ℤ` -/

/-- **`WTwo` invariance.**  Conjugation by every `S ∈ Ω` sends each basis matrix
to `±` a basis matrix. -/
theorem conj_inv_two : ∀ S ∈ Omega, ∀ i, S * w2 i * cinv S ∈ SW2 := by decide

/-! ## Frobenius Gram matrix, over `ℤ` -/

/-- The Frobenius Gram matrix of the remaining basis is `2·(2·I) = 4·I`. -/
theorem gram_two : ∀ i j : Fin 2, ((w2 i)ᵀ * w2 j).trace = if i = j then 4 else 0 := by decide

/-! ## Cross Frobenius orthogonality with the other three spaces (over `ℤ`) -/

theorem gram_two_half : ∀ (i : Fin 2) (j : Fin 4), ((w2 i)ᵀ * bHalf j).trace = 0 := by decide

theorem gram_two_10 : ∀ (i : Fin 2) (j : Fin 6), ((w2 i)ᵀ * b10 j).trace = 0 := by decide

theorem gram_two_Ps : ∀ (i : Fin 2) (j : Fin 4), ((w2 i)ᵀ * bPs j).trace = 0 := by decide

/-! ## Real model -/

/-- Remaining basis over `ℝ`. -/
noncomputable def w2R (i : Fin 2) : Matrix (Fin 4) (Fin 4) ℝ := castR (w2 i)

theorem gram_twoR : ∀ i j : Fin 2, ((w2R i)ᵀ * w2R j).trace = if i = j then (4 : ℝ) else 0 := by
  intro i j
  rw [w2R, w2R, ← castR_transpose, ← castR_mul, castR_trace, gram_two]
  split_ifs <;> norm_num

theorem gram_two_halfR : ∀ (i : Fin 2) (j : Fin 4), ((w2R i)ᵀ * bHalfR j).trace = (0 : ℝ) := by
  intro i j
  rw [w2R, bHalfR, ← castR_transpose, ← castR_mul, castR_trace, gram_two_half]
  norm_num

theorem gram_two_10R : ∀ (i : Fin 2) (j : Fin 6), ((w2R i)ᵀ * b10R j).trace = (0 : ℝ) := by
  intro i j
  rw [w2R, b10R, ← castR_transpose, ← castR_mul, castR_trace, gram_two_10]
  norm_num

theorem gram_two_PsR : ∀ (i : Fin 2) (j : Fin 4), ((w2R i)ᵀ * bPsR j).trace = (0 : ℝ) := by
  intro i j
  rw [w2R, bPsR, ← castR_transpose, ← castR_mul, castR_trace, gram_two_Ps]
  norm_num

/-! ## The remaining representation space -/

/-- The remaining two-dimensional representation space. -/
noncomputable def WTwo : Submodule ℝ (Matrix (Fin 4) (Fin 4) ℝ) :=
  Submodule.span ℝ (Set.range w2R)

theorem w2R_linearIndependent : LinearIndependent ℝ w2R :=
  linIndep_of_gram w2R gram_twoR

/-- The remaining representation space has dimension `2`. -/
theorem finrank_WTwo : finrank ℝ WTwo = 2 := by
  have := finrank_span_eq_card w2R_linearIndependent
  simpa [WTwo] using this

/-! ## Every element of the signed basis casts into `WTwo` -/

theorem castR_mem_WTwo : ∀ M ∈ SW2, castR M ∈ WTwo := by
  intro M hM
  simp only [SW2, Finset.mem_union, Finset.mem_image, Finset.mem_univ, true_and] at hM
  obtain ⟨i, rfl⟩ | ⟨i, rfl⟩ := hM <;> simp only [WTwo]
  · exact Submodule.subset_span ⟨i, rfl⟩
  · rw [show castR (-w2 i) = -castR (w2 i) by ext; simp [castR]]
    exact Submodule.neg_mem _ <| Submodule.subset_span <| Set.mem_range_self _

/-- **`WTwo` `Submodule` invariance.**  For `S ∈ Ω`, conjugation by `S` maps the
remaining representation space into itself. -/
theorem WTwo_invariant (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega) :
    WTwo.map (conjL (castR S) (castR (cinv S))) ≤ WTwo := by
  apply Submodule.map_le_iff_le_comap.mpr
  refine Submodule.span_le.mpr ?_
  rintro _ ⟨i, rfl⟩
  simp only [w2R, conjL_apply, Submodule.mem_comap, SetLike.mem_coe]
  convert castR_mem_WTwo _ (conj_inv_two S hS i) using 1
  simp [castR_mul]

/-! ## The concatenated `16`-element basis -/

/-- The concatenation of all four bases `bHalf` (4), `b10` (6), `bPs` (4),
`w2` (2), an integer basis of the whole `4×4` matrix algebra. -/
def bFull : Fin 16 → Matrix (Fin 4) (Fin 4) ℤ
  | 0 => bHalf 0
  | 1 => bHalf 1
  | 2 => bHalf 2
  | 3 => bHalf 3
  | 4 => b10 0
  | 5 => b10 1
  | 6 => b10 2
  | 7 => b10 3
  | 8 => b10 4
  | 9 => b10 5
  | 10 => bPs 0
  | 11 => bPs 1
  | 12 => bPs 2
  | 13 => bPs 3
  | 14 => w2 0
  | _ => w2 1

/-- The concatenated basis over `ℝ`. -/
noncomputable def bFullR (i : Fin 16) : Matrix (Fin 4) (Fin 4) ℝ := castR (bFull i)

set_option maxHeartbeats 4000000 in
-- `decide` evaluates all `16 × 16` integer Frobenius pairings, so raise the heartbeat budget.
/-- The Frobenius Gram matrix of the full concatenated basis is `4·I` (over `ℤ`). -/
theorem gram_full : ∀ i j : Fin 16, ((bFull i)ᵀ * bFull j).trace = if i = j then 4 else 0 := by
  decide

/-- The Frobenius Gram matrix of the full concatenated basis is `4·I` (over `ℝ`). -/
theorem gram_fullR :
    ∀ i j : Fin 16, ((bFullR i)ᵀ * bFullR j).trace = if i = j then (4 : ℝ) else 0 := by
  intro i j
  rw [bFullR, bFullR, ← castR_transpose, ← castR_mul, castR_trace, gram_full]
  split_ifs <;> norm_num

/-- The `16` concatenated basis matrices are linearly independent over `ℝ`. -/
theorem bFullR_linearIndependent : LinearIndependent ℝ bFullR :=
  linIndep_of_gram bFullR gram_fullR

/-! ## The span of the concatenated basis is the whole matrix algebra -/

/-- The range of the full concatenated real basis is the union of the four ranges. -/
theorem range_bFullR :
    Set.range bFullR
      = ((Set.range bHalfR ∪ Set.range b10R) ∪ Set.range bPsR) ∪ Set.range w2R := by
  ext x
  constructor
  · rintro ⟨y, rfl⟩
    fin_cases y <;> simp [bFullR, bHalfR, b10R, bPsR, w2R, bFull]
  · rintro (((⟨y, rfl⟩ | ⟨y, rfl⟩) | ⟨y, rfl⟩) | ⟨y, rfl⟩)
    · fin_cases y
      · exact ⟨0, rfl⟩
      · exact ⟨1, rfl⟩
      · exact ⟨2, rfl⟩
      · exact ⟨3, rfl⟩
    · fin_cases y
      · exact ⟨4, rfl⟩
      · exact ⟨5, rfl⟩
      · exact ⟨6, rfl⟩
      · exact ⟨7, rfl⟩
      · exact ⟨8, rfl⟩
      · exact ⟨9, rfl⟩
    · fin_cases y
      · exact ⟨10, rfl⟩
      · exact ⟨11, rfl⟩
      · exact ⟨12, rfl⟩
      · exact ⟨13, rfl⟩
    · fin_cases y
      · exact ⟨14, rfl⟩
      · exact ⟨15, rfl⟩

/-- The span of the full concatenated basis is the fourfold sum of the
representation spaces. -/
theorem span_bFullR_eq :
    Submodule.span ℝ (Set.range bFullR) = WHalf ⊔ W10 ⊔ WPs ⊔ WTwo := by
  rw [range_bFullR, Submodule.span_union, Submodule.span_union, Submodule.span_union]
  rfl

/-! ## The complete decomposition -/

/-- The full real matrix algebra has dimension `16`. -/
theorem finrank_matrix : finrank ℝ (Matrix (Fin 4) (Fin 4) ℝ) = 16 := by
  simp [Module.finrank_matrix]

/-- The fourfold sum of the representation spaces has dimension `16`. -/
theorem finrank_full : finrank ℝ ↥(WHalf ⊔ W10 ⊔ WPs ⊔ WTwo) = 16 := by
  have := finrank_span_eq_card bFullR_linearIndependent
  rw [span_bFullR_eq] at this
  simpa using this

/-- **Complete decomposition.**  The four mutually orthogonal representation
spaces span *all* of `Matrix (Fin 4) (Fin 4) ℝ`. -/
theorem decomposition_top : WHalf ⊔ W10 ⊔ WPs ⊔ WTwo = ⊤ := by
  apply Submodule.eq_top_of_finrank_eq
  rw [finrank_full, finrank_matrix]

/-- **Headline: complete internal direct sum.**  The dimension of the whole
matrix algebra equals the sum of the dimensions of the four mutually orthogonal
representation spaces, `16 = 4 + 6 + 4 + 2`. -/
theorem finrank_full_eq_add :
    finrank ℝ (Matrix (Fin 4) (Fin 4) ℝ)
      = finrank ℝ WHalf + finrank ℝ W10 + finrank ℝ WPs + finrank ℝ WTwo := by
  rw [finrank_matrix, finrank_WHalf, finrank_W10, finrank_WPs, finrank_WTwo]

end BookProof.ChapterLorentzRealRepFull
