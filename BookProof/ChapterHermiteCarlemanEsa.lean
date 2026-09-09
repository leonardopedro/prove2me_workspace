import Mathlib
import BookProof.ChapterQuadratureEsa

/-!
# A Carleman criterion on the product Hermite basis, and the full diagonal quadratic
family with an arbitrary first-order term

`BookProof.ChapterHermiteRelativeBound` proves that the inhomogeneous quadratic
Hamiltonian

`H = ∑ᵢ cᵢ(πᵢ² + xᵢ²/4) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is essentially self-adjoint on the Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`
when the quadratic part is **elliptic** (`cᵢ ≥ c₀ > 0`), by a relative bound; the
shifted-core modules (`ChapterShiftedQuadraticEsa`,
`ChapterShiftedQuadraticMatrixEsa`, `ChapterShiftedQuadraticDegenerate`) remove the sign
and the invertibility conditions by completing the square, but need a *classical
equilibrium* — which does not exist in a direction where the quadratic part vanishes and
both `bᵢ` and `b'ᵢ` are present — and they pay for it by moving to a translated,
modulated core.  `ChapterQuadratureEsa` settles the opposite extreme, `c = 0`, on the
plain core.

This module removes **all** of those restrictions at once, by a different route: a
*Carleman-type criterion* for the coefficient recursion on the multi-index lattice.

## What is proved

* `LadderRec`, `ladder_eq_zero` — **the instrument.**  Let `u : (Fin d →₀ ℕ) → ℂ` be a
  square-summable family (only Bessel's inequality `∑_{a ∈ F} ‖u a‖² ≤ B` on finite sets
  is used) satisfying, for every multi-index `α`, the nearest-neighbour recursion

  `lam α u_α + ∑ᵢ (conj(wᵢ)√(αᵢ+1) u_{α+eᵢ} + wᵢ√αᵢ u_{α−eᵢ}) = z u_α`

  with a **real** diagonal `lam` and constant amplitudes `w`, at a point `z` off the real
  axis.  Then `u = 0`.  The proof is the classical Wronskian/flux argument of Carleman,
  run on cubes `{α : ∀ i, αᵢ ≤ N}` instead of intervals: the interior contributions are
  pairwise conjugate, so the imaginary part of the recursion telescopes to the flux
  through the boundary faces (`flux_identity`), which is bounded by `√(N+1)` times the
  `ℓ²`-mass carried by those faces (`flux_bound`).  The faces are disjoint, so that mass
  is summable, while `∑ 1/√(N+1) = ∞` — a contradiction unless the mass vanishes.

* `mixOp_hermiteCore` — the ladder form of `H` on the product Hermite basis: the
  quadratic part is diagonal with the real symbol `∑ᵢ cᵢ(αᵢ + ½)`, and the first-order
  part raises the `i`-th excitation number with amplitude `wᵢ = bᵢ + ib'ᵢ/2` and lowers
  it with `conj wᵢ`.

* `mixOp_deficiencyTrivialAt`, `mixOp_essentiallySelfAdjoint` — **the headline.**  For
  **arbitrary** real weights `c` (any signs, zeros allowed) and **arbitrary** real
  coefficients `b, b'`, the operator `H_c + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)` is essentially
  self-adjoint on the plain Gauss–polynomial core of `L²(ℝᵈ)`.  No ellipticity, no sign
  condition, no classical equilibrium, and no change of core.

* `mixOp_stone_flow` — the resulting complete unitary Schrödinger flow, by Stone's
  theorem.

* `wave_indefiniteQuadratic_firstOrder_essentiallySelfAdjoint` — the Minkowski corollary:
  `□ + V` with `V(t,x) = (t² − ‖x‖²)/4` plus an arbitrary constant external field and an
  arbitrary constant boost, on the plain core.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.HermiteCarleman

open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

/-! ## 1. The multi-index cube and its faces -/

/-- The cube `{α : ∀ i, αᵢ ≤ N}` of multi-indices, as a finite set. -/
def cube (d N : ℕ) : Finset (Fin d →₀ ℕ) :=
  (Fintype.piFinset fun _ : Fin d => Finset.range (N + 1)).image Finsupp.equivFunOnFinite.symm

