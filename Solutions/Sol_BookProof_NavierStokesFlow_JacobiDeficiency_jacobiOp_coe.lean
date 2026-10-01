-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.jacobiOp_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency



open scoped ENNReal

set_option maxHeartbeats 1000000 in
 :=
  import Mathlib
  import BookProof.ChapterNavierStokesEsa
  
  /-!
  # Symmetry and density are not enough: an operator whose adjoint has deficiency
  
  Companion to `BookProof.ChapterNavierStokesEsa`.  That module proves two
  *positive* criteria for essential self-adjointness on a dense domain: a complete
  unitary flow suffices (`hasZeroDeficiencyOn_of_completeUnitaryFlow`), and so does
  boundedness (`hasZeroDeficiencyOn_of_bounded_symmetric`).
  
  This module supplies the matching *negative* fact, which is what makes those
  criteria necessary rather than decorative: there is a symmetric operator, defined
  on a dense invariant domain of a Hilbert space, whose adjoint **does** have a
  deficiency vector — so it is not essentially self-adjoint.  Hence no argument
  resting only on symmetry (the "polynomial of low degree in the fields" input of
  `book.tex` ~4199) can establish essential self-adjointness; an analytic criterion
  — flow completeness, boundedness, Faris–Lavine — is genuinely required.
  
  The example is the classical *limit-circle Jacobi matrix*: on `ℓ²(ℕ)`, with the
  finitely supported states as domain,
  
  `(H f)(0) = a₀ f(1)`,  `(H f)(n+1) = aₙ f(n) + a₍ₙ₊₁₎ f(n+2)`,
  
  a real symmetric tridiagonal operator with rapidly growing weights
  `a₀ = 2`, `a₍ₙ₊₁₎ = 4aₙ + 2`.  The weights are chosen so that the geometric
  sequence `w(n) = (i/2)ⁿ` — which is square-summable — solves `H w = i w`
  coefficientwise, and therefore is a deficiency vector of the adjoint.
  
  ## Scope
  
  This is a statement about a concrete example, not about Navier–Stokes: it
  delimits what the truncation results of `BookProof.ChapterNavierStokesFlow` can
  and cannot be extended by.  Nothing here claims anything about the continuum
  Navier–Stokes generator.
  -/
  
  open scoped ENNReal
  
  namespace BookProof.NavierStokesFlow
  
  namespace LpNat
  
  /-- The Hilbert space `ℓ²(ℕ)`. -/
  noncomputable abbrev L2N := lp (fun _ : ℕ => ℂ) 2
  
  /-- Square-summability of the moduli is membership in `ℓ²`. -/
  theorem memLpTwo_of_summable_normSq {ι : Type*} {g : ι → ℂ}
      (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
    apply memℓp_gen
    simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h
  
  /-- A function vanishing from some index on lies in `ℓ²`. -/
  theorem memLpTwo_of_tail_zero {g : ℕ → ℂ} {N : ℕ} (h : ∀ n, N ≤ n → g n = 0) : Memℓp g 2 := by
    refine memLpTwo_of_summable_normSq (summable_of_ne_finset_zero (s := Finset.range N) ?_)
    intro n hn
    rw [h n (by simpa using hn)]
    simp
  
  /-- A state of `ℓ²(ℕ)` with finitely many excited modes vanishes from some index
  on. -/
  theorem exists_tail_zero {f : L2N} (hf : f ∈ lpFiniteModes ℕ) :
      ∃ N, ∀ n, N ≤ n → (f : ℕ → ℂ) n = 0 := by
    obtain ⟨b, hb⟩ := (mem_lpFiniteModes.mp hf).bddAbove
    refine ⟨b + 1, fun n hn => ?_⟩
    by_contra hne
    exact absurd (hb hne) (by omega)
  
  /-- Conversely, a state vanishing from some index on has finitely many excited
  modes. -/
  theorem mem_lpFiniteModes_of_tail_zero {f : L2N} {N : ℕ}
      (h : ∀ n, N ≤ n → (f : ℕ → ℂ) n = 0) : f ∈ lpFiniteModes ℕ := by
    refine Set.Finite.subset (Set.finite_Iio N) fun n hn => ?_
    simp only [Function.mem_support] at hn
    exact lt_of_not_ge fun hge => hn (h n hge)
  
  /-! ## Inner products against a finitely supported state -/
  
  /-- Against a state vanishing from `N` on, the `ℓ²` inner product is a finite
  sum. -/
  theorem inner_eq_sum_range {f g : L2N} {N : ℕ} (hf : ∀ n, N ≤ n → (f : ℕ → ℂ) n = 0) :
      (inner ℂ f g : ℂ)
        = ∑ n ∈ Finset.range N, starRingEnd ℂ ((f : ℕ → ℂ) n) * (g : ℕ → ℂ) n := by
    have h0 : ∀ n ∉ Finset.range N, ((g : ℕ → ℂ) n) * starRingEnd ℂ ((f : ℕ → ℂ) n) = 0 := by
      intro n hn
      rw [hf n (by simpa using hn)]
      simp
    rw [lp.inner_eq_tsum]
    simp only [RCLike.inner_apply]
    rw [tsum_eq_sum h0]
    exact Finset.sum_congr rfl fun n _ => mul_comm _ _
  end LpNat
  
  namespace JacobiDeficiency
  
  open LpNat
  
  /-! ## The Jacobi weights and the tridiagonal operator -/
  
  /-- The Jacobi weights `a₀ = 2`, `a₍ₙ₊₁₎ = 4aₙ + 2`: growing fast enough that
  the operator below is in the *limit-circle* case. -/
  def jacobiWeight : ℕ → ℝ
    | 0 => 2
    | (n + 1) => 4 * jacobiWeight n + 2
  
  theorem jacobiWeight_pos (n : ℕ) : 0 < jacobiWeight n := by
    induction n with
    | zero => norm_num [jacobiWeight]
    | succ n ih => simp only [jacobiWeight]; linarith
  
  /-- The weights grow at least geometrically — the operator is unbounded. -/
  theorem jacobiWeight_ge (n : ℕ) : (2 : ℝ) * 4 ^ n ≤ jacobiWeight n := by
    induction n with
    | zero => norm_num [jacobiWeight]
    | succ n ih => simp only [jacobiWeight, pow_succ]; linarith
  
  /-- The coefficient action of the tridiagonal operator. -/
  def jacobiFun (f : ℕ → ℂ) : ℕ → ℂ
    | 0 => (jacobiWeight 0 : ℂ) * f 1
    | (n + 1) => (jacobiWeight n : ℂ) * f n + (jacobiWeight (n + 1) : ℂ) * f (n + 2)
  
  theorem jacobiFun_add (f g : ℕ → ℂ) (n : ℕ) :
      jacobiFun (f + g) n = jacobiFun f n + jacobiFun g n := by
    cases n with
    | zero => simp only [jacobiFun, Pi.add_apply]; ring
    | succ m => simp only [jacobiFun, Pi.add_apply]; ring
  
  theorem jacobiFun_smul (c : ℂ) (f : ℕ → ℂ) (n : ℕ) :
      jacobiFun (c • f) n = c * jacobiFun f n := by
    cases n with
    | zero => simp only [jacobiFun, Pi.smul_apply, smul_eq_mul]; ring
    | succ m => simp only [jacobiFun, Pi.smul_apply, smul_eq_mul]; ring
  
  theorem jacobiFun_tail_zero {f : ℕ → ℂ} {N : ℕ} (h : ∀ n, N ≤ n → f n = 0) :
      ∀ n, N + 1 ≤ n → jacobiFun f n = 0 := by
    intro n hn
    cases n with
    | zero => omega
    | succ m =>
      have hm : N ≤ m := by omega
      simp [jacobiFun, h m hm, h (m + 2) (by omega)]
  
  /-- **The discrete Green identity.**  Summing the "Wronskian" increments of two
  sequences telescopes: the failure of symmetry on a truncated window is a pure
  boundary term.  Symmetry of the operator on finitely supported states, and the
  deficiency identity below, are both instances of this one computation. -/
  theorem jacobi_wronskian (x y : ℕ → ℂ) (N : ℕ) :
      ∑ n ∈ Finset.range (N + 1),
          (starRingEnd ℂ (jacobiFun x n) * y n - starRingEnd ℂ (x n) * jacobiFun y n)
        = (jacobiWeight N : ℂ) *
            (starRingEnd ℂ (x (N + 1)) * y N - starRingEnd ℂ (x N) * y (N + 1)) := by
    induction N with
    | zero =>
      simp [jacobiFun, Complex.conj_ofReal]
      ring
    | succ N ih =>
      rw [Finset.sum_range_succ, ih]
      simp only [jacobiFun, map_add, map_mul, Complex.conj_ofReal]
      ring
  
  /-- The tridiagonal operator on the domain of finitely supported states. -/
  noncomputable def jacobiOp : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ where
    toFun f :=
      ⟨⟨jacobiFun ((f : L2N) : ℕ → ℂ), by
          obtain ⟨N, hN⟩ := exists_tail_zero f.2
          exact memLpTwo_of_tail_zero (jacobiFun_tail_zero hN)⟩, by
        obtain ⟨N, hN⟩ := exists_tail_zero f.2
        exact mem_lpFiniteModes_of_tail_zero (N := N + 1) (jacobiFun_tail_zero hN)⟩
    map_add' f g := by
      ext n
      exact jacobiFun_add ((f : L2N) : ℕ → ℂ) ((g : L2N) : ℕ → ℂ) n
    map_smul' c f := by
      ext n
      simpa using jacobiFun_smul c ((f : L2N) : ℕ → ℂ) n
  
  @[simp] theorem jacobiOp_coe (f : lpFiniteModes ℕ) :
      (((jacobiOp f : lpFiniteModes ℕ) : L2N) : ℕ → ℂ) = jacobiFun ((f : L2N) : ℕ → ℂ
