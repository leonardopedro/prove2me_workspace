import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib


/-!
# A Carleman criterion on simplex shells: hops which couple distinct modes

`BookProof.ChapterHermiteCarlemanEsa` and `BookProof.ChapterCarlemanTwoStep` run the
Carleman flux argument on **cubes** `{α : ∀ i, αᵢ ≤ N}`, for hops which move a *single*
excitation number: `α ↦ α ± eᵢ` and `α ↦ α ± 2eᵢ`.  That is exactly the ladder structure
of a quadratic Hamiltonian which does not couple distinct modes.

A general real quadratic Hamiltonian does couple them: `xᵢxⱼ`, `πᵢπⱼ` and `xᵢπⱼ` with
`i ≠ j` produce the hops `α ↦ α ± (eᵢ + eⱼ)` and `α ↦ α + eᵢ − eⱼ`.  On a cube the
bookkeeping of such hops is awkward — a hop leaves a cube through *two* faces at once,
and the mixed hop `α ↦ α + eᵢ − eⱼ` leaves it through one face while entering through
another.

This module reruns the argument on the **simplex shells** `{α : |α| ≤ N}`, where
`|α| = ∑ᵢ αᵢ` is the total degree.  The exhaustion is adapted to the grading by total
excitation number, and everything becomes uniform:

* a hop which *raises* the total degree by `k` (`α ↦ α + P` with `|P| = k`) leaks only
  through the shell `{N − k < |α| ≤ N}`, which meets at most `k` of the shells;
* a hop which *preserves* the total degree (`α ↦ α + eᵢ − eⱼ`) never leaves a shell, so
  it contributes **nothing at all** to the flux: the corresponding sum over a shell is
  real as soon as its amplitude matrix is Hermitian.

## What is proved

* `deg`, `simplexF`, `sInn`, `sBd` — the total degree, the simplex shells and their
  interiors and boundaries.
* `sum_simplex_hop_im` — **the abstract flux cancellation** for a hop `α ↦ α + P` of an
  arbitrary shift `P`: the interior contributions occur in conjugate pairs, so only the
  boundary shell contributes to the imaginary part.
* `sum_mterm_im` — **the degree-preserving hops carry no flux**: for a Hermitian
  amplitude matrix the total contribution of the hops `α ↦ α + eᵢ − eⱼ` over a shell is
  real.
* `LadderRecQ`, `flux_identityQ` — the recursion of a *general* quadratic ladder — one
  step, two steps, pair creation/annihilation and mode exchange — and its flux identity.
* `flux_bound_on`, `sBd_multiplicity`, `shifted_sBd_multiplicity` — the flux bound and
  the summability of the boundary mass (each index lies in at most `k` boundary shells).
* `ladderQ_eq_zero` — **the criterion.**  A square-summable family satisfying the general
  quadratic recursion, with a real diagonal, constant amplitudes and a Hermitian exchange
  matrix, at a point off the real axis, vanishes.  The Carleman divergence used is
  `∑ 1/(N+2) = ∞`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.CarlemanSimplex

open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

/-! ## 1. The simplex shells -/

/-- The total degree `|α| = ∑ᵢ αᵢ` of a multi-index. -/
def deg (a : Fin d →₀ ℕ) : ℕ := ∑ i, a i











/-- The simplex shell `{α : |α| ≤ N}` of multi-indices, as a finite set. -/
def simplexF (d N : ℕ) : Finset (Fin d →₀ ℕ) := (cube d N).filter (fun a => deg a ≤ N)



/-- The part of a shell which can still be raised by `k` degrees without leaving it. -/
def sInn (d N k : ℕ) : Finset (Fin d →₀ ℕ) := (simplexF d N).filter (fun a => deg a + k ≤ N)

/-- The `k`-thick boundary of a shell. -/
def sBd (d N k : ℕ) : Finset (Fin d →₀ ℕ) := (simplexF d N).filter (fun a => N < deg a + k)









/-! ## 2. The abstract flux cancellation for a raising hop -/

variable {u : (Fin d →₀ ℕ) → ℂ}