theorem mem_cube {d N : ℕ} {a : Fin d →₀ ℕ} : a ∈ cube d N ↔ ∀ i, a i ≤ N := by
  classical
  constructor
  · intro h
    rw [cube, Finset.mem_image] at h
    obtain ⟨f, hf, rfl⟩ := h
    intro i
    have h2 := (Fintype.mem_piFinset.mp hf) i
    have h3 := Nat.lt_succ_iff.mp (Finset.mem_range.mp h2)
    simpa [Finsupp.equivFunOnFinite] using h3
  · intro h
    rw [cube, Finset.mem_image]
    exact ⟨Finsupp.equivFunOnFinite a, Fintype.mem_piFinset.mpr
      (fun i => Finset.mem_range.mpr (Nat.lt_succ_of_le (h i))), by simp⟩

/-- The interior of the cube in the `i`-th direction: the multi-indices which can still
be raised in that direction without leaving the cube. -/
def inn (d N : ℕ) (i : Fin d) : Finset (Fin d →₀ ℕ) :=
  (cube d N).filter (fun a => a i < N)

/-- The `i`-th boundary face of the cube. -/
def face (d N : ℕ) (i : Fin d) : Finset (Fin d →₀ ℕ) :=
  (cube d N).filter (fun a => a i = N)

theorem mem_face {d N : ℕ} {i : Fin d} {a : Fin d →₀ ℕ} :
    a ∈ face d N i ↔ (∀ j, a j ≤ N) ∧ a i = N := by
  classical
  rw [face, Finset.mem_filter, mem_cube]

theorem sub_add_single {d : ℕ} {i : Fin d} {a : Fin d →₀ ℕ} (h : a i ≠ 0) :
    (a - Finsupp.single i 1) + Finsupp.single i 1 = a := by
  ext j
  by_cases hj : j = i
  · subst hj; simp; omega
  · simp [hj]

/-- Reindexing a sum which vanishes on the `i`-th bottom face along the shift `α ↦ α+eᵢ`. -/
theorem sum_shift (d N : ℕ) (i : Fin d) (F : (Fin d →₀ ℕ) → ℂ)
    (hF : ∀ a : Fin d →₀ ℕ, a i = 0 → F a = 0) :
    ∑ a ∈ cube d N, F a = ∑ b ∈ inn d N i, F (b + Finsupp.single i 1) := by
  classical
  rw [← Finset.sum_filter_of_ne (p := fun a : Fin d →₀ ℕ => a i ≠ 0)
    (fun a _ hne => fun h0 => hne (hF a h0))]
  refine Finset.sum_nbij' (fun a => a - Finsupp.single i 1) (fun b => b + Finsupp.single i 1)
    ?_ ?_ ?_ ?_ ?_
  · intro a ha
    simp only [Finset.mem_filter, mem_cube] at ha
    rw [inn, Finset.mem_filter, mem_cube]
    refine ⟨fun j => le_trans (by simp) (ha.1 j), ?_⟩
    have h1 : (a - Finsupp.single i 1 : Fin d →₀ ℕ) i = a i - 1 := by simp
    rw [h1]
    have h2 := ha.1 i
    have h3 := ha.2
    omega
  · intro b hb
    rw [inn, Finset.mem_filter, mem_cube] at hb
    simp only [Finset.mem_filter, mem_cube]
    refine ⟨fun j => ?_, ?_⟩
    · by_cases hj : j = i
      · subst hj; simp; omega
      · simpa [hj] using hb.1 j
    · simp
  · intro a ha
    simp only [Finset.mem_filter] at ha
    exact sub_add_single ha.2
  · intro b _; simp
  · intro a ha
    simp only [Finset.mem_filter] at ha
    rw [sub_add_single ha.2]

