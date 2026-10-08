import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterGammaCommutant
import Mathlib


/-!
# Note 36 — Pauli's fundamental theorem of the γ-matrices, proved

Source: `book.tex`, chapter *"Real representations, CPT theorem and the relativistic
position operator"*, §A.3, **Note 36**:

> Let `A^μ`, `B^μ` (`μ = 0,1,2,3`) be two sets of `4×4` complex matrices with
> `{A^μ, A^ν} = -2 η^{μν}`, `{B^μ, B^ν} = -2 η^{μν}`.  Then there is an invertible complex
> matrix `S` with `B^μ = S A^μ S⁻¹`, and `S` is unique up to a nonzero scalar.

`BookProof.ChapterA3b` carries this statement as the EXTERNAL named hypothesis
`PauliFundamental` (it is the only external input of §A.3, and the gap table of
`FORMALIZATION_ROADMAP.md` lists it as "not formalized"); Prop 37 (the real version) and
Lemma 40 are proved there *from* that hypothesis.  **This file proves the hypothesis**, so
`pauliFundamental` may be substituted wherever `PauliFundamental` was assumed.

## The proof

Everything is reduced to the *concrete* Majorana model `mgamma` of `BookProof.ChapterA3`.

* **The sixteen products.**  For `T : Finset (Fin 4)` let `gpF A T` be the product of the
  `A^μ`, `μ ∈ T`, in increasing order (`gp` over the list `sel T`).  The Clifford relations
  give the *shared* commutation rule `clifford_key`:
  `A^μ · gpF A T = sgnT μ T • gpF A (stepT μ T)`, where `stepT μ T = T Δ {μ}` and the sign
  `sgnT μ T = (-1)^#{ν ∈ T : ν < μ} · (μ ∈ T ? (A^μ)² : 1)` **depends only on `μ` and `T`** —
  the same function for every Clifford set, in particular for `mgamma`.
* **The intertwiner.**  `inter A F = ∑_T gpF A T · F · (G T)ᵀ`, with `G T = gpF mgamma T`
  (the concrete products are real orthogonal, so `(G T)ᵀ = (G T)⁻¹`).  The shared
  commutation rule plus the reindexing `T ↦ T Δ {μ}` (an involution of the index set) give
  `inter_intertwines`: `A^μ · inter A F = inter A F · mgamma μ`.
* **Nonvanishing.**  The concrete products are trace-orthogonal,
  `trace (G S · (G T)ᵀ) = 4 δ_{S,T}` (a finite integer computation), hence linearly
  independent, hence a basis of the `16`-dimensional matrix algebra.  If `inter A F = 0` for
  every `F`, taking `F` to be a matrix unit and pairing with `G U` forces every entry of
  every `gpF A T` to vanish — impossible, because `gpF A ∅ = 1`.
* **Invertibility.**  The kernel of a nonzero intertwiner is invariant under all `mgamma μ`,
  hence under all products `G T`, hence — as those span the whole matrix algebra — under
  every matrix; a nonzero vector in the kernel would therefore force the kernel to be
  everything, i.e. `S = 0`.  So `S` is injective and thus invertible.
* **Uniqueness** is `ChapterGammaCommutant.gamma_commutant_scalar` transported along `S`.

## Main results

* `exists_intertwiner` — every complex Clifford set is conjugate to the concrete Majorana
  set: `∃ S, IsUnit S.det ∧ ∀ μ, A μ = S * mgamma μ * S⁻¹`.
* `pauli_exists`, `pauli_unique` — the two halves of Note 36.
* **`pauliFundamental : PauliFundamental`** — the named hypothesis of `ChapterA3b`,
  discharged.
* `real_pauli'`, `chargeConj_unique'` — Prop 37 and the Lemma 40 uniqueness statement of
  `ChapterA3b`, now with no external input.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix Finset

namespace BookProof.ChapterPauliFundamental

open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

/-- `4×4` complex matrices. -/
abbrev M4 := Matrix (Fin 4) (Fin 4) ℂ

/-! ## The ordered products of a Clifford set -/

/-- The ordered product `A^{μ₁} ⋯ A^{μ_k}` along a list of indices. -/
noncomputable def gp (A : Fin 4 → M4) : List (Fin 4) → M4
  | [] => 1
  | μ :: t => A μ * gp A t



variable {A : Fin 4 → M4}







/-! ## The index bookkeeping (finite, decidable) -/

/-- The four indices in increasing order. -/
def idx : List (Fin 4) := [0, 1, 2, 3]

/-- The increasing list of the elements of `T`. -/
def sel (T : Finset (Fin 4)) : List (Fin 4) := idx.filter (fun x => x ∈ T)

/-- The elements of `T` below `μ`. -/
def lo (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) := T.filter (fun x => x < μ)

/-- The elements of `T` not below `μ`. -/
def hi (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) := T.filter (fun x => ¬ x < μ)

/-- The symmetric difference `T Δ {μ}`. -/
def stepT (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) :=
  if μ ∈ T then T.erase μ else insert μ T















theorem sel_empty : sel ∅ = [] := by decide

/-- The ordered product of the generators indexed by `T`. -/
noncomputable def gpF (A : Fin 4 → M4) (T : Finset (Fin 4)) : M4 := gp A (sel T)

@[simp] theorem gpF_empty (A : Fin 4 → M4) : gpF A ∅ = 1 := by
  rw [gpF, sel_empty]; rfl

/-- The sign produced when a generator is moved through an ordered product.  It depends only
on the index data, not on the Clifford set. -/
def sgnT (μ : Fin 4) (T : Finset (Fin 4)) : ℂ :=
  (-1) ^ ((lo μ T).card) * (if μ ∈ T then (if μ = 0 then (-1 : ℂ) else 1) else 1)ex`, chapter *"Real representations, CPT theorem and the relativistic
position operator"*, §A.3, **Note 36**:

> Let `A^μ`, `B^μ` (`μ = 0,1,2,3`) be two sets of `4×4` complex matrices with
> `{A^μ, A^ν} = -2 η^{μν}`, `{B^μ, B^ν} = -2 η^{μν}`.  Then there is an invertible complex
> matrix `S` with `B^μ = S A^μ S⁻¹`, and `S` is unique up to a nonzero scalar.

`BookProof.ChapterA3b` carries this statement as the EXTERNAL named hypothesis
`PauliFundamental` (it is the only external input of §A.3, and the gap table of
`FORMALIZATION_ROADMAP.md` lists it as "not formalized"); Prop 37 (the real version) and
Lemma 40 are proved there *from* that hypothesis.  **This file proves the hypothesis**, so
`pauliFundamental` may be substituted wherever `PauliFundamental` was assumed.

## The proof

Everything is reduced to the *concrete* Majorana model `mgamma` of `BookProof.ChapterA3`.

* **The sixteen products.**  For `T : Finset (Fin 4)` let `gpF A T` be the product of the
  `A^μ`, `μ ∈ T`, in increasing order (`gp` over the list `sel T`).  The Clifford relations
  give the *shared* commutation rule `clifford_key`:
  `A^μ · gpF A T = sgnT μ T • gpF A (stepT μ T)`, where `stepT μ T = T Δ {μ}` and the sign
  `sgnT μ T = (-1)^#{ν ∈ T : ν < μ} · (μ ∈ T ? (A^μ)² : 1)` **depends only on `μ` and `T`** —
  the same function for every Clifford set, in particular for `mgamma`.
* **The intertwiner.**  `inter A F = ∑_T gpF A T · F · (G T)ᵀ`, with `G T = gpF mgamma T`
  (the concrete products are real orthogonal, so `(G T)ᵀ = (G T)⁻¹`).  The shared
  commutation rule plus the reindexing `T ↦ T Δ {μ}` (an involution of the index set) give
  `inter_intertwines`: `A^μ · inter A F = inter A F · mgamma μ`.
* **Nonvanishing.**  The concrete products are trace-orthogonal,
  `trace (G S · (G T)ᵀ) = 4 δ_{S,T}` (a finite integer computation), hence linearly
  independent, hence a basis of the `16`-dimensional matrix algebra.  If `inter A F = 0` for
  every `F`, taking `F` to be a matrix unit and pairing with `G U` forces every entry of
  every `gpF A T` to vanish — impossible, because `gpF A ∅ = 1`.
* **Invertibility.**  The kernel of a nonzero intertwiner is invariant under all `mgamma μ`,
  hence under all products `G T`, hence — as those span the whole matrix algebra — under
  every matrix; a nonzero vector in the kernel would therefore force the kernel to be
  everything, i.e. `S = 0`.  So `S` is injective and thus invertible.
* **Uniqueness** is `ChapterGammaCommutant.gamma_commutant_scalar` transported along `S`.

## Main results

* `exists_intertwiner` — every complex Clifford set is conjugate to the concrete Majorana
  set: `∃ S, IsUnit S.det ∧ ∀ μ, A μ = S * mgamma μ * S⁻¹`.
* `pauli_exists`, `pauli_unique` — the two halves of Note 36.
* **`pauliFundamental : PauliFundamental`** — the named hypothesis of `ChapterA3b`,
  discharged.
* `real_pauli'`, `chargeConj_unique'` — Prop 37 and the Lemma 40 uniqueness statement of
  `ChapterA3b`, now with no external input.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix Finset

namespace BookProof.ChapterPauliFundamental

open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

/-- `4×4` complex matrices. -/
abbrev M4 := Matrix (Fin 4) (Fin 4) ℂ

/-! ## The ordered products of a Clifford set -/

/-- The ordered product `A^{μ₁} ⋯ A^{μ_k}` along a list of indices. -/
noncomputable def gp (A : Fin 4 → M4) : List (Fin 4) → M4
  | [] => 1
  | μ :: t => A μ * gp A t

theorem gp_append (A : Fin 4 → M4) (l₁ l₂ : List (Fin 4)) :
    gp A (l₁ ++ l₂) = gp A l₁ * gp A l₂ := by
  induction l₁ with
  | nil => simp [gp]
  | cons a t ih => simp [gp, ih, mul_assoc]

variable {A : Fin 4 → M4}

/-- Distinct generators of a Clifford set anticommute. -/
theorem cliff_anticomm (hA : IsCliffordC A) {μ ν : Fin 4} (h : μ ≠ ν) :
    A μ * A ν = -(A ν * A μ) := by
  have := hA μ ν
  rw [show minkowski μ ν = 0 by simp [minkowski, minkowskiZ, h]] at this
  simp only [mul_zero, zero_smul] at this
  linear_combination (norm := module) this

/-- The square of a generator: `(A⁰)² = -1` and `(A^k)² = 1` for `k = 1,2,3`. -/
theorem cliff_sq (hA : IsCliffordC A) (μ : Fin 4) :
    A μ * A μ = (if μ = 0 then (-1 : ℂ) else 1) • (1 : M4) := by
  have h := hA μ μ
  have h2 : (2 : ℂ) • (A μ * A μ) = (-2 * minkowski μ μ) • (1 : M4) := by
    rw [two_smul]; exact h
  have h3 := congrArg (fun Y : M4 => (2 : ℂ)⁻¹ • Y) h2
  simp only [smul_smul] at h3
  rw [show (2 : ℂ)⁻¹ * 2 = 1 by norm_num, one_smul] at h3
  rw [h3]; congr 1
  by_cases h0 : μ = 0 <;> simp [minkowski, minkowskiZ, h0]

