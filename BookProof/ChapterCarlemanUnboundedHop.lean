import Mathlib
import BookProof.ChapterNavierStokesDeficiency
import BookProof.ChapterStoneBridge

/-!
# A flux (Carleman) criterion for lattice operators with **unbounded hops**

Placeholder header; filled in once the mathematics is in place.
-/

namespace BookProof.CarlemanUnboundedHop

open Finset

noncomputable section

/-! ## 1. The kernel, the recursion and the flux across a cut -/

/-- A Hermitian matrix kernel on the lattice `ℕ`. -/
def IsHermitianKernel (a : ℕ → ℕ → ℂ) : Prop :=
  ∀ n k, a k n = (starRingEnd ℂ) (a n k)

/-- The deficiency recursion `∑ₖ a n k u k = z uₙ` for a kernel with (absolutely)
convergent rows. -/
structure LadderRecInf (a : ℕ → ℕ → ℂ) (u : ℕ → ℂ) (z : ℂ) : Prop where
  row : ∀ n, Summable fun k => a n k * u k
  eqn : ∀ n, ∑' k, a n k * u k = z * u n

/-- The **flux** of `u` through the cut separating `{0, …, N}` from `{N+1, …}`. -/
def flux (a : ℕ → ℕ → ℂ) (u : ℕ → ℂ) (N : ℕ) : ℂ :=
  ∑ n ∈ range (N + 1),
    (starRingEnd ℂ) (u n) * ∑' i : ℕ, a n (i + (N + 1)) * u (i + (N + 1))

/-- The interior contributions cancel: the finite Hermitian quadratic form is real. -/
theorem inner_block_im_eq_zero (a : ℕ → ℕ → ℂ) (u : ℕ → ℂ) (hherm : IsHermitianKernel a)
    (N : ℕ) :
    (∑ n ∈ range (N + 1), (starRingEnd ℂ) (u n) *
        ∑ k ∈ range (N + 1), a n k * u k).im = 0 := by
  set Q : ℂ := ∑ n ∈ range (N + 1), (starRingEnd ℂ) (u n) * ∑ k ∈ range (N + 1), a n k * u k
    with hQ
  have hexp : Q = ∑ n ∈ range (N + 1), ∑ k ∈ range (N + 1),
      (starRingEnd ℂ) (u n) * (a n k * u k) := by
    rw [hQ]; simp [Finset.mul_sum]
  have hconj : (starRingEnd ℂ) Q = Q := by
    rw [hexp]
    simp only [map_sum, map_mul, Complex.conj_conj]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun n _ => Finset.sum_congr rfl fun k _ => ?_
    rw [hherm, Complex.conj_conj]
    ring
  have := Complex.conj_eq_iff_im.mp hconj
  simpa [hQ] using this

/-- **The flux identity.**  For a Hermitian kernel and a solution of the recursion at
`z`, the imaginary part of the flux through the cut at `N` equals `Im z` times the mass
retained on `{0, …, N}`. -/
theorem flux_identity {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {z : ℂ} (hherm : IsHermitianKernel a)
    (hrec : LadderRecInf a u z) (N : ℕ) :
    z.im * ∑ n ∈ range (N + 1), ‖u n‖ ^ 2 = (flux a u N).im := by
  have hsplit : ∀ n, z * u n
      = (∑ k ∈ range (N + 1), a n k * u k)
        + ∑' i : ℕ, a n (i + (N + 1)) * u (i + (N + 1)) := by
    intro n
    rw [← hrec.eqn n, ← (hrec.row n).sum_add_tsum_nat_add (N + 1)]
  have hL : ∑ n ∈ range (N + 1), (starRingEnd ℂ) (u n) * (z * u n)
      = z * ((∑ n ∈ range (N + 1), ‖u n‖ ^ 2 : ℝ) : ℂ) := by
    push_cast
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun n _ => ?_
    have h1 : (starRingEnd ℂ) (u n) * u n = ((‖u n‖ ^ 2 : ℝ) : ℂ) := by
      rw [mul_comm, Complex.mul_conj]
      norm_cast
      simp [Complex.normSq_eq_norm_sq]
    push_cast at h1
    rw [show (starRingEnd ℂ) (u n) * (z * u n) = z * ((starRingEnd ℂ) (u n) * u n) by ring, h1]
  have hL2 : ∑ n ∈ range (N + 1), (starRingEnd ℂ) (u n) * (z * u n)
      = (∑ n ∈ range (N + 1), (starRingEnd ℂ) (u n) * ∑ k ∈ range (N + 1), a n k * u k)
        + flux a u N := by
    rw [flux, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [hsplit n, mul_add]
  have him := congrArg Complex.im (hL.symm.trans hL2)
  rw [Complex.add_im, inner_block_im_eq_zero a u hherm N, zero_add] at him
  rw [← him, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im]
  ring

/-- If the flux through arbitrarily late cuts is arbitrarily small, a solution of the
recursion at a non-real point vanishes. -/
theorem eq_zero_of_flux_small {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {z : ℂ} (hz : z.im ≠ 0)
    (hherm : IsHermitianKernel a) (hrec : LadderRecInf a u z)
    (hsmall : ∀ ε > 0, ∀ N₀ : ℕ, ∃ N, N₀ ≤ N ∧ ‖flux a u N‖ < ε) :
    ∀ n, u n = 0 := by
  have key : ∀ M : ℕ, ∑ n ∈ range (M + 1), ‖u n‖ ^ 2 ≤ 0 := by
    intro M
    by_contra hpos
    push_neg at hpos
    set S := ∑ n ∈ range (M + 1), ‖u n‖ ^ 2 with hS
    obtain ⟨N, hMN, hflux⟩ := hsmall (|z.im| * S) (by positivity) M
    have hmono : S ≤ ∑ n ∈ range (N + 1), ‖u n‖ ^ 2 := by
      refine Finset.sum_le_sum_of_subset_of_nonneg ?_ (fun n _ _ => by positivity)
      intro x hx
      simp only [Finset.mem_range] at hx ⊢
      omega
    have hid := flux_identity hherm hrec N
    have h1 : |z.im| * S ≤ |z.im * ∑ n ∈ range (N + 1), ‖u n‖ ^ 2| := by
      rw [abs_mul]
      have hnn : 0 ≤ ∑ n ∈ range (N + 1), ‖u n‖ ^ 2 :=
        Finset.sum_nonneg fun n _ => by positivity
      rw [abs_of_nonneg hnn]
      exact mul_le_mul_of_nonneg_left hmono (abs_nonneg _)
    have h2 : |z.im * ∑ n ∈ range (N + 1), ‖u n‖ ^ 2| ≤ ‖flux a u N‖ := by
      rw [hid]
      exact Complex.abs_im_le_norm _
    linarith
  intro n
  have h := key n
  have hnn : 0 ≤ ∑ m ∈ range (n + 1), ‖u m‖ ^ 2 := Finset.sum_nonneg fun m _ => by positivity
  have hzero : ∑ m ∈ range (n + 1), ‖u m‖ ^ 2 = 0 := le_antisymm h hnn
  have := (Finset.sum_eq_zero_iff_of_nonneg (fun m _ => by positivity)).mp hzero n
    (Finset.self_mem_range_succ n)
  simpa using this

/-! ## 2. The flux bound for a kernel with decaying hops -/

section Bound

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

/-- The boundary mass carried by the cut at `N`: the `ℓ²`-mass on either side of the
cut, weighted by the tail `Θ` of the hop profile. -/
def cutMass (u : ℕ → ℂ) (Θ : ℕ → ℝ) (N : ℕ) : ℝ :=
  ∑ n ∈ range (N + 1), Θ (N - n) * ‖u n‖ ^ 2 + ∑' i : ℕ, Θ i * ‖u (i + (N + 1))‖ ^ 2

/-- Each hop weight is at most the tail it belongs to. -/
theorem theta_le_Theta (hθ0 : ∀ r, 0 ≤ θ r)
    (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j)) (j i : ℕ) : θ (i + j + 1) ≤ Θ j :=
  le_hasSum (hΘ j) i fun _ _ => hθ0 _

theorem Theta_nonneg (hθ0 : ∀ r, 0 ≤ θ r)
    (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j)) (j : ℕ) : 0 ≤ Θ j :=
  le_trans (hθ0 _) (theta_le_Theta hθ0 hΘ j 0)

/-- The tails of a nonnegative hop profile decrease. -/
theorem Theta_succ_le (hθ0 : ∀ r, 0 ≤ θ r)
    (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j)) (j : ℕ) : Θ (j + 1) ≤ Θ j := by
  have h := (hΘ j).summable.tsum_eq_zero_add
  rw [(hΘ j).tsum_eq] at h
  have h2 : ∑' b : ℕ, θ (b + 1 + j + 1) = Θ (j + 1) := by
    rw [← (hΘ (j + 1)).tsum_eq]
    exact tsum_congr fun b => by congr 1; omega
  rw [h2] at h
  have := hθ0 (0 + j + 1)
  linarith

