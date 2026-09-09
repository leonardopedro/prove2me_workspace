import Mathlib
import BookProof.ChapterNavierStokesFullEsa

/-!
# Carleman's criterion, and an **unbounded, non-commuting** full Navier–Stokes
Hamiltonian that is essentially self-adjoint

`BookProof.ChapterNavierStokesFullEsa` proves essential self-adjointness of the
full (untruncated) Navier–Stokes Hamiltonian in two infinite-dimensional
realizations: a *bounded* one on `ℓ²(ℤ)`, and an *unbounded but diagonal* one on
`ℓ²(ℕ)`, where the momenta commute with the field modes.  Neither carries the
genuine difficulty of the continuum problem, in which the momentum does **not**
commute with the (possibly unbounded) velocity field.

This module supplies that case.  On the half-line lattice `ℓ²(ℕ)` the momentum
is the symmetric-difference operator `(p f)_n = -(i/2)(f_{n+1} - f_{n-1})`, the
field modes are multiplication by arbitrary real sequences — bounded or not —
and the Weyl-symmetrized Navier–Stokes Hamiltonian
`H = ∑_i (π_i A_i + A_i π_i)` is then a **tridiagonal (Jacobi) operator** whose
off-diagonal couplings are `c_n = -(i/2)(α_n + α_{n+1})`, `α` the total
Navier–Stokes symbol `∑_i (∑_j u_j u_{i,j} − ν u_{i,jj})`.

* `tridiagOp` — the tridiagonal operator with complex couplings `c`, on the
  finite-mode domain of `ℓ²(ℕ)`; `tridiagOp_isSymmetricDom` its symmetry.
* `tridiag_hasZeroDeficiencyOn_of_carleman` — **Carleman's criterion**: if
  `∑ 1/|c_n| = ∞` then the tridiagonal operator is essentially self-adjoint.
  The proof is the classical Wronskian argument: a deficiency vector `w`
  satisfies `c_n w_{n+1} + \bar c_{n-1} w_{n-1} = ± i w_n`, whose Wronskian
  telescopes to `2i ∑_{m ≤ n} |w_m|²`, forcing
  `|w_n| |w_{n+1}| ≥ (∑_{m ≤ n₀} |w_m|²)/|c_n|`; summing contradicts
  `∑ 1/|c_n| = ∞` because `∑ |w_n| |w_{n+1}| ≤ ‖w‖²`.
* `halfLineFullData` — the untruncated Navier–Stokes data on `ℓ²(ℕ)` with the
  symmetric-difference momentum and arbitrary real field modes, and
  `halfLineFullData_hamiltonian`, the identification of its full Hamiltonian
  with a tridiagonal operator.
* `halfLineFull_hasZeroDeficiencyOn` — **the headline**: the full Navier–Stokes
  Hamiltonian of this realization is essentially self-adjoint whenever the
  Navier–Stokes symbol satisfies Carleman's growth condition.
* `linearFull_hasZeroDeficiencyOn` together with `linearFull_not_bounded` — a
  concrete instance: a velocity/viscous field growing **linearly** gives an
  unbounded full Navier–Stokes Hamiltonian, with non-commuting momentum and
  field modes, which is essentially self-adjoint.

*The dichotomy.*  Carleman's condition is a growth restriction: `α_n ∼ n`
diverges (`∑ 1/n = ∞`) and gives essential self-adjointness, while for a field
growing fast enough the sum converges and the criterion is silent — as it must
be, since `BookProof.ChapterNavierStokesDeficiency` exhibits a tridiagonal
operator with geometrically growing couplings that is *not* essentially
self-adjoint, and `BookProof.ChapterNavierStokesFullEsa` realizes it as a full
Navier–Stokes Hamiltonian.  This is the lattice form of the ODE chapter's
`ẋ = x²` warning: quadratic (and faster) growth of the field can destroy
essential self-adjointness, subquadratic growth cannot.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace Carleman

open LpNat DiagonalEsa FullEsa

/-! ## The tridiagonal operator with complex couplings -/

/-- Square-summability of the moduli of an `ℓ²(ℕ)` state. -/
theorem summable_normSq (f : L2N) : Summable fun n : ℕ => ‖(f : ℕ → ℂ) n‖ ^ 2 := by
  have hsum := (lp.memℓp f).summable (p := 2) (by norm_num)
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using hsum

/-- The coefficient action of the tridiagonal operator with couplings `c`:
`(T f)_n = \bar c_{n-1} f_{n-1} + c_n f_{n+1}` (zero diagonal). -/
def tridiagFun (c : ℕ → ℂ) (f : ℕ → ℂ) : ℕ → ℂ
  | 0 => c 0 * f 1
  | (n + 1) => (starRingEnd ℂ) (c n) * f n + c (n + 1) * f (n + 2)