/-- Moving a generator past a product of generators all different from it costs one sign per
factor. -/
theorem gp_push (hA : IsCliffordC A) (μ : Fin 4) :
    ∀ l : List (Fin 4), (∀ ν ∈ l, ν ≠ μ) →
      A μ * gp A l = ((-1 : ℂ) ^ l.length) • (gp A l * A μ) := by
  intro l
  induction l with
  | nil => intro _; simp [gp]
  | cons a t ih =>
      intro h
      have ha : a ≠ μ := h a (by simp)
      have ht : ∀ ν ∈ t, ν ≠ μ := fun ν hν => h ν (by simp [hν])
      have h1 : A μ * A a = -(A a * A μ) := cliff_anticomm hA (Ne.symm ha)
      simp only [gp, List.length_cons, ← mul_assoc, h1]
      rw [neg_mul, mul_assoc, ih ht]
      simp [pow_succ, mul_assoc]

/-! ## The index bookkeeping (finite, decidable) -/

/-- The four indices in increasing order. -/
def idx : List (Fin 4) := [0, 1, 2, 3]

/-- The increasing list of the elements of `T`. -/
def sel (T : Finset (Fin 4)) : List (Fin 4) := idx.filter (fun x => x ∈ T)

/-- The elements of `T` below `μ`. -/
def lo (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) := T.filter (fun x => x < μ)

/-- The elements of `T` not below `μ`. -/
def hi (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) := T.filter (fun x => ¬ x < μ)

/-- The symmetric difference `T Δ {μ}`. -/
def stepT (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) :=
  if μ ∈ T then T.erase μ else insert μ T

theorem sel_split : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    sel T = sel (lo μ T) ++ sel (hi μ T) := by decide

theorem sel_hi_mem : ∀ (μ : Fin 4) (T : Finset (Fin 4)), μ ∈ T →
    sel (hi μ T) = μ :: sel (hi μ (T.erase μ)) := by decide

theorem sel_hi_insert : ∀ (μ : Fin 4) (T : Finset (Fin 4)), μ ∉ T →
    sel (hi μ (insert μ T)) = μ :: sel (hi μ T) := by decide

theorem lo_stepT : ∀ (μ : Fin 4) (T : Finset (Fin 4)), lo μ (stepT μ T) = lo μ T := by decide

theorem sel_lo_ne : ∀ (μ : Fin 4) (T : Finset (Fin 4)), ∀ ν ∈ sel (lo μ T), ν ≠ μ := by decide

theorem stepT_involutive : ∀ (μ : Fin 4) (T : Finset (Fin 4)), stepT μ (stepT μ T) = T := by
  decide

theorem sel_lo_length : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    (sel (lo μ T)).length = (lo μ T).card := by decide

theorem sel_empty : sel ∅ = [] := by decide

/-- The ordered product of the generators indexed by `T`. -/
noncomputable def gpF (A : Fin 4 → M4) (T : Finset (Fin 4)) : M4 := gp A (sel T)

@[simp] theorem gpF_empty (A : Fin 4 → M4) : gpF A ∅ = 1 := by
  rw [gpF, sel_empty]; rfl

/-- The sign produced when a generator is moved through an ordered product.  It depends only
on the index data, not on the Clifford set. -/
def sgnT (μ : Fin 4) (T : Finset (Fin 4)) : ℂ :=
  (-1) ^ ((lo μ T).card) * (if μ ∈ T then (if μ = 0 then (-1 : ℂ) else 1) else 1)

/-- **The shared commutation rule.**  For *every* complex Clifford set,
`A^μ · gpF A T = sgnT μ T • gpF A (T Δ {μ})`. -/
theorem clifford_key (hA : IsCliffordC A) (μ : Fin 4) (T : Finset (Fin 4)) :
    A μ * gpF A T = sgnT μ T • gpF A (stepT μ T) := by
  set c := (lo μ T).card with hc
  have hL : A μ * gp A (sel (lo μ T)) = ((-1 : ℂ) ^ c) • (gp A (sel (lo μ T)) * A μ) := by
    rw [hc, ← sel_lo_length μ T]; exact gp_push hA μ _ (sel_lo_ne μ T)
  have hsplit : gpF A T = gp A (sel (lo μ T)) * gp A (sel (hi μ T)) := by
    rw [gpF, sel_split μ T, gp_append]
  by_cases hμ : μ ∈ T
  · have hstep : stepT μ T = T.erase μ := if_pos hμ
    have hlo : lo μ (T.erase μ) = lo μ T := by rw [← hstep]; exact lo_stepT μ T
    have h2 : gp A (sel (hi μ T)) = A μ * gp A (sel (hi μ (T.erase μ))) := by
      rw [sel_hi_mem μ T hμ]; rfl
    have h3 : gpF A (stepT μ T)
        = gp A (sel (lo μ T)) * gp A (sel (hi μ (T.erase μ))) := by
      rw [hstep, gpF, sel_split μ (T.erase μ), gp_append, hlo]
    rw [hsplit, h2, h3, sgnT, if_pos hμ, ← mul_assoc, hL]
    rw [smul_mul_assoc, mul_assoc, ← mul_assoc (A μ) (A μ), cliff_sq hA μ]
    rw [smul_mul_assoc, Matrix.one_mul, Matrix.mul_smul, smul_smul]
  · have hstep : stepT μ T = insert μ T := if_neg hμ
    have hlo : lo μ (insert μ T) = lo μ T := by rw [← hstep]; exact lo_stepT μ T
    have h3 : gpF A (stepT μ T)
        = gp A (sel (lo μ T)) * (A μ * gp A (sel (hi μ T))) := by
      rw [hstep, gpF, sel_split μ (insert μ T), gp_append, hlo, sel_hi_insert μ T hμ]
      rfl
    rw [hsplit, h3, sgnT, if_neg hμ, ← mul_assoc, hL, mul_one]
    rw [smul_mul_assoc, mul_assoc] *"Real representations, CPT theorem and the relativistic
position operator"*, §A.3, **Note 36**:

> Let `A^μ`, `B^μ` (`μ = 0,1,2,3`) be two sets of `4×4` complex matrices with
> `{A^μ, A^ν} = -2 η^{μν}`, `{B^μ, B^ν} = -2 η^{μν}`.  Then there is an invertible complex
> matrix `S` with `B^μ = S A^μ S⁻¹`, and `S` is unique up to a nonzero scalar.

`BookProof.ChapterA3b` carries this statement as the EXTERNAL named hypothesis
`PauliFundamental` (it is the only external input of §A.3, and the gap table of
`FORMALIZATION_ROADMAP.md` lists it as "not formalized"); Prop 37 (the real version) and
Lemma 40 are proved there *from* that hypothesis.  **This file proves the hypothesis**, so
`pauliFundamental` may be substituted wherever `PauliFundamental` was assumed.

## The proof

Everything is reduced to the *concrete* Majorana model `mgamma` of `BookProof.ChapterA3`.

* **The sixteen products.**  For `T : Finset (Fin 4)` let `gpF A T` be the product of the
  `A^μ`, `μ ∈ T`, in increasing order (`gp` over the list `sel T`).  The Clifford relations
  give the *shared* commutation rule `clifford_key`:
  `A^μ · gpF A T = sgnT μ T • gpF A (stepT μ T)`, where `stepT μ T = T Δ {μ}` and the sign
  `sgnT μ T = (-1)^#{ν ∈ T : ν < μ} · (μ ∈ T ? (A^μ)² : 1)` **depends only on `μ` and `T`** —
  the same function for every Clifford set, in particular for `mgamma`.
* **The intertwiner.**  `inter A F = ∑_T gpF A T · F · (G T)ᵀ`, with `G T = gpF mgamma T`
  (the concrete products are real orthogonal, so `(G T)ᵀ = (G T)⁻¹`).  The shared
  commutation rule plus the reindexing `T ↦ T Δ {μ}` (an involution of the index set) give
  `inter_intertwines`: `A^μ · inter A F = inter A F · mgamma μ`.
* **Nonvanishing.**  The concrete products are trace-orthogonal,
  `trace (G S · (G T)ᵀ) = 4 δ_{S,T}` (a finite integer computation), hence linearly
  independent, hence a basis of the `16`-dimensional matrix algebra.  If `inter A F = 0` for
  every `F`, taking `F` to be a matrix unit and pairing with `G U` forces every entry of
  every `gpF A T` to vanish — impossible, because `gpF A ∅ = 1`.
* **Invertibility.**  The kernel of a nonzero intertwiner is invariant under all `mgamma μ`,
  hence under all products `G T`, hence — as those span the whole matrix algebra — under
  every matrix; a nonzero vector in the kernel would therefore force the kernel to be
  everything, i.e. `S = 0`.  So `S` is injective and thus invertible.
* **Uniqueness** is `ChapterGammaCommutant.gamma_commutant_scalar` transported along `S`.

## Main results

* `exists_intertwiner` — every complex Clifford set is conjugate to the concrete Majorana
  set: `∃ S, IsUnit S.det ∧ ∀ μ, A μ = S * mgamma μ * S⁻¹`.
* `pauli_exists`, `pauli_unique` — the two halves of Note 36.
* **`pauliFundamental : PauliFundamental`** — the named hypothesis of `ChapterA3b`,
  discharged.
* `real_pauli'`, `chargeConj_unique'` — Prop 37 and the Lemma 40 uniqueness statement of
  `ChapterA3b`, now with no external input.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix Finset

namespace BookProof.ChapterPauliFundamental

open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

/-- `4×4` complex matrices. -/
abbrev M4 := Matrix (Fin 4) (Fin 4) ℂ

/-! ## The ordered products of a Clifford set -/

/-- The ordered product `A^{μ₁} ⋯ A^{μ_k}` along a list of indices. -/
noncomputable def gp (A : Fin 4 → M4) : List (Fin 4) → M4
  | [] => 1
  | μ :: t => A μ * gp A t

theorem gp_append (A : Fin 4 → M4) (l₁ l₂ : List (Fin 4)) :
    gp A (l₁ ++ l₂) = gp A l₁ * gp A l₂ := by
  induction l₁ with
  | nil => simp [gp]
  | cons a t ih => simp [gp, ih, mul_assoc]

variable {A : Fin 4 → M4}

/-- Distinct generators of a Clifford set anticommute. -/
theorem cliff_anticomm (hA : IsCliffordC A) {μ ν : Fin 4} (h : μ ≠ ν) :
    A μ * A ν = -(A ν * A μ) := by
  have := hA μ ν
  rw [show minkowski μ ν = 0 by simp [minkowski, minkowskiZ, h]] at this
  simp only [mul_zero, zero_smul] at this
  linear_combination (norm := module) this

/-- The square of a generator: `(A⁰)² = -1` and `(A^k)² = 1` for `k = 1,2,3`. -/
theorem cliff_sq (hA : IsCliffordC A) (μ : Fin 4) :
    A μ * A μ = (if μ = 0 then (-1 : ℂ) else 1) • (1 : M4) := by
  have h := hA μ μ
  have h2 : (2 : ℂ) • (A μ * A μ) = (-2 * minkowski μ μ) • (1 : M4) := by
    rw [two_smul]; exact h
  have h3 := congrArg (fun Y : M4 => (2 : ℂ)⁻¹ • Y) h2
  simp only [smul_smul] at h3
  rw [show (2 : ℂ)⁻¹ * 2 = 1 by norm_num, one_smul] at h3
  rw [h3]; congr 1
  by_cases h0 : μ = 0 <;> simp [minkowski, minkowskiZ, h0]

