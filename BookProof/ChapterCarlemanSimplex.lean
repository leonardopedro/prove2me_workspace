import Mathlib
import BookProof.ChapterCarlemanTwoStep

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

theorem shiftm_apply_self {a : Fin d →₀ ℕ} {i j : Fin d} :
    (shiftm a i j) i = (a - Finsupp.single j 1 : Fin d →₀ ℕ) i + 1 := by
  simp [shiftm]

theorem shiftm_shiftm {a : Fin d →₀ ℕ} {i j : Fin d} (h : 1 ≤ a j) :
    shiftm (shiftm a i j) j i = a := by
  have hle : Finsupp.single j 1 ≤ a := by
    rw [Finsupp.le_def]
    intro k
    by_cases hk : k = j
    · subst hk; simpa using h
    · simp [Ne.symm hk]
  rw [shiftm, shiftm, add_tsub_cancel_right, tsub_add_cancel_of_le' hle]

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

/-- The `(i, j)` and `(j, i)` mode-exchange sums over a shell are complex conjugates. -/
theorem sum_mterm_conj {M : Fin d → Fin d → ℂ} (hM : ∀ i j, M j i = (starRingEnd ℂ) (M i j))
    (N : ℕ) (i j : Fin d) :
    (starRingEnd ℂ) (∑ a ∈ simplexF d N, mterm u M a i j)
      = ∑ b ∈ simplexF d N, mterm u M b j i := by
  classical
  rw [map_sum]
  -- restrict both sides to the multi-indices where the amplitude does not vanish
  have hL : ∑ a ∈ simplexF d N, (starRingEnd ℂ) (mterm u M a i j)
      = ∑ a ∈ (simplexF d N).filter (fun a => 1 ≤ a j),
          (starRingEnd ℂ) (mterm u M a i j) := by
    refine (Finset.sum_filter_of_ne fun a _ hne => ?_).symm
    by_contra hlt
    have h0 : a j = 0 := by omega
    rw [mterm, rcm_of_zero h0] at hne
    simp at hne
  have hR : ∑ b ∈ simplexF d N, mterm u M b j i
      = ∑ b ∈ (simplexF d N).filter (fun b => 1 ≤ b i), mterm u M b j i := by
    refine (Finset.sum_filter_of_ne fun b _ hne => ?_).symm
    by_contra hlt
    have h0 : b i = 0 := by omega
    rw [mterm, rcm_of_zero h0] at hne
    simp at hne
  rw [hL, hR]
  refine Finset.sum_nbij' (fun a => shiftm a i j) (fun b => shiftm b j i) ?_ ?_ ?_ ?_ ?_
  · intro a ha
    simp only [Finset.mem_filter, mem_simplexF] at ha ⊢
    refine ⟨by rw [deg_shiftm ha.2]; exact ha.1, ?_⟩
    rw [shiftm_apply_self]
    omega
  · intro b hb
    simp only [Finset.mem_filter, mem_simplexF] at hb ⊢
    refine ⟨by rw [deg_shiftm hb.2]; exact hb.1, ?_⟩
    rw [shiftm_apply_self]
    omega
  · intro a ha
    simp only [Finset.mem_filter] at ha
    exact shiftm_shiftm ha.2
  · intro b hb
    simp only [Finset.mem_filter] at hb
    exact shiftm_shiftm hb.2
  · intro a ha
    simp only [Finset.mem_filter] at ha
    rw [mterm, mterm, rcm_shiftm ha.2, shiftm_shiftm ha.2, hM i j]
    simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal]
    ring

/-- **The mode-exchange hops carry no flux.**  With a Hermitian amplitude matrix, the
total contribution of the degree-preserving hops over a shell is real. -/
theorem sum_mterm_im {M : Fin d → Fin d → ℂ} (hM : ∀ i j, M j i = (starRingEnd ℂ) (M i j))
    (N : ℕ) : (∑ i, ∑ j, ∑ a ∈ simplexF d N, mterm u M a i j).im = 0 := by
  classical
  set S : ℂ := ∑ i, ∑ j, ∑ a ∈ simplexF d N, mterm u M a i j with hS
  have hconj : (starRingEnd ℂ) S = S := by
    rw [hS, map_sum]
    have h1 : ∀ i : Fin d, (starRingEnd ℂ) (∑ j, ∑ a ∈ simplexF d N, mterm u M a i j)
        = ∑ j, ∑ b ∈ simplexF d N, mterm u M b j i := by
      intro i
      rw [map_sum]
      exact Finset.sum_congr rfl fun j _ => sum_mterm_conj hM N i j
    rw [Finset.sum_congr rfl fun i _ => h1 i]
    exact Finset.sum_comm
  have := Complex.conj_eq_iff_im.mp hconj
  exact this

/-! ## 4. The general quadratic recursion -/