theorem Theta_antitone (hθ0 : ∀ r, 0 ≤ θ r)
    (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j)) : Antitone Θ := by
  refine antitone_nat_of_succ_le fun j => Theta_succ_le hθ0 hΘ j

set_option maxHeartbeats 1000000 in
-- The proof re-associates a double sum over the cut and interleaves several `tsum`
-- comparison steps; the default heartbeat budget is not enough for the `Summable`
-- side conditions discharged along the way.
/-- **The flux bound.**  If the hop from `n` to `k > n` has modulus at most
`A n · θ (k − n)` with `A` nondecreasing and `θ` a hop profile with tails `Θ`, then the
flux through the cut at `N` is at most `A N` times the boundary mass there. -/
theorem two_norm_flux_le (hu : Summable fun n => ‖u n‖ ^ 2)
    (hθ0 : ∀ r, 0 ≤ θ r) (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j))
    (hA0 : ∀ n, 0 ≤ A n) (hAmono : Monotone A)
    (hbd : ∀ n k, n < k → ‖a n k‖ ≤ A n * θ (k - n)) (N : ℕ) :
    2 * ‖flux a u N‖ ≤ A N * cutMass u Θ N := by
  have hushift : Summable (fun i : ℕ => ‖u (i + (N + 1))‖ ^ 2) :=
    (summable_nat_add_iff (N + 1)).mpr hu
  -- the summability of the tail series, row by row
  have hsθu : ∀ j : ℕ, Summable (fun i : ℕ => θ (i + j + 1) * ‖u (i + (N + 1))‖ ^ 2) := by
    intro j
    refine Summable.of_nonneg_of_le (fun i => mul_nonneg (hθ0 _) (by positivity)) (fun i => ?_)
      (hushift.mul_left (Θ j))
    exact mul_le_mul_of_nonneg_right (theta_le_Theta hθ0 hΘ j i) (by positivity)
  have habs : ∀ n ∈ range (N + 1),
      Summable (fun i : ℕ => ‖a n (i + (N + 1))‖ * ‖u (i + (N + 1))‖) := by
    intro n hn
    rw [Finset.mem_range] at hn
    have hmaj : Summable (fun i : ℕ =>
        A N * (θ (i + (N - n) + 1) + θ (i + (N - n) + 1) * ‖u (i + (N + 1))‖ ^ 2) / 2) := by
      have := (((hΘ (N - n)).summable).add (hsθu (N - n))).mul_left (A N)
      simpa [mul_div_assoc, mul_add] using this.div_const 2
    refine Summable.of_nonneg_of_le (fun i => by positivity) (fun i => ?_) hmaj
    have hlt : n < i + (N + 1) := by omega
    have hidx : i + (N + 1) - n = i + (N - n) + 1 := by omega
    have hb := hbd n (i + (N + 1)) hlt
    rw [hidx] at hb
    have hAn : A n ≤ A N := hAmono (by omega)
    have hθn : 0 ≤ θ (i + (N - n) + 1) := hθ0 _
    have hun : 0 ≤ ‖u (i + (N + 1))‖ := norm_nonneg _
    have hAN : 0 ≤ A N := hA0 N
    have hb2 : ‖a n (i + (N + 1))‖ ≤ A N * θ (i + (N - n) + 1) :=
      hb.trans (mul_le_mul_of_nonneg_right hAn hθn)
    nlinarith [mul_nonneg (mul_nonneg hAN hθn) (sq_nonneg (‖u (i + (N + 1))‖ - 1)),
      mul_le_mul_of_nonneg_right hb2 hun]
  -- the row estimate
  have key : ∀ n ∈ range (N + 1),
      2 * (‖u n‖ * ‖∑' i : ℕ, a n (i + (N + 1)) * u (i + (N + 1))‖)
        ≤ A N * (Θ (N - n) * ‖u n‖ ^ 2
            + ∑' i : ℕ, θ (i + (N - n) + 1) * ‖u (i + (N + 1))‖ ^ 2) := by
    intro n hn
    have hn' : n ≤ N := by simpa [Finset.mem_range, Nat.lt_succ_iff] using hn
    have habsn := habs n hn
    have hnorm : ‖∑' i : ℕ, a n (i + (N + 1)) * u (i + (N + 1))‖
        ≤ ∑' i : ℕ, ‖a n (i + (N + 1))‖ * ‖u (i + (N + 1))‖ := by
      have := norm_tsum_le_tsum_norm (f := fun i : ℕ => a n (i + (N + 1)) * u (i + (N + 1)))
        (by simpa [norm_mul] using habsn)
      simpa [norm_mul] using this
    have hstep1 : 2 * (‖u n‖ * ‖∑' i : ℕ, a n (i + (N + 1)) * u (i + (N + 1))‖)
        ≤ 2 * (‖u n‖ * ∑' i : ℕ, ‖a n (i + (N + 1))‖ * ‖u (i + (N + 1))‖) := by
      have := mul_le_mul_of_nonneg_left hnorm (norm_nonneg (u n))
      linarith
    have hmul : 2 * (‖u n‖ * ∑' i : ℕ, ‖a n (i + (N + 1))‖ * ‖u (i + (N + 1))‖)
        = ∑' i : ℕ, 2 * (‖u n‖ * (‖a n (i + (N + 1))‖ * ‖u (i + (N + 1))‖)) := by
      rw [← habsn.tsum_mul_left, ← (habsn.mul_left ‖u n‖).tsum_mul_left]
    have hterm : ∀ i : ℕ, 2 * (‖u n‖ * (‖a n (i + (N + 1))‖ * ‖u (i + (N + 1))‖))
        ≤ A N * (θ (i + (N - n) + 1) * ‖u n‖ ^ 2
            + θ (i + (N - n) + 1) * ‖u (i + (N + 1))‖ ^ 2) := by
      intro i
      have hlt : n < i + (N + 1) := by omega
      have hidx : i + (N + 1) - n = i + (N - n) + 1 := by omega
      have hb := hbd n (i + (N + 1)) hlt
      rw [hidx] at hb
      have hAn : A n ≤ A N := hAmono hn'
      have hθn : 0 ≤ θ (i + (N - n) + 1) := hθ0 _
      have hun : 0 ≤ ‖u (i + (N + 1))‖ := norm_nonneg _
      have hun0 : 0 ≤ ‖u n‖ := norm_nonneg _
      have hAN : 0 ≤ A N := hA0 N
      have hb2 : ‖a n (i + (N + 1))‖ ≤ A N * θ (i + (N - n) + 1) :=
        hb.trans (mul_le_mul_of_nonneg_right hAn hθn)
      nlinarith [mul_nonneg (mul_nonneg hAN hθn) (sq_nonneg (‖u n‖ - ‖u (i + (N + 1))‖)),
        mul_le_mul_of_nonneg_right hb2 (mul_nonneg hun0 hun)]
    have hrhs_sum : Summable (fun i : ℕ => A N * (θ (i + (N - n) + 1) * ‖u n‖ ^ 2
        + θ (i + (N - n) + 1) * ‖u (i + (N + 1))‖ ^ 2)) :=
      ((((hΘ (N - n)).summable).mul_right (‖u n‖ ^ 2)).add (hsθu (N - n))).mul_left (A N)
    have hstep2 : ∑' i : ℕ, 2 * (‖u n‖ * (‖a n (i + (N + 1))‖ * ‖u (i + (N + 1))‖))
        ≤ ∑' i : ℕ, A N * (θ (i + (N - n) + 1) * ‖u n‖ ^ 2
            + θ (i + (N - n) + 1) * ‖u (i + (N + 1))‖ ^ 2) :=
      Summable.tsum_mono ((habsn.mul_left ‖u n‖).mul_left 2) hrhs_sum hterm
    have hstep3 : ∑' i : ℕ, A N * (θ (i + (N - n) + 1) * ‖u n‖ ^ 2
            + θ (i + (N - n) + 1) * ‖u (i + (N + 1))‖ ^ 2)
        = A N * (Θ (N - n) * ‖u n‖ ^ 2
            + ∑' i : ℕ, θ (i + (N - n) + 1) * ‖u (i + (N + 1))‖ ^ 2) := by
      rw [tsum_mul_left, Summable.tsum_add
        (((hΘ (N - n)).summable).mul_right (‖u n‖ ^ 2)) (hsθu (N - n)),
        tsum_mul_right, (hΘ (N - n)).tsum_eq]
    linarith [hstep1, hmul ▸ hstep1, hstep2, hstep3]
  -- assemble
  have hflux1 : ‖flux a u N‖
      ≤ ∑ n ∈ range (N + 1), ‖u n‖ * ‖∑' i : ℕ, a n (i + (N + 1)) * u (i + (N + 1))‖ := by
    refine (norm_sum_le _ _).trans (le_of_eq (Finset.sum_congr rfl fun n _ => ?_))
    rw [norm_mul, RCLike.norm_conj]
  have hflux2 : 2 * ‖flux a u N‖
      ≤ ∑ n ∈ range (N + 1), A N * (Θ (N - n) * ‖u n‖ ^ 2
          + ∑' i : ℕ, θ (i + (N - n) + 1) * ‖u (i + (N + 1))‖ ^ 2) := by
    have h2 : 2 * ‖flux a u N‖
        ≤ ∑ n ∈ range (N + 1),
            2 * (‖u n‖ * ‖∑' i : ℕ, a n (i + (N + 1)) * u (i + (N + 1))‖) := by
      rw [← Finset.mul_sum]
      linarith
    exact h2.trans (Finset.sum_le_sum key)
  -- the incoming layer, after interchanging the finite sum with the series
  have hRsum : Summable (fun i : ℕ => Θ i * ‖u (i + (N + 1))‖ ^ 2) :=
    Summable.of_nonneg_of_le (fun i => mul_nonneg (Theta_nonneg hθ0 hΘ i) (by positivity))
      (fun i => mul_le_mul_of_nonneg_right (Theta_antitone hθ0 hΘ (Nat.zero_le i))
        (by positivity)) (hushift.mul_left (Θ 0))
  have hinter : ∑ n ∈ range (N + 1),
        (∑' i : ℕ, θ (i + (N - n) + 1) * ‖u (i + (N + 1))‖ ^ 2)
      ≤ ∑' i : ℕ, Θ i * ‖u (i + (N + 1))‖ ^ 2 := by
    rw [← Summable.tsum_finsetSum (fun n _ => hsθu (N - n))]
    refine Summable.tsum_mono (summable_sum (fun n _ => hsθu (N - n))) hRsum (fun i => ?_)
    · rw [← Finset.sum_mul]
      refine mul_le_mul_of_nonneg_right ?_ (by positivity)
      have hrefl : ∑ n ∈ range (N + 1), θ (i + (N - n) + 1)
          = ∑ m ∈ range (N + 1), θ (i + m + 1) := by
        simpa using Finset.sum_range_reflect (fun m => θ (i + m + 1)) (N + 1)
      rw [hrefl]
      have hcomm : ∀ m : ℕ, θ (i + m + 1) = θ (m + i + 1) := by
        intro m; rw [Nat.add_comm i m]
      simp_rw [hcomm]
      exact Summable.sum_le_tsum (range (N + 1)) (fun _ _ => hθ0 _) ((hΘ i).summable) |>.trans
        (le_of_eq ((hΘ i).tsum_eq))
  have hfin : ∑ n ∈ range (N + 1), A N * (Θ (N - n) * ‖u n‖ ^ 2
        + ∑' i : ℕ, θ (i + (N - n) + 1) * ‖u (i + (N + 1))‖ ^ 2)
      ≤ A N * cutMass u Θ N := by
    rw [← Finset.mul_sum, cutMass, Finset.sum_add_distrib]
    exact mul_le_mul_of_nonneg_left (by linarith [hinter]) (hA0 N)
  linarith

/-! ## 3. Carleman's condition: the flux is small along a subsequence of cuts -/

theorem cutMass_nonneg (hθ0 : ∀ r, 0 ≤ θ r)
    (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j)) (N : ℕ) : 0 ≤ cutMass u Θ N := by
  refine add_nonneg (Finset.sum_nonneg fun n _ => mul_nonneg (Theta_nonneg hθ0 hΘ _)
    (by positivity)) ?_
  exact tsum_nonneg fun i => mul_nonneg (Theta_nonneg hθ0 hΘ _) (by positivity)

/-- **The boundary masses are summable.**  Because the hop profile has a finite first
moment (`Θ` summable) and `u` is square-summable, the total boundary mass over all cuts
is finite. -/
theorem summable_cutMass (hu : Summable fun n => ‖u n‖ ^ 2) (hΘ0 : ∀ j, 0 ≤ Θ j)
    (hΘsum : Summable Θ) : Summable (fun N => cutMass u Θ N) := by
  set v : ℕ → ℝ := fun n => ‖u n‖ ^ 2 with hv
  have hv0 : ∀ n, 0 ≤ v n := fun n => by positivity
  -- the outgoing layer is a Cauchy product
  have hpart1 : Summable (fun N => ∑ n ∈ range (N + 1), Θ (N - n) * v n) := by
    have hprod : Summable (fun x : ℕ × ℕ => Θ x.1 * v x.2) :=
      hΘsum.mul_of_nonneg hu hΘ0 hv0
    have hanti := summable_sum_mul_antidiagonal_of_summable_mul hprod
    refine hanti.congr fun N => ?_
    rw [Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
    rw [← Finset.sum_range_reflect (fun k => Θ k * v (N - k)) (N + 1)]
    refine Finset.sum_congr rfl fun j hj => ?_
    simp only [Finset.mem_range] at hj
    congr 2
    all_goals omega
  -- the incoming layer is an injective reindexing of the product family
  have hpart2 : Summable (fun N => ∑' i : ℕ, Θ i * v (i + (N + 1))) := by
    have hprod : Summable (fun x : ℕ × ℕ => Θ x.1 * v x.2) :=
      hΘsum.mul_of_nonneg hu hΘ0 hv0
    have hinj : Function.Injective (fun p : ℕ × ℕ => (p.2, p.2 + p.1 + 1)) := by
      rintro ⟨N, i⟩ ⟨N', i'⟩ h
      simp only [Prod.mk.injEq] at h
      obtain ⟨h1, h2⟩ := h
      subst h1
      have : N = N' := by omega
      simp [this]
    have hcomp : Summable (fun p : ℕ × ℕ => Θ p.2 * v (p.2 + p.1 + 1)) := by
      simpa [Function.comp] using hprod.comp_injective hinj
    exact hcomp.prod
  simpa [cutMass, hv] using hpart1.add hpart2

/-- **Carleman's condition.**  If the amplitudes `A` grow slowly enough that
`∑ 1/A n = ∞`, then a summable sequence of boundary masses cannot keep `A N · S N` away
from zero: it is arbitrarily small along arbitrarily late cuts. -/
theorem exists_mul_lt_of_not_summable_inv {A S : ℕ → ℝ} (hA : ∀ n, 0 < A n)
    (hSsum : Summable S) (hcar : ¬ Summable fun n => (A n)⁻¹) :
    ∀ ε > 0, ∀ N₀ : ℕ, ∃ N, N₀ ≤ N ∧ A N * S N < ε := by
  by_contra hcon
  push_neg at hcon
  obtain ⟨ε, hε, N₀, hall⟩ := hcon
  refine hcar ?_
  have hkey : ∀ N : ℕ, (A (N + N₀))⁻¹ ≤ S (N + N₀) / ε := by
    intro N
    have h := hall (N + N₀) (by omega)
    have hApos := hA (N + N₀)
    rw [inv_eq_one_div, div_le_div_iff₀ hApos hε]
    nlinarith
  have hmaj : Summable (fun N : ℕ => S (N + N₀) / ε) :=
    (((summable_nat_add_iff N₀).mpr hSsum)).div_const ε
  have h2 : Summable (fun N : ℕ => (A (N + N₀))⁻¹) :=
    Summable.of_nonneg_of_le (fun N => inv_nonneg.mpr (hA _).le) hkey hmaj
  exact (summable_nat_add_iff N₀).mp h2

/-- **The unbounded-hop Carleman criterion.**  Let `a` be a Hermitian kernel on `ℕ` whose
hops obey `‖a n k‖ ≤ A n · θ (k − n)` for `n < k`, with

* `θ ≥ 0` a hop profile of **finite first moment** (its tails `Θ` are summable) — the hop
  range may be infinite, and
* `A > 0` nondecreasing with `∑ 1/A n = ∞` (Carleman).

Then every square-summable solution of the recursion at a non-real `z` vanishes.  The
*diagonal* of `a` is unconstrained. -/
theorem ladder_eq_zero_of_carleman {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {z : ℂ} {A θ Θ : ℕ → ℝ}
    (hz : z.im ≠ 0) (hherm : IsHermitianKernel a) (hrec : LadderRecInf a u z)
    (hu : Summable fun n => ‖u n‖ ^ 2) (hθ0 : ∀ r, 0 ≤ θ r)
    (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j)) (hΘsum : Summable Θ)
    (hApos : ∀ n, 0 < A n) (hAmono : Monotone A)
    (hbd : ∀ n k, n < k → ‖a n k‖ ≤ A n * θ (k - n))
    (hcar : ¬ Summable fun n => (A n)⁻¹) :
    ∀ n, u n = 0 := by
  refine eq_zero_of_flux_small hz hherm hrec ?_
  intro ε hε N₀
  obtain ⟨N, hN, hlt⟩ := exists_mul_lt_of_not_summable_inv hApos
    (summable_cutMass hu (Theta_nonneg hθ0 hΘ) hΘsum) hcar
    (2 * ε) (by positivity) N₀
  refine ⟨N, hN, ?_⟩
  have hb := two_norm_flux_le (a := a) hu hθ0 hΘ (fun n => (hApos n).le) hAmono hbd N
  linarith

end Bound

/-! ## 4. The kernel operator on `ℓ²(ℕ)` -/

section Operator

open BookProof BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine

/-- A Hermitian kernel whose columns are square-summable: enough for the associated
matrix to act on the finitely supported states. -/
structure IsL2Kernel (a : ℕ → ℕ → ℂ) : Prop where
  herm : IsHermitianKernel a
  col : ∀ k, Memℓp (fun n => a n k) 2

/-- The action of the kernel on a coefficient sequence. -/
def kernelFun (a : ℕ → ℕ → ℂ) (f : ℕ → ℂ) : ℕ → ℂ := fun n => ∑' k : ℕ, a n k * f k

theorem kernelFun_eq_sum (a : ℕ → ℕ → ℂ) {f : ℕ → ℂ} {M : ℕ} (hf : ∀ n, M ≤ n → f n = 0)
    (n : ℕ) : kernelFun a f n = ∑ k ∈ range M, a n k * f k := by
  refine tsum_eq_sum ?_
  intro k hk
  rw [hf k (by simpa using hk)]
  ring

theorem memℓp_finsetSum (s : Finset ℕ) (g : ℕ → ℕ → ℂ) (h : ∀ k ∈ s, Memℓp (g k) 2) :
    Memℓp (fun n => ∑ k ∈ s, g k n) 2 := by
  classical
  induction s using Finset.induction with
  | empty => simpa using zero_memℓp (E := fun _ : ℕ => ℂ) (p := 2)
  | insert j s hj ih =>
    have h1 : Memℓp (g j) 2 := h j (Finset.mem_insert_self _ _)
    have h2 : Memℓp (fun n => ∑ k ∈ s, g k n) 2 :=
      ih fun k hk => h k (Finset.mem_insert_of_mem hk)
    have heq : (fun n => ∑ k ∈ insert j s, g k n) = g j + (fun n => ∑ k ∈ s, g k n) := by
      funext n
      simp [Finset.sum_insert hj]
    rw [heq]
    exact h1.add h2

theorem memℓp_kernelFun {a : ℕ → ℕ → ℂ} (hk : IsL2Kernel a) {f : ℕ → ℂ} {M : ℕ}
    (hf : ∀ n, M ≤ n → f n = 0) : Memℓp (kernelFun a f) 2 := by
  have heq : kernelFun a f = fun n => ∑ k ∈ range M, f k * a n k := by
    funext n
    rw [kernelFun_eq_sum a hf n]
    exact Finset.sum_congr rfl fun k _ => mul_comm _ _
  rw [heq]
  exact memℓp_finsetSum (range M) (fun k n => f k * a n k)
    fun k _ => (hk.col k).const_smul (f k)

/-- The operator defined by an `ℓ²`-column Hermitian kernel, on the finitely supported
states of `ℓ²(ℕ)`. -/
def kernelOp {a : ℕ → ℕ → ℂ} (hk : IsL2Kernel a) : lpFiniteModes ℕ →ₗ[ℂ] L2N where
  toFun f := ⟨kernelFun a ((f : L2N) : ℕ → ℂ),
    memℓp_kernelFun hk (Classical.choose_spec (exists_tail_zero f.2))⟩
  map_add' f g := by
    obtain ⟨Mf, hMf⟩ := exists_tail_zero f.2
    obtain ⟨Mg, hMg⟩ := exists_tail_zero g.2
    have hf : ∀ n, max Mf Mg ≤ n → ((f : L2N) : ℕ → ℂ) n = 0 :=
      fun n hn => hMf n (le_trans (le_max_left _ _) hn)
    have hg : ∀ n, max Mf Mg ≤ n → ((g : L2N) : ℕ → ℂ) n = 0 :=
      fun n hn => hMg n (le_trans (le_max_right _ _) hn)
    have hfg : ∀ n, max Mf Mg ≤ n → (((f + g : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) n = 0 := by
      intro n hn
      simp [hf n hn, hg n hn]
    ext n
    change kernelFun a (((f + g : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) n = _
    rw [kernelFun_eq_sum a hfg n]
    change _ = kernelFun a ((f : L2N) : ℕ → ℂ) n + kernelFun a ((g : L2N) : ℕ → ℂ) n
    rw [kernelFun_eq_sum a hf n, kernelFun_eq_sum a hg n, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun k _ => ?_
    have : (((f + g : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) k
        = ((f : L2N) : ℕ → ℂ) k + ((g : L2N) : ℕ → ℂ) k := by simp
    rw [this]; ring
  map_smul' c f := by
    obtain ⟨Mf, hMf⟩ := exists_tail_zero f.2
    have hcf : ∀ n, Mf ≤ n → (((c • f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) n = 0 := by
      intro n hn
      simp [hMf n hn]
    ext n
    change kernelFun a (((c • f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) n = _
    rw [kernelFun_eq_sum a hcf n]
    change _ = c * kernelFun a ((f : L2N) : ℕ → ℂ) n
    rw [kernelFun_eq_sum a hMf n, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    have : (((c • f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) k = c * ((f : L2N) : ℕ → ℂ) k := by simp
    rw [this]; ring

@[simp] theorem kernelOp_coe {a : ℕ → ℕ → ℂ} (hk : IsL2Kernel a) (f : lpFiniteModes ℕ) :
    ((kernelOp hk f : L2N) : ℕ → ℂ) = kernelFun a ((f : L2N) : ℕ → ℂ) := rfl

/-- The kernel operator is symmetric on the finitely supported states. -/
theorem kernelOp_symmetric {a : ℕ → ℕ → ℂ} (hk : IsL2Kernel a) :
    SymmetricOn (lpFiniteModes ℕ) (kernelOp hk) := by
  intro x y
  obtain ⟨Mx, hMx⟩ := exists_tail_zero x.2
  obtain ⟨My, hMy⟩ := exists_tail_zero y.2
  have hL : (inner ℂ (kernelOp hk x : L2N) (y : L2N) : ℂ)
      = ∑ n ∈ range My, ∑ k ∈ range Mx,
          ((y : L2N) : ℕ → ℂ) n * ((starRingEnd ℂ) (a n k)
            * (starRingEnd ℂ) (((x : L2N) : ℕ → ℂ) k)) := by
    rw [← inner_conj_symm, inner_eq_sum_range (f := (y : L2N)) hMy, map_sum]
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [map_mul, Complex.conj_conj]
    change ((y : L2N) : ℕ → ℂ) n * (starRingEnd ℂ) (kernelFun a ((x : L2N) : ℕ → ℂ) n) = _
    rw [kernelFun_eq_sum a hMx n, map_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [map_mul]
  have hR : (inner ℂ (x : L2N) (kernelOp hk y : L2N) : ℂ)
      = ∑ k ∈ range Mx, ∑ n ∈ range My,
          (starRingEnd ℂ) (((x : L2N) : ℕ → ℂ) k) * (a k n * ((y : L2N) : ℕ → ℂ) n) := by
    rw [inner_eq_sum_range (f := (x : L2N)) hMx]
    refine Finset.sum_congr rfl fun k _ => ?_
    change (starRingEnd ℂ) (((x : L2N) : ℕ → ℂ) k) * kernelFun a ((y : L2N) : ℕ → ℂ) k = _
    rw [kernelFun_eq_sum a hMy k, Finset.mul_sum]
  rw [hL, hR, Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun n _ => ?_
  rw [hk.herm n k]
  ring

/-- Square-summability of the moduli of an `ℓ²(ℕ)` state. -/
theorem summable_normSq_lp (f : L2N) : Summable fun n : ℕ => ‖(f : ℕ → ℂ) n‖ ^ 2 := by
  have hsum := (lp.memℓp f).summable (p := 2) (by norm_num)
  refine hsum.congr fun n => ?_
  rw [show ENNReal.toReal 2 = ((2 : ℕ) : ℝ) by norm_num, Real.rpow_natCast]

/-- The rows of an `ℓ²`-column Hermitian kernel are square-summable too. -/
theorem row_summable {a : ℕ → ℕ → ℂ} (hk : IsL2Kernel a) (k : ℕ) :
    Summable fun n : ℕ => ‖a k n‖ ^ 2 := by
  have hcol : Summable fun n : ℕ => ‖a n k‖ ^ 2 := by
    have hsum := (hk.col k).summable (p := 2) (by norm_num)
    refine hsum.congr fun n => ?_
    rw [show ENNReal.toReal 2 = ((2 : ℕ) : ℝ) by norm_num, Real.rpow_natCast]
  refine hcol.congr fun n => ?_
  rw [hk.herm n k, RCLike.norm_conj]

/-- **A deficiency vector satisfies the recursion.**  Testing the deficiency identity
against the canonical basis vector `e_k` gives the `k`-th line of `a w = z w`. -/
theorem ladderRec_of_deficiency {a : ℕ → ℕ → ℂ} (hk : IsL2Kernel a) {z : ℂ} {w : L2N}
    (hw : ∀ v : lpFiniteModes ℕ, (inner ℂ (kernelOp hk v) (w : L2N) : ℂ)
        = z * inner ℂ (v : L2N) (w : L2N)) :
    LadderRecInf a ((w : ℕ → ℂ)) z := by
  classical
  have hw2 := summable_normSq_lp w
  have hrow : ∀ k : ℕ, Summable fun n : ℕ => a k n * (w : ℕ → ℂ) n := by
    intro k
    refine Summable.of_norm ?_
    refine Summable.of_nonneg_of_le (fun n => norm_nonneg _) (fun n => ?_)
      (((row_summable hk k).add hw2).mul_left (1 / 2))
    rw [norm_mul]
    nlinarith [sq_nonneg (‖a k n‖ - ‖(w : ℕ → ℂ) n‖), norm_nonneg (a k n),
      norm_nonneg ((w : ℕ → ℂ) n)]
  refine ⟨hrow, fun k => ?_⟩
  -- test against `e_k`
  set v : lpFiniteModes ℕ := ⟨lp.single 2 k (1 : ℂ), lpSingle_mem_lpFiniteModes k 1⟩ with hv
  have hvcoe : ∀ j, ((v : L2N) : ℕ → ℂ) j = if j = k then (1 : ℂ) else 0 := by
    intro j; simp [hv, lp.single_apply, Pi.single_apply]
  have hTv : ∀ n, ((kernelOp hk v : L2N) : ℕ → ℂ) n = a n k := by
    intro n
    rw [kernelOp_coe, kernelFun]
    rw [tsum_eq_single k (by
      intro b hb
      rw [hvcoe b, if_neg hb]
      ring)]
    rw [hvcoe k, if_pos rfl]
    ring
  have hrhs : (inner ℂ (v : L2N) (w : L2N) : ℂ) = (w : ℕ → ℂ) k := by
    rw [lp.inner_eq_tsum]
    rw [tsum_eq_single k (by
      intro b hb
      simp [RCLike.inner_apply, hvcoe b, if_neg hb])]
    simp [RCLike.inner_apply, hvcoe k]
  have hlhs : (inner ℂ (kernelOp hk v : L2N) (w : L2N) : ℂ)
      = ∑' n : ℕ, a k n * (w : ℕ → ℂ) n := by
    rw [lp.inner_eq_tsum]
    refine tsum_congr fun n => ?_
    rw [RCLike.inner_apply, hTv n, hk.herm n k]
    ring
  have := hw v
  rw [hlhs, hrhs] at this
  exact this

/-- **Essential self-adjointness under the unbounded-hop Carleman condition.**  The
deficiency spaces of the kernel operator are trivial at every non-real point. -/
theorem kernelOp_deficiencyTrivialAt {a : ℕ → ℕ → ℂ} {A θ Θ : ℕ → ℝ} (hk : IsL2Kernel a)
    (hθ0 : ∀ r, 0 ≤ θ r) (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j))
    (hΘsum : Summable Θ) (hApos : ∀ n, 0 < A n) (hAmono : Monotone A)
    (hbd : ∀ n k, n < k → ‖a n k‖ ≤ A n * θ (k - n))
    (hcar : ¬ Summable fun n => (A n)⁻¹) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (lpFiniteModes ℕ) (kernelOp hk) z := by
  intro w hw
  have hrec := ladderRec_of_deficiency hk hw
  have hzero := ladder_eq_zero_of_carleman hz hk.herm hrec (summable_normSq_lp w)
    hθ0 hΘ hΘsum hApos hAmono hbd hcar
  exact lp.ext (funext hzero)

/-- **The headline of the unbounded-hop criterion.**  A Hermitian matrix on `ℓ²(ℕ)` whose
off-diagonal entries decay in the hop length with a finite first moment, with amplitudes
satisfying Carleman's growth condition, is essentially self-adjoint on the finitely
supported states — whatever its diagonal, and however long its hops. -/
theorem kernelOp_essentiallySelfAdjoint {a : ℕ → ℕ → ℂ} {A θ Θ : ℕ → ℝ} (hk : IsL2Kernel a)
    (hθ0 : ∀ r, 0 ≤ θ r) (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j))
    (hΘsum : Summable Θ) (hApos : ∀ n, 0 < A n) (hAmono : Monotone A)
    (hbd : ∀ n k, n < k → ‖a n k‖ ≤ A n * θ (k - n))
    (hcar : ¬ Summable fun n => (A n)⁻¹) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ) (kernelOp hk) :=
  ⟨kernelOp_deficiencyTrivialAt hk hθ0 hΘ hΘsum hApos hAmono hbd hcar (by simp),
    kernelOp_deficiencyTrivialAt hk hθ0 hΘ hΘsum hApos hAmono hbd hcar (by simp)⟩

/-- **The unitary flow.**  Stone's theorem applied to the closure of the kernel
operator. -/
theorem kernelOp_stone_flow {a : ℕ → ℕ → ℂ} {A θ Θ : ℕ → ℝ} (hk : IsL2Kernel a)
    (hθ0 : ∀ r, 0 ≤ θ r) (hΘ : ∀ j, HasSum (fun i => θ (i + j + 1)) (Θ j))
    (hΘsum : Summable Θ) (hApos : ∀ n, 0 < A n) (hAmono : Monotone A)
    (hbd : ∀ n k, n < k → ‖a n k‖ ≤ A n * θ (k - n))
    (hcar : ¬ Summable fun n => (A n)⁻¹) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint L2N) (U : ℝ → (L2N →L[ℂ] L2N)),
      EsaClosure.IsSelfAdjointExtension (kernelOp hk) T.op ∧ StoneBridge.IsStoneFlow T U :=
  StoneBridge.exists_stone_flow_of_esa _ lpFiniteModes_dense (kernelOp_symmetric hk)
    (kernelOp_essentiallySelfAdjoint hk hθ0 hΘ hΘsum hApos hAmono hbd hcar)

end Operator

/-! ## 5. An instance with genuinely unbounded hops -/

section Instance

open BookProof BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine

/-- A Hermitian matrix on `ℓ²(ℕ)` with **infinite hop range**: the entry at distance `r`
from the diagonal is `(1 + min n k) ρ^r`, and the diagonal is an arbitrary real sequence
`b` — no growth restriction on it whatsoever. -/
def geoHop (b : ℕ → ℝ) (rho : ℝ) : ℕ → ℕ → ℂ := fun n k =>
  if n = k then ((b n : ℝ) : ℂ)
  else (((1 + ((min n k : ℕ) : ℝ)) * rho ^ (max n k - min n k) : ℝ) : ℂ)

theorem geoHop_herm (b : ℕ → ℝ) (rho : ℝ) : IsHermitianKernel (geoHop b rho) := by
  intro n k
  by_cases h : n = k
  · subst h; simp [geoHop]
  · rw [geoHop, geoHop, if_neg (Ne.symm h), if_neg h, min_comm k n, max_comm k n,
      Complex.conj_ofReal]

theorem geoHop_norm_off {b : ℕ → ℝ} {rho : ℝ} (hrho : 0 ≤ rho) {n k : ℕ} (h : n ≠ k) :
    ‖geoHop b rho n k‖ = (1 + ((min n k : ℕ) : ℝ)) * rho ^ (max n k - min n k) := by
  rw [geoHop, if_neg h, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by positivity)]

/-- Off the diagonal, the hop amplitude splits as `A n · θ (k − n)` with `A n = 1 + n`
and the geometric profile `θ r = ρ^r`. -/
theorem geoHop_bound {b : ℕ → ℝ} {rho : ℝ} (hrho : 0 ≤ rho) (n k : ℕ) (hnk : n < k) :
    ‖geoHop b rho n k‖ ≤ (1 + (n : ℝ)) * rho ^ (k - n) := by
  have hmin : min n k = n := min_eq_left hnk.le
  have hmax : max n k = k := max_eq_right hnk.le
  rw [geoHop_norm_off hrho (Nat.ne_of_lt hnk), hmin, hmax]

theorem geoHop_col {b : ℕ → ℝ} {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) (k : ℕ) :
    Memℓp (fun n => geoHop b rho n k) 2 := by
  refine memLpTwo_of_summable_normSq ?_
  refine (summable_nat_add_iff (k + 1)).mp ?_
  have heq : ∀ m : ℕ, ‖geoHop b rho (m + (k + 1)) k‖ ^ 2
      = (1 + (k : ℝ)) ^ 2 * ((rho ^ 2) ^ (m + 1)) := by
    intro m
    have hne : m + (k + 1) ≠ k := by omega
    have hmin : min (m + (k + 1)) k = k := by omega
    have hmax : max (m + (k + 1)) k = m + (k + 1) := by omega
    have hsub : m + (k + 1) - k = m + 1 := by omega
    rw [geoHop_norm_off hrho hne, hmin, hmax, hsub, mul_pow, ← pow_mul, ← pow_mul]
    ring_nf
  have hgeo : Summable (fun m : ℕ => (1 + (k : ℝ)) ^ 2 * ((rho ^ 2) ^ (m + 1))) := by
    have hlt : rho ^ 2 < 1 := by nlinarith
    have hsum : Summable (fun m : ℕ => (rho ^ 2) ^ m) :=
      (hasSum_geometric_of_lt_one (by positivity) hlt).summable
    have := (hsum.mul_left (rho ^ 2)).mul_left ((1 + (k : ℝ)) ^ 2)
    refine this.congr fun m => ?_
    rw [pow_succ]
    ring
  exact hgeo.congr fun m => (heq m).symm

/-- The geometric hop profile has a finite first moment: its tails are summable. -/
theorem geo_hasSum_tail {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) (j : ℕ) :
    HasSum (fun i : ℕ => rho ^ (i + j + 1)) (rho ^ (j + 1) * (1 - rho)⁻¹) := by
  have h := (hasSum_geometric_of_lt_one hrho hrho1).mul_left (rho ^ (j + 1))
  have heq : (fun i : ℕ => rho ^ (j + 1) * rho ^ i) = fun i : ℕ => rho ^ (i + j + 1) := by
    funext i
    rw [← pow_add]
    congr 1
    omega
  exact heq ▸ h

theorem geo_summable_tail {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) :
    Summable (fun j : ℕ => rho ^ (j + 1) * (1 - rho)⁻¹) := by
  have hsum : Summable (fun j : ℕ => rho ^ j) :=
    (hasSum_geometric_of_lt_one hrho hrho1).summable
  have := ((hsum.mul_left rho).mul_right (1 - rho)⁻¹)
  refine this.congr fun j => ?_
  rw [pow_succ]
  ring

theorem not_summable_inv_one_add_nat : ¬ Summable (fun n : ℕ => (1 + (n : ℝ))⁻¹) := by
  intro h
  refine Real.not_summable_natCast_inv ?_
  have h1 : Summable (fun n : ℕ => (((n : ℝ) + 1))⁻¹) := by simpa [add_comm] using h
  exact (summable_nat_add_iff (f := fun n : ℕ => ((n : ℝ))⁻¹) 1).mp (by simpa using h1)

/-- The kernel data of `geoHop`. -/
theorem geoHop_isL2Kernel (b : ℕ → ℝ) {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) :
    IsL2Kernel (geoHop b rho) :=
  ⟨geoHop_herm b rho, fun k => geoHop_col hrho hrho1 k⟩

/-- **An unbounded-hop instance.**  For an *arbitrary* real diagonal `b` and geometric
hops of infinite range with linearly growing amplitudes, the matrix operator is
essentially self-adjoint on the finitely supported states of `ℓ²(ℕ)`.  The finite-hop
Carleman criteria of `ChapterHermiteCarlemanEsa`, `ChapterCarlemanTwoStep` and
`ChapterCarlemanGeneralHop` do not cover this operator: every row has infinitely many
nonzero entries. -/
theorem geoHop_essentiallySelfAdjoint (b : ℕ → ℝ) {rho : ℝ} (hrho : 0 ≤ rho)
    (hrho1 : rho < 1) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ) (kernelOp (geoHop_isL2Kernel b hrho hrho1)) :=
  kernelOp_essentiallySelfAdjoint (A := fun n => 1 + (n : ℝ)) (θ := fun r => rho ^ r)
    (Θ := fun j => rho ^ (j + 1) * (1 - rho)⁻¹) _
    (fun r => by positivity) (geo_hasSum_tail hrho hrho1) (geo_summable_tail hrho hrho1)
    (fun n => by positivity) (fun m n hmn => by
      have : (m : ℝ) ≤ (n : ℝ) := Nat.cast_le.mpr hmn
      linarith)
    (fun n k hnk => geoHop_bound hrho n k hnk) not_summable_inv_one_add_nat

/-- The corresponding unitary flow. -/
theorem geoHop_stone_flow (b : ℕ → ℝ) {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint L2N) (U : ℝ → (L2N →L[ℂ] L2N)),
      EsaClosure.IsSelfAdjointExtension (kernelOp (geoHop_isL2Kernel b hrho hrho1)) T.op ∧
        StoneBridge.IsStoneFlow T U :=
  StoneBridge.exists_stone_flow_of_esa _ lpFiniteModes_dense
    (kernelOp_symmetric (geoHop_isL2Kernel b hrho hrho1))
    (geoHop_essentiallySelfAdjoint b hrho hrho1)

end Instance

end

end BookProof.CarlemanUnboundedHop