/-- Moving a generator past a product of generators all different from it costs one sign per
factor. -/
theorem gp_push (hA : IsCliffordC A) (μ : Fin 4) :
    ∀ l : List (Fin 4), (∀ ν ∈ l, ν ≠ μ) →
      A μ * gp A l = ((-1 : ℂ) ^ l.length) • (gp A l * A μ) := by
  intro l
  induction l with
  | nil => intro _; simp [gp]
  | cons a t ih =>
      intro h
      have ha : a ≠ μ := h a (by simp)
      have ht : ∀ ν ∈ t, ν ≠ μ := fun ν hν => h ν (by simp [hν])
      have h1 : A μ * A a = -(A a * A μ) := cliff_anticomm hA (Ne.symm ha)
      simp only [gp, List.length_cons, ← mul_assoc, h1]
      rw [neg_mul, mul_assoc, ih ht]
      simp [pow_succ, mul_assoc]

/-! ## The index bookkeeping (finite, decidable) -/

/-- The four indices in increasing order. -/
def idx : List (Fin 4) := [0, 1, 2, 3]

/-- The increasing list of the elements of `T`. -/
def sel (T : Finset (Fin 4)) : List (Fin 4) := idx.filter (fun x => x ∈ T)

/-- The elements of `T` below `μ`. -/
def lo (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) := T.filter (fun x => x < μ)

/-- The elements of `T` not below `μ`. -/
def hi (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) := T.filter (fun x => ¬ x < μ)

/-- The symmetric difference `T Δ {μ}`. -/
def stepT (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) :=
  if μ ∈ T then T.erase μ else insert μ T

theorem sel_split : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    sel T = sel (lo μ T) ++ sel (hi μ T) := by decide

theorem sel_hi_mem : ∀ (μ : Fin 4) (T : Finset (Fin 4)), μ ∈ T →
    sel (hi μ T) = μ :: sel (hi μ (T.erase μ)) := by decide

theorem sel_hi_insert : ∀ (μ : Fin 4) (T : Finset (Fin 4)), μ ∉ T →
    sel (hi μ (insert μ T)) = μ :: sel (hi μ T) := by decide

theorem lo_stepT : ∀ (μ : Fin 4) (T : Finset (Fin 4)), lo μ (stepT μ T) = lo μ T := by decide

theorem sel_lo_ne : ∀ (μ : Fin 4) (T : Finset (Fin 4)), ∀ ν ∈ sel (lo μ T), ν ≠ μ := by decide

theorem stepT_involutive : ∀ (μ : Fin 4) (T : Finset (Fin 4)), stepT μ (stepT μ T) = T := by
  decide

theorem sel_lo_length : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    (sel (lo μ T)).length = (lo μ T).card := by decide

theorem sel_empty : sel ∅ = [] := by decide

/-- The ordered product of the generators indexed by `T`. -/
noncomputable def gpF (A : Fin 4 → M4) (T : Finset (Fin 4)) : M4 := gp A (sel T)

@[simp] theorem gpF_empty (A : Fin 4 → M4) : gpF A ∅ = 1 := by
  rw [gpF, sel_empty]; rfl

/-- The sign produced when a generator is moved through an ordered product.  It depends only
on the index data, not on the Clifford set. -/
def sgnT (μ : Fin 4) (T : Finset (Fin 4)) : ℂ :=
  (-1) ^ ((lo μ T).card) * (if μ ∈ T then (if μ = 0 then (-1 : ℂ) else 1) else 1)

/-- **The shared commutation rule.**  For *every* complex Clifford set,
`A^μ · gpF A T = sgnT μ T • gpF A (T Δ {μ})`. -/
theorem clifford_key (hA : IsCliffordC A) (μ : Fin 4) (T : Finset (Fin 4)) :
    A μ * gpF A T = sgnT μ T • gpF A (stepT μ T) := by
  set c := (lo μ T).card with hc
  have hL : A μ * gp A (sel (lo μ T)) = ((-1 : ℂ) ^ c) • (gp A (sel (lo μ T)) * A μ) := by
    rw [hc, ← sel_lo_length μ T]; exact gp_push hA μ _ (sel_lo_ne μ T)
  have hsplit : gpF A T = gp A (sel (lo μ T)) * gp A (sel (hi μ T)) := by
    rw [gpF, sel_split μ T, gp_append]
  by_cases hμ : μ ∈ T
  · have hstep : stepT μ T = T.erase μ := if_pos hμ
    have hlo : lo μ (T.erase μ) = lo μ T := by rw [← hstep]; exact lo_stepT μ T
    have h2 : gp A (sel (hi μ T)) = A μ * gp A (sel (hi μ (T.erase μ))) := by
      rw [sel_hi_mem μ T hμ]; rfl
    have h3 : gpF A (stepT μ T)
        = gp A (sel (lo μ T)) * gp A (sel (hi μ (T.erase μ))) := by
      rw [hstep, gpF, sel_split μ (T.erase μ), gp_append, hlo]
    rw [hsplit, h2, h3, sgnT, if_pos hμ, ← mul_assoc, hL]
    rw [smul_mul_assoc, mul_assoc, ← mul_assoc (A μ) (A μ), cliff_sq hA μ]
    rw [smul_mul_assoc, Matrix.one_mul, Matrix.mul_smul, smul_smul]
  · have hstep : stepT μ T = insert μ T := if_neg hμ
    have hlo : lo μ (insert μ T) = lo μ T := by rw [← hstep]; exact lo_stepT μ T
    have h3 : gpF A (stepT μ T)
        = gp A (sel (lo μ T)) * (A μ * gp A (sel (hi μ T))) := by
      rw [hstep, gpF, sel_split μ (insert μ T), gp_append, hlo, sel_hi_insert μ T hμ]
      rfl
    rw [hsplit, h3, sgnT, if_neg hμ, ← mul_assoc, hL, mul_one]
    rw [smul_mul_assoc, mul_assoc]

/-! ## The concrete products and their trace orthogonality -/

/-- The ordered products over `ℤ`, for the integer Majorana model. -/
def gpZ (A : Fin 4 → Matrix (Fin 4) (Fin 4) ℤ) : List (Fin 4) → Matrix (Fin 4) (Fin 4) ℤ
  | [] => 1
  | μ :: t => A μ * gpZ A t

/-- The sixteen integer products of the Majorana matrices. -/
def GZ (T : Finset (Fin 4)) : Matrix (Fin 4) (Fin 4) ℤ := gpZ mgammaZ (sel T)

theorem GZ_orthogonal : ∀ T : Finset (Fin 4), GZ T * (GZ T)ᵀ = 1 := by decide



/-- The sixteen complex products of the Majorana matrices. -/
noncomputable def G (T : Finset (Fin 4)) : M4 := gpF mgamma T











/-! ## Linear independence and spanning of the sixteen products -/





/-! ## The intertwiner -/

/-- Pauli's averaged intertwiner `∑_T (A-product) · F · (γ-product)⁻¹`. -/
noncomputable def inter (A : Fin 4 → M4) (F : M4) : M4 :=
  ∑ T : Finset (Fin 4), gpF A T * F * (G T)ᵀ





/-! ## The intertwiner is not always zero -/



/-! ## Invertibility of a nonzero intertwiner -/



matrix `S` with `B^μ = S A^μ S⁻¹`, and `S` is unique up to a nonzero scalar.

`BookProof.ChapterA3b` carries this statement as the EXTERNAL named hypothesis
`PauliFundamental` (it is the only external input of §A.3, and the gap table of
`FORMALIZATION_ROADMAP.md` lists it as "not formalized"); Prop 37 (the real version) and
Lemma 40 are proved there *from* that hypothesis.  **This file proves the hypothesis**, so
`pauliFundamental` may be substituted wherever `PauliFundamental` was assumed.

## The proof

Everything is reduced to the *concrete* Majorana model `mgamma` of `BookProof.ChapterA3`.

* **The sixteen products.**  For `T : Finset (Fin 4)` let `gpF A T` be the product of the
  `A^μ`, `μ ∈ T`, in increasing order (`gp` over the list `sel T`).  The Clifford relations
  give the *shared* commutation rule `clifford_key`:
  `A^μ · gpF A T = sgnT μ T • gpF A (stepT μ T)`, where `stepT μ T = T Δ {μ}` and the sign
  `sgnT μ T = (-1)^#{ν ∈ T : ν < μ} · (μ ∈ T ? (A^μ)² : 1)` **depends only on `μ` and `T`** —
  the same function for every Clifford set, in particular for `mgamma`.
* **The intertwiner.**  `inter A F = ∑_T gpF A T · F · (G T)ᵀ`, with `G T = gpF mgamma T`
  (the concrete products are real orthogonal, so `(G T)ᵀ = (G T)⁻¹`).  The shared
  commutation rule plus the reindexing `T ↦ T Δ {μ}` (an involution of the index set) give
  `inter_intertwines`: `A^μ · inter A F = inter A F · mgamma μ`.
* **Nonvanishing.**  The concrete products are trace-orthogonal,
  `trace (G S · (G T)ᵀ) = 4 δ_{S,T}` (a finite integer computation), hence linearly
  independent, hence a basis of the `16`-dimensional matrix algebra.  If `inter A F = 0` for
  every `F`, taking `F` to be a matrix unit and pairing with `G U` forces every entry of
  every `gpF A T` to vanish — impossible, because `gpF A ∅ = 1`.
* **Invertibility.**  The kernel of a nonzero intertwiner is invariant under all `mgamma μ`,
  hence under all products `G T`, hence — as those span the whole matrix algebra — under
  every matrix; a nonzero vector in the kernel would therefore force the kernel to be
  everything, i.e. `S = 0`.  So `S` is injective and thus invertible.
* **Uniqueness** is `ChapterGammaCommutant.gamma_commutant_scalar` transported along `S`.

## Main results

* `exists_intertwiner` — every complex Clifford set is conjugate to the concrete Majorana
  set: `∃ S, IsUnit S.det ∧ ∀ μ, A μ = S * mgamma μ * S⁻¹`.
* `pauli_exists`, `pauli_unique` — the two halves of Note 36.
* **`pauliFundamental : PauliFundamental`** — the named hypothesis of `ChapterA3b`,
  discharged.
* `real_pauli'`, `chargeConj_unique'` — Prop 37 and the Lemma 40 uniqueness statement of
  `ChapterA3b`, now with no external input.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix Finset

namespace BookProof.ChapterPauliFundamental

open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

/-- `4×4` complex matrices. -/
abbrev M4 := Matrix (Fin 4) (Fin 4) ℂ

/-! ## The ordered products of a Clifford set -/

/-- The ordered product `A^{μ₁} ⋯ A^{μ_k}` along a list of indices. -/
noncomputable def gp (A : Fin 4 → M4) : List (Fin 4) → M4
  | [] => 1
  | μ :: t => A μ * gp A t

theorem gp_append (A : Fin 4 → M4) (l₁ l₂ : List (Fin 4)) :
    gp A (l₁ ++ l₂) = gp A l₁ * gp A l₂ := by
  induction l₁ with
  | nil => simp [gp]
  | cons a t ih => simp [gp, ih, mul_assoc]

variable {A : Fin 4 → M4}

/-- Distinct generators of a Clifford set anticommute. -/
theorem cliff_anticomm (hA : IsCliffordC A) {μ ν : Fin 4} (h : μ ≠ ν) :
    A μ * A ν = -(A ν * A μ) := by
  have := hA μ ν
  rw [show minkowski μ ν = 0 by simp [minkowski, minkowskiZ, h]] at this
  simp only [mul_zero, zero_smul] at this
  linear_combination (norm := module) this