/-- The cube is the disjoint union of its `i`-th interior and its `i`-th face. -/
theorem sum_cube_split (d N : ℕ) (i : Fin d) (F : (Fin d →₀ ℕ) → ℂ) :
    ∑ a ∈ cube d N, F a = ∑ a ∈ inn d N i, F a + ∑ a ∈ face d N i, F a := by
  classical
  rw [inn, face, ← Finset.sum_filter_add_sum_filter_not (cube d N) (fun a => a i < N) F]
  congr 1
  refine Finset.sum_congr ?_ fun _ _ => rfl
  ext a
  simp only [Finset.mem_filter, mem_cube]
  constructor
  · rintro ⟨h1, h2⟩; exact ⟨h1, by have := h1 i; omega⟩
  · rintro ⟨h1, h2⟩; exact ⟨h1, by omega⟩

/-! ## 2. The Carleman criterion on the multi-index lattice -/

/-- The raising contribution to the flux at the multi-index `a` in the direction `i`. -/
def rterm (u : (Fin d →₀ ℕ) → ℂ) (amp : Fin d → ℂ) (i : Fin d) (a : Fin d →₀ ℕ) : ℂ :=
  (starRingEnd ℂ) (amp i) * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ)
    * (starRingEnd ℂ) (u a) * u (a + Finsupp.single i 1)

/-- The lowering contribution to the flux at the multi-index `a` in the direction `i`. -/
def lterm (u : (Fin d →₀ ℕ) → ℂ) (amp : Fin d → ℂ) (i : Fin d) (a : Fin d →₀ ℕ) : ℂ :=
  amp i * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ)
    * (starRingEnd ℂ) (u a) * u (a - Finsupp.single i 1)

variable {u : (Fin d →₀ ℕ) → ℂ} {lam : (Fin d →₀ ℕ) → ℝ} {amp : Fin d → ℂ} {z : ℂ}

theorem lterm_shift (i : Fin d) (b : Fin d →₀ ℕ) :
    lterm u amp i (b + Finsupp.single i 1) = (starRingEnd ℂ) (rterm u amp i b) := by
  rw [lterm, rterm]
  simp only [map_mul, Complex.conj_conj, Finsupp.coe_add, Pi.add_apply,
    Finsupp.single_eq_same, Complex.conj_ofReal]
  rw [add_tsub_cancel_right]
  push_cast
  ring

/-- The lowering contributions are exactly the conjugates of the interior raising
contributions: this is the pairwise cancellation that makes the flux a boundary term. -/
theorem sum_lterm (N : ℕ) (i : Fin d) :
    ∑ a ∈ cube d N, lterm u amp i a
      = (starRingEnd ℂ) (∑ a ∈ inn d N i, rterm u amp i a) := by
  rw [sum_shift d N i (lterm u amp i) (fun a ha => by rw [lterm, ha]; simp), map_sum]
  exact Finset.sum_congr rfl fun b _ => lterm_shift i b

/-- The nearest-neighbour recursion satisfied by the Hermite coefficients of a deficiency
vector: a real diagonal `lam`, raising amplitude `conj (amp i) √(αᵢ+1)` and lowering
amplitude `amp i √αᵢ`, at the (non-real) point `z`. -/
def LadderRec (u : (Fin d →₀ ℕ) → ℂ) (lam : (Fin d →₀ ℕ) → ℝ) (amp : Fin d → ℂ) (z : ℂ) :
    Prop :=
  ∀ a : Fin d →₀ ℕ,
    ((lam a : ℝ) : ℂ) * u a
      + ∑ i, ((starRingEnd ℂ) (amp i) * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ)
                * u (a + Finsupp.single i 1)
            + amp i * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) * u (a - Finsupp.single i 1))
      = z * u a