/-- The shift of the pair hop `(i, j)`: `eᵢ + eⱼ`. -/
def pvec (i j : Fin d) : Fin d →₀ ℕ := Finsupp.single i 1 + Finsupp.single j 1

theorem deg_pvec (i j : Fin d) : deg (pvec (d := d) i j) = 2 := by
  rw [pvec, deg_add, deg_single, deg_single]

/-- The raising amplitude of the pair hop: `√((αᵢ+1)(αⱼ+1))` for `i ≠ j`, and
`√((αᵢ+1)(αᵢ+2))` for `i = j`. -/
def rcp (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a j : ℝ) + 1) * Real.sqrt ((((a + Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1)

/-- The lowering amplitude of the pair hop: `√(αᵢαⱼ)` for `i ≠ j`, and `√(αᵢ(αᵢ−1))` for
`i = j`. -/
def lcp (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a i : ℝ)) * Real.sqrt ((((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ))

theorem rcp_nonneg (a : Fin d →₀ ℕ) (i j : Fin d) : 0 ≤ rcp a i j :=
  mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)

theorem lcp_shift (i j : Fin d) (a : Fin d →₀ ℕ) :
    lcp (a + pvec i j) i j = rcp a i j := by
  classical
  by_cases hij : i = j
  · subst hij
    have h1 : ((a + pvec i i : Fin d →₀ ℕ) i : ℕ) = a i + 2 := by
      simp [pvec]
    have h2 : (((a + pvec i i) - Finsupp.single i 1 : Fin d →₀ ℕ) i : ℕ) = a i + 1 := by
      simp [pvec, Finsupp.tsub_apply]
    have h3 : (((a + Finsupp.single i 1 : Fin d →₀ ℕ)) i : ℕ) = a i + 1 := by simp
    rw [lcp, rcp, h1, h2, h3]
    push_cast
    ring_nf
  · have h1 : ((a + pvec i j : Fin d →₀ ℕ) i : ℕ) = a i + 1 := by
      simp [pvec, hij]
    have h2 : (((a + pvec i j) - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) = a j + 1 := by
      simp [pvec, Finsupp.tsub_apply, Ne.symm hij]
    have h3 : (((a + Finsupp.single j 1 : Fin d →₀ ℕ)) i : ℕ) = a i := by
      simp [Ne.symm hij]
    rw [lcp, rcp, h1, h2, h3]
    push_cast
    ring

theorem lcp_vanish (i j : Fin d) (a : Fin d →₀ ℕ) (h : ¬ pvec i j ≤ a) : lcp a i j = 0 := by
  classical
  rcases eq_or_ne i j with rfl | hij
  · have hle : ¬ (2 ≤ a i) := by
      intro h2
      refine h ?_
      rw [Finsupp.le_def]
      intro k
      by_cases hk : k = i
      · subst hk
        simpa [pvec] using h2
      · simp [pvec, Ne.symm hk]
    rcases Nat.lt_or_ge (a i) 1 with h0 | h1
    · have hai : a i = 0 := by omega
      rw [lcp, hai]
      simp
    · have hz : ((a - Finsupp.single i 1 : Fin d →₀ ℕ) i : ℕ) = 0 := by
        simp only [Finsupp.tsub_apply, Finsupp.single_eq_same]
        omega
      rw [lcp, hz]
      simp
  · have hor : a i = 0 ∨ a j = 0 := by
      by_contra hc
      push_neg at hc
      refine h ?_
      rw [Finsupp.le_def]
      intro k
      by_cases hki : k = i
      · subst hki
        have hp : (pvec k j : Fin d →₀ ℕ) k = 1 := by
          simp [pvec, hij]
        rw [hp]
        omega
      · by_cases hkj : k = j
        · subst hkj
          have hp : (pvec i k : Fin d →₀ ℕ) k = 1 := by
            simp [pvec, Ne.symm hki]
          rw [hp]
          omega
        · simp [pvec, Ne.symm hki, Ne.symm hkj]
    rcases hor with h0 | h0
    · rw [lcp, h0]
      simp
    · have hz : ((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) = 0 := by
        simp only [Finsupp.tsub_apply, Finsupp.single_apply, h0]
        omega
      rw [lcp, hz]
      simp

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

theorem lc1_vanish' (i : Fin d) (a : Fin d →₀ ℕ) (h : ¬ Finsupp.single i 1 ≤ a) :
    lc1 a i = 0 := by
  classical
  refine lc1_vanish i a ?_
  by_contra hge
  refine h ?_
  rw [Finsupp.le_def]
  intro k
  by_cases hk : k = i
  · subst hk
    simpa using (by omega : 1 ≤ a k)
  · simp [Ne.symm hk]

/-- **The flux identity** for the general quadratic recursion. -/
theorem flux_identityQ (hM : ∀ i j, M j i = (starRingEnd ℂ) (M i j))
    (hrec : LadderRecQ u lam w W M z) (N : ℕ) :
    z.im * (∑ a ∈ simplexF d N, ‖u a‖ ^ 2)
      = (∑ i, (∑ a ∈ sBd d N 1, rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a).im)
        + ∑ i, ∑ j,
            (∑ a ∈ sBd d N 2, rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a).im := by
  classical
  have hcm : ∀ v : ℂ, (starRingEnd ℂ) v * v = ((‖v‖ ^ 2 : ℝ) : ℂ) := by
    intro v; rw [Complex.conj_mul']; norm_cast
  have hpt : ∀ a : Fin d →₀ ℕ, (starRingEnd ℂ) (u a) * (z * u a)
      = ((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ)
        + (∑ i, (rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a
                  + ltermP u (w i) (fun b => lc1 b i) (Finsupp.single i 1) a))
        + (∑ i, ∑ j, (rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a
                  + ltermP u (W i j) (fun b => lcp b i j) (pvec i j) a))
        + ∑ i, ∑ j, mterm u M a i j := by
    intro a
    rw [← hrec a, mul_add, mul_add, mul_add, Finset.mul_sum, Finset.mul_sum, Finset.mul_sum]
    congr 1
    · congr 1
      · congr 1
        · rw [← hcm (u a)]; ring
        · refine Finset.sum_congr rfl fun i _ => ?_
          rw [rtermP, ltermP]; ring
      · refine Finset.sum_congr rfl fun i _ => ?_
        rw [Finset.mul_sum]
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [rtermP, ltermP]; ring
    · refine Finset.sum_congr rfl fun i _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [mterm]; ring
  have hL : ∑ a ∈ simplexF d N, (starRingEnd ℂ) (u a) * (z * u a)
      = z * ((∑ a ∈ simplexF d N, ‖u a‖ ^ 2 : ℝ) : ℂ) := by
    rw [Complex.ofReal_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← hcm (u a)]; ring
  have hR : ∑ a ∈ simplexF d N, (starRingEnd ℂ) (u a) * (z * u a)
      = ((∑ a ∈ simplexF d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
        + (∑ i, ∑ a ∈ simplexF d N, (rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a
                  + ltermP u (w i) (fun b => lc1 b i) (Finsupp.single i 1) a))
        + (∑ i, ∑ j, ∑ a ∈ simplexF d N, (rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a
                  + ltermP u (W i j) (fun b => lcp b i j) (pvec i j) a))
        + ∑ i, ∑ j, ∑ a ∈ simplexF d N, mterm u M a i j := by
    calc ∑ a ∈ simplexF d N, (starRingEnd ℂ) (u a) * (z * u a)
        = ∑ a ∈ simplexF d N, (((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ)
            + (∑ i, (rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a
                  + ltermP u (w i) (fun b => lc1 b i) (Finsupp.single i 1) a))
            + (∑ i, ∑ j, (rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a
                  + ltermP u (W i j) (fun b => lcp b i j) (pvec i j) a))
            + ∑ i, ∑ j, mterm u M a i j) :=
          Finset.sum_congr rfl fun a _ => hpt a
      _ = ((∑ a ∈ simplexF d N, ((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ))
            + ∑ a ∈ simplexF d N, ∑ i,
                (rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a
                  + ltermP u (w i) (fun b => lc1 b i) (Finsupp.single i 1) a)
            + ∑ a ∈ simplexF d N, ∑ i, ∑ j,
                (rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a
                  + ltermP u (W i j) (fun b => lcp b i j) (pvec i j) a))
            + ∑ a ∈ simplexF d N, ∑ i, ∑ j, mterm u M a i j := by
          rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.sum_add_distrib]
      _ = ((∑ a ∈ simplexF d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
            + (∑ i, ∑ a ∈ simplexF d N,
                (rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a
                  + ltermP u (w i) (fun b => lc1 b i) (Finsupp.single i 1) a))
            + (∑ i, ∑ j, ∑ a ∈ simplexF d N,
                (rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a
                  + ltermP u (W i j) (fun b => lcp b i j) (pvec i j) a))
            + ∑ i, ∑ j, ∑ a ∈ simplexF d N, mterm u M a i j := by
          rw [Finset.sum_comm (s := simplexF d N) (t := Finset.univ)]
          rw [Finset.sum_comm (s := simplexF d N) (t := Finset.univ)
            (f := fun a i => ∑ j, (rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a
                  + ltermP u (W i j) (fun b => lcp b i j) (pvec i j) a))]
          rw [Finset.sum_comm (s := simplexF d N) (t := Finset.univ)
            (f := fun a i => ∑ j, mterm u M a i j)]
          have e1 : ∀ i : Fin d, ∑ a ∈ simplexF d N, ∑ j,
              (rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a
                + ltermP u (W i j) (fun b => lcp b i j) (pvec i j) a)
              = ∑ j, ∑ a ∈ simplexF d N,
                  (rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a
                    + ltermP u (W i j) (fun b => lcp b i j) (pvec i j) a) := fun i =>
            Finset.sum_comm
          have e2 : ∀ i : Fin d, ∑ a ∈ simplexF d N, ∑ j, mterm u M a i j
              = ∑ j, ∑ a ∈ simplexF d N, mterm u M a i j := fun i => Finset.sum_comm
          rw [Finset.sum_congr rfl fun i _ => e1 i, Finset.sum_congr rfl fun i _ => e2 i]
          push_cast
          ring_nf
  have hEq := hL.symm.trans hR
  have hLim : (z * ((∑ a ∈ simplexF d N, ‖u a‖ ^ 2 : ℝ) : ℂ)).im
      = z.im * (∑ a ∈ simplexF d N, ‖u a‖ ^ 2) := by
    rw [Complex.mul_im, Complex.ofReal_im, Complex.ofReal_re, mul_zero, zero_add]
  rw [← hLim, hEq]
  rw [Complex.add_im, Complex.add_im, Complex.add_im, Complex.ofReal_im, zero_add,
    sum_mterm_im hM N, add_zero, Complex.im_sum, Complex.im_sum]
  congr 1
  · refine Finset.sum_congr rfl fun i _ => ?_
    have h := sum_simplex_hop_im (u := u) (w := w i) (rc := fun b => rc1 b i)
      (lc := fun b => lc1 b i) (P := Finsupp.single i 1)
      (fun a => lc1_shift i a) (fun a ha => lc1_vanish' i a ha) N
    rwa [deg_single] at h
  · refine Finset.sum_congr rfl fun i _ => ?_
    rw [Complex.im_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    have h := sum_simplex_hop_im (u := u) (w := W i j) (rc := fun b => rcp b i j)
      (lc := fun b => lcp b i j) (P := pvec i j)
      (fun a => lcp_shift i j a) (fun a ha => lcp_vanish i j a ha) N
    rwa [deg_pvec] at h

/-! ## 5. The flux bound and the boundary mass -/

/-- **The flux bound** on an arbitrary finite set of multi-indices. -/
theorem flux_bound_on {w : ℂ} {rc : (Fin d →₀ ℕ) → ℝ} (F : Finset (Fin d →₀ ℕ))
    (P : Fin d →₀ ℕ) {Cn : ℝ} (hC : ∀ a ∈ F, |rc a| ≤ Cn) :
    |(∑ a ∈ F, rtermP u w rc P a).im|
      ≤ Cn * (‖w‖ * ((∑ a ∈ F, (‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2)) / 2)) := by
  classical
  have h1 : |(∑ a ∈ F, rtermP u w rc P a).im| ≤ ‖∑ a ∈ F, rtermP u w rc P a‖ :=
    Complex.abs_im_le_norm _
  have h2 : ‖∑ a ∈ F, rtermP u w rc P a‖ ≤ ∑ a ∈ F, ‖rtermP u w rc P a‖ := norm_sum_le _ _
  have h3 : ∀ a ∈ F, ‖rtermP u w rc P a‖
      ≤ Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) / 2)) := by
    intro a ha
    have hnorm : ‖rtermP u w rc P a‖ = ‖w‖ * |rc a| * ‖u a‖ * ‖u (a + P)‖ := by
      rw [rtermP]
      simp [Complex.norm_real]
    have hprod : ‖u a‖ * ‖u (a + P)‖ ≤ (‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) / 2 := by
      nlinarith [sq_nonneg (‖u a‖ - ‖u (a + P)‖)]
    have hb1 : ‖w‖ * |rc a| ≤ ‖w‖ * Cn := mul_le_mul_of_nonneg_left (hC a ha) (norm_nonneg w)
    have hCn : 0 ≤ Cn := le_trans (abs_nonneg _) (hC a ha)
    rw [hnorm]
    calc ‖w‖ * |rc a| * ‖u a‖ * ‖u (a + P)‖
        = (‖w‖ * |rc a|) * (‖u a‖ * ‖u (a + P)‖) := by ring
      _ ≤ (‖w‖ * Cn) * (‖u a‖ * ‖u (a + P)‖) := by
          refine mul_le_mul_of_nonneg_right hb1 ?_
          positivity
      _ ≤ (‖w‖ * Cn) * ((‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) / 2) := by
          refine mul_le_mul_of_nonneg_left hprod ?_
          positivity
      _ = Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) / 2)) := by ring
  calc |(∑ a ∈ F, rtermP u w rc P a).im|
      ≤ ∑ a ∈ F, ‖rtermP u w rc P a‖ := h1.trans h2
    _ ≤ ∑ a ∈ F, Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) / 2)) := Finset.sum_le_sum h3
    _ = Cn * (‖w‖ * ((∑ a ∈ F, (‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2)) / 2)) := by
        rw [← Finset.mul_sum, ← Finset.mul_sum, Finset.sum_div]

theorem sBd_multiplicity (k : ℕ) (a : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter (fun N => a ∈ sBd d N k)).card) ≤ k := by
  classical
  have hsub : ((Finset.range M).filter (fun N => a ∈ sBd d N k))
      ⊆ Finset.Ico (deg a) (deg a + k) := by
    intro N hN
    simp only [Finset.mem_filter] at hN
    rw [mem_sBd] at hN
    exact Finset.mem_Ico.mpr ⟨hN.2.1, hN.2.2⟩
  calc (((Finset.range M).filter (fun N => a ∈ sBd d N k)).card)
      ≤ (Finset.Ico (deg a) (deg a + k)).card := Finset.card_le_card hsub
    _ = k := by rw [Nat.card_Ico]; omega

theorem shifted_sBd_multiplicity (P : Fin d →₀ ℕ) (b : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter
      (fun N => b ∈ (sBd d N (deg P)).image (fun a => a + P))).card) ≤ deg P := by
  classical
  have hsub : ((Finset.range M).filter
        (fun N => b ∈ (sBd d N (deg P)).image (fun a => a + P)))
      ⊆ Finset.Ico (deg b - deg P) (deg b) := by
    intro N hN
    simp only [Finset.mem_filter, Finset.mem_image] at hN
    obtain ⟨a, ha, hab⟩ := hN.2
    rw [mem_sBd] at ha
    have hbd : deg b = deg a + deg P := by rw [← hab, deg_add]
    refine Finset.mem_Ico.mpr ⟨by omega, by omega⟩
  calc (((Finset.range M).filter
        (fun N => b ∈ (sBd d N (deg P)).image (fun a => a + P))).card)
      ≤ (Finset.Ico (deg b - deg P) (deg b)).card := Finset.card_le_card hsub
    _ ≤ deg P := by rw [Nat.card_Ico]; omega

theorem sBd_mass_le {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B) (k M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ sBd d N k, ‖u a‖ ^ 2 ≤ (k : ℝ) * B :=
  sum_range_of_multiplicity k hbes (fun N => sBd d N k) (sBd_multiplicity k) M

theorem shifted_sBd_mass_le {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B) (P : Fin d →₀ ℕ) (M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ sBd d N (deg P), ‖u (a + P)‖ ^ 2 ≤ ((deg P : ℕ) : ℝ) * B := by
  classical
  have hinj : ∀ N : ℕ, ∑ a ∈ sBd d N (deg P), ‖u (a + P)‖ ^ 2
      = ∑ b ∈ (sBd d N (deg P)).image (fun a => a + P), ‖u b‖ ^ 2 := by
    intro N
    rw [Finset.sum_image]
    intro x _ y _ hxy
    exact add_right_cancel hxy
  simp_rw [hinj]
  exact sum_range_of_multiplicity (deg P) hbes
    (fun N => (sBd d N (deg P)).image (fun a => a + P))
    (shifted_sBd_multiplicity P) M

/-- The Carleman divergence at growth rate `N`: `∑ 1/(N+2) = ∞`. -/
theorem not_summable_inv_natCast_add_two : ¬ Summable (fun N : ℕ => ((N : ℝ) + 2)⁻¹) := by
  intro h
  refine not_summable_inv_natCast_succ ?_
  refine (summable_nat_add_iff 1).mp ?_
  refine h.congr fun N => ?_
  push_cast
  ring_nf

/-! ## 6. The criterion -/

/-- **The general quadratic Carleman criterion.**  A square-summable family satisfying the
general quadratic recursion — one-step hops, pair creation/annihilation hops and
mode-exchange hops — with a real diagonal, constant amplitudes and a Hermitian exchange
matrix, at a point off the real axis, vanishes identically. -/
theorem ladderQ_eq_zero {B : ℝ} (hz : z.im ≠ 0)
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (hM : ∀ i j, M j i = (starRingEnd ℂ) (M i j))
    (hrec : LadderRecQ u lam w W M z) : ∀ a, u a = 0 := by
  classical
  by_contra hcon
  push_neg at hcon
  obtain ⟨a₀, ha₀⟩ := hcon
  set mass : ℕ → (Fin d →₀ ℕ) → ℝ := fun N P =>
    (∑ a ∈ sBd d N (deg P), (‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2)) / 2 with hmass
  set A : ℕ → ℝ := fun N =>
    (∑ i, ‖w i‖ * mass N (Finsupp.single i 1)) + ∑ i, ∑ j, ‖W i j‖ * mass N (pvec i j)
    with hAdef
  have hmass_nonneg : ∀ N P, 0 ≤ mass N P := by
    intro N P
    have hs : 0 ≤ ∑ a ∈ sBd d N (deg P), (‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2) :=
      Finset.sum_nonneg fun a _ => by positivity
    rw [hmass]
    positivity
  have hAnn : ∀ N, 0 ≤ A N := by
    intro N
    have h1 : 0 ≤ ∑ i, ‖w i‖ * mass N (Finsupp.single i 1) :=
      Finset.sum_nonneg fun i _ => mul_nonneg (norm_nonneg _) (hmass_nonneg N _)
    have h2 : 0 ≤ ∑ i, ∑ j, ‖W i j‖ * mass N (pvec i j) :=
      Finset.sum_nonneg fun i _ =>
        Finset.sum_nonneg fun j _ => mul_nonneg (norm_nonneg _) (hmass_nonneg N _)
    rw [hAdef]
    linarith
  -- the total boundary mass is finite
  have hmass_sum : ∀ (P : Fin d →₀ ℕ) (Mx : ℕ),
      ∑ N ∈ Finset.range Mx, mass N P ≤ ((deg P : ℕ) : ℝ) * B := by
    intro P Mx
    have h1 := sBd_mass_le hbes (deg P) Mx
    have h2 := shifted_sBd_mass_le hbes P Mx
    have hpt : ∀ N : ℕ, mass N P
        = ((∑ a ∈ sBd d N (deg P), ‖u a‖ ^ 2)
            + ∑ a ∈ sBd d N (deg P), ‖u (a + P)‖ ^ 2) / 2 := by
      intro N; simp only [hmass]; rw [Finset.sum_add_distrib]
    simp_rw [hpt]
    rw [← Finset.sum_div, Finset.sum_add_distrib]
    linarith
  have hApart : ∀ Mx, ∑ N ∈ Finset.range Mx, A N
      ≤ ((∑ i, ‖w i‖) * (1 * B)) + (∑ i, ∑ j, ‖W i j‖) * (2 * B) := by
    intro Mx
    have hsplit : ∑ N ∈ Finset.range Mx, A N
        = (∑ N ∈ Finset.range Mx, ∑ i, ‖w i‖ * mass N (Finsupp.single i 1))
          + ∑ N ∈ Finset.range Mx, ∑ i, ∑ j, ‖W i j‖ * mass N (pvec i j) := by
      rw [hAdef, ← Finset.sum_add_distrib]
    have hb1 : ∑ N ∈ Finset.range Mx, ∑ i, ‖w i‖ * mass N (Finsupp.single i 1)
        ≤ (∑ i, ‖w i‖) * (1 * B) := by
      rw [Finset.sum_comm, Finset.sum_mul]
      refine Finset.sum_le_sum fun i _ => ?_
      calc ∑ N ∈ Finset.range Mx, ‖w i‖ * mass N (Finsupp.single i 1)
          = ‖w i‖ * ∑ N ∈ Finset.range Mx, mass N (Finsupp.single i 1) := by rw [Finset.mul_sum]
        _ ≤ ‖w i‖ * (1 * B) := by
            refine mul_le_mul_of_nonneg_left ?_ (norm_nonneg _)
            have := hmass_sum (Finsupp.single i 1) Mx
            rw [deg_single] at this
            simpa using this
    have hb2 : ∑ N ∈ Finset.range Mx, ∑ i, ∑ j, ‖W i j‖ * mass N (pvec i j)
        ≤ (∑ i, ∑ j, ‖W i j‖) * (2 * B) := by
      rw [Finset.sum_comm, Finset.sum_mul]
      refine Finset.sum_le_sum fun i _ => ?_
      rw [Finset.sum_comm, Finset.sum_mul]
      refine Finset.sum_le_sum fun j _ => ?_
      calc ∑ N ∈ Finset.range Mx, ‖W i j‖ * mass N (pvec i j)
          = ‖W i j‖ * ∑ N ∈ Finset.range Mx, mass N (pvec i j) := by rw [Finset.mul_sum]
        _ ≤ ‖W i j‖ * (2 * B) := by
            refine mul_le_mul_of_nonneg_left ?_ (norm_nonneg _)
            have := hmass_sum (pvec i j) Mx
            rw [deg_pvec] at this
            simpa using this
    rw [hsplit]
    push_cast at hb1 hb2
    linarith
  have hsummable : Summable A := summable_of_sum_range_le hAnn hApart
  -- the amplitude bound on the boundary
  have hC1 : ∀ (N : ℕ) (i : Fin d), ∀ a ∈ sBd d N 1, |rc1 a i| ≤ (N : ℝ) + 2 := by
    intro N i a ha
    rw [mem_sBd] at ha
    have hai : ((a i : ℝ)) ≤ (N : ℝ) := by
      exact_mod_cast le_trans (apply_le_deg a i) ha.1
    have h1 : rc1 a i ≤ (N : ℝ) + 2 := by
      rw [rc1]
      have : Real.sqrt ((a i : ℝ) + 1) ≤ Real.sqrt (((N : ℝ) + 2) ^ 2) := by
        refine Real.sqrt_le_sqrt ?_
        nlinarith [Nat.cast_nonneg (α := ℝ) N]
      rwa [Real.sqrt_sq (by positivity)] at this
    rw [abs_of_nonneg (rc1_nonneg a i)]
    exact h1
  have hC2 : ∀ (N : ℕ) (i j : Fin d), ∀ a ∈ sBd d N 2, |rcp a i j| ≤ (N : ℝ) + 2 := by
    intro N i j a ha
    rw [mem_sBd] at ha
    have haj : ((a j : ℝ)) ≤ (N : ℝ) := by
      exact_mod_cast le_trans (apply_le_deg a j) ha.1
    have hai : (((a + Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) ≤ (N : ℝ) + 1 := by
      have : ((a + Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) ≤ a i + 1 := by
        simp only [Finsupp.add_apply, Finsupp.single_apply]
        by_cases h : j = i <;> simp [h]
      have h2 : (a i : ℕ) ≤ N := le_trans (apply_le_deg a i) ha.1
      have : ((a + Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) ≤ N + 1 := by omega
      exact_mod_cast this
    have hs1 : Real.sqrt ((a j : ℝ) + 1) ≤ Real.sqrt (((N : ℝ) + 2)) := by
      refine Real.sqrt_le_sqrt ?_
      linarith
    have hs2 : Real.sqrt ((((a + Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1)
        ≤ Real.sqrt (((N : ℝ) + 2)) := by
      refine Real.sqrt_le_sqrt ?_
      linarith
    have hnn : (0 : ℝ) ≤ Real.sqrt ((N : ℝ) + 2) := Real.sqrt_nonneg _
    have hprod : rcp a i j ≤ Real.sqrt ((N : ℝ) + 2) * Real.sqrt ((N : ℝ) + 2) := by
      rw [rcp]
      exact mul_le_mul hs1 hs2 (Real.sqrt_nonneg _) hnn
    have hsq : Real.sqrt ((N : ℝ) + 2) * Real.sqrt ((N : ℝ) + 2) = (N : ℝ) + 2 :=
      Real.mul_self_sqrt (by positivity)
    rw [abs_of_nonneg (rcp_nonneg a i j)]
    linarith [hprod, hsq]
  have hkey : ∀ N : ℕ,
      |z.im| * (∑ a ∈ simplexF d N, ‖u a‖ ^ 2) ≤ ((N : ℝ) + 2) * A N := by
    intro N
    have hS : 0 ≤ ∑ a ∈ simplexF d N, ‖u a‖ ^ 2 := Finset.sum_nonneg fun a _ => by positivity
    have h1 : |z.im| * (∑ a ∈ simplexF d N, ‖u a‖ ^ 2)
        = |(∑ i, (∑ a ∈ sBd d N 1,
                rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a).im)
            + ∑ i, ∑ j, (∑ a ∈ sBd d N 2,
                rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a).im| := by
      rw [← flux_identityQ hM hrec N, abs_mul, abs_of_nonneg hS]
    rw [h1]
    have hb1 : |∑ i, (∑ a ∈ sBd d N 1,
          rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a).im|
        ≤ ((N : ℝ) + 2) * ∑ i, ‖w i‖ * mass N (Finsupp.single i 1) := by
      calc |∑ i, (∑ a ∈ sBd d N 1,
              rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a).im|
          ≤ ∑ i, |(∑ a ∈ sBd d N 1,
              rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a).im| :=
            Finset.abs_sum_le_sum_abs _ _
        _ ≤ ∑ i, ((N : ℝ) + 2) * (‖w i‖ * mass N (Finsupp.single i 1)) := by
            refine Finset.sum_le_sum fun i _ => ?_
            have h := flux_bound_on (u := u) (w := w i) (rc := fun b => rc1 b i)
              (sBd d N 1) (Finsupp.single i 1) (Cn := (N : ℝ) + 2) (hC1 N i)
            have hd : deg (Finsupp.single i 1 : Fin d →₀ ℕ) = 1 := deg_single i 1
            simpa [hmass, hd] using h
        _ = ((N : ℝ) + 2) * ∑ i, ‖w i‖ * mass N (Finsupp.single i 1) := by rw [Finset.mul_sum]
    have hb2 : |∑ i, ∑ j, (∑ a ∈ sBd d N 2,
          rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a).im|
        ≤ ((N : ℝ) + 2) * ∑ i, ∑ j, ‖W i j‖ * mass N (pvec i j) := by
      calc |∑ i, ∑ j, (∑ a ∈ sBd d N 2,
              rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a).im|
          ≤ ∑ i, |∑ j, (∑ a ∈ sBd d N 2,
              rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a).im| :=
            Finset.abs_sum_le_sum_abs _ _
        _ ≤ ∑ i, ((N : ℝ) + 2) * ∑ j, (‖W i j‖ * mass N (pvec i j)) := by
            refine Finset.sum_le_sum fun i _ => ?_
            calc |∑ j, (∑ a ∈ sBd d N 2,
                    rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a).im|
                ≤ ∑ j, |(∑ a ∈ sBd d N 2,
                    rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a).im| :=
                  Finset.abs_sum_le_sum_abs _ _
              _ ≤ ∑ j, ((N : ℝ) + 2) * (‖W i j‖ * mass N (pvec i j)) := by
                  refine Finset.sum_le_sum fun j _ => ?_
                  have h := flux_bound_on (u := u) (w := W i j) (rc := fun b => rcp b i j)
                    (sBd d N 2) (pvec i j) (Cn := (N : ℝ) + 2) (hC2 N i j)
                  have hd : deg (pvec (d := d) i j) = 2 := deg_pvec i j
                  simpa [hmass, hd] using h
              _ = ((N : ℝ) + 2) * ∑ j, (‖W i j‖ * mass N (pvec i j)) := by rw [Finset.mul_sum]
        _ = ((N : ℝ) + 2) * ∑ i, ∑ j, ‖W i j‖ * mass N (pvec i j) := by rw [Finset.mul_sum]
    have habs := abs_add_le
      (∑ i, (∑ a ∈ sBd d N 1,
        rtermP u (w i) (fun b => rc1 b i) (Finsupp.single i 1) a).im)
      (∑ i, ∑ j, (∑ a ∈ sBd d N 2,
        rtermP u (W i j) (fun b => rcp b i j) (pvec i j) a).im)
    rw [hAdef]
    simp only
    rw [mul_add]
    linarith
  -- the shell mass is bounded below
  set N₀ : ℕ := deg a₀ with hN₀
  have hlow : ∀ N : ℕ, N₀ ≤ N → ‖u a₀‖ ^ 2 ≤ ∑ a ∈ simplexF d N, ‖u a‖ ^ 2 := by
    intro N hN
    refine Finset.single_le_sum (f := fun a => ‖u a‖ ^ 2) (fun a _ => by positivity) ?_
    rw [mem_simplexF]
    exact hN
  have hcpos : 0 < |z.im| * ‖u a₀‖ ^ 2 := by
    have h1 : 0 < |z.im| := abs_pos.mpr hz
    have h2 : 0 < ‖u a₀‖ ^ 2 := by
      have : 0 < ‖u a₀‖ := norm_pos_iff.mpr ha₀
      positivity
    positivity
  have hAlow : ∀ N : ℕ, N₀ ≤ N →
      (|z.im| * ‖u a₀‖ ^ 2) * ((N : ℝ) + 2)⁻¹ ≤ A N := by
    intro N hN
    have hpos : (0 : ℝ) < (N : ℝ) + 2 := by positivity
    have h1 := hkey N
    have h2 := hlow N hN
    have h3 : |z.im| * ‖u a₀‖ ^ 2 ≤ ((N : ℝ) + 2) * A N := by
      have := mul_le_mul_of_nonneg_left h2 (abs_nonneg z.im)
      linarith
    have h5 : (|z.im| * ‖u a₀‖ ^ 2) * ((N : ℝ) + 2)⁻¹
        = (|z.im| * ‖u a₀‖ ^ 2) / ((N : ℝ) + 2) := by
      field_simp
    rw [h5, div_le_iff₀ hpos]
    linarith [h3, mul_comm ((N : ℝ) + 2) (A N)]
  have hshift : Summable (fun N : ℕ => A (N + N₀)) := (summable_nat_add_iff N₀).mpr hsummable
  have hcomp : Summable (fun N : ℕ =>
      (|z.im| * ‖u a₀‖ ^ 2) * (((N + N₀ : ℕ) : ℝ) + 2)⁻¹) := by
    refine Summable.of_nonneg_of_le (fun N => by positivity) (fun N => ?_) hshift
    exact hAlow (N + N₀) (Nat.le_add_left _ _)
  have h4 : Summable (fun N : ℕ => (((N + N₀ : ℕ) : ℝ) + 2)⁻¹) := by
    have h5 := hcomp.mul_left (|z.im| * ‖u a₀‖ ^ 2)⁻¹
    refine h5.congr fun N => ?_
    field_simp
  exact not_summable_inv_natCast_add_two ((summable_nat_add_iff N₀).mp h4)

end

end BookProof.CarlemanSimplex