/-- The square of a generator: `(A⁰)² = -1` and `(A^k)² = 1` for `k = 1,2,3`. -/
theorem cliff_sq (hA : IsCliffordC A) (μ : Fin 4) :
    A μ * A μ = (if μ = 0 then (-1 : ℂ) else 1) • (1 : M4) := by
  have h := hA μ μ
  have h2 : (2 : ℂ) • (A μ * A μ) = (-2 * minkowski μ μ) • (1 : M4) := by
    rw [two_smul]; exact h
  have h3 := congrArg (fun Y : M4 => (2 : ℂ)⁻¹ • Y) h2
  simp only [smul_smul] at h3
  rw [show (2 : ℂ)⁻¹ * 2 = 1 by norm_num, one_smul] at h3
  rw [h3]; congr 1
  by_cases h0 : μ = 0 <;> simp [minkowski, minkowskiZ, h0]

/-- Moving a generator past a product of generators all different from it costs one sign per
factor. -/
theorem gp_push (hA : IsCliffordC A) (μ : Fin 4) :
    ∀ l : List (Fin 4), (∀ ν ∈ l, ν ≠ μ) →
      A μ * gp A l = ((-1 : ℂ) ^ l.length) • (gp A l * A μ) := by
  intro l
  induction l with
  | nil => intro _; simp [gp]
  | cons a t ih =>
      intro h
      have ha : a ≠ μ := h a (by simp)
      have ht : ∀ ν ∈ t, ν ≠ μ := fun ν hν => h ν (by simp [hν])
      have h1 : A μ * A a = -(A a * A μ) := cliff_anticomm hA (Ne.symm ha)
      simp only [gp, List.length_cons, ← mul_assoc, h1]
      rw [neg_mul, mul_assoc, ih ht]
      simp [pow_succ, mul_assoc]

/-! ## The index bookkeeping (finite, decidable) -/

/-- The four indices in increasing order. -/
def idx : List (Fin 4) := [0, 1, 2, 3]

/-- The increasing list of the elements of `T`. -/
def sel (T : Finset (Fin 4)) : List (Fin 4) := idx.filter (fun x => x ∈ T)

/-- The elements of `T` below `μ`. -/
def lo (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) := T.filter (fun x => x < μ)

/-- The elements of `T` not below `μ`. -/
def hi (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) := T.filter (fun x => ¬ x < μ)

/-- The symmetric difference `T Δ {μ}`. -/
def stepT (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) :=
  if μ ∈ T then T.erase μ else insert μ T

theorem sel_split : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    sel T = sel (lo μ T) ++ sel (hi μ T) := by decide

theorem sel_hi_mem : ∀ (μ : Fin 4) (T : Finset (Fin 4)), μ ∈ T →
    sel (hi μ T) = μ :: sel (hi μ (T.erase μ)) := by decide

theorem sel_hi_insert : ∀ (μ : Fin 4) (T : Finset (Fin 4)), μ ∉ T →
    sel (hi μ (insert μ T)) = μ :: sel (hi μ T) := by decide

theorem lo_stepT : ∀ (μ : Fin 4) (T : Finset (Fin 4)), lo μ (stepT μ T) = lo μ T := by decide

theorem sel_lo_ne : ∀ (μ : Fin 4) (T : Finset (Fin 4)), ∀ ν ∈ sel (lo μ T), ν ≠ μ := by decide

theorem stepT_involutive : ∀ (μ : Fin 4) (T : Finset (Fin 4)), stepT μ (stepT μ T) = T := by
  decide

theorem sel_lo_length : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    (sel (lo μ T)).length = (lo μ T).card := by decide

theorem sel_empty : sel ∅ = [] := by decide

/-- The ordered product of the generators indexed by `T`. -/
noncomputable def gpF (A : Fin 4 → M4) (T : Finset (Fin 4)) : M4 := gp A (sel T)

@[simp] theorem gpF_empty (A : Fin 4 → M4) : gpF A ∅ = 1 := by
  rw [gpF, sel_empty]; rfl

/-- The sign produced when a generator is moved through an ordered product.  It depends only
on the index data, not on the Clifford set. -/
def sgnT (μ : Fin 4) (T : Finset (Fin 4)) : ℂ :=
  (-1) ^ ((lo μ T).card) * (if μ ∈ T then (if μ = 0 then (-1 : ℂ) else 1) else 1)

/-- **The shared commutation rule.**  For *every* complex Clifford set,
`A^μ · gpF A T = sgnT μ T • gpF A (T Δ {μ})`. -/
theorem clifford_key (hA : IsCliffordC A) (μ : Fin 4) (T : Finset (Fin 4)) :
    A μ * gpF A T = sgnT μ T • gpF A (stepT μ T) := by
  set c := (lo μ T).card with hc
  have hL : A μ * gp A (sel (lo μ T)) = ((-1 : ℂ) ^ c) • (gp A (sel (lo μ T)) * A μ) := by
    rw [hc, ← sel_lo_length μ T]; exact gp_push hA μ _ (sel_lo_ne μ T)
  have hsplit : gpF A T = gp A (sel (lo μ T)) * gp A (sel (hi μ T)) := by
    rw [gpF, sel_split μ T, gp_append]
  by_cases hμ : μ ∈ T
  · have hstep : stepT μ T = T.erase μ := if_pos hμ
    have hlo : lo μ (T.erase μ) = lo μ T := by rw [← hstep]; exact lo_stepT μ T
    have h2 : gp A (sel (hi μ T)) = A μ * gp A (sel (hi μ (T.erase μ))) := by
      rw [sel_hi_mem μ T hμ]; rfl
    have h3 : gpF A (stepT μ T)
        = gp A (sel (lo μ T)) * gp A (sel (hi μ (T.erase μ))) := by
      rw [hstep, gpF, sel_split μ (T.erase μ), gp_append, hlo]
    rw [hsplit, h2, h3, sgnT, if_pos hμ, ← mul_assoc, hL]
    rw [smul_mul_assoc, mul_assoc, ← mul_assoc (A μ) (A μ), cliff_sq hA μ]
    rw [smul_mul_assoc, Matrix.one_mul, Matrix.mul_smul, smul_smul]
  · have hstep : stepT μ T = insert μ T := if_neg hμ
    have hlo : lo μ (insert μ T) = lo μ T := by rw [← hstep]; exact lo_stepT μ T
    have h3 : gpF A (stepT μ T)
        = gp A (sel (lo μ T)) * (A μ * gp A (sel (hi μ T))) := by
      rw [hstep, gpF, sel_split μ (insert μ T), gp_append, hlo, sel_hi_insert μ T hμ]
      rfl
    rw [hsplit, h3, sgnT, if_neg hμ, ← mul_assoc, hL, mul_one]
    rw [smul_mul_assoc, mul_assoc]

/-! ## The concrete products and their trace orthogonality -/

/-- The ordered products over `ℤ`, for the integer Majorana model. -/
def gpZ (A : Fin 4 → Matrix (Fin 4) (Fin 4) ℤ) : List (Fin 4) → Matrix (Fin 4) (Fin 4) ℤ
  | [] => 1
  | μ :: t => A μ * gpZ A t

/-- The sixteen integer products of the Majorana matrices. -/
def GZ (T : Finset (Fin 4)) : Matrix (Fin 4) (Fin 4) ℤ := gpZ mgammaZ (sel T)

theorem GZ_orthogonal : ∀ T : Finset (Fin 4), GZ T * (GZ T)ᵀ = 1 := by decide

theorem GZ_traceOrth : ∀ S T : Finset (Fin 4),
    (GZ S * (GZ T)ᵀ).trace = if S = T then 4 else 0 := by decide

/-- The sixteen complex products of the Majorana matrices. -/
noncomputable def G (T : Finset (Fin 4)) : M4 := gpF mgamma T

theorem G_eq_map (T : Finset (Fin 4)) : G T = (GZ T).map (Int.cast) := by
  have h : ∀ l : List (Fin 4), gp mgamma l = (gpZ mgammaZ l).map (Int.cast) := by
    intro l
    induction l with
    | nil =>
        ext i j
        by_cases hij : i = j <;> simp [gp, gpZ, Matrix.one_apply, hij]
    | cons a t ih =>
        change mgamma a * gp mgamma t = _
        rw [ih, mgamma]
        ext i j
        simp [gpZ, Matrix.mul_apply, RingHom.mapMatrix_apply, Matrix.map_apply]
  rw [G, gpF, GZ, h]

theorem G_orthogonal (T : Finset (Fin 4)) : G T * (G T)ᵀ = 1 := by
  have h := GZ_orthogonal T
  rw [G_eq_map]
  ext i j
  have := congrFun (congrFun (congrArg (fun M : Matrix (Fin 4) (Fin 4) ℤ =>
    M.map (Int.cast : ℤ → ℂ)) h) i) j
  simpa [Matrix.mul_apply, Matrix.map_apply, Matrix.transpose_apply, Matrix.one_apply,
    apply_ite (Int.cast : ℤ → ℂ)] using this

theorem G_inv (T : Finset (Fin 4)) : (G T)⁻¹ = (G T)ᵀ :=
  Matrix.inv_eq_right_inv (G_orthogonal T)

theorem G_isUnit (T : Finset (Fin 4)) : IsUnit (G T).det :=
  Matrix.isUnit_det_of_right_inverse (G_orthogonal T)

theorem G_traceOrth (S T : Finset (Fin 4)) :
    (G S * (G T)ᵀ).trace = if S = T then 4 else 0 := by
  have h := GZ_traceOrth S T
  have hmap : (G S * (G T)ᵀ) = (GZ S * (GZ T)ᵀ).map (Int.cast : ℤ → ℂ) := by
    rw [G_eq_map, G_eq_map]
    ext i j
    simp [Matrix.mul_apply, Matrix.map_apply, Matrix.transpose_apply]
  have htr : ((GZ S * (GZ T)ᵀ).map (Int.cast : ℤ → ℂ)).trace
      = ((GZ S * (GZ T)ᵀ).trace : ℂ) := by
    simp [Matrix.trace, Matrix.diag_apply, Matrix.map_apply]
  rw [hmap, htr, h]
  split <;> simp

/-! ## Linear independence and spanning of the sixteen products -/

