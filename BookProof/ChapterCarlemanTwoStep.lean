import Mathlib
import BookProof.ChapterHermiteCarlemanEsa

/-!
# A two-step Carleman criterion on the multi-index lattice

`BookProof.ChapterHermiteCarlemanEsa` proves a Carleman criterion for a *nearest
neighbour* recursion on the lattice of multi-indices: the hops are `α ↦ α ± eᵢ`, with
amplitudes of size `O(√αᵢ)`.  That is exactly the ladder structure of a **diagonal**
quadratic Hamiltonian `∑ᵢ cᵢ(πᵢ² + xᵢ²/4)` plus a first-order term.

A general **mode-diagonal** quadratic Hamiltonian

`H = ∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is not of that form: `xᵢ²`, `πᵢ²` and the squeezing generator `½(xᵢπᵢ + πᵢxᵢ)` all
contain `aᵢ†²` and `aᵢ²`, which move the `i`-th excitation number by **two**, with an
amplitude of size `O(αᵢ)`.  This module proves the Carleman criterion for such a
recursion: hops `α ↦ α ± eᵢ` *and* `α ↦ α ± 2eᵢ`, with amplitudes `O(N)` on the boundary
of the cube `{α : ∀ i, αᵢ ≤ N}`.

## What is proved

* `innK`, `faceK` — the interior and the `k`-thick boundary face of a cube in a fixed
  direction; `sum_shiftK`, `sum_cube_splitK` — the reindexing and splitting identities.
* `rtermG`, `ltermG`, `sum_cube_hop_im` — **the abstract flux cancellation**: for a
  single Hermitian hop family of step `k`, the interior contributions occur in conjugate
  pairs, so the imaginary part of the total contribution over a cube is carried entirely
  by the `k`-thick boundary face.
* `LadderRec2`, `flux_identity2` — the two-step recursion and its flux identity.
* `flux_boundG` — the flux through a face is at most the amplitude bound there times the
  `ℓ²`-mass carried by the face and its shift.
* `sum_range_of_multiplicity`, `faceK_multiplicity`, `shiftedK_multiplicity` — Bessel's
  inequality with multiplicity: a `k`-thick face meets at most `k` cubes, so the total
  face mass is at most `k` times the total mass.  (For `k = 1` the faces are disjoint;
  for `k = 2` they are not, and this is what replaces disjointness.)
* `ladder2_eq_zero` — **the criterion.**  A square-summable family satisfying the
  two-step recursion with a real diagonal and constant amplitudes, at a point off the
  real axis, vanishes.  The Carleman divergence used is `∑ 1/(N+1) = ∞`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.CarlemanTwoStep

open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

/-! ## 1. Cubes with a step -/

/-- The part of the cube that can still be raised by `k` in the direction `i` without
leaving the cube. -/
def innK (d N : ℕ) (i : Fin d) (k : ℕ) : Finset (Fin d →₀ ℕ) :=
  (cube d N).filter (fun a => a i + k ≤ N)

/-- The `k`-thick boundary face of the cube in the direction `i`. -/
def faceK (d N : ℕ) (i : Fin d) (k : ℕ) : Finset (Fin d →₀ ℕ) :=
  (cube d N).filter (fun a => N < a i + k)

theorem mem_innK {d N : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ innK d N i k ↔ (∀ j, a j ≤ N) ∧ a i + k ≤ N := by
  classical
  rw [innK, Finset.mem_filter, mem_cube]

theorem mem_faceK {d N : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ faceK d N i k ↔ (∀ j, a j ≤ N) ∧ N < a i + k := by
  classical
  rw [faceK, Finset.mem_filter, mem_cube]

theorem sub_add_singleK {d : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} (h : k ≤ a i) :
    (a - Finsupp.single i k) + Finsupp.single i k = a := by
  ext j
  by_cases hj : j = i
  · subst hj; simp; omega
  · simp [hj]

theorem sub_singleK_apply {d : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} :
    (a - Finsupp.single i k : Fin d →₀ ℕ) i = a i - k := by
  simp [Finsupp.tsub_apply]

/-- Reindexing a sum which vanishes on the bottom `k` layers along the shift
`α ↦ α + k eᵢ`. -/
theorem sum_shiftK (d N : ℕ) (i : Fin d) (k : ℕ) (F : (Fin d →₀ ℕ) → ℂ)
    (hF : ∀ a : Fin d →₀ ℕ, a i < k → F a = 0) :
    ∑ a ∈ cube d N, F a = ∑ b ∈ innK d N i k, F (b + Finsupp.single i k) := by
  classical
  rw [← Finset.sum_filter_of_ne (p := fun a : Fin d →₀ ℕ => k ≤ a i)
    (fun a _ hne => by by_contra hlt; exact hne (hF a (by omega)))]
  refine Finset.sum_nbij' (fun a => a - Finsupp.single i k) (fun b => b + Finsupp.single i k)
    ?_ ?_ ?_ ?_ ?_
  · intro a ha
    simp only [Finset.mem_filter, mem_cube] at ha
    rw [mem_innK]
    refine ⟨fun j => le_trans (by simp [Finsupp.tsub_apply]) (ha.1 j), ?_⟩
    rw [sub_singleK_apply]
    have h2 := ha.1 i
    have h3 := ha.2
    omega
  · intro b hb
    rw [mem_innK] at hb
    simp only [Finset.mem_filter, mem_cube]
    refine ⟨fun j => ?_, ?_⟩
    · by_cases hj : j = i
      · subst hj; simp; omega
      · simpa [hj] using hb.1 j
    · simp
  · intro a ha
    simp only [Finset.mem_filter] at ha
    exact sub_add_singleK ha.2
  · intro b _; simp
  · intro a ha
    simp only [Finset.mem_filter] at ha
    rw [sub_add_singleK ha.2]

/-- The cube is the disjoint union of its `k`-interior and its `k`-thick face. -/
theorem sum_cube_splitK (d N : ℕ) (i : Fin d) (k : ℕ) (F : (Fin d →₀ ℕ) → ℂ) :
    ∑ a ∈ cube d N, F a = ∑ a ∈ innK d N i k, F a + ∑ a ∈ faceK d N i k, F a := by
  classical
  rw [innK, faceK,
    ← Finset.sum_filter_add_sum_filter_not (cube d N) (fun a => a i + k ≤ N) F]
  congr 1
  refine Finset.sum_congr ?_ fun _ _ => rfl
  ext a
  simp only [Finset.mem_filter, mem_cube]
  constructor
  · rintro ⟨h1, h2⟩; exact ⟨h1, by omega⟩
  · rintro ⟨h1, h2⟩; exact ⟨h1, by omega⟩

/-! ## 2. The abstract flux cancellation for one hop family -/

variable {u : (Fin d →₀ ℕ) → ℂ}

/-- The raising contribution of a hop of step `k` in the direction `i`. -/
def rtermG (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (rc : (Fin d →₀ ℕ) → Fin d → ℝ) (k : ℕ) (i : Fin d)
    (a : Fin d →₀ ℕ) : ℂ :=
  (starRingEnd ℂ) w * ((rc a i : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (a + Finsupp.single i k)

/-- The lowering contribution of a hop of step `k` in the direction `i`. -/
def ltermG (u : (Fin d →₀ ℕ) → ℂ) (w : ℂ) (lc : (Fin d →₀ ℕ) → Fin d → ℝ) (k : ℕ) (i : Fin d)
    (a : Fin d →₀ ℕ) : ℂ :=
  w * ((lc a i : ℝ) : ℂ) * (starRingEnd ℂ) (u a) * u (a - Finsupp.single i k)

theorem ltermG_shift {w : ℂ} {rc lc : (Fin d →₀ ℕ) → Fin d → ℝ} {k : ℕ} {i : Fin d}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + Finsupp.single i k) i = rc a i) (b : Fin d →₀ ℕ) :
    ltermG u w lc k i (b + Finsupp.single i k) = (starRingEnd ℂ) (rtermG u w rc k i b) := by
  rw [ltermG, rtermG, hcomp b, add_tsub_cancel_right]
  simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal]
  ring

theorem sum_ltermG {w : ℂ} {rc lc : (Fin d →₀ ℕ) → Fin d → ℝ} {k : ℕ} {i : Fin d}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + Finsupp.single i k) i = rc a i)
    (hvan : ∀ a : Fin d →₀ ℕ, a i < k → lc a i = 0) (N : ℕ) :
    ∑ a ∈ cube d N, ltermG u w lc k i a
      = (starRingEnd ℂ) (∑ a ∈ innK d N i k, rtermG u w rc k i a) := by
  rw [sum_shiftK d N i k (ltermG u w lc k i) (fun a ha => by rw [ltermG, hvan a ha]; simp),
    map_sum]
  exact Finset.sum_congr rfl fun b _ => ltermG_shift hcomp b

/-- **The flux cancellation.**  The interior contributions occur in conjugate pairs, so
only the `k`-thick face contributes to the imaginary part. -/
theorem sum_cube_hop_im {w : ℂ} {rc lc : (Fin d →₀ ℕ) → Fin d → ℝ} {k : ℕ} {i : Fin d}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + Finsupp.single i k) i = rc a i)
    (hvan : ∀ a : Fin d →₀ ℕ, a i < k → lc a i = 0) (N : ℕ) :
    (∑ a ∈ cube d N, (rtermG u w rc k i a + ltermG u w lc k i a)).im
      = (∑ a ∈ faceK d N i k, rtermG u w rc k i a).im := by
  rw [Finset.sum_add_distrib, sum_cube_splitK d N i k (rtermG u w rc k i),
    sum_ltermG hcomp hvan N]
  simp [Complex.add_im]

/-! ## 3. The two-step recursion -/

/-- The raising coefficient of a one-step hop: `√(αᵢ+1)`. -/
def rc1 (a : Fin d →₀ ℕ) (i : Fin d) : ℝ := Real.sqrt ((a i : ℝ) + 1)

/-- The lowering coefficient of a one-step hop: `√αᵢ`. -/
def lc1 (a : Fin d →₀ ℕ) (i : Fin d) : ℝ := Real.sqrt (a i : ℝ)

/-- The raising coefficient of a two-step hop: `√((αᵢ+1)(αᵢ+2))`. -/
def rc2 (a : Fin d →₀ ℕ) (i : Fin d) : ℝ := Real.sqrt (((a i : ℝ) + 1) * ((a i : ℝ) + 2))

/-- The lowering coefficient of a two-step hop: `√(αᵢ(αᵢ−1))`. -/
def lc2 (a : Fin d →₀ ℕ) (i : Fin d) : ℝ := Real.sqrt ((a i : ℝ) * ((a i : ℝ) - 1))

theorem lc1_shift (i : Fin d) (a : Fin d →₀ ℕ) :
    lc1 (a + Finsupp.single i 1) i = rc1 a i := by
  rw [lc1, rc1]
  norm_num

theorem lc1_vanish (i : Fin d) (a : Fin d →₀ ℕ) (h : a i < 1) : lc1 a i = 0 := by
  have : a i = 0 := by omega
  rw [lc1, this]
  simp

theorem lc2_shift (i : Fin d) (a : Fin d →₀ ℕ) :
    lc2 (a + Finsupp.single i 2) i = rc2 a i := by
  rw [lc2, rc2]
  have h : ((a + Finsupp.single i 2 : Fin d →₀ ℕ) i : ℝ) = (a i : ℝ) + 2 := by
    simp
  rw [h]
  ring_nf

theorem lc2_vanish (i : Fin d) (a : Fin d →₀ ℕ) (h : a i < 2) : lc2 a i = 0 := by
  interval_cases hai : (a i)
  · rw [lc2, hai]; norm_num
  · rw [lc2, hai]; norm_num

theorem rc1_nonneg (a : Fin d →₀ ℕ) (i : Fin d) : 0 ≤ rc1 a i := Real.sqrt_nonneg _

theorem rc2_nonneg (a : Fin d →₀ ℕ) (i : Fin d) : 0 ≤ rc2 a i := Real.sqrt_nonneg _

/-- **The two-step recursion.**  A real diagonal `lam`, one-step amplitudes `w1` and
two-step amplitudes `w2`, at the point `z`. -/
def LadderRec2 (u : (Fin d →₀ ℕ) → ℂ) (lam : (Fin d →₀ ℕ) → ℝ) (w1 w2 : Fin d → ℂ) (z : ℂ) :
    Prop :=
  ∀ a : Fin d →₀ ℕ,
    ((lam a : ℝ) : ℂ) * u a
      + ∑ i, ((starRingEnd ℂ) (w1 i) * ((rc1 a i : ℝ) : ℂ) * u (a + Finsupp.single i 1)
            + w1 i * ((lc1 a i : ℝ) : ℂ) * u (a - Finsupp.single i 1))
      + ∑ i, ((starRingEnd ℂ) (w2 i) * ((rc2 a i : ℝ) : ℂ) * u (a + Finsupp.single i 2)
            + w2 i * ((lc2 a i : ℝ) : ℂ) * u (a - Finsupp.single i 2))
      = z * u a

variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}

/-- **The flux identity** for the two-step recursion. -/
theorem flux_identity2 (hrec : LadderRec2 u lam w1 w2 z) (N : ℕ) :
    z.im * (∑ a ∈ cube d N, ‖u a‖ ^ 2)
      = (∑ i, (∑ a ∈ faceK d N i 1, rtermG u (w1 i) rc1 1 i a).im)
        + ∑ i, (∑ a ∈ faceK d N i 2, rtermG u (w2 i) rc2 2 i a).im := by
  classical
  have hcm : ∀ v : ℂ, (starRingEnd ℂ) v * v = ((‖v‖ ^ 2 : ℝ) : ℂ) := by
    intro v; rw [Complex.conj_mul']; norm_cast
  have hpt : ∀ a : Fin d →₀ ℕ, (starRingEnd ℂ) (u a) * (z * u a)
      = ((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ)
        + (∑ i, (rtermG u (w1 i) rc1 1 i a + ltermG u (w1 i) lc1 1 i a))
        + ∑ i, (rtermG u (w2 i) rc2 2 i a + ltermG u (w2 i) lc2 2 i a) := by
    intro a
    rw [← hrec a, mul_add, mul_add, Finset.mul_sum, Finset.mul_sum]
    congr 1
    · congr 1
      · rw [← hcm (u a)]; ring
      · refine Finset.sum_congr rfl fun i _ => ?_
        rw [rtermG, ltermG]; ring
    · refine Finset.sum_congr rfl fun i _ => ?_
      rw [rtermG, ltermG]; ring
  have hL : ∑ a ∈ cube d N, (starRingEnd ℂ) (u a) * (z * u a)
      = z * ((∑ a ∈ cube d N, ‖u a‖ ^ 2 : ℝ) : ℂ) := by
    rw [Complex.ofReal_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← hcm (u a)]; ring
  have hR : ∑ a ∈ cube d N, (starRingEnd ℂ) (u a) * (z * u a)
      = ((∑ a ∈ cube d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
        + (∑ i, ∑ a ∈ cube d N, (rtermG u (w1 i) rc1 1 i a + ltermG u (w1 i) lc1 1 i a))
        + ∑ i, ∑ a ∈ cube d N, (rtermG u (w2 i) rc2 2 i a + ltermG u (w2 i) lc2 2 i a) := by
    calc ∑ a ∈ cube d N, (starRingEnd ℂ) (u a) * (z * u a)
        = ∑ a ∈ cube d N, (((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ)
            + (∑ i, (rtermG u (w1 i) rc1 1 i a + ltermG u (w1 i) lc1 1 i a))
            + ∑ i, (rtermG u (w2 i) rc2 2 i a + ltermG u (w2 i) lc2 2 i a)) :=
          Finset.sum_congr rfl fun a _ => hpt a
      _ = ((∑ a ∈ cube d N, ((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ))
            + ∑ a ∈ cube d N, ∑ i, (rtermG u (w1 i) rc1 1 i a + ltermG u (w1 i) lc1 1 i a))
            + ∑ a ∈ cube d N, ∑ i,
                (rtermG u (w2 i) rc2 2 i a + ltermG u (w2 i) lc2 2 i a) := by
          rw [Finset.sum_add_distrib, Finset.sum_add_distrib]
      _ = ((∑ a ∈ cube d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
            + (∑ i, ∑ a ∈ cube d N, (rtermG u (w1 i) rc1 1 i a + ltermG u (w1 i) lc1 1 i a))
            + ∑ i, ∑ a ∈ cube d N,
                (rtermG u (w2 i) rc2 2 i a + ltermG u (w2 i) lc2 2 i a) := by
          rw [Finset.sum_comm (s := cube d N) (t := Finset.univ),
            Finset.sum_comm (s := cube d N) (t := Finset.univ)]
          push_cast
          ring_nf
  have hEq := hL.symm.trans hR
  have hLim : (z * ((∑ a ∈ cube d N, ‖u a‖ ^ 2 : ℝ) : ℂ)).im
      = z.im * (∑ a ∈ cube d N, ‖u a‖ ^ 2) := by
    rw [Complex.mul_im, Complex.ofReal_im, Complex.ofReal_re, mul_zero, zero_add]
  rw [← hLim, hEq]
  rw [Complex.add_im, Complex.add_im, Complex.ofReal_im, zero_add, Complex.im_sum,
    Complex.im_sum]
  congr 1
  · exact Finset.sum_congr rfl fun i _ =>
      sum_cube_hop_im (lc1_shift i) (fun a ha => lc1_vanish i a ha) N
  · exact Finset.sum_congr rfl fun i _ =>
      sum_cube_hop_im (lc2_shift i) (fun a ha => lc2_vanish i a ha) N

/-! ## 4. The flux bound -/

/-- **The flux bound.**  The flux through a `k`-thick face is at most the amplitude bound
there times the `ℓ²`-mass carried by that face and its shift. -/
theorem flux_boundG {w : ℂ} {rc : (Fin d →₀ ℕ) → Fin d → ℝ} (N : ℕ) (i : Fin d) (k : ℕ)
    {Cn : ℝ} (hCn : 0 ≤ Cn) (hC : ∀ a ∈ faceK d N i k, |rc a i| ≤ Cn) :
    |(∑ a ∈ faceK d N i k, rtermG u w rc k i a).im|
      ≤ Cn * (‖w‖ * ((∑ a ∈ faceK d N i k,
          (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i k)‖ ^ 2)) / 2)) := by
  classical
  have h1 : |(∑ a ∈ faceK d N i k, rtermG u w rc k i a).im|
      ≤ ‖∑ a ∈ faceK d N i k, rtermG u w rc k i a‖ := Complex.abs_im_le_norm _
  have h2 : ‖∑ a ∈ faceK d N i k, rtermG u w rc k i a‖
      ≤ ∑ a ∈ faceK d N i k, ‖rtermG u w rc k i a‖ := norm_sum_le _ _
  have h3 : ∀ a ∈ faceK d N i k, ‖rtermG u w rc k i a‖
      ≤ Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i k)‖ ^ 2) / 2)) := by
    intro a ha
    have hnorm : ‖rtermG u w rc k i a‖
        = ‖w‖ * |rc a i| * ‖u a‖ * ‖u (a + Finsupp.single i k)‖ := by
      rw [rtermG]
      simp [Complex.norm_real]
    have hprod : ‖u a‖ * ‖u (a + Finsupp.single i k)‖
        ≤ (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i k)‖ ^ 2) / 2 := by
      nlinarith [sq_nonneg (‖u a‖ - ‖u (a + Finsupp.single i k)‖)]
    have hrcC := hC a ha
    have hb1 : ‖w‖ * |rc a i| ≤ ‖w‖ * Cn := by
      exact mul_le_mul_of_nonneg_left hrcC (norm_nonneg w)
    rw [hnorm]
    calc ‖w‖ * |rc a i| * ‖u a‖ * ‖u (a + Finsupp.single i k)‖
        = (‖w‖ * |rc a i|) * (‖u a‖ * ‖u (a + Finsupp.single i k)‖) := by ring
      _ ≤ (‖w‖ * Cn) * (‖u a‖ * ‖u (a + Finsupp.single i k)‖) := by
          refine mul_le_mul_of_nonneg_right hb1 ?_
          positivity
      _ ≤ (‖w‖ * Cn) * ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i k)‖ ^ 2) / 2) := by
          refine mul_le_mul_of_nonneg_left hprod ?_
          positivity
      _ = Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i k)‖ ^ 2) / 2)) := by ring
  calc |(∑ a ∈ faceK d N i k, rtermG u w rc k i a).im|
      ≤ ∑ a ∈ faceK d N i k, ‖rtermG u w rc k i a‖ := h1.trans h2
    _ ≤ ∑ a ∈ faceK d N i k,
          Cn * (‖w‖ * ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i k)‖ ^ 2) / 2)) :=
        Finset.sum_le_sum h3
    _ = Cn * (‖w‖ * ((∑ a ∈ faceK d N i k,
          (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i k)‖ ^ 2)) / 2)) := by
        rw [← Finset.mul_sum, ← Finset.mul_sum, Finset.sum_div]

/-! ## 5. Bessel's inequality with multiplicity -/

/-- If every multi-index lies in at most `m` of the sets `G N`, the total mass they carry
is at most `m` times the total mass. -/
theorem sum_range_of_multiplicity {B : ℝ} (m : ℕ)
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (G : ℕ → Finset (Fin d →₀ ℕ))
    (hm : ∀ (a : Fin d →₀ ℕ) (M : ℕ),
      (((Finset.range M).filter (fun N => a ∈ G N)).card) ≤ m)
    (M : ℕ) : ∑ N ∈ Finset.range M, ∑ a ∈ G N, ‖u a‖ ^ 2 ≤ (m : ℝ) * B := by
  classical
  set T : Finset (Fin d →₀ ℕ) := (Finset.range M).biUnion G with hT
  have hsub : ∀ N ∈ Finset.range M, G N ⊆ T := by
    intro N hN a ha
    exact Finset.mem_biUnion.mpr ⟨N, hN, ha⟩
  have hstep1 : ∀ N ∈ Finset.range M,
      ∑ a ∈ G N, ‖u a‖ ^ 2 = ∑ a ∈ T, if a ∈ G N then ‖u a‖ ^ 2 else 0 := by
    intro N hN
    rw [← Finset.sum_filter]
    refine (Finset.sum_congr ?_ fun _ _ => rfl).symm
    ext a
    simp only [Finset.mem_filter]
    exact ⟨fun h => h.2, fun h => ⟨hsub N hN h, h⟩⟩
  have hstep2 : ∀ a : Fin d →₀ ℕ,
      ∑ N ∈ Finset.range M, (if a ∈ G N then ‖u a‖ ^ 2 else 0)
        = (((Finset.range M).filter (fun N => a ∈ G N)).card : ℝ) * ‖u a‖ ^ 2 := by
    intro a
    rw [← Finset.sum_filter, Finset.sum_const, nsmul_eq_mul]
  calc ∑ N ∈ Finset.range M, ∑ a ∈ G N, ‖u a‖ ^ 2
      = ∑ N ∈ Finset.range M, ∑ a ∈ T, (if a ∈ G N then ‖u a‖ ^ 2 else 0) :=
        Finset.sum_congr rfl hstep1
    _ = ∑ a ∈ T, ∑ N ∈ Finset.range M, (if a ∈ G N then ‖u a‖ ^ 2 else 0) := Finset.sum_comm
    _ = ∑ a ∈ T, (((Finset.range M).filter (fun N => a ∈ G N)).card : ℝ) * ‖u a‖ ^ 2 :=
        Finset.sum_congr rfl fun a _ => hstep2 a
    _ ≤ ∑ a ∈ T, (m : ℝ) * ‖u a‖ ^ 2 := by
        refine Finset.sum_le_sum fun a _ => ?_
        refine mul_le_mul_of_nonneg_right ?_ (by positivity)
        exact_mod_cast hm a M
    _ = (m : ℝ) * ∑ a ∈ T, ‖u a‖ ^ 2 := by rw [Finset.mul_sum]
    _ ≤ (m : ℝ) * B := by
        refine mul_le_mul_of_nonneg_left (hbes T) (by positivity)

theorem faceK_multiplicity (i : Fin d) (k : ℕ) (a : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter (fun N => a ∈ faceK d N i k)).card) ≤ k := by
  classical
  have hsub : ((Finset.range M).filter (fun N => a ∈ faceK d N i k))
      ⊆ Finset.Ico (a i) (a i + k) := by
    intro N hN
    simp only [Finset.mem_filter] at hN
    rw [mem_faceK] at hN
    exact Finset.mem_Ico.mpr ⟨hN.2.1 i, hN.2.2⟩
  calc (((Finset.range M).filter (fun N => a ∈ faceK d N i k)).card)
      ≤ (Finset.Ico (a i) (a i + k)).card := Finset.card_le_card hsub
    _ = k := by rw [Nat.card_Ico]; omega

theorem shiftedK_multiplicity (i : Fin d) (k : ℕ) (b : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter
      (fun N => b ∈ (faceK d N i k).image (fun a => a + Finsupp.single i k))).card) ≤ k := by
  classical
  have hsub : ((Finset.range M).filter
        (fun N => b ∈ (faceK d N i k).image (fun a => a + Finsupp.single i k)))
      ⊆ Finset.Ico (b i - k) (b i) := by
    intro N hN
    simp only [Finset.mem_filter, Finset.mem_image] at hN
    obtain ⟨a, ha, hab⟩ := hN.2
    rw [mem_faceK] at ha
    have hbi : b i = a i + k := by
      rw [← hab]; simp
    refine Finset.mem_Ico.mpr ⟨?_, ?_⟩
    · have := ha.1 i; omega
    · have := ha.2; omega
  calc (((Finset.range M).filter
        (fun N => b ∈ (faceK d N i k).image (fun a => a + Finsupp.single i k))).card)
      ≤ (Finset.Ico (b i - k) (b i)).card := Finset.card_le_card hsub
    _ ≤ k := by rw [Nat.card_Ico]; omega

theorem facesK_le {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B) (i : Fin d) (k M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ faceK d N i k, ‖u a‖ ^ 2 ≤ (k : ℝ) * B :=
  sum_range_of_multiplicity k hbes (fun N => faceK d N i k) (faceK_multiplicity i k) M

theorem shifted_facesK_le {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B) (i : Fin d) (k M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ faceK d N i k, ‖u (a + Finsupp.single i k)‖ ^ 2
      ≤ (k : ℝ) * B := by
  classical
  have hinj : ∀ N : ℕ, ∑ a ∈ faceK d N i k, ‖u (a + Finsupp.single i k)‖ ^ 2
      = ∑ b ∈ (faceK d N i k).image (fun a => a + Finsupp.single i k), ‖u b‖ ^ 2 := by
    intro N
    rw [Finset.sum_image]
    intro x _ y _ hxy
    exact add_right_cancel hxy
  simp_rw [hinj]
  exact sum_range_of_multiplicity k hbes
    (fun N => (faceK d N i k).image (fun a => a + Finsupp.single i k))
    (shiftedK_multiplicity i k) M

/-- The Carleman divergence at growth rate `N`: `∑ 1/(N+1) = ∞`. -/
theorem not_summable_inv_natCast_succ : ¬ Summable (fun N : ℕ => ((N : ℝ) + 1)⁻¹) := by
  intro h
  refine Real.not_summable_one_div_natCast ?_
  refine (summable_nat_add_iff 1).mp ?_
  refine h.congr fun N => ?_
  push_cast
  rw [one_div]

/-! ## 6. The criterion -/

/-- **The two-step Carleman criterion.**  A square-summable family satisfying the
two-step recursion, with a real diagonal and constant amplitudes, at a point off the real
axis, vanishes identically. -/
theorem ladder2_eq_zero {B : ℝ} (hz : z.im ≠ 0)
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (hrec : LadderRec2 u lam w1 w2 z) : ∀ a, u a = 0 := by
  classical
  by_contra hcon
  push_neg at hcon
  obtain ⟨a₀, ha₀⟩ := hcon
  -- the boundary mass functional
  set mass : ℕ → Fin d → ℕ → ℝ := fun N i k =>
    (∑ a ∈ faceK d N i k, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i k)‖ ^ 2)) / 2 with hmass
  set A : ℕ → ℝ := fun N =>
    (∑ i, ‖w1 i‖ * mass N i 1) + ∑ i, ‖w2 i‖ * mass N i 2 with hAdef
  have hmass_nonneg : ∀ N i k, 0 ≤ mass N i k := by
    intro N i k
    have hs : 0 ≤ ∑ a ∈ faceK d N i k, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i k)‖ ^ 2) :=
      Finset.sum_nonneg fun a _ => by positivity
    rw [hmass]
    positivity
  have hAnn : ∀ N, 0 ≤ A N := by
    intro N
    have h1 : 0 ≤ ∑ i, ‖w1 i‖ * mass N i 1 :=
      Finset.sum_nonneg fun i _ => mul_nonneg (norm_nonneg _) (hmass_nonneg N i 1)
    have h2 : 0 ≤ ∑ i, ‖w2 i‖ * mass N i 2 :=
      Finset.sum_nonneg fun i _ => mul_nonneg (norm_nonneg _) (hmass_nonneg N i 2)
    rw [hAdef]
    linarith
  -- the total boundary mass is finite
  have hmass_sum : ∀ (i : Fin d) (k M : ℕ),
      ∑ N ∈ Finset.range M, mass N i k ≤ (k : ℝ) * B := by
    intro i k M
    have h1 := facesK_le hbes i k M
    have h2 := shifted_facesK_le hbes i k M
    have hpt : ∀ N : ℕ, mass N i k
        = ((∑ a ∈ faceK d N i k, ‖u a‖ ^ 2)
            + ∑ a ∈ faceK d N i k, ‖u (a + Finsupp.single i k)‖ ^ 2) / 2 := by
      intro N; simp only [hmass]; rw [Finset.sum_add_distrib]
    simp_rw [hpt]
    rw [← Finset.sum_div, Finset.sum_add_distrib]
    linarith
  have hApart : ∀ M, ∑ N ∈ Finset.range M, A N
      ≤ ((∑ i, ‖w1 i‖) * (1 * B)) + (∑ i, ‖w2 i‖) * (2 * B) := by
    intro M
    have hsplit : ∑ N ∈ Finset.range M, A N
        = (∑ N ∈ Finset.range M, ∑ i, ‖w1 i‖ * mass N i 1)
          + ∑ N ∈ Finset.range M, ∑ i, ‖w2 i‖ * mass N i 2 := by
      rw [hAdef, ← Finset.sum_add_distrib]
    have hb : ∀ (k : ℕ) (W : Fin d → ℂ),
        ∑ N ∈ Finset.range M, ∑ i, ‖W i‖ * mass N i k
          ≤ (∑ i, ‖W i‖) * ((k : ℝ) * B) := by
      intro k W
      rw [Finset.sum_comm, Finset.sum_mul]
      refine Finset.sum_le_sum fun i _ => ?_
      calc ∑ N ∈ Finset.range M, ‖W i‖ * mass N i k
          = ‖W i‖ * ∑ N ∈ Finset.range M, mass N i k := by rw [Finset.mul_sum]
        _ ≤ ‖W i‖ * ((k : ℝ) * B) :=
            mul_le_mul_of_nonneg_left (hmass_sum i k M) (norm_nonneg _)
    have h1 := hb 1 w1
    have h2 := hb 2 w2
    rw [hsplit]
    push_cast at h1 h2
    linarith
  have hsummable : Summable A := summable_of_sum_range_le hAnn hApart
  -- the flux bound, with the uniform amplitude bound `2(N+1)`
  have hCn : ∀ N : ℕ, (0 : ℝ) ≤ 2 * ((N : ℝ) + 1) := by intro N; positivity
  have hC1 : ∀ (N : ℕ) (i : Fin d), ∀ a ∈ faceK d N i 1, |rc1 a i| ≤ 2 * ((N : ℝ) + 1) := by
    intro N i a ha
    rw [mem_faceK] at ha
    have hai : ((a i : ℝ)) ≤ (N : ℝ) := by exact_mod_cast ha.1 i
    have h1 : rc1 a i ≤ (N : ℝ) + 1 := by
      rw [rc1]
      have : Real.sqrt ((a i : ℝ) + 1) ≤ Real.sqrt (((N : ℝ) + 1) ^ 2) := by
        refine Real.sqrt_le_sqrt ?_
        nlinarith [Nat.cast_nonneg (α := ℝ) N]
      rwa [Real.sqrt_sq (by positivity)] at this
    rw [abs_of_nonneg (rc1_nonneg a i)]
    linarith
  have hC2 : ∀ (N : ℕ) (i : Fin d), ∀ a ∈ faceK d N i 2, |rc2 a i| ≤ 2 * ((N : ℝ) + 1) := by
    intro N i a ha
    rw [mem_faceK] at ha
    have hai : ((a i : ℝ)) ≤ (N : ℝ) := by exact_mod_cast ha.1 i
    have h1 : rc2 a i ≤ (N : ℝ) + 2 := by
      rw [rc2]
      have : Real.sqrt (((a i : ℝ) + 1) * ((a i : ℝ) + 2)) ≤ Real.sqrt (((N : ℝ) + 2) ^ 2) := by
        refine Real.sqrt_le_sqrt ?_
        nlinarith [Nat.cast_nonneg (α := ℝ) (a i)]
      rwa [Real.sqrt_sq (by positivity)] at this
    rw [abs_of_nonneg (rc2_nonneg a i)]
    have : (0 : ℝ) ≤ (N : ℝ) := Nat.cast_nonneg N
    linarith
  have hkey : ∀ N : ℕ,
      |z.im| * (∑ a ∈ cube d N, ‖u a‖ ^ 2) ≤ (2 * ((N : ℝ) + 1)) * A N := by
    intro N
    have hS : 0 ≤ ∑ a ∈ cube d N, ‖u a‖ ^ 2 := Finset.sum_nonneg fun a _ => by positivity
    have h1 : |z.im| * (∑ a ∈ cube d N, ‖u a‖ ^ 2)
        = |(∑ i, (∑ a ∈ faceK d N i 1, rtermG u (w1 i) rc1 1 i a).im)
            + ∑ i, (∑ a ∈ faceK d N i 2, rtermG u (w2 i) rc2 2 i a).im| := by
      rw [← flux_identity2 hrec N, abs_mul, abs_of_nonneg hS]
    rw [h1]
    have hb1 : |∑ i, (∑ a ∈ faceK d N i 1, rtermG u (w1 i) rc1 1 i a).im|
        ≤ (2 * ((N : ℝ) + 1)) * ∑ i, ‖w1 i‖ * mass N i 1 := by
      calc |∑ i, (∑ a ∈ faceK d N i 1, rtermG u (w1 i) rc1 1 i a).im|
          ≤ ∑ i, |(∑ a ∈ faceK d N i 1, rtermG u (w1 i) rc1 1 i a).im| :=
            Finset.abs_sum_le_sum_abs _ _
        _ ≤ ∑ i, (2 * ((N : ℝ) + 1)) * (‖w1 i‖ * mass N i 1) :=
            Finset.sum_le_sum fun i _ => flux_boundG N i 1 (hCn N) (hC1 N i)
        _ = (2 * ((N : ℝ) + 1)) * ∑ i, ‖w1 i‖ * mass N i 1 := by rw [Finset.mul_sum]
    have hb2 : |∑ i, (∑ a ∈ faceK d N i 2, rtermG u (w2 i) rc2 2 i a).im|
        ≤ (2 * ((N : ℝ) + 1)) * ∑ i, ‖w2 i‖ * mass N i 2 := by
      calc |∑ i, (∑ a ∈ faceK d N i 2, rtermG u (w2 i) rc2 2 i a).im|
          ≤ ∑ i, |(∑ a ∈ faceK d N i 2, rtermG u (w2 i) rc2 2 i a).im| :=
            Finset.abs_sum_le_sum_abs _ _
        _ ≤ ∑ i, (2 * ((N : ℝ) + 1)) * (‖w2 i‖ * mass N i 2) :=
            Finset.sum_le_sum fun i _ => flux_boundG N i 2 (hCn N) (hC2 N i)
        _ = (2 * ((N : ℝ) + 1)) * ∑ i, ‖w2 i‖ * mass N i 2 := by rw [Finset.mul_sum]
    have habs := abs_add_le (∑ i, (∑ a ∈ faceK d N i 1, rtermG u (w1 i) rc1 1 i a).im)
      (∑ i, (∑ a ∈ faceK d N i 2, rtermG u (w2 i) rc2 2 i a).im)
    rw [hAdef]
    simp only
    rw [mul_add]
    linarith
  -- the cube mass is bounded below
  set N₀ : ℕ := Finset.univ.sup (fun i : Fin d => a₀ i) with hN₀
  have hlow : ∀ N : ℕ, N₀ ≤ N → ‖u a₀‖ ^ 2 ≤ ∑ a ∈ cube d N, ‖u a‖ ^ 2 := by
    intro N hN
    refine Finset.single_le_sum (f := fun a => ‖u a‖ ^ 2) (fun a _ => by positivity) ?_
    rw [mem_cube]
    intro i
    exact le_trans (Finset.le_sup (f := fun i : Fin d => a₀ i) (Finset.mem_univ i)) hN
  have hcpos : 0 < |z.im| * ‖u a₀‖ ^ 2 := by
    have h1 : 0 < |z.im| := abs_pos.mpr hz
    have h2 : 0 < ‖u a₀‖ ^ 2 := by
      have : 0 < ‖u a₀‖ := norm_pos_iff.mpr ha₀
      positivity
    positivity
  have hAlow : ∀ N : ℕ, N₀ ≤ N →
      ((|z.im| * ‖u a₀‖ ^ 2) / 2) * ((N : ℝ) + 1)⁻¹ ≤ A N := by
    intro N hN
    have hpos : (0 : ℝ) < 2 * ((N : ℝ) + 1) := by positivity
    have h1 := hkey N
    have h2 := hlow N hN
    have h3 : |z.im| * ‖u a₀‖ ^ 2 ≤ (2 * ((N : ℝ) + 1)) * A N := by
      have := mul_le_mul_of_nonneg_left h2 (abs_nonneg z.im)
      linarith
    have h5 : ((|z.im| * ‖u a₀‖ ^ 2) / 2) * ((N : ℝ) + 1)⁻¹
        = (|z.im| * ‖u a₀‖ ^ 2) / (2 * ((N : ℝ) + 1)) := by
      field_simp
    rw [h5, div_le_iff₀ hpos]
    linarith [h3, mul_comm (2 * ((N : ℝ) + 1)) (A N)]
  have hshift : Summable (fun N : ℕ => A (N + N₀)) := (summable_nat_add_iff N₀).mpr hsummable
  have hcomp : Summable (fun N : ℕ =>
      ((|z.im| * ‖u a₀‖ ^ 2) / 2) * (((N + N₀ : ℕ) : ℝ) + 1)⁻¹) := by
    refine Summable.of_nonneg_of_le (fun N => by positivity) (fun N => ?_) hshift
    exact hAlow (N + N₀) (Nat.le_add_left _ _)
  have h4 : Summable (fun N : ℕ => (((N + N₀ : ℕ) : ℝ) + 1)⁻¹) := by
    have h5 := hcomp.mul_left ((|z.im| * ‖u a₀‖ ^ 2) / 2)⁻¹
    refine h5.congr fun N => ?_
    field_simp
  exact not_summable_inv_natCast_succ ((summable_nat_add_iff N₀).mp h4)

end

end BookProof.CarlemanTwoStep