theorem tridiagFun_add (c f g : ℕ → ℂ) (n : ℕ) :
    tridiagFun c (f + g) n = tridiagFun c f n + tridiagFun c g n := by
  cases n with
  | zero => simp only [tridiagFun, Pi.add_apply]; ring
  | succ m => simp only [tridiagFun, Pi.add_apply]; ring

theorem tridiagFun_smul (c : ℕ → ℂ) (a : ℂ) (f : ℕ → ℂ) (n : ℕ) :
    tridiagFun c (a • f) n = a * tridiagFun c f n := by
  cases n with
  | zero => simp only [tridiagFun, Pi.smul_apply, smul_eq_mul]; ring
  | succ m => simp only [tridiagFun, Pi.smul_apply, smul_eq_mul]; ring

theorem tridiagFun_tail_zero (c : ℕ → ℂ) {f : ℕ → ℂ} {N : ℕ} (h : ∀ n, N ≤ n → f n = 0) :
    ∀ n, N + 1 ≤ n → tridiagFun c f n = 0 := by
  intro n hn
  cases n with
  | zero => omega
  | succ m =>
    have hm : N ≤ m := by omega
    simp [tridiagFun, h m hm, h (m + 2) (by omega)]

/-- The tridiagonal operator on the finite-mode domain of `ℓ²(ℕ)`. -/
noncomputable def tridiagOp (c : ℕ → ℂ) : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ where
  toFun f :=
    ⟨⟨tridiagFun c ((f : L2N) : ℕ → ℂ), by
        obtain ⟨N, hN⟩ := exists_tail_zero f.2
        exact memLpTwo_of_tail_zero (tridiagFun_tail_zero c hN)⟩, by
      obtain ⟨N, hN⟩ := exists_tail_zero f.2
      exact mem_lpFiniteModes_of_tail_zero (N := N + 1) (tridiagFun_tail_zero c hN)⟩
  map_add' f g := by
    ext n
    simpa using tridiagFun_add c ((f : L2N) : ℕ → ℂ) ((g : L2N) : ℕ → ℂ) n
  map_smul' a f := by
    ext n
    simpa using tridiagFun_smul c a ((f : L2N) : ℕ → ℂ) n

