import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterLorentzRealRep
import Mathlib


/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"On the Lorentz, SL(2,C) and Pin(3,1) groups", **Lemma 52** — the three real
irreducible representations are mutually orthogonal and form an internal direct sum

Continuing `BookProof.ChapterLorentzRealRep` (Lemma 52, `book.tex` line ~5560),
which built the three explicit real representation spaces of `SL(2,C)` inside the
`4×4` Majorana matrix model:

* `WHalf` — the `(1/2,1/2)` vector representation, `dim 4`;
* `W10`   — the `(1,0)` representation, `dim 6`;
* `WPs`   — the pseudo-`(1/2,1/2)` representation, `dim 4`.

This file discharges the *distinctness* half of the classification: the three
representation spaces are **mutually orthogonal** in the Frobenius inner product
`⟨A, B⟩ = tr(Aᵀ B)`, and therefore their sum inside the `16`-dimensional space of
`4×4` real matrices is an **internal direct sum** of dimension `4 + 6 + 4 = 14`.

Concretely:

* `gram_half10R`/`gram_halfPsR`/`gram_10PsR` — every cross Frobenius pairing
  between two different bases vanishes (mutual orthogonality, decided over `ℤ`
  and cast to `ℝ`);
* `bAll`/`bAllR` — the concatenated `14`-element basis, whose Frobenius Gram
  matrix is `4·I` (`gram_allR`), hence `bAllR_linearIndependent`
  (the `14` matrices are linearly independent over `ℝ`);
* `span_bAllR_eq` — the span of the concatenated basis is exactly
  `WHalf ⊔ W10 ⊔ WPs`;
* `finrank_WHalf`/`finrank_W10`/`finrank_WPs` (`= 4, 6, 4`) and
  `finrank_sup` (`= 14`), with `finrank_sup_eq_add` exhibiting the
  dimension additivity `dim (WHalf ⊔ W10 ⊔ WPs) = dim WHalf + dim W10 + dim WPs`
  that certifies the internal direct sum.

As requested this stays **off the gravity line** and **off the Hankel-transform
line** (only the concrete Majorana matrices of `ChapterA3`, the discrete group
`Ω` of `ChapterPinOmega`, and the representation spaces of
`ChapterLorentzRealRep` are used).

Everything is `sorry`-free and `axiom`-free.
-/

open Matrix

namespace BookProof.ChapterLorentzRealRepSum

open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

/-! ## Cross Frobenius orthogonality (over `ℤ`) -/







/-! ## Cross Frobenius orthogonality (over `ℝ`) -/







/-! ## The concatenated `14`-element basis -/

/-- The concatenation of the three bases `bHalf` (4), `b10` (6), `bPs` (4). -/
def bAll : Fin 14 → Matrix (Fin 4) (Fin 4) ℤ
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

/-- The concatenated basis over `ℝ`. -/
noncomputable def bAllR (i : Fin 14) : Matrix (Fin 4) (Fin 4) ℝ := castR (bAll i)







/-! ## The span of the concatenated basis is `WHalf ⊔ W10 ⊔ WPs` -/

PT theorem and the relativistic position operator",
§"On the Lorentz, SL(2,C) and Pin(3,1) groups", **Lemma 52** — the three real
irreducible representations are mutually orthogonal and form an internal direct sum

Continuing `BookProof.ChapterLorentzRealRep` (Lemma 52, `book.tex` line ~5560),
which built the three explicit real representation spaces of `SL(2,C)` inside the
`4×4` Majorana matrix model:

* `WHalf` — the `(1/2,1/2)` vector representation, `dim 4`;
* `W10`   — the `(1,0)` representation, `dim 6`;
* `WPs`   — the pseudo-`(1/2,1/2)` representation, `dim 4`.

This file discharges the *distinctness* half of the classification: the three
representation spaces are **mutually orthogonal** in the Frobenius inner product
`⟨A, B⟩ = tr(Aᵀ B)`, and therefore their sum inside the `16`-dimensional space of
`4×4` real matrices is an **internal direct sum** of dimension `4 + 6 + 4 = 14`.

Concretely:

* `gram_half10R`/`gram_halfPsR`/`gram_10PsR` — every cross Frobenius pairing
  between two different bases vanishes (mutual orthogonality, decided over `ℤ`
  and cast to `ℝ`);
* `bAll`/`bAllR` — the concatenated `14`-element basis, whose Frobenius Gram
  matrix is `4·I` (`gram_allR`), hence `bAllR_linearIndependent`
  (the `14` matrices are linearly independent over `ℝ`);
* `span_bAllR_eq` — the span of the concatenated basis is exactly
  `WHalf ⊔ W10 ⊔ WPs`;
* `finrank_WHalf`/`finrank_W10`/`finrank_WPs` (`= 4, 6, 4`) and
  `finrank_sup` (`= 14`), with `finrank_sup_eq_add` exhibiting the
  dimension additivity `dim (WHalf ⊔ W10 ⊔ WPs) = dim WHalf + dim W10 + dim WPs`
  that certifies the internal direct sum.