theorem G_linearIndependent : LinearIndependent ℂ G := by
  rw [Fintype.linearIndependent_iff]
  intro g hg U
  have h := congrArg (fun X : M4 => (X * (G U)ᵀ).trace) hg
  simp only [Finset.sum_mul, Matrix.trace_sum, zero_mul, Matrix.trace_zero,
    Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul] at h
  rw [Finset.sum_congr rfl (fun T _ => by rw [G_traceOrth T U])] at h
  simp only [mul_ite, mul_zero] at h
  rw [Finset.sum_ite_eq' Finset.univ U (fun T => g T * 4)] at h
  simp only [Finset.mem_univ, if_true] at h
  have h4 : (4 : ℂ) ≠ 0 := by norm_num
  exact (mul_eq_zero.1 h).resolve_right h4

theorem G_span : Submodule.span ℂ (Set.range G) = ⊤ := by
  have hcard : Fintype.card (Finset (Fin 4)) = Module.finrank ℂ M4 := by
    rw [Module.finrank_matrix]
    simp
  have := (basisOfLinearIndependentOfCardEqFinrank G_linearIndependent hcard).span_eq
  rwa [coe_basisOfLinearIndependentOfCardEqFinrank] at this

/-! ## The intertwiner -/

/-- Pauli's averaged intertwiner `∑_T (A-product) · F · (γ-product)⁻¹`. -/
noncomputable def inter (A : Fin 4 → M4) (F : M4) : M4 :=
  ∑ T : Finset (Fin 4), gpF A T * F * (G T)ᵀ

/-- The transpose (= inverse) of a concrete product moves a `γ^μ` through, with the same
sign as the abstract rule. -/
theorem G_transpose_mul (μ : Fin 4) (T : Finset (Fin 4)) :
    (G T)ᵀ * mgamma μ = sgnT μ (stepT μ T) • (G (stepT μ T))ᵀ := by
  set T' := stepT μ T with hT'
  have hkey : mgamma μ * G T' = sgnT μ T' • G (stepT μ T') :=
    clifford_key mgamma_clifford μ T'
  rw [hT', stepT_involutive μ T] at hkey
  have hinvT : (G T)ᵀ * G T = 1 := by
    have := G_orthogonal T
    have hdet := G_isUnit T
    calc (G T)ᵀ * G T = (G T)⁻¹ * G T := by rw [G_inv]
    _ = 1 := Matrix.nonsing_inv_mul _ hdet
  have hinvT' : G T' * (G T')ᵀ = 1 := G_orthogonal T'
  calc (G T)ᵀ * mgamma μ
      = (G T)ᵀ * mgamma μ * (G T' * (G T')ᵀ) := by rw [hinvT', Matrix.mul_one]
    _ = (G T)ᵀ * (mgamma μ * G T') * (G T')ᵀ := by
        simp only [Matrix.mul_assoc]
    _ = (G T)ᵀ * ((sgnT μ T') • G T) * (G T')ᵀ := by rw [hkey]
    _ = sgnT μ T' • (((G T)ᵀ * G T) * (G T')ᵀ) := by
        rw [Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_assoc]
    _ = sgnT μ T' • (G T')ᵀ := by rw [hinvT, Matrix.one_mul]

/-- **The intertwining property.**  `A^μ · inter A F = inter A F · γ^μ`. -/
theorem inter_intertwines (hA : IsCliffordC A) (F : M4) (μ : Fin 4) :
    A μ * inter A F = inter A F * mgamma μ := by
  have hleft : A μ * inter A F
      = ∑ T : Finset (Fin 4), sgnT μ T • (gpF A (stepT μ T) * F * (G T)ᵀ) := by
    rw [inter, Finset.mul_sum]
    refine Finset.sum_congr rfl fun T _ => ?_
    rw [← Matrix.mul_assoc, ← Matrix.mul_assoc, clifford_key hA μ T,
      Matrix.smul_mul, Matrix.smul_mul]
  have hright : inter A F * mgamma μ
      = ∑ T : Finset (Fin 4),
          sgnT μ (stepT μ T) • (gpF A T * F * (G (stepT μ T))ᵀ) := by
    rw [inter, Finset.sum_mul]
    refine Finset.sum_congr rfl fun T _ => ?_
    rw [Matrix.mul_assoc, G_transpose_mul μ T, Matrix.mul_smul, Matrix.mul_assoc]
  rw [hleft, hright]
  refine Fintype.sum_equiv (Function.Involutive.toPerm (stepT μ) (stepT_involutive μ)) _ _ ?_
  intro T
  change sgnT μ T • (gpF A (stepT μ T) * F * (G T)ᵀ)
      = sgnT μ (stepT μ (stepT μ T)) • (gpF A (stepT μ T) * F * (G (stepT μ (stepT μ T)))ᵀ)
  rw [stepT_involutive μ T]

/-! ## The intertwiner is not always zero -/

theorem exists_inter_ne_zero : ∃ F : M4, inter A F ≠ 0 := by
  by_contra hcon
  push_neg at hcon
  -- every entry of every product `gpF A T` vanishes
  have hzero : ∀ (T : Finset (Fin 4)) (m i : Fin 4), gpF A T m i = 0 := by
    intro U m i
    -- the combination `∑_T (gpF A T) m i • (G T)ᵀ` vanishes
    have hcomb : ∑ T : Finset (Fin 4), (gpF A T m i) • (G T)ᵀ = 0 := by
      ext j n
      have h := congrFun (congrFun (hcon (Matrix.single i j (1 : ℂ))) m) n
      have hexp : ∀ T : Finset (Fin 4),
          (gpF A T * Matrix.single i j (1 : ℂ) * (G T)ᵀ) m n
            = (gpF A T m i) * ((G T)ᵀ j n) := by
        intro T
        simp [Matrix.mul_apply, Matrix.single_apply, ite_and, Finset.sum_ite_eq, mul_comm]
      simp only [inter, Matrix.sum_apply, hexp] at h
      simpa [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul] using h
    -- pair with `G U` through the trace
    have h := congrArg (fun X : M4 => (X * G U).trace) hcomb
    simp only [Finset.sum_mul, Matrix.trace_sum, Matrix.smul_mul, Matrix.trace_smul,
      smul_eq_mul, Matrix.zero_mul, Matrix.trace_zero] at h
    have hTr : ∀ T : Finset (Fin 4), ((G T)ᵀ * G U).trace = if U = T then 4 else 0 := by
      intro T
      rw [Matrix.trace_mul_comm]
      exact G_traceOrth U T
    rw [Finset.sum_congr rfl (fun T _ => by rw [hTr T])] at h
    simp only [mul_ite, mul_zero] at h
    rw [Finset.sum_ite_eq Finset.univ U (fun T => gpF A T m i * 4)] at h
    simp only [Finset.mem_univ, if_true] at h
    have h4 : (4 : ℂ) ≠ 0 := by norm_num
    exact (mul_eq_zero.1 h).resolve_right h4
  have h1 := hzero ∅ 0 0
  rw [gpF_empty] at h1
  simp at h1

/-! ## Invertibility of a nonzero intertwiner -/

/-- **A nonzero intertwiner is invertible.**  If `A^μ · S = S · γ^μ` for all `μ` and
`S ≠ 0`, then `S` is invertible: its kernel is invariant under all the `γ^μ`, hence under
the sixteen products, hence — as those span the whole matrix algebra — under every matrix,
so a nonzero kernel vector would force `S = 0`. -/
theorem intertwiner_isUnit {S : M4} (hS0 : S ≠ 0) (hSint : ∀ μ, A μ * S = S * mgamma μ) :
    IsUnit S.det := by
  by_contra hdet
  have hdet0 : S.det = 0 := by
    by_contra h
    exact hdet (isUnit_iff_ne_zero.mpr h)
  obtain ⟨v, hv0, hv⟩ := Matrix.exists_mulVec_eq_zero_iff.2 hdet0
  -- the kernel of `S`
  let K : Submodule ℂ (Fin 4 → ℂ) :=
    { carrier := {w | S *ᵥ w = 0}
      add_mem' := by
        intro a b ha hb
        simp only [Set.mem_setOf_eq] at *
        rw [Matrix.mulVec_add, ha, hb, add_zero]
      zero_mem' := by simp
      smul_mem' := by
        intro c a ha
        simp only [Set.mem_setOf_eq] at *
        rw [Matrix.mulVec_smul, ha, smul_zero] }
  have hmemK : ∀ w : Fin 4 → ℂ, w ∈ K ↔ S *ᵥ w = 0 := fun w => Iff.rfl
  have hgamma : ∀ (μ : Fin 4) (w : Fin 4 → ℂ), w ∈ K → mgamma μ *ᵥ w ∈ K := by
    intro μ w hw
    rw [hmemK] at hw ⊢
    rw [Matrix.mulVec_mulVec, ← hSint μ, ← Matrix.mulVec_mulVec, hw, Matrix.mulVec_zero]
  have hgp : ∀ (l : List (Fin 4)) (w : Fin 4 → ℂ), w ∈ K → gp mgamma l *ᵥ w ∈ K := by
    intro l
    induction l with
    | nil => intro w hw; simpa [gp] using hw
    | cons a t ih =>
        intro w hw
        have hstep : gp mgamma (a :: t) *ᵥ w = mgamma a *ᵥ (gp mgamma t *ᵥ w) := by
          change (mgamma a * gp mgamma t) *ᵥ w = _
          rw [Matrix.mulVec_mulVec]
        rw [hstep]
        exact hgamma a _ (ih w hw)
  have hGK : ∀ (T : Finset (Fin 4)) (w : Fin 4 → ℂ), w ∈ K → G T *ᵥ w ∈ K :=
    fun T w hw => hgp (sel T) w hw
  -- hence the kernel is invariant under every matrix
  have hall : ∀ (X : M4) (w : Fin 4 → ℂ), w ∈ K → X *ᵥ w ∈ K := by
    intro X w hw
    have hmem : X ∈ Submodule.span ℂ (Set.range G) := by rw [G_span]; trivial
    refine Submodule.span_induction ?_ ?_ ?_ ?_ hmem
    · rintro Y ⟨T, rfl⟩
      exact hGK T w hw
    · change (0 : M4) *ᵥ w ∈ K
      rw [Matrix.zero_mulVec]
      exact K.zero_mem
    · intro Y Z _ _ hY hZ
      change (Y + Z) *ᵥ w ∈ K
      rw [Matrix.add_mulVec]
      exact K.add_mem hY hZ
    · intro c Y _ hY
      change (c • Y) *ᵥ w ∈ K
      rw [Matrix.smul_mulVec]
      exact K.smul_mem c hY
  -- a nonzero kernel vector makes the kernel everything, so `S = 0`
  have htop : ∀ w : Fin 4 → ℂ, w ∈ K := by
    intro w
    obtain ⟨i, hi⟩ : ∃ i, v i ≠ 0 := by
      by_contra hcon
      push_neg at hcon
      exact hv0 (funext hcon)
    have hX := hall (Matrix.of fun a b => if b = i then w a / v i else 0) v hv
    have heq : (Matrix.of fun a b => if b = i then w a / v i else 0) *ᵥ v = w := by
      funext a
      rw [Matrix.mulVec, dotProduct]
      rw [Finset.sum_eq_single i]
      · simp only [Matrix.of_apply, if_true]
        field_simp
      · intro b _ hb; simp [hb]
      · intro h; exact absurd (Finset.mem_univ i) h
    rwa [heq] at hX
  have hzero : S = 0 := by
    ext a b
    have hb : S *ᵥ (fun c => if c = b then (1 : ℂ) else 0) = 0 :=
      htop (fun c => if c = b then 1 else 0)
    have hcol := congrFun hb a
    rw [Matrix.mulVec, dotProduct] at hcol
    rw [Finset.sum_eq_single b] at hcol
    · simpa using hcol
    · intro c _ hc; simp [hc]
    · intro h; exact absurd (Finset.mem_univ b) h
  exact hS0 hzero

theorem inter_isUnit (hA : IsCliffordC A) {F : M4} (hF : inter A F ≠ 0) :
    IsUnit (inter A F).det :=
  intertwiner_isUnit hF (fun μ => inter_intertwines hA F μ)


/-! ## Pauli's fundamental theorem -/



/-- **Note 36, part 1 (existence).**  Two complex Clifford sets are conjugate. -/
theorem pauli_exists {B : Fin 4 → M4} (hA : IsCliffordC A) (hB : IsCliffordC B) :
    ∃ S : M4, IsUnit S.det ∧ ∀ μ, B μ = S * A μ * S⁻¹ := by
  obtain ⟨P, hP, hPeq⟩ := exists_intertwiner hA
  obtain ⟨Q, hQ, hQeq⟩ := exists_intertwiner hB
  have hPP : P⁻¹ * P = 1 := Matrix.nonsing_inv_mul _ hP
  have hPinv : IsUnit (P⁻¹).det := Matrix.isUnit_nonsing_inv_det P hP
  refine ⟨Q * P⁻¹, ?_, fun μ => ?_⟩
  · rw [Matrix.det_mul]
    exact hQ.mul hPinv
  · have hmul : (Q * P⁻¹)⁻¹ = P * Q⁻¹ := by
      rw [Matrix.mul_inv_rev, Matrix.nonsing_inv_nonsing_inv _ hP]
    rw [hmul, hPeq μ, hQeq μ]
    have e : (Q * P⁻¹) * (P * mgamma μ * P⁻¹) * (P * Q⁻¹)
        = Q * (P⁻¹ * P) * mgamma μ * ((P⁻¹ * P) * Q⁻¹) := by
      simp only [Matrix.mul_assoc]
    rw [e, hPP, Matrix.mul_one, Matrix.one_mul]

 a nonzero scalar.

`BookProof.ChapterA3b` carries this statement as the EXTERNAL named hypothesis
`PauliFundamental` (it is the only external input of §A.3, and the gap table of
`FORMALIZATION_ROADMAP.md` lists it as "not formalized"); Prop 37 (the real version) and
Lemma 40 are proved there *from* that hypothesis.  **This file proves the hypothesis**, so
`pauliFundamental` may be substituted wherever `PauliFundamental` was assumed.

## The proof

Everything is reduced to the *concrete* Majorana model `mgamma` of `BookProof.ChapterA3`.

* **The sixteen products.**  For `T : Finset (Fin 4)` let `gpF A T` be the product of the
  `A^μ`, `μ ∈ T`, in increasing order (`gp` over the list `sel T`).  The Clifford relations
  give the *shared* commutation rule `clifford_key`:
  `A^μ · gpF A T = sgnT μ T • gpF A (stepT μ T)`, where `stepT μ T = T Δ {μ}` and the sign
  `sgnT μ T = (-1)^#{ν ∈ T : ν < μ} · (μ ∈ T ? (A^μ)² : 1)` **depends only on `μ` and `T`** —
  the same function for every Clifford set, in particular for `mgamma`.
* **The intertwiner.**  `inter A F = ∑_T gpF A T · F · (G T)ᵀ`, with `G T = gpF mgamma T`
  (the concrete products are real orthogonal, so `(G T)ᵀ = (G T)⁻¹`).  The shared
  commutation rule plus the reindexing `T ↦ T Δ {μ}` (an involution of the index set) give
  `inter_intertwines`: `A^μ · inter A F = inter A F · mgamma μ`.
* **Nonvanishing.**  The concrete products are trace-orthogonal,
  `trace (G S · (G T)ᵀ) = 4 δ_{S,T}` (a finite integer computation), hence linearly
  independent, hence a basis of the `16`-dimensional matrix algebra.  If `inter A F = 0` for
  every `F`, taking `F` to be a matrix unit and pairing with `G U` forces every entry of
  every `gpF A T` to vanish — impossible, because `gpF A ∅ = 1`.
* **Invertibility.**  The kernel of a nonzero intertwiner is invariant under all `mgamma μ`,
  hence under all products `G T`, hence — as those span the whole matrix algebra — under
  every matrix; a nonzero vector in the kernel would therefore force the kernel to be
  everything, i.e. `S = 0`.  So `S` is injective and thus invertible.
* **Uniqueness** is `ChapterGammaCommutant.gamma_commutant_scalar` transported along `S`.

## Main results

* `exists_intertwiner` — every complex Clifford set is conjugate to the concrete Majorana
  set: `∃ S, IsUnit S.det ∧ ∀ μ, A μ = S * mgamma μ * S⁻¹`.
* `pauli_exists`, `pauli_unique` — the two halves of Note 36.
* **`pauliFundamental : PauliFundamental`** — the named hypothesis of `ChapterA3b`,
  discharged.
* `real_pauli'`, `chargeConj_unique'` — Prop 37 and the Lemma 40 uniqueness statement of
  `ChapterA3b`, now with no external input.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix Finset

namespace BookProof.ChapterPauliFundamental

open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

/-- `4×4` complex matrices. -/
abbrev M4 := Matrix (Fin 4) (Fin 4) ℂ

/-! ## The ordered products of a Clifford set -/

/-- The ordered product `A^{μ₁} ⋯ A^{μ_k}` along a list of indices. -/
noncomputable def gp (A : Fin 4 → M4) : List (Fin 4) → M4
  | [] => 1
  | μ :: t => A μ * gp A t

theorem gp_append (A : Fin 4 → M4) (l₁ l₂ : List (Fin 4)) :
    gp A (l₁ ++ l₂) = gp A l₁ * gp A l₂ := by
  induction l₁ with
  | nil => simp [gp]
  | cons a t ih => simp [gp, ih, mul_assoc]

variable {A : Fin 4 → M4}

/-- Distinct generators of a Clifford set anticommute. -/
theorem cliff_anticomm (hA : IsCliffordC A) {μ ν : Fin 4} (h : μ ≠ ν) :
    A μ * A ν = -(A ν * A μ) := by
  have := hA μ ν
  rw [show minkowski μ ν = 0 by simp [minkowski, minkowskiZ, h]] at this
  simp only [mul_zero, zero_smul] at this
  linear_combination (norm := module) this

/-- The square of a generator: `(A⁰)² = -1` and `(A^k)² = 1` for `k = 1,2,3`. -/
theorem cliff_sq (hA : IsCliffordC A) (μ : Fin 4) :
    A μ * A μ = (if μ = 0 then (-1 : ℂ) else 1) • (1 : M4) := by
  have h := hA μ μ
  have h2 : (2 : ℂ) • (A μ * A μ) = (-2 * minkowski μ μ) • (1 : M4) := by
    rw [two_smul]; exact h
  have h3 := congrArg (fun Y : M4 => (2 : ℂ)⁻¹ • Y) h2
  simp only [smul_smul] at h3
  rw [show (2 : ℂ)⁻¹ * 2 = 1 by norm_num, one_smul] at h3
  rw [h3]; congr 1
  by_cases h0 : μ = 0 <;> simp [minkowski, minkowskiZ, h0]

/-- Moving a generator past a product of generators all different from it costs one sign per
factor. -/
theorem gp_push (hA : IsCliffordC A) (μ : Fin 4) :
    ∀ l : List (Fin 4), (∀ ν ∈ l, ν ≠ μ) →
      A μ * gp A l = ((-1 : ℂ) ^ l.length) • (gp A l * A μ) := by
  intro l
  induction l with
  | nil => intro _; simp [gp]
  | cons a t ih =>
      intro h
      have ha : a ≠ μ := h a (by simp)
      have ht : ∀ ν ∈ t, ν ≠ μ := fun ν hν => h ν (by simp [hν])
      have h1 : A μ * A a = -(A a * A μ) := cliff_anticomm hA (Ne.symm ha)
      simp only [gp, List.length_cons, ← mul_assoc, h1]
      rw [neg_mul, mul_assoc, ih ht]
      simp [pow_succ, mul_assoc]

/-! ## The index bookkeeping (finite, decidable) -/

/-- The four indices in increasing order. -/
def idx : List (Fin 4) := [0, 1, 2, 3]

/-- The increasing list of the elements of `T`. -/
def sel (T : Finset (Fin 4)) : List (Fin 4) := idx.filter (fun x => x ∈ T)

/-- The elements of `T` below `μ`. -/
def lo (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) := T.filter (fun x => x < μ)

/-- The elements of `T` not below `μ`. -/
def hi (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) := T.filter (fun x => ¬ x < μ)

/-- The symmetric difference `T Δ {μ}`. -/
def stepT (μ : Fin 4) (T : Finset (Fin 4)) : Finset (Fin 4) :=
  if μ ∈ T then T.erase μ else insert μ T

theorem sel_split : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    sel T = sel (lo μ T) ++ sel (hi μ T) := by decide

theorem sel_hi_mem : ∀ (μ : Fin 4) (T : Finset (Fin 4)), μ ∈ T →
    sel (hi μ T) = μ :: sel (hi μ (T.erase μ)) := by decide

theorem sel_hi_insert : ∀ (μ : Fin 4) (T : Finset (Fin 4)), μ ∉ T →
    sel (hi μ (insert μ T)) = μ :: sel (hi μ T) := by decide

theorem lo_stepT : ∀ (μ : Fin 4) (T : Finset (Fin 4)), lo μ (stepT μ T) = lo μ T := by decide

theorem sel_lo_ne : ∀ (μ : Fin 4) (T : Finset (Fin 4)), ∀ ν ∈ sel (lo μ T), ν ≠ μ := by decide

theorem stepT_involutive : ∀ (μ : Fin 4) (T : Finset (Fin 4)), stepT μ (stepT μ T) = T := by
  decide

theorem sel_lo_length : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    (sel (lo μ T)).length = (lo μ T).card := by decide

theorem sel_empty : sel ∅ = [] := by decide

/-- The ordered product of the generators indexed by `T`. -/
noncomputable def gpF (A : Fin 4 → M4) (T : Finset (Fin 4)) : M4 := gp A (sel T)

@[simp] theorem gpF_empty (A : Fin 4 → M4) : gpF A ∅ = 1 := by
  rw [gpF, sel_empty]; rfl

/-- The sign produced when a generator is moved through an ordered product.  It depends only
on the index data, not on the Clifford set. -/
def sgnT (μ : Fin 4) (T : Finset (Fin 4)) : ℂ :=
  (-1) ^ ((lo μ T).card) * (if μ ∈ T then (if μ = 0 then (-1 : ℂ) else 1) else 1)

/-- **The shared commutation rule.**  For *every* complex Clifford set,
`A^μ · gpF A T = sgnT μ T • gpF A (T Δ {μ})`. -/
theorem clifford_key (hA : IsCliffordC A) (μ : Fin 4) (T : Finset (Fin 4)) :
    A μ * gpF A T = sgnT μ T • gpF A (stepT μ T) := by
  set c := (lo μ T).card with hc
  have hL : A μ * gp A (sel (lo μ T)) = ((-1 : ℂ) ^ c) • (gp A (sel (lo μ T)) * A μ) := by
    rw [hc, ← sel_lo_length μ T]; exact gp_push hA μ _ (sel_lo_ne μ T)
  have hsplit : gpF A T = gp A (sel (lo μ T)) * gp A (sel (hi μ T)) := by
    rw [gpF, sel_split μ T, gp_append]
  by_cases hμ : μ ∈ T
  · have hstep : stepT μ T = T.erase μ := if_pos hμ
    have hlo : lo μ (T.erase μ) = lo μ T := by rw [← hstep]; exact lo_stepT μ T
    have h2 : gp A (sel (hi μ T)) = A μ * gp A (sel (hi μ (T.erase μ))) := by
      rw [sel_hi_mem μ T hμ]; rfl
    have h3 : gpF A (stepT μ T)
        = gp A (sel (lo μ T)) * gp A (sel (hi μ (T.erase μ))) := by
      rw [hstep, gpF, sel_split μ (T.erase μ), gp_append, hlo]
    rw [hsplit, h2, h3, sgnT, if_pos hμ, ← mul_assoc, hL]
    rw [smul_mul_assoc, mul_assoc, ← mul_assoc (A μ) (A μ), cliff_sq hA μ]
    rw [smul_mul_assoc, Matrix.one_mul, Matrix.mul_smul, smul_smul]
  · have hstep : stepT μ T = insert μ T := if_neg hμ
    have hlo : lo μ (insert μ T) = lo μ T := by rw [← hstep]; exact lo_stepT μ T
    have h3 : gpF A (stepT μ T)
        = gp A (sel (lo μ T)) * (A μ * gp A (sel (hi μ T))) := by
      rw [hstep, gpF, sel_split μ (insert μ T), gp_append, hlo, sel_hi_insert μ T hμ]
      rfl
    rw [hsplit, h3, sgnT, if_neg hμ, ← mul_assoc, hL, mul_one]
    rw [smul_mul_assoc, mul_assoc]

/-! ## The concrete products and their trace orthogonality -/

/-- The ordered products over `ℤ`, for the integer Majorana model. -/
def gpZ (A : Fin 4 → Matrix (Fin 4) (Fin 4) ℤ) : List (Fin 4) → Matrix (Fin 4) (Fin 4) ℤ
  | [] => 1
  | μ :: t => A μ * gpZ A t

/-- The sixteen integer products of the Majorana matrices. -/
def GZ (T : Finset (Fin 4)) : Matrix (Fin 4) (Fin 4) ℤ := gpZ mgammaZ (sel T)

theorem GZ_orthogonal : ∀ T : Finset (Fin 4), GZ T * (GZ T)ᵀ = 1 := by decide

theorem GZ_traceOrth : ∀ S T : Finset (Fin 4),
    (GZ S * (GZ T)ᵀ).trace = if S = T then 4 else 0 := by decide

/-- The sixteen complex products of the Majorana matrices. -/
noncomputable def G (T : Finset (Fin 4)) : M4 := gpF mgamma T

theorem G_eq_map (T : Finset (Fin 4)) : G T = (GZ T).map (Int.cast) := by
  have h : ∀ l : List (Fin 4), gp mgamma l = (gpZ mgammaZ l).map (Int.cast) := by
    intro l
    induction l with
    | nil =>
        ext i j
        by_cases hij : i = j <;> simp [gp, gpZ, Matrix.one_apply, hij]
    | cons a t ih =>
        change mgamma a * gp mgamma t = _
        rw [ih, mgamma]
        ext i j
        simp [gpZ, Matrix.mul_apply, RingHom.mapMatrix_apply, Matrix.map_apply]
  rw [G, gpF, GZ, h]

theorem G_orthogonal (T : Finset (Fin 4)) : G T * (G T)ᵀ = 1 := by
  have h := GZ_orthogonal T
  rw [G_eq_map]
  ext i j
  have := congrFun (congrFun (congrArg (fun M : Matrix (Fin 4) (Fin 4) ℤ =>
    M.map (Int.cast : ℤ → ℂ)) h) i) j
  simpa [Matrix.mul_apply, Matrix.map_apply, Matrix.transpose_apply, Matrix.one_apply,
    apply_ite (Int.cast : ℤ → ℂ)] using this

theorem G_inv (T : Finset (Fin 4)) : (G T)⁻¹ = (G T)ᵀ :=
  Matrix.inv_eq_right_inv (G_orthogonal T)

theorem G_isUnit (T : Finset (Fin 4)) : IsUnit (G T).det :=
  Matrix.isUnit_det_of_right_inverse (G_orthogonal T)

theorem G_traceOrth (S T : Finset (Fin 4)) :
    (G S * (G T)ᵀ).trace = if S = T then 4 else 0 := by
  have h := GZ_traceOrth S T
  have hmap : (G S * (G T)ᵀ) = (GZ S * (GZ T)ᵀ).map (Int.cast : ℤ → ℂ) := by
    rw [G_eq_map, G_eq_map]
    ext i j
    simp [Matrix.mul_apply, Matrix.map_apply, Matrix.transpose_apply]
  have htr : ((GZ S * (GZ T)ᵀ).map (Int.cast : ℤ → ℂ)).trace
      = ((GZ S * (GZ T)ᵀ).trace : ℂ) := by
    simp [Matrix.trace, Matrix.diag_apply, Matrix.map_apply]
  rw [hmap, htr, h]
  split <;> simp

/-! ## Linear independence and spanning of the sixteen products -/

theorem G_linearIndependent : LinearIndependent ℂ G := by
  rw [Fintype.linearIndependent_iff]
  intro g hg U
  have h := congrArg (fun X : M4 => (X * (G U)ᵀ).trace) hg
  simp only [Finset.sum_mul, Matrix.trace_sum, zero_mul, Matrix.trace_zero,
    Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul] at h
  rw [Finset.sum_congr rfl (fun T _ => by rw [G_traceOrth T U])] at h
  simp only [mul_ite, mul_zero] at h
  rw [Finset.sum_ite_eq' Finset.univ U (fun T => g T * 4)] at h
  simp only [Finset.mem_univ, if_true] at h
  have h4 : (4 : ℂ) ≠ 0 := by norm_num
  exact (mul_eq_zero.1 h).resolve_right h4

theorem G_span : Submodule.span ℂ (Set.range G) = ⊤ := by
  have hcard : Fintype.card (Finset (Fin 4)) = Module.finrank ℂ M4 := by
    rw [Module.finrank_matrix]
    simp
  have := (basisOfLinearIndependentOfCardEqFinrank G_linearIndependent hcard).span_eq
  rwa [coe_basisOfLinearIndependentOfCardEqFinrank] at this

/-! ## The intertwiner -/

/-- Pauli's averaged intertwiner `∑_T (A-product) · F · (γ-product)⁻¹`. -/
noncomputable def inter (A : Fin 4 → M4) (F : M4) : M4 :=
  ∑ T : Finset (Fin 4), gpF A T * F * (G T)ᵀ

/-- The transpose (= inverse) of a concrete product moves a `γ^μ` through, with the same
sign as the abstract rule. -/
theorem G_transpose_mul (μ : Fin 4) (T : Finset (Fin 4)) :
    (G T)ᵀ * mgamma μ = sgnT μ (stepT μ T) • (G (stepT μ T))ᵀ := by
  set T' := stepT μ T with hT'
  have hkey : mgamma μ * G T' = sgnT μ T' • G (stepT μ T') :=
    clifford_key mgamma_clifford μ T'
  rw [hT', stepT_involutive μ T] at hkey
  have hinvT : (G T)ᵀ * G T = 1 := by
    have := G_orthogonal T
    have hdet := G_isUnit T
    calc (G T)ᵀ * G T = (G T)⁻¹ * G T := by rw [G_inv]
    _ = 1 := Matrix.nonsing_inv_mul _ hdet
  have hinvT' : G T' * (G T')ᵀ = 1 := G_orthogonal T'
  calc (G T)ᵀ * mgamma μ
      = (G T)ᵀ * mgamma μ * (G T' * (G T')ᵀ) := by rw [hinvT', Matrix.mul_one]
    _ = (G T)ᵀ * (mgamma μ * G T') * (G T')ᵀ := by
        simp only [Matrix.mul_assoc]
    _ = (G T)ᵀ * ((sgnT μ T') • G T) * (G T')ᵀ := by rw [hkey]
    _ = sgnT μ T' • (((G T)ᵀ * G T) * (G T')ᵀ) := by
        rw [Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_assoc]
    _ = sgnT μ T' • (G T')ᵀ := by rw [hinvT, Matrix.one_mul]

/-- **The intertwining property.**  `A^μ · inter A F = inter A F · γ^μ`. -/
theorem inter_intertwines (hA : IsCliffordC A) (F : M4) (μ : Fin 4) :
    A μ * inter A F = inter A F * mgamma μ := by
  have hleft : A μ * inter A F
      = ∑ T : Finset (Fin 4), sgnT μ T • (gpF A (stepT μ T) * F * (G T)ᵀ) := by
    rw [inter, Finset.mul_sum]
    refine Finset.sum_congr rfl fun T _ => ?_
    rw [← Matrix.mul_assoc, ← Matrix.mul_assoc, clifford_key hA μ T,
      Matrix.smul_mul, Matrix.smul_mul]
  have hright : inter A F * mgamma μ
      = ∑ T : Finset (Fin 4),
          sgnT μ (stepT μ T) • (gpF A T * F * (G (stepT μ T))ᵀ) := by
    rw [inter, Finset.sum_mul]
    refine Finset.sum_congr rfl fun T _ => ?_
    rw [Matrix.mul_assoc, G_transpose_mul μ T, Matrix.mul_smul, Matrix.mul_assoc]
  rw [hleft, hright]
  refine Fintype.sum_equiv (Function.Involutive.toPerm (stepT μ) (stepT_involutive μ)) _ _ ?_
  intro T
  change sgnT μ T • (gpF A (stepT μ T) * F * (G T)ᵀ)
      = sgnT μ (stepT μ (stepT μ T)) • (gpF A (stepT μ T) * F * (G (stepT μ (stepT μ T)))ᵀ)
  rw [stepT_involutive μ T]

/-! ## The intertwiner is not always zero -/

theorem exists_inter_ne_zero : ∃ F : M4, inter A F ≠ 0 := by
  by_contra hcon
  push_neg at hcon
  -- every entry of every product `gpF A T` vanishes
  have hzero : ∀ (T : Finset (Fin 4)) (m i : Fin 4), gpF A T m i = 0 := by
    intro U m i
    -- the combination `∑_T (gpF A T) m i • (G T)ᵀ` vanishes
    have hcomb : ∑ T : Finset (Fin 4), (gpF A T m i) • (G T)ᵀ = 0 := by
      ext j n
      have h := congrFun (congrFun (hcon (Matrix.single i j (1 : ℂ))) m) n
      have hexp : ∀ T : Finset (Fin 4),
          (gpF A T * Matrix.single i j (1 : ℂ) * (G T)ᵀ) m n
            = (gpF A T m i) * ((G T)ᵀ j n) := by
        intro T
        simp [Matrix.mul_apply, Matrix.single_apply, ite_and, Finset.sum_ite_eq, mul_comm]
      simp only [inter, Matrix.sum_apply, hexp] at h
      simpa [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul] using h
    -- pair with `G U` through the trace
    have h := congrArg (fun X : M4 => (X * G U).trace) hcomb
    simp only [Finset.sum_mul, Matrix.trace_sum, Matrix.smul_mul, Matrix.trace_smul,
      smul_eq_mul, Matrix.zero_mul, Matrix.trace_zero] at h
    have hTr : ∀ T : Finset (Fin 4), ((G T)ᵀ * G U).trace = if U = T then 4 else 0 := by
      intro T
      rw [Matrix.trace_mul_comm]
      exact G_traceOrth U T
    rw [Finset.sum_congr rfl (fun T _ => by rw [hTr T])] at h
    simp only [mul_ite, mul_zero] at h
    rw [Finset.sum_ite_eq Finset.univ U (fun T => gpF A T m i * 4)] at h
    simp only [Finset.mem_univ, if_true] at h
    have h4 : (4 : ℂ) ≠ 0 := by norm_num
    exact (mul_eq_zero.1 h).resolve_right h4
  have h1 := hzero ∅ 0 0
  rw [gpF_empty] at h1
  simp at h1

/-! ## Invertibility of a nonzero intertwiner -/

/-- **A nonzero intertwiner is invertible.**  If `A^μ · S = S · γ^μ` for all `μ` and
`S ≠ 0`, then `S` is invertible: its kernel is invariant under all the `γ^μ`, hence under
the sixteen products, hence — as those span the whole matrix algebra — under every matrix,
so a nonzero kernel vector would force `S = 0`. -/
theorem intertwiner_isUnit {S : M4} (hS0 : S ≠ 0) (hSint : ∀ μ, A μ * S = S * mgamma μ) :
    IsUnit S.det := by
  by_contra hdet
  have hdet0 : S.det = 0 := by
    by_contra h
    exact hdet (isUnit_iff_ne_zero.mpr h)
  obtain ⟨v, hv0, hv⟩ := Matrix.exists_mulVec_eq_zero_iff.2 hdet0
  -- the kernel of `S`
  let K : Submodule ℂ (Fin 4 → ℂ) :=
    { carrier := {w | S *ᵥ w = 0}
      add_mem' := by
        intro a b ha hb
        simp only [Set.mem_setOf_eq] at *
        rw [Matrix.mulVec_add, ha, hb, add_zero]
      zero_mem' := by simp
      smul_mem' := by
        intro c a ha
        simp only [Set.mem_setOf_eq] at *
        rw [Matrix.mulVec_smul, ha, smul_zero] }
  have hmemK : ∀ w : Fin 4 → ℂ, w ∈ K ↔ S *ᵥ w = 0 := fun w => Iff.rfl
  have hgamma : ∀ (μ : Fin 4) (w : Fin 4 → ℂ), w ∈ K → mgamma μ *ᵥ w ∈ K := by
    intro μ w hw
    rw [hmemK] at hw ⊢
    rw [Matrix.mulVec_mulVec, ← hSint μ, ← Matrix.mulVec_mulVec, hw, Matrix.mulVec_zero]
  have hgp : ∀ (l : List (Fin 4)) (w : Fin 4 → ℂ), w ∈ K → gp mgamma l *ᵥ w ∈ K := by
    intro l
    induction l with
    | nil => intro w hw; simpa [gp] using hw
    | cons a t ih =>
        intro w hw
        have hstep : gp mgamma (a :: t) *ᵥ w = mgamma a *ᵥ (gp mgamma t *ᵥ w) := by
          change (mgamma a * gp mgamma t) *ᵥ w = _
          rw [Matrix.mulVec_mulVec]
        rw [hstep]
        exact hgamma a _ (ih w hw)
  have hGK : ∀ (T : Finset (Fin 4)) (w : Fin 4 → ℂ), w ∈ K → G T *ᵥ w ∈ K :=
    fun T w hw => hgp (sel T) w hw
  -- hence the kernel is invariant under every matrix
  have hall : ∀ (X : M4) (w : Fin 4 → ℂ), w ∈ K → X *ᵥ w ∈ K := by
    intro X w hw
    have hmem : X ∈ Submodule.span ℂ (Set.range G) := by rw [G_span]; trivial
    refine Submodule.span_induction ?_ ?_ ?_ ?_ hmem
    · rintro Y ⟨T, rfl⟩
      exact hGK T w hw
    · change (0 : M4) *ᵥ w ∈ K
      rw [Matrix.zero_mulVec]
      exact K.zero_mem
    · intro Y Z _ _ hY hZ
      change (Y + Z) *ᵥ w ∈ K
      rw [Matrix.add_mulVec]
      exact K.add_mem hY hZ
    · intro c Y _ hY
      change (c • Y) *ᵥ w ∈ K
      rw [Matrix.smul_mulVec]
      exact K.smul_mem c hY
  -- a nonzero kernel vector makes the kernel everything, so `S = 0`
  have htop : ∀ w : Fin 4 → ℂ, w ∈ K := by
    intro w
    obtain ⟨i, hi⟩ : ∃ i, v i ≠ 0 := by
      by_contra hcon
      push_neg at hcon
      exact hv0 (funext hcon)
    have hX := hall (Matrix.of fun a b => if b = i then w a / v i else 0) v hv
    have heq : (Matrix.of fun a b => if b = i then w a / v i else 0) *ᵥ v = w := by
      funext a
      rw [Matrix.mulVec, dotProduct]
      rw [Finset.sum_eq_single i]
      · simp only [Matrix.of_apply, if_true]
        field_simp
      · intro b _ hb; simp [hb]
      · intro h; exact absurd (Finset.mem_univ i) h
    rwa [heq] at hX
  have hzero : S = 0 := by
    ext a b
    have hb : S *ᵥ (fun c => if c = b then (1 : ℂ) else 0) = 0 :=
      htop (fun c => if c = b then 1 else 0)
    have hcol := congrFun hb a
    rw [Matrix.mulVec, dotProduct] at hcol
    rw [Finset.sum_eq_single b] at hcol
    · simpa using hcol
    · intro c _ hc; simp [hc]
    · intro h; exact absurd (Finset.mem_univ b) h
  exact hS0 hzero

theorem inter_isUnit (hA : IsCliffordC A) {F : M4} (hF : inter A F ≠ 0) :
    IsUnit (inter A F).det :=
  intertwiner_isUnit hF (fun μ => inter_intertwines hA F μ)


/-! ## Pauli's fundamental theorem -/

/-- **Every complex Clifford set is conjugate to the concrete Majorana set.** -/
theorem exists_intertwiner (hA : IsCliffordC A) :
    ∃ S : M4, IsUnit S.det ∧ ∀ μ, A μ = S * mgamma μ * S⁻¹ := by
  obtain ⟨F, hF⟩ := exists_inter_ne_zero (A := A)
  refine ⟨inter A F, inter_isUnit hA hF, fun μ => ?_⟩
  have h := inter_intertwines hA F μ
  have hinv : inter A F * (inter A F)⁻¹ = 1 :=
    Matrix.mul_nonsing_inv _ (inter_isUnit hA hF)
  calc A μ = A μ * (inter A F * (inter A F)⁻¹) := by rw [hinv, Matrix.mul_one]
    _ = (A μ * inter A F) * (inter A F)⁻¹ := by rw [Matrix.mul_assoc]
    _ = (inter A F * mgamma μ) * (inter A F)⁻¹ := by rw [h]

/-- **Note 36, part 1 (existence).**  Two complex Clifford sets are conjugate. -/
theorem pauli_exists {B : Fin 4 → M4} (hA : IsCliffordC A) (hB : IsCliffordC B) :
    ∃ S : M4, IsUnit S.det ∧ ∀ μ, B μ = S * A μ * S⁻¹ := by
  obtain ⟨P, hP, hPeq⟩ := exists_intertwiner hA
  obtain ⟨Q, hQ, hQeq⟩ := exists_intertwiner hB
  have hPP : P⁻¹ * P = 1 := Matrix.nonsing_inv_mul _ hP
  have hPinv : IsUnit (P⁻¹).det := Matrix.isUnit_nonsing_inv_det P hP
  refine ⟨Q * P⁻¹, ?_, fun μ => ?_⟩
  · rw [Matrix.det_mul]
    exact hQ.mul hPinv
  · have hmul : (Q * P⁻¹)⁻¹ = P * Q⁻¹ := by
      rw [Matrix.mul_inv_rev, Matrix.nonsing_inv_nonsing_inv _ hP]
    rw [hmul, hPeq μ, hQeq μ]
    have e : (Q * P⁻¹) * (P * mgamma μ * P⁻¹) * (P * Q⁻¹)
        = Q * (P⁻¹ * P) * mgamma μ * ((P⁻¹ * P) * Q⁻¹) := by
      simp only [Matrix.mul_assoc]
    rw [e, hPP, Matrix.mul_one, Matrix.one_mul]

/-- **Note 36, part 1 (uniqueness).**  The conjugating matrix is unique up to a nonzero
scalar. -/
theorem pauli_unique {B : Fin 4 → M4} (hA : IsCliffordC A)
    (S T : M4) (hS : IsUnit S.det) (hT : IsUnit T.det)
    (hSeq : ∀ μ, B μ = S * A μ * S⁻¹) (hTeq : ∀ μ, B μ = T * A μ * T⁻¹) :
    ∃ c : ℂ, c ≠ 0 ∧ T = c • S := by
  obtain ⟨P, hP, hPeq⟩ := exists_intertwiner hA
  have hSS : S⁻¹ * S = 1 := Matrix.nonsing_inv_mul _ hS
  have hSS' : S * S⁻¹ = 1 := Matrix.mul_nonsing_inv _ hS
  have hTT : T⁻¹ * T = 1 := Matrix.nonsing_inv_mul _ hT
  have hPP : P⁻¹ * P = 1 := Matrix.nonsing_inv_mul _ hP
  have hPP' : P * P⁻¹ = 1 := Matrix.mul_nonsing_inv _ hP
  -- `X = S⁻¹ T` commutes with the Clifford set `A`
  set X : M4 := S⁻¹ * T with hX
  have hcomm : ∀ μ, X * A μ = A μ * X := by
    intro μ
    have h1 : S * A μ * S⁻¹ = T * A μ * T⁻¹ := by rw [← hSeq μ, ← hTeq μ]
    have e1 : S⁻¹ * (S * A μ * S⁻¹) * T = (S⁻¹ * S) * A μ * (S⁻¹ * T) := by
      simp only [Matrix.mul_assoc]
    have e2 : S⁻¹ * (T * A μ * T⁻¹) * T = (S⁻¹ * T) * A μ * (T⁻¹ * T) := by
      simp only [Matrix.mul_assoc]
    have h2 := congrArg (fun Y : M4 => S⁻¹ * Y * T) h1
    rw [e1, e2, hSS, hTT, Matrix.one_mul, Matrix.mul_one] at h2
    rw [hX, ← h2]
  -- transport to the concrete model, where the commutant is scalar
  set Y : M4 := P⁻¹ * X * P with hY
  have hYcomm : ∀ μ, Y * mgamma μ = mgamma μ * Y := by
    intro μ
    have hg : mgamma μ = P⁻¹ * A μ * P := by
      rw [hPeq μ]
      have e : P⁻¹ * (P * mgamma μ * P⁻¹) * P = (P⁻¹ * P) * mgamma μ * (P⁻¹ * P) := by
        simp only [Matrix.mul_assoc]
      rw [e, hPP, Matrix.one_mul, Matrix.mul_one]
    rw [hY, hg]
    have e1 : (P⁻¹ * X * P) * (P⁻¹ * A μ * P) = P⁻¹ * X * (P * P⁻¹) * A μ * P := by
      simp only [Matrix.mul_assoc]
    have e2 : (P⁻¹ * A μ * P) * (P⁻¹ * X * P) = P⁻¹ * A μ * (P * P⁻¹) * X * P := by
      simp only [Matrix.mul_assoc]
    rw [e1, e2, hPP', Matrix.mul_one, Matrix.mul_one]
    rw [Matrix.mul_assoc P⁻¹ X (A μ), hcomm μ, ← Matrix.mul_assoc]
  obtain ⟨c, hc⟩ : ∃ c : ℂ, Y = c • (1 : M4) := ⟨Y 0 0, gamma_commutant_scalar Y hYcomm⟩
  have hXc : X = c • (1 : M4) := by
    have hXeq : P * Y * P⁻¹ = X := by
      rw [hY]
      have e : P * (P⁻¹ * X * P) * P⁻¹ = (P * P⁻¹) * X * (P * P⁻¹) := by
        simp only [Matrix.mul_assoc]
      rw [e, hPP', Matrix.one_mul, Matrix.mul_one]
    rw [← hXeq, hc, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_one, hPP']
  have hTc : T = c • S := by
    have hSX : S * X = T := by rw [hX, ← Matrix.mul_assoc, hSS', Matrix.one_mul]
    rw [← hSX, hXc, Matrix.mul_smul, Matrix.mul_one]
  refine ⟨c, ?_, hTc⟩
  rintro rfl
  rw [zero_smul] at hTc
  rw [hTc, Matrix.det_zero] at hT
  exact not_isUnit_zero hT

/-- **Pauli's fundamental theorem (Note 36)** — the `EXTERNAL` hypothesis
`BookProof.ChapterA3.PauliFundamental` of `ChapterA3b`, discharged. -/
theorem pauliFundamental : PauliFundamental := by
  intro A B hA hB
  exact ⟨pauli_exists hA hB, fun S T hS hT hSeq hTeq => pauli_unique hA S T hS hT hSeq hTeq⟩



end BookProof.ChapterPauliFundamental