@[simp] theorem tridiagOp_coe (c : ℕ → ℂ) (f : lpFiniteModes ℕ) :
    (((tridiagOp c f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) = tridiagFun c ((f : L2N) : ℕ → ℂ) := rfl

/-- **The discrete Green identity** for the tridiagonal operator: the failure of
symmetry on a truncated window is a pure boundary term. -/
theorem tridiag_wronskian (c x y : ℕ → ℂ) (N : ℕ) :
    ∑ n ∈ Finset.range (N + 1),
        (starRingEnd ℂ (tridiagFun c x n) * y n - starRingEnd ℂ (x n) * tridiagFun c y n)
      = starRingEnd ℂ (c N) * (starRingEnd ℂ (x (N + 1)) * y N)
        - c N * (starRingEnd ℂ (x N) * y (N + 1)) := by
  induction N with
  | zero =>
    rw [zero_add, Finset.sum_range_one]
    simp only [tridiagFun, map_mul]
    ring
  | succ N ih =>
    rw [Finset.sum_range_succ, ih]
    simp only [tridiagFun, map_add, map_mul, RingHomCompTriple.comp_apply, RingHom.id_apply]
    ring

/-- The tridiagonal operator is symmetric on the finite-mode domain. -/
theorem tridiagOp_isSymmetricDom (c : ℕ → ℂ) : IsSymmetricDom (tridiagOp c) := by
  intro x y
  obtain ⟨Nx, hNx⟩ := exists_tail_zero x.2
  obtain ⟨Ny, hNy⟩ := exists_tail_zero y.2
  set N := max Nx Ny with hN
  have hx : ∀ n, N ≤ n → ((x : L2N) : ℕ → ℂ) n = 0 :=
    fun n hn => hNx n (le_trans (le_max_left _ _) hn)
  have hy : ∀ n, N ≤ n → ((y : L2N) : ℕ → ℂ) n = 0 :=
    fun n hn => hNy n (le_trans (le_max_right _ _) hn)
  have hlhs := inner_eq_sum_range (f := ((tridiagOp c x : lpFiniteModes ℕ) : L2N))
    (g := ((y : lpFiniteModes ℕ) : L2N)) (N := N + 1)
    (by simpa using tridiagFun_tail_zero c hx)
  have hrhs := inner_eq_sum_range (f := ((x : lpFiniteModes ℕ) : L2N))
    (g := ((tridiagOp c y : lpFiniteModes ℕ) : L2N)) (N := N + 1)
    (fun n hn => hx n (by omega))
  rw [hlhs, hrhs, ← sub_eq_zero, ← Finset.sum_sub_distrib]
  simp only [tridiagOp_coe]
  rw [tridiag_wronskian]
  rw [hx N le_rfl, hx (N + 1) (by omega)]
  simp

/-! ## The action on the canonical basis states -/

theorem tridiagOp_basis_zero (c : ℕ → ℂ) :
    ((tridiagOp c (basis 0) : lpFiniteModes ℕ) : L2N)
      = (starRingEnd ℂ (c 0)) • lp.single 2 1 (1 : ℂ) := by
  ext m
  cases m with
  | zero => simp [tridiagOp, basis, tridiagFun, lp.single_apply]
  | succ j =>
    rcases Nat.eq_zero_or_pos j with hj | hj
    · subst hj
      simp [tridiagOp, basis, tridiagFun, lp.single_apply]
    · have hj1 : j ≠ 0 := by omega
      simp [tridiagOp, basis, tridiagFun, lp.single_apply, hj1]

theorem tridiagOp_basis_succ (c : ℕ → ℂ) (k : ℕ) :
    ((tridiagOp c (basis (k + 1)) : lpFiniteModes ℕ) : L2N)
      = (starRingEnd ℂ (c (k + 1))) • lp.single 2 (k + 2) (1 : ℂ)
        + (c k) • lp.single 2 k (1 : ℂ) := by
  ext m
  cases m with
  | zero =>
    rcases Nat.eq_zero_or_pos k with hk | hk
    · subst hk
      simp [tridiagOp, basis, tridiagFun, lp.single_apply]
    · have hk1 : (0 : ℕ) ≠ k := by omega
      have hk0 : ¬ (k = 0) := by omega
      simp [tridiagOp, basis, tridiagFun, lp.single_apply, hk1, hk0]
  | succ j =>
    by_cases hjk : j = k + 1
    · subst hjk
      have hne : ¬ (k + 1 + 1 = k) := by omega
      simp [tridiagOp, basis, tridiagFun, lp.single_apply, hne]
    · by_cases hjk2 : j + 1 = k
      · subst hjk2
        simp [tridiagOp, basis, tridiagFun, lp.single_apply, hjk]
      · have h1 : j ≠ k + 1 := hjk
        have h2 : j + 2 ≠ k + 1 := by omega
        have h4 : j + 1 ≠ k := by omega
        simp [tridiagOp, basis, tridiagFun, lp.single_apply, h1, h2, h4]

/-! ## From a deficiency vector to the three-term recursion -/

theorem tridiag_recursion_of_deficiency (c : ℕ → ℂ) (z : ℂ) (w : L2N)
    (hw : ∀ v : lpFiniteModes ℕ,
      (inner ℂ ((tridiagOp c v : lpFiniteModes ℕ) : L2N) w : ℂ)
        = inner ℂ ((v : lpFiniteModes ℕ) : L2N) (z • w)) :
    ∀ n, tridiagFun c ((w : L2N) : ℕ → ℂ) n = z * ((w : L2N) : ℕ → ℂ) n := by
  intro n
  cases n with
  | zero =>
    have h := hw (basis 0)
    rw [tridiagOp_basis_zero] at h
    rw [inner_smul_left, lp.inner_single_left] at h
    rw [show ((basis 0 : lpFiniteModes ℕ) : L2N) = lp.single 2 0 (1 : ℂ) from rfl,
      lp.inner_single_left] at h
    simpa [tridiagFun] using h
  | succ k =>
    have h := hw (basis (k + 1))
    rw [tridiagOp_basis_succ] at h
    rw [inner_add_left, inner_smul_left, inner_smul_left, lp.inner_single_left,
      lp.inner_single_left] at h
    rw [show ((basis (k + 1) : lpFiniteModes ℕ) : L2N) = lp.single 2 (k + 1) (1 : ℂ) from rfl,
      lp.inner_single_left] at h
    simp only [Complex.conj_conj, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul] at h
    simpa [tridiagFun, add_comm] using h

/-! ## The Wronskian and Carleman's criterion -/

/-- The Wronskian of a solution of the three-term recursion with its
conjugate. -/
noncomputable def wron (c w : ℕ → ℂ) (n : ℕ) : ℂ :=
  c n * (w (n + 1) * starRingEnd ℂ (w n))
    - starRingEnd ℂ (c n) * (starRingEnd ℂ (w (n + 1)) * w n)

/-- **The Wronskian telescopes.**  For a solution of `T w = z w` the Wronskian
accumulates the squared moduli of `w`. -/
theorem wron_eq_sum (c w : ℕ → ℂ) (z : ℂ)
    (hrec : ∀ n, tridiagFun c w n = z * w n) (N : ℕ) :
    wron c w N
      = (z - starRingEnd ℂ z) * ∑ n ∈ Finset.range (N + 1), starRingEnd ℂ (w n) * w n := by
  induction N with
  | zero =>
    have h0 : c 0 * w 1 = z * w 0 := hrec 0
    have h0' : starRingEnd ℂ (c 0) * starRingEnd ℂ (w 1) = starRingEnd ℂ z * starRingEnd ℂ (w 0) :=
      by simpa [map_mul] using congrArg (starRingEnd ℂ) h0
    rw [zero_add, Finset.sum_range_one]
    simp only [wron]
    linear_combination starRingEnd ℂ (w 0) * h0 - w 0 * h0'
  | succ N ih =>
    have hN : starRingEnd ℂ (c N) * w N + c (N + 1) * w (N + 2) = z * w (N + 1) := hrec (N + 1)
    have hN' : c N * starRingEnd ℂ (w N) + starRingEnd ℂ (c (N + 1)) * starRingEnd ℂ (w (N + 2))
        = starRingEnd ℂ z * starRingEnd ℂ (w (N + 1)) := by
      simpa [map_add, map_mul] using congrArg (starRingEnd ℂ) hN
    rw [Finset.sum_range_succ, mul_add, ← ih]
    simp only [wron] at *
    linear_combination starRingEnd ℂ (w (N + 1)) * hN - w (N + 1) * hN'

/-- The key inequality: the accumulated mass is dominated by one coupling. -/
theorem sum_normSq_le (c w : ℕ → ℂ) (hrec : ∀ n, tridiagFun c w n = Complex.I * w n) (N : ℕ) :
    ∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2 ≤ ‖c N‖ * (‖w (N + 1)‖ * ‖w N‖) := by
  have hw := wron_eq_sum c w Complex.I hrec N
  have hz : Complex.I - starRingEnd ℂ Complex.I = 2 * Complex.I := by
    simp [Complex.conj_I]
    ring
  have hsum : (∑ n ∈ Finset.range (N + 1), starRingEnd ℂ (w n) * w n)
      = ((∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2 : ℝ) : ℂ) := by
    rw [Complex.ofReal_sum]
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [← Complex.normSq_eq_conj_mul_self]
    norm_cast
    exact Complex.normSq_eq_norm_sq (w n)
  rw [hz, hsum] at hw
  have hnorm : ‖wron c w N‖ = 2 * ∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2 := by
    have hpos : (0 : ℝ) ≤ ∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2 :=
      Finset.sum_nonneg fun n _ => sq_nonneg _
    generalize (∑ n ∈ Finset.range (N + 1), ‖w n‖ ^ 2) = S at hw hpos ⊢
    rw [hw]
    simp [abs_of_nonneg hpos]
  have hle : ‖wron c w N‖ ≤ 2 * (‖c N‖ * (‖w (N + 1)‖ * ‖w N‖)) := by
    have h1 : ‖c N * (w (N + 1) * starRingEnd ℂ (w N))‖ = ‖c N‖ * (‖w (N + 1)‖ * ‖w N‖) := by
      simp
    have h2 : ‖starRingEnd ℂ (c N) * (starRingEnd ℂ (w (N + 1)) * w N)‖
        = ‖c N‖ * (‖w (N + 1)‖ * ‖w N‖) := by
      simp
    calc ‖wron c w N‖ ≤ ‖c N * (w (N + 1) * starRingEnd ℂ (w N))‖
          + ‖starRingEnd ℂ (c N) * (starRingEnd ℂ (w (N + 1)) * w N)‖ := norm_sub_le _ _
      _ = 2 * (‖c N‖ * (‖w (N + 1)‖ * ‖w N‖)) := by rw [h1, h2]; ring
  rw [hnorm] at hle
  linarith

/-- `∑ |w_n| |w_{n+1}|` converges for an `ℓ²` state. -/
theorem summable_mul_shift (w : L2N) :
    Summable fun n : ℕ => ‖(w : ℕ → ℂ) n‖ * ‖(w : ℕ → ℂ) (n + 1)‖ := by
  have hsq := summable_normSq w
  have hshift : Summable fun n : ℕ => ‖(w : ℕ → ℂ) (n + 1)‖ ^ 2 :=
    (summable_nat_add_iff 1).2 hsq
  refine Summable.of_nonneg_of_le (fun n => by positivity) (fun n => ?_)
    (((hsq.add hshift)).mul_left (1 / 2))
  have h := sq_nonneg (‖(w : ℕ → ℂ) n‖ - ‖(w : ℕ → ℂ) (n + 1)‖)
  nlinarith [h]

/-- **Carleman's criterion.**  If `∑ 1/|c_n| diverges`, the tridiagonal operator
is essentially self-adjoint on the finite-mode domain of `ℓ²(ℕ)`. -/
theorem tridiag_hasZeroDeficiencyOn_of_carleman (c : ℕ → ℂ)
    (hcar : ¬ Summable fun n => 1 / ‖c n‖) :
    HasZeroDeficiencyOn (lpFiniteModes ℕ) (tridiagOp c) := by
  have key : ∀ (z : ℂ), z = Complex.I ∨ z = -Complex.I → ∀ w : L2N,
      (∀ v : lpFiniteModes ℕ, (inner ℂ ((tridiagOp c v : lpFiniteModes ℕ) : L2N) w : ℂ)
        = inner ℂ ((v : lpFiniteModes ℕ) : L2N) (z • w)) → w = 0 := by
    intro z hz w hw
    by_contra hne
    -- the recursion, normalized to the `+i` case by conjugating the state if necessary
    have hrec : ∀ n, tridiagFun c ((w : L2N) : ℕ → ℂ) n = z * ((w : L2N) : ℕ → ℂ) n :=
      tridiag_recursion_of_deficiency c z w hw
    have hkey : ∀ N, ∑ n ∈ Finset.range (N + 1), ‖((w : L2N) : ℕ → ℂ) n‖ ^ 2
        ≤ ‖c N‖ * (‖((w : L2N) : ℕ → ℂ) (N + 1)‖ * ‖((w : L2N) : ℕ → ℂ) N‖) := by
      intro N
      rcases hz with hz | hz
      · exact sum_normSq_le c _ (by simpa [hz] using hrec) N
      · -- for `z = -i` the conjugate state solves the `+i` recursion
        have hconj : ∀ n, tridiagFun (fun k => starRingEnd ℂ (c k))
            (fun k => starRingEnd ℂ (((w : L2N) : ℕ → ℂ) k)) n
              = Complex.I * starRingEnd ℂ (((w : L2N) : ℕ → ℂ) n) := by
          intro n
          have h := congrArg (starRingEnd ℂ) (hrec n)
          cases n with
          | zero =>
            simpa [tridiagFun, hz, map_mul, Complex.conj_I] using h
          | succ m =>
            simpa [tridiagFun, hz, map_add, map_mul, Complex.conj_I] using h
        have := sum_normSq_le (fun k => starRingEnd ℂ (c k))
          (fun k => starRingEnd ℂ (((w : L2N) : ℕ → ℂ) k)) hconj N
        simpa using this
    -- some coefficient is nonzero
    obtain ⟨n₀, hn₀⟩ : ∃ n₀, ((w : L2N) : ℕ → ℂ) n₀ ≠ 0 := by
      by_contra hall
      push_neg at hall
      exact hne (by ext n; simpa using hall n)
    set S := ∑ n ∈ Finset.range (n₀ + 1), ‖((w : L2N) : ℕ → ℂ) n‖ ^ 2 with hS
    have hSpos : 0 < S := by
      refine Finset.sum_pos' (fun n _ => sq_nonneg _) ⟨n₀, Finset.self_mem_range_succ n₀, ?_⟩
      have : ‖((w : L2N) : ℕ → ℂ) n₀‖ ≠ 0 := norm_ne_zero_iff.2 hn₀
      positivity
    -- Carleman's sum converges — contradiction
    refine hcar ?_
    have hmono : ∀ N, n₀ ≤ N → S ≤ ‖c N‖ * (‖((w : L2N) : ℕ → ℂ) (N + 1)‖
        * ‖((w : L2N) : ℕ → ℂ) N‖) := by
      intro N hN
      refine le_trans ?_ (hkey N)
      rw [hS]
      have hsub : Finset.range (n₀ + 1) ⊆ Finset.range (N + 1) :=
        Finset.range_subset_range.2 (by omega)
      exact Finset.sum_le_sum_of_subset_of_nonneg hsub (fun n _ _ => sq_nonneg _)
    have hbound : ∀ N, n₀ ≤ N → 1 / ‖c N‖
        ≤ (1 / S) * (‖((w : L2N) : ℕ → ℂ) N‖ * ‖((w : L2N) : ℕ → ℂ) (N + 1)‖) := by
      intro N hN
      have h := hmono N hN
      have hcN : 0 < ‖c N‖ := by
        rcases (norm_nonneg (c N)).lt_or_eq with h' | h'
        · exact h'
        · exfalso
          rw [← h'] at h
          nlinarith [hSpos]
      rw [div_le_iff₀ hcN]
      rw [one_div, inv_mul_eq_div, div_mul_eq_mul_div, le_div_iff₀ hSpos]
      nlinarith [h, norm_nonneg (c N)]
    have hshift : Summable fun n : ℕ => 1 / ‖c (n + n₀)‖ := by
      have hmul : Summable fun n : ℕ =>
          ‖((w : L2N) : ℕ → ℂ) (n + n₀)‖ * ‖((w : L2N) : ℕ → ℂ) (n + n₀ + 1)‖ :=
        (summable_nat_add_iff n₀).2 (summable_mul_shift w)
      refine Summable.of_nonneg_of_le (fun n => by positivity)
        (fun n => hbound (n + n₀) (Nat.le_add_left _ _)) (hmul.mul_left (1 / S))
    exact (summable_nat_add_iff n₀).1 hshift
  exact ⟨key Complex.I (Or.inl rfl), fun w hw =>
    key (-Complex.I) (Or.inr rfl) w (by simpa using hw)⟩

/-! ## The half-line realization of the full Navier–Stokes Hamiltonian -/

section HalfLine

open NSFullData

/-- **The half-line momentum**: the symmetric-difference operator
`(p f)_n = -(i/2)(f_{n+1} - f_{n-1})` (with `f_{-1} = 0`), which is exactly the
tridiagonal operator with the constant coupling `-i/2`. -/
noncomputable def momOp : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ :=
  tridiagOp (fun _ => -(Complex.I / 2))

theorem momOp_isSymmetricDom : IsSymmetricDom momOp := tridiagOp_isSymmetricDom _

/-- The couplings produced by Weyl-symmetrizing the half-line momentum against
multiplication by the real sequence `a`. -/
noncomputable def nsCoupling (a : ℕ → ℝ) : ℕ → ℂ := fun n =>
  -(Complex.I / 2) * ((a n : ℂ) + (a (n + 1) : ℂ))

theorem tridiagOp_add (c c' : ℕ → ℂ) :
    tridiagOp c + tridiagOp c' = tridiagOp (fun n => c n + c' n) := by
  refine LinearMap.ext fun f => Subtype.ext (lp.ext ?_)
  funext n
  cases n with
  | zero => simp only [LinearMap.add_apply, Submodule.coe_add, lp.coeFn_add, Pi.add_apply,
      tridiagOp_coe, tridiagFun]; ring
  | succ m => simp only [LinearMap.add_apply, Submodule.coe_add, lp.coeFn_add, Pi.add_apply,
      tridiagOp_coe, tridiagFun, map_add]; ring

theorem tridiagOp_sum {ι : Type*} (s : Finset ι) (cc : ι → ℕ → ℂ) :
    (∑ i ∈ s, tridiagOp (cc i)) = tridiagOp (fun n => ∑ i ∈ s, cc i n) := by
  classical
  induction s using Finset.induction with
  | empty =>
      refine LinearMap.ext fun f => Subtype.ext (lp.ext ?_)
      funext n
      cases n with
      | zero => simp [tridiagFun]
      | succ m => simp [tridiagFun]
  | insert x s hx ih =>
      rw [Finset.sum_insert hx, ih, tridiagOp_add]
      congr 1
      funext n
      rw [Finset.sum_insert hx]

/-- **The Weyl-symmetrized product is tridiagonal.**  Symmetrizing the half-line
momentum against multiplication by a real sequence `a` gives the tridiagonal
operator with couplings `-(i/2)(a_n + a_{n+1})`. -/
theorem weyl_momOp_diagOp (a : ℕ → ℝ) :
    momOp.comp (diagOp a) + (diagOp a).comp momOp = tridiagOp (nsCoupling a) := by
  refine LinearMap.ext fun f => Subtype.ext (lp.ext ?_)
  funext n
  cases n with
  | zero =>
      simp only [LinearMap.add_apply, LinearMap.comp_apply, Submodule.coe_add, lp.coeFn_add,
        Pi.add_apply, momOp, tridiagOp_coe, diagOp_coe, tridiagFun, diagFun, nsCoupling]
      ring
  | succ m =>
      simp only [LinearMap.add_apply, LinearMap.comp_apply, Submodule.coe_add, lp.coeFn_add,
        Pi.add_apply, momOp, tridiagOp_coe, diagOp_coe, tridiagFun, diagFun, nsCoupling,
        map_mul, map_neg, map_div₀, Complex.conj_I, Complex.conj_ofNat, Complex.conj_ofReal,
        map_add]
      ring

/-- **The untruncated Navier–Stokes data on the half-line lattice**: the fifteen
field modes are multiplication by *arbitrary* — in particular unbounded — real
sequences, and each of the three momenta is the symmetric-difference momentum,
which does **not** commute with the modes. -/
noncomputable def halfLineFullData (c : Fin 15 → ℕ → ℝ) (nu : ℝ) : NSFullData L2N where
  D := lpFiniteModes ℕ
  u k := diagOp (c k)
  mom _ := momOp
  nu := nu
  dense := lpFiniteModes_dense
  u_symm k := diagOp_isSymmetricDom (c k)
  mom_symm _ := momOp_isSymmetricDom
  u_comm k l := by rw [diagOp_comp, diagOp_comp]; simp [mul_comm]

/-- The Navier–Stokes term `A_i = ∑_j u_j u_{i,j} − ν u_{i,jj}` as a real
sequence. -/
def halfLineAlpha (c : Fin 15 → ℕ → ℝ) (nu : ℝ) (i : Fin 3) : ℕ → ℝ := fun n =>
  (∑ j : Fin 3, c (nsVelIdx j) n * c (nsGradIdx i j) n) - nu * c (nsLapIdx i) n

/-- The total Navier–Stokes symbol `∑_i A_i`. -/
def halfLineSymbol (c : Fin 15 → ℕ → ℝ) (nu : ℝ) : ℕ → ℝ := fun n =>
  ∑ i : Fin 3, halfLineAlpha c nu i n

theorem halfLineFullData_advection (c : Fin 15 → ℕ → ℝ) (nu : ℝ) (i : Fin 3) :
    (halfLineFullData c nu).advection i = diagOp (halfLineAlpha c nu i) := by
  simp only [NSFullData.advection, NSFullData.velocity, NSFullData.gradVelocity,
    NSFullData.lapVelocity, halfLineFullData, diagOp_comp, diagOp_sum, diagOp_real_smul,
    diagOp_sub]
  rfl

/-- **The full Navier–Stokes Hamiltonian of the half-line realization is a
tridiagonal (Jacobi) operator**, with couplings `-(i/2)(α_n + α_{n+1})` for the
total Navier–Stokes symbol `α`. -/
theorem halfLineFullData_hamiltonian (c : Fin 15 → ℕ → ℝ) (nu : ℝ) :
    (halfLineFullData c nu).hamiltonian = tridiagOp (nsCoupling (halfLineSymbol c nu)) := by
  have h : ∀ i : Fin 3,
      ((halfLineFullData c nu).mom i).comp ((halfLineFullData c nu).advection i)
        + ((halfLineFullData c nu).advection i).comp ((halfLineFullData c nu).mom i)
        = tridiagOp (nsCoupling (halfLineAlpha c nu i)) := by
    intro i
    rw [halfLineFullData_advection]
    exact weyl_momOp_diagOp _
  rw [NSFullData.hamiltonian, Finset.sum_congr rfl (fun i _ => h i), tridiagOp_sum]
  congr 1
  funext n
  simp only [nsCoupling, halfLineSymbol, Complex.ofReal_sum]
  rw [show (∑ i : Fin 3, ((halfLineAlpha c nu i n : ℝ) : ℂ))
        + (∑ i : Fin 3, ((halfLineAlpha c nu i (n + 1) : ℝ) : ℂ))
      = ∑ i : Fin 3, (((halfLineAlpha c nu i n : ℝ) : ℂ)
          + ((halfLineAlpha c nu i (n + 1) : ℝ) : ℂ)) from Finset.sum_add_distrib.symm,
    Finset.mul_sum]

/-- **The headline.**  The full (untruncated) Navier–Stokes Hamiltonian of the
half-line realization — unbounded modes, non-commuting momentum — is essentially
self-adjoint on the finite-mode domain of `ℓ²(ℕ)` as soon as the Navier–Stokes
symbol satisfies Carleman's growth condition. -/
theorem halfLineFull_hasZeroDeficiencyOn (c : Fin 15 → ℕ → ℝ) (nu : ℝ)
    (hcar : ¬ Summable fun n => 1 / ‖nsCoupling (halfLineSymbol c nu) n‖) :
    HasZeroDeficiencyOn (halfLineFullData c nu).D (halfLineFullData c nu).hamiltonian := by
  rw [halfLineFullData_hamiltonian]
  exact tridiag_hasZeroDeficiencyOn_of_carleman _ hcar

/-! ### A concrete unbounded instance: a linearly growing field -/

/-- The field modes of the linear instance: the viscous mode `u_{0,jj}` grows
linearly, every other mode vanishes. -/
noncomputable def linearMode (k : Fin 15) : ℕ → ℝ :=
  if k = nsLapIdx 0 then fun n => -((n : ℝ) + 1) else fun _ => 0

/-- The untruncated half-line Navier–Stokes data with a linearly growing viscous
mode and unit viscosity. -/
noncomputable def linearFullData : NSFullData L2N := halfLineFullData linearMode 1

theorem linearFullData_eq : linearFullData = halfLineFullData linearMode 1 := rfl

theorem linearFullData_symbol : halfLineSymbol linearMode 1 = fun m : ℕ => (m : ℝ) + 1 := by
  funext n
  simp only [halfLineSymbol, halfLineAlpha, linearMode, Fin.sum_univ_three]
  norm_num [nsVelIdx, nsGradIdx, nsLapIdx, Fin.ext_iff]

theorem norm_nsCoupling_linear (n : ℕ) :
    ‖nsCoupling (fun m : ℕ => (m : ℝ) + 1) n‖ = ((n : ℝ) + 3 / 2) := by
  have h : ((((n : ℝ) + 1 : ℝ)) : ℂ) + (((((n + 1 : ℕ) : ℝ) + 1 : ℝ)) : ℂ)
      = (((2 * (n : ℝ) + 3 : ℝ)) : ℂ) := by
    push_cast
    ring
  simp only [nsCoupling, h, norm_mul, norm_neg, norm_div, Complex.norm_I,
    Complex.norm_real, Real.norm_eq_abs]
  rw [abs_of_nonneg (by positivity : (0 : ℝ) ≤ 2 * (n : ℝ) + 3)]
  norm_num
  ring

theorem not_summable_nsCoupling_linear :
    ¬ Summable fun n : ℕ => 1 / ‖nsCoupling (fun m : ℕ => (m : ℝ) + 1) n‖ := by
  intro hs
  have hle : ∀ n : ℕ, 1 / (((n : ℝ) + 2)) ≤ 1 / ‖nsCoupling (fun m : ℕ => (m : ℝ) + 1) n‖ := by
    intro n
    rw [norm_nsCoupling_linear]
    have h1 : (0 : ℝ) < (n : ℝ) + 3 / 2 := by positivity
    have h2 : (n : ℝ) + 3 / 2 ≤ (n : ℝ) + 2 := by linarith
    exact one_div_le_one_div_of_le h1 h2
  have hsum : Summable fun n : ℕ => 1 / (((n : ℝ) + 2)) :=
    Summable.of_nonneg_of_le (fun n => by positivity) hle hs
  have hcast : (fun n : ℕ => 1 / ((n + 2 : ℕ) : ℝ)) = fun n : ℕ => 1 / (((n : ℝ) + 2)) := by
    funext n; push_cast; ring
  exact Real.not_summable_one_div_natCast ((summable_nat_add_iff 2).1 (by rw [hcast]; exact hsum))

/-- **A concrete unbounded, non-commuting, essentially self-adjoint full
Navier–Stokes Hamiltonian.** -/
theorem linearFull_hasZeroDeficiencyOn :
    HasZeroDeficiencyOn linearFullData.D linearFullData.hamiltonian := by
  refine halfLineFull_hasZeroDeficiencyOn linearMode 1 ?_
  rw [linearFullData_symbol]
  exact not_summable_nsCoupling_linear

/-- The tridiagonal operator is unbounded as soon as its couplings are. -/
theorem tridiagOp_not_bounded (c : ℕ → ℂ) (hc : ∀ C : ℝ, ∃ n, C < ‖c n‖) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes ℕ, ‖tridiagOp c f‖ ≤ C * ‖f‖ := by
  rintro ⟨C, hC⟩
  obtain ⟨k, hk⟩ := hc C
  have hb := hC (basis (k + 1))
  rw [norm_basis, mul_one] at hb
  have hcoord : ‖(((tridiagOp c (basis (k + 1)) : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) k‖ ≤
      ‖((tridiagOp c (basis (k + 1)) : lpFiniteModes ℕ) : L2N)‖ :=
    lp.norm_apply_le_norm (by norm_num) _ k
  have hval : (((tridiagOp c (basis (k + 1)) : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) k = c k := by
    rw [tridiagOp_basis_succ]
    simp [lp.single_apply]
  rw [hval] at hcoord
  have : ‖c k‖ ≤ C := le_trans hcoord hb
  exact absurd hk (not_lt.mpr this)

theorem linearFull_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : linearFullData.D, ‖linearFullData.hamiltonian f‖ ≤ C * ‖f‖ := by
  have hham : (halfLineFullData linearMode 1).hamiltonian
      = tridiagOp (nsCoupling (fun m : ℕ => (m : ℝ) + 1)) := by
    rw [halfLineFullData_hamiltonian, linearFullData_symbol]
  have hnb : ¬ ∃ C : ℝ, ∀ f : lpFiniteModes ℕ,
      ‖tridiagOp (nsCoupling (fun m : ℕ => (m : ℝ) + 1)) f‖ ≤ C * ‖f‖ := by
    refine tridiagOp_not_bounded _ fun C => ?_
    refine ⟨⌈|C|⌉₊, ?_⟩
    rw [norm_nsCoupling_linear]
    have hc : C ≤ |C| := le_abs_self C
    have hn : |C| ≤ (⌈|C|⌉₊ : ℝ) := Nat.le_ceil _
    linarith
  rintro ⟨C, hC⟩
  exact hnb ⟨C, fun f => by rw [← hham]; exact hC f⟩

end HalfLine

end Carleman

end BookProof.NavierStokesFlow