/-- The raising contribution of the hop `α ↦ α + P`. -/
def rtermP (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (rc : (Fin d →₀ ℕ) → ℝ) (P : Fin d →₀ ℕ)
    (a : Fin d →₀ ℕ) : ℂ :=
  (starRingEnd ℂ) w * ((rc a : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (a + P)

/-- The lowering contribution of the hop `α ↦ α − P`. -/
def ltermP (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (lc : (Fin d →₀ ℕ) → ℝ) (P : Fin d →₀ ℕ)
    (a : Fin d →₀ ℕ) : ℂ :=
  w * ((lc a : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (a - P)







/-! ## 3. The degree-preserving hops carry no flux -/

/-- The mode-exchange hop `α ↦ α − eⱼ + eᵢ`. -/
def shiftm (a : Fin d →₀ ℕ) (i j : Fin d) : Fin d →₀ ℕ :=
  a - Finsupp.single j 1 + Finsupp.single i 1

/-- The amplitude of the mode-exchange hop: `√(αⱼ(αᵢ+1))` for `i ≠ j`, and the number
`αᵢ` for `i = j`. -/
def rcm (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a j : ℝ)) * Real.sqrt ((((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1)

/-- The contribution of the mode-exchange hop `(i, j)`. -/
def mterm (u : (Fin d →₀ ℕ) → ℂ) (M : Fin d → Fin d → ℂ) (a : Fin d →₀ ℕ) (i j : Fin d) : ℂ :=
  M i j * ((rcm a i j : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (shiftm a i j)



bes** `{α : ∀ i, αᵢ ≤ N}`, for hops which move a *single*
excitation number: `α ↦ α ± eᵢ` and `α ↦ α ± 2eᵢ`.  That is exactly the ladder structure
of a quadratic Hamiltonian which does not couple distinct modes.

A general real quadratic Hamiltonian does couple them: `xᵢxⱼ`, `πᵢπⱼ` and `xᵢπⱼ` with
`i ≠ j` produce the hops `α ↦ α ± (eᵢ + eⱼ)` and `α ↦ α + eᵢ − eⱼ`.  On a cube the
bookkeeping of such hops is awkward — a hop leaves a cube through *two* faces at once,
and the mixed hop `α ↦ α + eᵢ − eⱼ` leaves it through one face while entering through
another.

This module reruns the argument on the **simplex shells** `{α : |α| ≤ N}`, where
`|α| = ∑ᵢ αᵢ` is the total degree.  The exhaustion is adapted to the grading by total
excitation number, and everything becomes uniform:

* a hop which *raises* the total degree by `k` (`α ↦ α + P` with `|P| = k`) leaks only
  through the shell `{N − k < |α| ≤ N}`, which meets at most `k` of the shells;
* a hop which *preserves* the total degree (`α ↦ α + eᵢ − eⱼ`) never leaves a shell, so
  it contributes **nothing at all** to the flux: the corresponding sum over a shell is
  real as soon as its amplitude matrix is Hermitian.

## What is proved

* `deg`, `simplexF`, `sInn`, `sBd` — the total degree, the simplex shells and their
  interiors and boundaries.
* `sum_simplex_hop_im` — **the abstract flux cancellation** for a hop `α ↦ α + P` of an
  arbitrary shift `P`: the interior contributions occur in conjugate pairs, so only the
  boundary shell contributes to the imaginary part.
* `sum_mterm_im` — **the degree-preserving hops carry no flux**: for a Hermitian
  amplitude matrix the total contribution of the hops `α ↦ α + eᵢ − eⱼ` over a shell is
  real.
* `LadderRecQ`, `flux_identityQ` — the recursion of a *general* quadratic ladder — one
  step, two steps, pair creation/annihilation and mode exchange — and its flux identity.
* `flux_bound_on`, `sBd_multiplicity`, `shifted_sBd_multiplicity` — the flux bound and
  the summability of the boundary mass (each index lies in at most `k` boundary shells).
* `ladderQ_eq_zero` — **the criterion.**  A square-summable family satisfying the general
  quadratic recursion, with a real diagonal, constant amplitudes and a Hermitian exchange
  matrix, at a point off the real axis, vanishes.  The Carleman divergence used is
  `∑ 1/(N+2) = ∞`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.CarlemanSimplex

open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

/-! ## 1. The simplex shells -/

/-- The total degree `|α| = ∑ᵢ αᵢ` of a multi-index. -/
def deg (a : Fin d →₀ ℕ) : ℕ := ∑ i, a i

theorem deg_add (a b : Fin d →₀ ℕ) : deg (a + b) = deg a + deg b := by
  simp [deg, Finsupp.add_apply, Finset.sum_add_distrib]

theorem apply_le_deg (a : Fin d →₀ ℕ) (i : Fin d) : a i ≤ deg a :=
  Finset.single_le_sum (f := fun j => a j) (fun _ _ => Nat.zero_le _) (Finset.mem_univ i)

theorem deg_single (i : Fin d) (k : ℕ) : deg (Finsupp.single i k) = k := by
  simp [deg]

/-- Cancellation of a truncated subtraction below a multi-index. -/
theorem tsub_add_cancel_of_le' {P a : Fin d →₀ ℕ} (h : P ≤ a) : a - P + P = a := by
  ext j
  have hj : P j ≤ a j := by
    have := h
    rw [Finsupp.le_def] at this
    exact this j
  simp only [Finsupp.add_apply, Finsupp.tsub_apply]
  omega

theorem deg_tsub_of_le {P a : Fin d →₀ ℕ} (h : P ≤ a) : deg (a - P) + deg P = deg a := by
  rw [← deg_add, tsub_add_cancel_of_le' h]

/-- The simplex shell `{α : |α| ≤ N}` of multi-indices, as a finite set. -/
def simplexF (d N : ℕ) : Finset (Fin d →₀ ℕ) := (cube d N).filter (fun a => deg a ≤ N)

theorem mem_simplexF {d N : ℕ} {a : Fin d →₀ ℕ} : a ∈ simplexF d N ↔ deg a ≤ N := by
  classical
  rw [simplexF, Finset.mem_filter, mem_cube]
  exact ⟨fun h => h.2, fun h => ⟨fun i => le_trans (apply_le_deg a i) h, h⟩⟩

/-- The part of a shell which can still be raised by `k` degrees without leaving it. -/
def sInn (d N k : ℕ) : Finset (Fin d →₀ ℕ) := (simplexF d N).filter (fun a => deg a + k ≤ N)

/-- The `k`-thick boundary of a shell. -/
def sBd (d N k : ℕ) : Finset (Fin d →₀ ℕ) := (simplexF d N).filter (fun a => N < deg a + k)

theorem mem_sInn {d N k : ℕ} {a : Fin d →₀ ℕ} : a ∈ sInn d N k ↔ deg a + k ≤ N := by
  classical
  rw [sInn, Finset.mem_filter, mem_simplexF]
  exact ⟨fun h => h.2, fun h => ⟨by omega, h⟩⟩

theorem mem_sBd {d N k : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ sBd d N k ↔ deg a ≤ N ∧ N < deg a + k := by
  classical
  rw [sBd, Finset.mem_filter, mem_simplexF]

theorem sBd_subset_simplexF (d N k : ℕ) : sBd d N k ⊆ simplexF d N := by
  intro a ha
  rw [mem_sBd] at ha
  exact mem_simplexF.mpr ha.1

theorem sum_simplex_split (d N k : ℕ) (F : (Fin d →₀ ℕ) → ℂ) :
    ∑ a ∈ simplexF d N, F a = ∑ a ∈ sInn d N k, F a + ∑ a ∈ sBd d N k, F a := by
  classical
  rw [sInn, sBd,
    ← Finset.sum_filter_add_sum_filter_not (simplexF d N) (fun a => deg a + k ≤ N) F]
  congr 1
  refine Finset.sum_congr ?_ fun _ _ => rfl
  ext a
  simp only [Finset.mem_filter]
  constructor
  · rintro ⟨h1, h2⟩; exact ⟨h1, by omega⟩
  · rintro ⟨h1, h2⟩; exact ⟨h1, by omega⟩

/-! ## 2. The abstract flux cancellation for a raising hop -/

variable {u : (Fin d →₀ ℕ) → ℂ}

/-- The raising contribution of the hop `α ↦ α + P`. -/
def rtermP (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (rc : (Fin d →₀ ℕ) → ℝ) (P : Fin d →₀ ℕ)
    (a : Fin d →₀ ℕ) : ℂ :=
  (starRingEnd ℂ) w * ((rc a : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (a + P)

/-- The lowering contribution of the hop `α ↦ α − P`. -/
def ltermP (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (lc : (Fin d →₀ ℕ) → ℝ) (P : Fin d →₀ ℕ)
    (a : Fin d →₀ ℕ) : ℂ :=
  w * ((lc a : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (a - P)

theorem ltermP_shift {w : ℂ} {rc lc : (Fin d →₀ ℕ) → ℝ} {P : Fin d →₀ ℕ}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + P) = rc a) (b : Fin d →₀ ℕ) :
    ltermP u w lc P (b + P) = (starRingEnd ℂ) (rtermP u w rc P b) := by
  rw [ltermP, rtermP, hcomp b, add_tsub_cancel_right]
  simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal]
  ring

/-- Reindexing the lowering sum over a shell along the shift `α ↦ α + P`. -/
theorem sum_ltermP {w : ℂ} {rc lc : (Fin d →₀ ℕ) → ℝ} {P : Fin d →₀ ℕ}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + P) = rc a)
    (hvan : ∀ a : Fin d →₀ ℕ, ¬ P ≤ a → lc a = 0) (N : ℕ) :
    ∑ a ∈ simplexF d N, ltermP u w lc P a
      = (starRingEnd ℂ) (∑ b ∈ sInn d N (deg P), rtermP u w rc P b) := by
  classical
  have hstep : ∑ a ∈ simplexF d N, ltermP u w lc P a
      = ∑ b ∈ sInn d N (deg P), ltermP u w lc P (b + P) := by
    rw [← Finset.sum_filter_of_ne (p := fun a : Fin d →₀ ℕ => P ≤ a)
      (fun a _ hne => by
        by_contra hle
        exact hne (by rw [ltermP, hvan a hle]; simp))]
    refine Finset.sum_nbij' (fun a => a - P) (fun b => b + P) ?_ ?_ ?_ ?_ ?_
    · intro a ha
      simp only [Finset.mem_filter, mem_simplexF] at ha
      rw [mem_sInn, deg_tsub_of_le ha.2]
      exact ha.1
    · intro b hb
      rw [mem_sInn] at hb
      simp only [Finset.mem_filter, mem_simplexF]
      refine ⟨by rw [deg_add]; omega, le_add_self⟩
    · intro a ha
      simp only [Finset.mem_filter] at ha
      exact tsub_add_cancel_of_le' ha.2
    · intro b _; exact add_tsub_cancel_right b P
    · intro a ha
      simp only [Finset.mem_filter] at ha
      rw [tsub_add_cancel_of_le' ha.2]
  rw [hstep, map_sum]
  exact Finset.sum_congr rfl fun b _ => ltermP_shift hcomp b

/-- **The flux cancellation.**  The interior contributions occur in conjugate pairs, so
only the boundary shell contributes to the imaginary part. -/
theorem sum_simplex_hop_im {w : ℂ} {rc lc : (Fin d →₀ ℕ) → ℝ} {P : Fin d →₀ ℕ}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + P) = rc a)
    (hvan : ∀ a : Fin d →₀ ℕ, ¬ P ≤ a → lc a = 0) (N : ℕ) :
    (∑ a ∈ simplexF d N, (rtermP u w rc P a + ltermP u w lc P a)).im
      = (∑ a ∈ sBd d N (deg P), rtermP u w rc P a).im := by
  rw [Finset.sum_add_distrib, sum_simplex_split d N (deg P) (rtermP u w rc P),
    sum_ltermP hcomp hvan N]
  simp [Complex.add_im]

/-! ## 3. The degree-preserving hops carry no flux -/

/-- The mode-exchange hop `α ↦ α − eⱼ + eᵢ`. -/
def shiftm (a : Fin d →₀ ℕ) (i j : Fin d) : Fin d →₀ ℕ :=
  a - Finsupp.single j 1 + Finsupp.single i 1

/-- The amplitude of the mode-exchange hop: `√(αⱼ(αᵢ+1))` for `i ≠ j`, and the number
`αᵢ` for `i = j`. -/
def rcm (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a j : ℝ)) * Real.sqrt ((((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1)

/-- The contribution of the mode-exchange hop `(i, j)`. -/
def mterm (u : (Fin d →₀ ℕ) → ℂ) (M : Fin d → Fin d → ℂ) (a : Fin d →₀ ℕ) (i j : Fin d) : ℂ :=
  M i j * ((rcm a i j : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (shiftm a i j)

theorem rcm_of_zero {a : Fin d →₀ ℕ} {i j : Fin d} (h : a j = 0) : rcm a i j = 0 := by
  rw [rcm, h]
  simp

theorem deg_shiftm {a : Fin d →₀ ℕ} {i j : Fin d} (h : 1 ≤ a j) : deg (shiftm a i j) = deg a := by
  have hle : Finsupp.single j 1 ≤ a := by
    rw [Finsupp.le_def]
    intro k
    by_cases hk : k = j
    · subst hk; simpa using h
    · simp [Ne.symm hk]
  rw [shiftm, deg_add, deg_single, ← deg_tsub_of_le hle, deg_single]





theorem rcm_shiftm {a : Fin d →₀ ℕ} {i j : Fin d} (h : 1 ≤ a j) :
    rcm (shiftm a i j) j i = rcm a i j := by
  classical
  have h2 : ((shiftm a i j - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) = a j - 1 := by
    simp only [shiftm, Finsupp.tsub_apply, Finsupp.add_apply, Finsupp.single_apply]
    split_ifs <;> omega
  have e1 : (((shiftm a i j) i : ℕ) : ℝ)
      = (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1 := by
    rw [shiftm_apply_self]
    push_cast
    ring
  have e2 : ((((shiftm a i j - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ)) + 1
      = ((a j : ℕ) : ℝ) := by
    rw [h2]
    have h1 : (1 : ℕ) ≤ a j := h
    push_cast [Nat.cast_sub h1]
    ring
  rw [rcm, rcm, e1, e2, mul_comm]





/-! ## 4. The general quadratic recursion -/

/-- The shift of the pair hop `(i, j)`: `eᵢ + eⱼ`. -/
def pvec (i j : Fin d) : Fin d →₀ ℕ := Finsupp.single i 1 + Finsupp.single j 1



/-- The raising amplitude of the pair hop: `√((αᵢ+1)(αⱼ+1))` for `i ≠ j`, and
`√((αᵢ+1)(αᵢ+2))` for `i = j`. -/
def rcp (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a j : ℝ) + 1) * Real.sqrt ((((a + Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1)

/-- The lowering amplitude of the pair hop: `√(αᵢαⱼ)` for `i ≠ j`, and `√(αᵢ(αᵢ−1))` for
`i = j`. -/
def lcp (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a i : ℝ)) * Real.sqrt ((((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ))







/-- **The general quadratic recursion**: a real diagonal `lam`, one-step amplitudes `w`,
pair creation/annihilation amplitudes `W`, and a mode-exchange matrix `M`. -/
def LadderRecQ (u : (Fin d →₀ ℕ) → ℂ) (lam : (Fin d →₀ ℕ) → ℝ) (w : Fin d → ℂ)
    (W M : Fin d → Fin d → ℂ) (z : ℂ) : Prop :=
  ∀ a : Fin d →₀ ℕ,
    ((lam a : ℝ) : ℂ) * u a
      + ∑ i, ((starRingEnd ℂ) (w i) * ((rc1 a i : ℝ) : ℂ) * u (a + Finsupp.single i 1)
            + w i * ((lc1 a i : ℝ) : ℂ) * u (a - Finsupp.single i 1))
      + ∑ i, ∑ j, ((starRingEnd ℂ) (W i j) * ((rcp a i j : ℝ) : ℂ) * u (a + pvec i j)
            + W i j * ((lcp a i j : ℝ) : ℂ) * u (a - pvec i j))
      + ∑ i, ∑ j, (M i j * ((rcm a i j : ℝ) : ℂ) * u (shiftm a i j))
      = z * u a

variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}





/-! ## 5. The flux bound and the boundary mass -/













/-! ## 6. The criterion -/



end

end BookProof.CarlemanSimplex