/-- **The flux identity.**  The imaginary part of the recursion, summed over a cube,
telescopes to the flux through the boundary faces. -/
theorem flux_identity (hrec : LadderRec u lam amp z) (N : ℕ) :
    z.im * (∑ a ∈ cube d N, ‖u a‖ ^ 2)
      = ∑ i, (∑ a ∈ face d N i, rterm u amp i a).im := by
  classical
  have hcm : ∀ w : ℂ, (starRingEnd ℂ) w * w = ((‖w‖ ^ 2 : ℝ) : ℂ) := by
    intro w; rw [Complex.conj_mul']; norm_cast
  have hpt : ∀ a : Fin d →₀ ℕ, (starRingEnd ℂ) (u a) * (z * u a)
      = ((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ)
        + ∑ i, (rterm u amp i a + lterm u amp i a) := by
    intro a
    rw [← hrec a, mul_add, Finset.mul_sum]
    congr 1
    · rw [← hcm (u a)]; ring
    · refine Finset.sum_congr rfl fun i _ => ?_
      rw [rterm, lterm]; ring
  have hL : ∑ a ∈ cube d N, (starRingEnd ℂ) (u a) * (z * u a)
      = z * ((∑ a ∈ cube d N, ‖u a‖ ^ 2 : ℝ) : ℂ) := by
    rw [Complex.ofReal_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← hcm (u a)]; ring
  have hR : ∑ a ∈ cube d N, (starRingEnd ℂ) (u a) * (z * u a)
      = ((∑ a ∈ cube d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
        + ∑ i, ((∑ a ∈ inn d N i, rterm u amp i a)
                + (∑ a ∈ face d N i, rterm u amp i a)
                + (starRingEnd ℂ) (∑ a ∈ inn d N i, rterm u amp i a)) := by
    calc ∑ a ∈ cube d N, (starRingEnd ℂ) (u a) * (z * u a)
        = ∑ a ∈ cube d N, (((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ)
            + ∑ i, (rterm u amp i a + lterm u amp i a)) :=
          Finset.sum_congr rfl fun a _ => hpt a
      _ = (∑ a ∈ cube d N, ((lam a : ℝ) : ℂ) * ((‖u a‖ ^ 2 : ℝ) : ℂ))
            + ∑ a ∈ cube d N, ∑ i, (rterm u amp i a + lterm u amp i a) := Finset.sum_add_distrib
      _ = ((∑ a ∈ cube d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
            + ∑ i, ∑ a ∈ cube d N, (rterm u amp i a + lterm u amp i a) := by
          rw [Finset.sum_comm]; push_cast; ring_nf
      _ = ((∑ a ∈ cube d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
            + ∑ i, ((∑ a ∈ inn d N i, rterm u amp i a)
                + (∑ a ∈ face d N i, rterm u amp i a)
                + (starRingEnd ℂ) (∑ a ∈ inn d N i, rterm u amp i a)) := by
          congr 1
          refine Finset.sum_congr rfl fun i _ => ?_
          rw [Finset.sum_add_distrib, sum_cube_split d N i (rterm u amp i), sum_lterm N i]
  have hEq := hL.symm.trans hR
  have hLim : (z * ((∑ a ∈ cube d N, ‖u a‖ ^ 2 : ℝ) : ℂ)).im
      = z.im * (∑ a ∈ cube d N, ‖u a‖ ^ 2) := by
    rw [Complex.mul_im, Complex.ofReal_im, Complex.ofReal_re, mul_zero, zero_add]
  have hRim : (((∑ a ∈ cube d N, lam a * ‖u a‖ ^ 2 : ℝ) : ℂ)
        + ∑ i, ((∑ a ∈ inn d N i, rterm u amp i a)
                + (∑ a ∈ face d N i, rterm u amp i a)
                + (starRingEnd ℂ) (∑ a ∈ inn d N i, rterm u amp i a))).im
      = ∑ i, (∑ a ∈ face d N i, rterm u amp i a).im := by
    rw [Complex.add_im, Complex.ofReal_im, zero_add, Complex.im_sum]
    exact Finset.sum_congr rfl fun x _ => by simp [Complex.add_im]
  rw [← hLim, hEq, hRim]

/-- **The flux bound.**  The flux through a face is at most `√(N+1)` times the `ℓ²`-mass
carried by that face and its shift — the Carleman growth rate. -/
theorem flux_bound (N : ℕ) (i : Fin d) :
    |(∑ a ∈ face d N i, rterm u amp i a).im|
      ≤ Real.sqrt ((N : ℝ) + 1) *
        (‖amp i‖ * ((∑ a ∈ face d N i,
          (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2)) := by
  classical
  have h1 : |(∑ a ∈ face d N i, rterm u amp i a).im| ≤ ‖∑ a ∈ face d N i, rterm u amp i a‖ :=
    Complex.abs_im_le_norm _
  have h2 : ‖∑ a ∈ face d N i, rterm u amp i a‖ ≤ ∑ a ∈ face d N i, ‖rterm u amp i a‖ :=
    norm_sum_le _ _
  have h3 : ∀ a ∈ face d N i, ‖rterm u amp i a‖
      ≤ Real.sqrt ((N : ℝ) + 1) * (‖amp i‖ *
          ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2)) := by
    intro a ha
    rw [mem_face] at ha
    have hai : ((a i : ℝ)) = (N : ℝ) := by rw [ha.2]
    have hnorm : ‖rterm u amp i a‖
        = ‖amp i‖ * Real.sqrt ((N : ℝ) + 1) * ‖u a‖ * ‖u (a + Finsupp.single i 1)‖ := by
      rw [rterm, hai]
      simp [abs_of_nonneg (Real.sqrt_nonneg ((N : ℝ) + 1))]
    have hprod : ‖u a‖ * ‖u (a + Finsupp.single i 1)‖
        ≤ (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2 := by
      nlinarith [sq_nonneg (‖u a‖ - ‖u (a + Finsupp.single i 1)‖)]
    have hstep := mul_le_mul_of_nonneg_left hprod
      (mul_nonneg (norm_nonneg (amp i)) (Real.sqrt_nonneg ((N : ℝ) + 1)))
    rw [hnorm]
    calc ‖amp i‖ * Real.sqrt ((N : ℝ) + 1) * ‖u a‖ * ‖u (a + Finsupp.single i 1)‖
        = (‖amp i‖ * Real.sqrt ((N : ℝ) + 1)) * (‖u a‖ * ‖u (a + Finsupp.single i 1)‖) := by
          ring
      _ ≤ (‖amp i‖ * Real.sqrt ((N : ℝ) + 1))
            * ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2) := hstep
      _ = Real.sqrt ((N : ℝ) + 1)
            * (‖amp i‖ * ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2)) := by ring
  calc |(∑ a ∈ face d N i, rterm u amp i a).im|
      ≤ ∑ a ∈ face d N i, ‖rterm u amp i a‖ := h1.trans h2
    _ ≤ ∑ a ∈ face d N i, Real.sqrt ((N : ℝ) + 1) * (‖amp i‖ *
          ((‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2)) := Finset.sum_le_sum h3
    _ = Real.sqrt ((N : ℝ) + 1) * (‖amp i‖ * ((∑ a ∈ face d N i,
          (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2)) := by
        rw [← Finset.mul_sum, ← Finset.mul_sum, Finset.sum_div]

/-- Bessel's inequality over a pairwise disjoint family of finite sets. -/
theorem sum_range_of_disjoint {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (G : ℕ → Finset (Fin d →₀ ℕ)) (hd : ∀ M N : ℕ, M ≠ N → Disjoint (G M) (G N)) (M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ G N, ‖u a‖ ^ 2 ≤ B := by
  classical
  rw [← Finset.sum_biUnion (fun x _ y _ hxy => hd x y hxy)]
  exact hbes _

theorem faces_le {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B) (i : Fin d) (M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ face d N i, ‖u a‖ ^ 2 ≤ B := by
  refine sum_range_of_disjoint hbes (fun N => face d N i) (fun M N hMN => ?_) M
  rw [Finset.disjoint_left]
  intro a haM haN
  rw [mem_face] at haM haN
  exact hMN (haM.2 ▸ haN.2 ▸ rfl)

theorem shifted_faces_le {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B) (i : Fin d) (M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ face d N i, ‖u (a + Finsupp.single i 1)‖ ^ 2 ≤ B := by
  classical
  have hinj : ∀ N : ℕ, ∑ a ∈ face d N i, ‖u (a + Finsupp.single i 1)‖ ^ 2
      = ∑ b ∈ (face d N i).image (fun a => a + Finsupp.single i 1), ‖u b‖ ^ 2 := by
    intro N
    rw [Finset.sum_image]
    intro x _ y _ hxy
    exact add_right_cancel hxy
  simp_rw [hinj]
  refine sum_range_of_disjoint hbes
    (fun N => (face d N i).image (fun a => a + Finsupp.single i 1)) (fun M N hMN => ?_) M
  rw [Finset.disjoint_left]
  intro b hbM hbN
  rw [Finset.mem_image] at hbM hbN
  obtain ⟨x, hx, rfl⟩ := hbM
  obtain ⟨y, hy, hxy⟩ := hbN
  rw [mem_face] at hx hy
  have hxyi : x i = y i := by
    have h := congrArg (fun f : Fin d →₀ ℕ => f i) hxy
    simp at h
    omega
  exact hMN (by rw [← hx.2, ← hy.2, hxyi])

/-- The Carleman divergence: `∑ 1/√(N+1) = ∞`. -/
theorem not_summable_inv_sqrt : ¬ Summable (fun N : ℕ => (Real.sqrt ((N : ℝ) + 1))⁻¹) := by
  intro h
  have h2 : Summable (fun N : ℕ => 1 / ((N : ℝ) + 1)) := by
    refine Summable.of_nonneg_of_le (fun N => by positivity) (fun N => ?_) h
    rw [one_div, inv_le_inv₀ (by positivity) (by positivity)]
    nlinarith [Real.sq_sqrt (by positivity : (0 : ℝ) ≤ (N : ℝ) + 1), Real.sqrt_nonneg ((N : ℝ) + 1)]
  refine Real.not_summable_one_div_natCast ?_
  refine (summable_nat_add_iff 1).mp ?_
  simpa using h2

/-- **The Carleman criterion on the multi-index lattice.**  A square-summable family
satisfying the nearest-neighbour recursion with a real diagonal and constant amplitudes,
at a non-real point, vanishes. -/
theorem ladder_eq_zero {B : ℝ} (hz : z.im ≠ 0)
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (hrec : LadderRec u lam amp z) : ∀ a, u a = 0 := by
  classical
  by_contra hcon
  push_neg at hcon
  obtain ⟨a₀, ha₀⟩ := hcon
  set A : ℕ → ℝ := fun N => ∑ i, ‖amp i‖ *
    ((∑ a ∈ face d N i, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2) with hAdef
  have hAnn : ∀ N, 0 ≤ A N := by
    intro N
    refine Finset.sum_nonneg fun i _ => ?_
    have hs : 0 ≤ ∑ a ∈ face d N i, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2) :=
      Finset.sum_nonneg fun a _ => by positivity
    positivity
  have hApart : ∀ M, ∑ N ∈ Finset.range M, A N ≤ (∑ i, ‖amp i‖) * B := by
    intro M
    rw [hAdef, Finset.sum_comm, Finset.sum_mul]
    refine Finset.sum_le_sum fun i _ => ?_
    have h1 := faces_le hbes i M
    have h2 := shifted_faces_le hbes i M
    have hsplit : ∑ N ∈ Finset.range M,
          ((∑ a ∈ face d N i, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2) ≤ B := by
      have hpt : ∀ N : ℕ, (∑ a ∈ face d N i,
            (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2
          = ((∑ a ∈ face d N i, ‖u a‖ ^ 2)
              + ∑ a ∈ face d N i, ‖u (a + Finsupp.single i 1)‖ ^ 2) / 2 := by
        intro N; rw [Finset.sum_add_distrib]
      simp_rw [hpt]
      rw [← Finset.sum_div, Finset.sum_add_distrib]
      linarith
    calc ∑ N ∈ Finset.range M, ‖amp i‖ *
          ((∑ a ∈ face d N i, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2)
        = ‖amp i‖ * ∑ N ∈ Finset.range M,
            ((∑ a ∈ face d N i, (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2) := by
          rw [Finset.mul_sum]
      _ ≤ ‖amp i‖ * B := mul_le_mul_of_nonneg_left hsplit (norm_nonneg _)
  have hsummable : Summable A := summable_of_sum_range_le hAnn hApart
  have hkey : ∀ N : ℕ, |z.im| * (∑ a ∈ cube d N, ‖u a‖ ^ 2) ≤ Real.sqrt ((N : ℝ) + 1) * A N := by
    intro N
    have hS : 0 ≤ ∑ a ∈ cube d N, ‖u a‖ ^ 2 := Finset.sum_nonneg fun a _ => by positivity
    have h1 : |z.im| * (∑ a ∈ cube d N, ‖u a‖ ^ 2)
        = |∑ i, (∑ a ∈ face d N i, rterm u amp i a).im| := by
      rw [← flux_identity hrec N, abs_mul, abs_of_nonneg hS]
    rw [h1]
    calc |∑ i, (∑ a ∈ face d N i, rterm u amp i a).im|
        ≤ ∑ i, |(∑ a ∈ face d N i, rterm u amp i a).im| := Finset.abs_sum_le_sum_abs _ _
      _ ≤ ∑ i, Real.sqrt ((N : ℝ) + 1) * (‖amp i‖ * ((∑ a ∈ face d N i,
            (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i 1)‖ ^ 2)) / 2)) :=
          Finset.sum_le_sum fun i _ => flux_bound N i
      _ = Real.sqrt ((N : ℝ) + 1) * A N := by rw [hAdef, Finset.mul_sum]
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
      (|z.im| * ‖u a₀‖ ^ 2) * (Real.sqrt ((N : ℝ) + 1))⁻¹ ≤ A N := by
    intro N hN
    have hsq : 0 < Real.sqrt ((N : ℝ) + 1) := Real.sqrt_pos.mpr (by positivity)
    have h1 := hkey N
    have h2 := hlow N hN
    have h3 : |z.im| * ‖u a₀‖ ^ 2 ≤ Real.sqrt ((N : ℝ) + 1) * A N := by
      have := mul_le_mul_of_nonneg_left h2 (abs_nonneg z.im)
      linarith
    rw [mul_inv_le_iff₀ hsq]
    linarith [h3]
  have hshift : Summable (fun N : ℕ => A (N + N₀)) := (summable_nat_add_iff N₀).mpr hsummable
  have hcomp : Summable (fun N : ℕ =>
      (|z.im| * ‖u a₀‖ ^ 2) * (Real.sqrt (((N + N₀ : ℕ) : ℝ) + 1))⁻¹) := by
    refine Summable.of_nonneg_of_le (fun N => by positivity) (fun N => ?_) hshift
    exact hAlow (N + N₀) (Nat.le_add_left _ _)
  have h4 : Summable (fun N : ℕ => (Real.sqrt (((N + N₀ : ℕ) : ℝ) + 1))⁻¹) := by
    have h5 := hcomp.mul_left (|z.im| * ‖u a₀‖ ^ 2)⁻¹
    refine h5.congr fun N => ?_
    field_simp
  exact not_summable_inv_sqrt ((summable_nat_add_iff N₀).mp h4)

/-! ## 3. The inhomogeneous quadratic Hamiltonian on the Hermite core -/

/-- The inhomogeneous quadratic Hamiltonian `H_c + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)` on the
Gauss–polynomial core. -/
def mixOp (c b b' : Fin d → ℝ) : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  quadOp c + foOp b b'

/-- **The ladder form of the Hamiltonian on the product Hermite basis.** -/
theorem mixOp_hermiteCore (c b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    mixOp c b b' (hermiteCore a)
      = ((quadSymbol c a : ℝ) : ℂ) • hermiteMvLp a
        + ∑ i, ((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
                  • hermiteMvLp (a + Finsupp.single i 1)
                + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
                  • hermiteMvLp (a - Finsupp.single i 1)) := by
  have hmem : hermiteMvLp (d := d) a ∈ polyGaussCore (d := d) := hermiteMvLp_mem_core a
  rw [mixOp, LinearMap.add_apply, foOp_hermiteCore, ← hermiteCore_eq a hmem,
    quadOp_hermiteMvLp c a hmem]

set_option maxHeartbeats 1600000 in
-- the core coercions make the elaboration of the deficiency computation expensive
/-- **The deficiency spaces vanish at every non-real point**, for arbitrary real weights
and arbitrary real first-order coefficients. -/
theorem mixOp_deficiencyTrivialAt (c b b' : Fin d → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (mixOp c b b') z := by
  classical
  intro w hw
  set u : (Fin d →₀ ℕ) → ℂ := fun a => (inner ℂ (hermiteMvLp (d := d) a) w : ℂ) with hu
  have hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ ‖w‖ ^ 2 := fun F =>
    Orthonormal.sum_inner_products_le (𝕜 := ℂ) w (orthonormal_hermiteMvLp (d := d))
  have hrec : LadderRec u (quadSymbol c) (foAmp b b') z := by
    intro a
    have h := hw (hermiteCore a)
    rw [mixOp_hermiteCore c b b' a, inner_add_left, inner_smul_left, Complex.conj_ofReal,
      sum_inner] at h
    rw [hermiteCore_coe] at h
    have hterm : ∀ i : Fin d,
        (inner ℂ (((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
              • hermiteMvLp (d := d) (a + Finsupp.single i 1)
            + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
              • hermiteMvLp (d := d) (a - Finsupp.single i 1))) w : ℂ)
        = (starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ)
            * u (a + Finsupp.single i 1)
          + foAmp b b' i * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) * u (a - Finsupp.single i 1) := by
      intro i
      rw [inner_add_left, inner_smul_left, inner_smul_left]
      simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal, hu]
    rw [Finset.sum_congr rfl (fun i _ => hterm i)] at h
    exact h
  have hzero : ∀ a, u a = 0 := ladder_eq_zero hz hbes hrec
  exact hermiteMvLp_total w fun a => hzero a

/-- **HEADLINE.**  For *arbitrary* real weights `c` — any signs, zeros allowed — and
*arbitrary* real coefficients `b, b'`, the operator

`H = ∑ᵢ cᵢ(πᵢ² + xᵢ²/4) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is essentially self-adjoint on the Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`.
No ellipticity, no sign condition, no classical equilibrium, and no change of core. -/
theorem mixOp_essentiallySelfAdjoint (c b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (mixOp c b b') :=
  ⟨mixOp_deficiencyTrivialAt c b b' (by simp), mixOp_deficiencyTrivialAt c b b' (by simp)⟩

set_option maxHeartbeats 1600000 in
-- the core coercions make the elaboration of this identity expensive
/-- The Hamiltonian is symmetric on the core. -/
theorem mixOp_symmetric (c b b' : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (mixOp c b b') := by
  intro x y
  rw [mixOp, LinearMap.add_apply, LinearMap.add_apply, inner_add_left, inner_add_right,
    quadOp_symmetric c x y, foOp_symmetric b b' x y]

/-- **The complete unitary flow.**  Stone's theorem applied to the closure of the
Hamiltonian. -/
theorem mixOp_stone_flow (c b b' : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (mixOp c b b') T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (mixOp_symmetric c b b')
    (mixOp_essentiallySelfAdjoint c b b')

/-- **The Minkowski corollary.**  In the convention `□ = −∂_t² + Δ_x` this is `□ + V`
with the indefinite quadratic potential `V(t,x) = (t² − ‖x‖²)/4`, plus an arbitrary
constant external field `∑ᵢ bᵢxᵢ` and an arbitrary constant boost `∑ᵢ b'ᵢπᵢ`, on the plain
Gauss–polynomial core. -/
theorem wave_indefiniteQuadratic_firstOrder_essentiallySelfAdjoint (n : ℕ)
    (b b' : Fin (1 + n) → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 1 + n)) (mixOp (minkowskiCoeff n) b b') :=
  mixOp_essentiallySelfAdjoint _ b b'

end

end BookProof.HermiteCarleman