As requested this stays **off the gravity line** and **off the Hankel-transform
line** (only the concrete Majorana matrices of `ChapterA3`, the discrete group
`Ω` of `ChapterPinOmega`, and the representation spaces of
`ChapterLorentzRealRep` are used).

Everything is `sorry`-free and `axiom`-free.
-/

open Matrix

namespace BookProof.ChapterLorentzRealRepSum

open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

/-! ## Cross Frobenius orthogonality (over `ℤ`) -/

/-- The `(1/2,1/2)` and `(1,0)` bases are Frobenius-orthogonal. -/
theorem gram_half10 : ∀ (i : Fin 4) (j : Fin 6), ((bHalf i)ᵀ * b10 j).trace = 0 := by decide

/-- The `(1/2,1/2)` and pseudo-`(1/2,1/2)` bases are Frobenius-orthogonal. -/
theorem gram_halfPs : ∀ (i j : Fin 4), ((bHalf i)ᵀ * bPs j).trace = 0 := by decide

/-- The `(1,0)` and pseudo-`(1/2,1/2)` bases are Frobenius-orthogonal. -/
theorem gram_10Ps : ∀ (i : Fin 6) (j : Fin 4), ((b10 i)ᵀ * bPs j).trace = 0 := by decide

/-! ## Cross Frobenius orthogonality (over `ℝ`) -/

theorem gram_half10R : ∀ (i : Fin 4) (j : Fin 6), ((bHalfR i)ᵀ * b10R j).trace = (0 : ℝ) := by
  intro i j
  rw [bHalfR, b10R, ← castR_transpose, ← castR_mul, castR_trace, gram_half10]
  norm_num

theorem gram_halfPsR : ∀ (i j : Fin 4), ((bHalfR i)ᵀ * bPsR j).trace = (0 : ℝ) := by
  intro i j
  rw [bHalfR, bPsR, ← castR_transpose, ← castR_mul, castR_trace, gram_halfPs]
  norm_num

theorem gram_10PsR : ∀ (i : Fin 6) (j : Fin 4), ((b10R i)ᵀ * bPsR j).trace = (0 : ℝ) := by
  intro i j
  rw [b10R, bPsR, ← castR_transpose, ← castR_mul, castR_trace, gram_10Ps]
  norm_num

/-! ## The concatenated `14`-element basis -/

/-- The concatenation of the three bases `bHalf` (4), `b10` (6), `bPs` (4). -/
def bAll : Fin 14 → Matrix (Fin 4) (Fin 4) ℤ
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

/-- The concatenated basis over `ℝ`. -/
noncomputable def bAllR (i : Fin 14) : Matrix (Fin 4) (Fin 4) ℝ := castR (bAll i)

set_option maxHeartbeats 1000000 in
-- `decide` evaluates all `14 × 14` integer Frobenius pairings, so raise the heartbeat budget.
/-- The Frobenius Gram matrix of the concatenated basis is `4·I` (over `ℤ`). -/
theorem gram_all : ∀ i j : Fin 14, ((bAll i)ᵀ * bAll j).trace = if i = j then 4 else 0 := by
  decide

/-- The Frobenius Gram matrix of the concatenated basis is `4·I` (over `ℝ`). -/
theorem gram_allR :
    ∀ i j : Fin 14, ((bAllR i)ᵀ * bAllR j).trace = if i = j then (4 : ℝ) else 0 := by
  intro i j
  rw [bAllR, bAllR, ← castR_transpose, ← castR_mul, castR_trace, gram_all]
  split_ifs <;> norm_num

/-- The `14` concatenated basis matrices are linearly independent over `ℝ`. -/
theorem bAllR_linearIndependent : LinearIndependent ℝ bAllR :=
  linIndep_of_gram bAllR gram_allR

/-! ## The span of the concatenated basis is `WHalf ⊔ W10 ⊔ WPs` -/

/-- The range of the concatenated real basis is the union of the three ranges. -/
theorem range_bAllR :
    Set.range bAllR = Set.range bHalfR ∪ Set.range b10R ∪ Set.range bPsR := by
  ext x;
  constructor;
  · rintro ⟨ y, rfl ⟩;
    fin_cases y <;> simp [ bAllR, bHalfR, b10R, bPsR, bAll ];
  · rintro ((⟨y, rfl⟩ | ⟨y, rfl⟩) | ⟨y, rfl⟩)
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

/-- The span of the concatenated basis is the sum of the three representation spaces. -/
theorem span_bAllR_eq :
    Submodule.span ℝ (Set.range bAllR) = WHalf ⊔ W10 ⊔ WPs := by
  rw [range_bAllR, Submodule.span_union, Submodule.span_union]
  rfl

/-! ## Dimensions -/











end BookProof.ChapterLorentzRealRepSum
