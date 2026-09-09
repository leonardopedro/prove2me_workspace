import Mathlib

/-!
# Chapter "Black hole information paradox and the Stern-Gerlach experiment"

This file formalizes the self-contained mathematical content of the section
*"Black hole information paradox and the Stern-Gerlach experiment"* (and the
preceding *"The Stern-Gerlach experiment"*) of the chapter *"Wave-function
collapse versus Euler's formula"* (`book.tex`, lines ~3344–3476).

The book's central self-contained claim there is:

> *"there is always a unitary transformation such that the corresponding
> probability distribution is necessarily the constant distribution, for all
> initial states in the same orthogonal basis."*

In Born's rule, applying a unitary `U` to a basis state `eⱼ` and measuring in the
same basis gives the probability distribution `i ↦ |Uᵢⱼ|²`.  The claim is that
for **any** finite dimension `n` there is a unitary `U` whose *every* entry has
`|Uᵢⱼ|² = 1/n`, i.e. every basis input produces the *uniform* (constant) output
distribution.  This is exactly the statement that a "black hole" transformation
can turn any incoming basis state into a maximally mixed (information-erased)
distribution while remaining unitary.

We realize this with the (unnormalized) **discrete Fourier transform matrix**
`Uᵢⱼ = exp(2πi·i·j/n)/√n`, a complex Hadamard matrix.  For `n = 2` this is the
usual Hadamard gate `(1/√2)·[[1,1],[1,-1]]`, the two-state case the book uses to
model the Stern-Gerlach experiment.

We also record the concrete numerical fact behind the sequential Stern-Gerlach
experiment: a `π/4` rotation of the two-state spin gives the `50%/50%`
distribution, `cos²(π/4) = sin²(π/4) = 1/2`.

All results are `sorry`-free and axiom-clean (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterSternGerlach

open Complex Matrix Finset

/-- The (normalized) discrete Fourier transform matrix on `Fin n`:
`Uᵢⱼ = exp(2πi·i·j/n)/√n`.  A complex Hadamard matrix; for `n = 2` it is the
Hadamard gate. -/
noncomputable def dftMatrix (n : ℕ) : Matrix (Fin n) (Fin n) ℂ :=
  fun i j => Complex.exp (2 * Real.pi * Complex.I * (i.val * j.val) / n) / Real.sqrt n

/-- The squared modulus of `exp(θi)` for real `θ` is `1`. -/
lemma normSq_exp_mul_I (θ : ℝ) :
    Complex.normSq (Complex.exp ((θ : ℂ) * Complex.I)) = 1 := by
  rw [Complex.exp_mul_I, ← Complex.ofReal_cos, ← Complex.ofReal_sin,
    Complex.normSq_add_mul_I]
  exact Real.cos_sq_add_sin_sq θ

/-- Every entry of the DFT matrix lies on the circle of radius `1/√n`; its
squared modulus is exactly `1/n`.  This is the "constant/uniform distribution"
property: reading any column (a Born distribution) gives the uniform law. -/
lemma dft_normSq (n : ℕ) (hn : 0 < n) (i j : Fin n) :
    Complex.normSq (dftMatrix n i j) = 1 / n := by
  unfold dftMatrix
  rw [map_div₀]
  have hexp : (2 * (Real.pi : ℂ) * Complex.I * (i.val * j.val) / n)
      = ((2 * Real.pi * (i.val * j.val) / n : ℝ) : ℂ) * Complex.I := by
    push_cast; ring
  rw [hexp, normSq_exp_mul_I]
  have hsqrt : Complex.normSq (Real.sqrt n : ℂ) = n := by
    rw [Complex.normSq_ofReal, Real.mul_self_sqrt (by positivity)]
  rw [hsqrt]

/-- A single column of the DFT matrix is a genuine probability distribution:
its squared moduli sum to `1`. -/
lemma dft_column_sum (n : ℕ) (hn : 0 < n) (j : Fin n) :
    ∑ i, Complex.normSq (dftMatrix n i j) = 1 := by
  rw [Finset.sum_congr rfl (fun i _ => dft_normSq n hn i j)]
  rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  field_simp

/-- Key orthogonality computation: for `a : ℤ` with `n ∤ a` (encoded here as the
root of unity `exp(2πi·a/n) ≠ 1`), the geometric sum of its powers over a full
period vanishes. -/
lemma dft_geom_sum_zero (n : ℕ) (w : ℂ) (hw : w ≠ 1) (hwn : w ^ n = 1) :
    ∑ i ∈ Finset.range n, w ^ i = 0 := by
  rw [geom_sum_eq hw, hwn]; simp

/-- The DFT matrix is unitary: `U · Uᴴ = 1`. -/
lemma dft_unitary (n : ℕ) (hn : 0 < n) :
    dftMatrix n * star (dftMatrix n) = 1 := by
  ext i k
  have hnc : (n : ℂ) ≠ 0 := by exact_mod_cast hn.ne'
  rw [Matrix.mul_apply]
  simp only [Matrix.star_apply, dftMatrix, Matrix.one_apply]
  set w : ℂ := Complex.exp (2 * Real.pi * Complex.I * ((i.val : ℂ) - k.val) / n) with hwdef
  have key : ∀ j : Fin n,
      Complex.exp (2 * Real.pi * Complex.I * (i.val * j.val) / n) / (Real.sqrt n : ℂ) *
        star (Complex.exp (2 * Real.pi * Complex.I * (k.val * j.val) / n) / (Real.sqrt n : ℂ))
      = w ^ (j.val) / n := by
    intro j
    rw [hwdef, star_div₀, Complex.star_def, Complex.conj_ofReal, ← Complex.exp_conj]
    have hconj : (starRingEnd ℂ) (2 * Real.pi * Complex.I * (k.val * j.val) / n)
        = - (2 * Real.pi * Complex.I * (k.val * j.val) / n) := by
      simp only [map_div₀, map_mul, Complex.conj_ofReal, Complex.conj_I, map_ofNat, map_natCast]
      ring
    rw [hconj, ← Complex.exp_nat_mul, div_mul_div_comm, ← Complex.exp_add]
    congr 1
    · congr 1; ring
    · rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity), Complex.ofReal_natCast]
  rw [Finset.sum_congr rfl (fun j _ => key j)]
  rw [← Finset.sum_div, Fin.sum_univ_eq_sum_range (fun m => w ^ m)]
  by_cases hik : i = k
  · subst hik
    have hw1 : w = 1 := by rw [hwdef]; simp
    rw [hw1]
    simp only [one_pow, Finset.sum_const, Finset.card_range, nsmul_eq_mul, mul_one, if_true]
    field_simp
  · have hwn : w ^ n = 1 := by
      rw [hwdef, ← Complex.exp_nat_mul]
      have heq : (n : ℂ) * (2 * Real.pi * Complex.I * ((i.val : ℂ) - k.val) / n)
          = (((i.val : ℤ) - k.val : ℤ) : ℂ) * (2 * Real.pi * Complex.I) := by
        push_cast; field_simp
      rw [heq, Complex.exp_int_mul_two_pi_mul_I]
    have hwne : w ≠ 1 := by
      rw [hwdef, Ne, Complex.exp_eq_one_iff]
      rintro ⟨m, hm⟩
      have hA : (2 * (Real.pi : ℂ) * Complex.I) ≠ 0 := by
        simp [Real.pi_ne_zero, Complex.I_ne_zero]
      have h2 : ((i.val : ℂ) - k.val) = (m : ℂ) * n := by
        field_simp at hm
        linear_combination hm
      have hint : ((i.val : ℤ) - k.val) = m * n := by exact_mod_cast h2
      have hdvd : (n : ℤ) ∣ ((i.val : ℤ) - k.val) := ⟨m, by linarith [hint]⟩
      have hdne : ((i.val : ℤ) - k.val) ≠ 0 := by
        intro h; apply hik; apply Fin.ext; omega
      have hle : (n : ℤ) ≤ |((i.val : ℤ) - k.val)| :=
        Int.le_of_dvd (abs_pos.mpr hdne) ((dvd_abs _ _).mpr hdvd)
      have hbi : (i.val : ℤ) < n := by exact_mod_cast i.isLt
      have hbk : (k.val : ℤ) < n := by exact_mod_cast k.isLt
      have hub : |((i.val : ℤ) - k.val)| < n := by rw [abs_lt]; omega
      linarith [hle, hub]
    rw [dft_geom_sum_zero n w hwne hwn, zero_div, if_neg hik]

/-- The DFT matrix is a member of the unitary group. -/
lemma dft_mem_unitaryGroup (n : ℕ) (hn : 0 < n) :
    dftMatrix n ∈ Matrix.unitaryGroup (Fin n) ℂ := by
  rw [Matrix.mem_unitaryGroup_iff]
  exact dft_unitary n hn

/-- **Headline (black-hole information / Stern-Gerlach).**  For every finite
dimension `n ≥ 1` there is a unitary transformation `U` such that measuring the
image of *any* basis state in the same basis yields the *constant* (uniform)
probability distribution `i ↦ 1/n`.  A unitary time evolution can therefore turn
any incoming basis state into a maximally mixed, information-erased state. -/
theorem exists_uniform_unitary (n : ℕ) (hn : 0 < n) :
    ∃ U ∈ Matrix.unitaryGroup (Fin n) ℂ,
      ∀ i j : Fin n, Complex.normSq (U i j) = 1 / n :=
  ⟨dftMatrix n, dft_mem_unitaryGroup n hn, fun i j => dft_normSq n hn i j⟩

/-- The two-state Stern-Gerlach `π/4` rotation gives probability `1/2` for the
`+` outcome: `cos²(π/4) = 1/2`. -/
lemma sg_cos_sq_quarter : Real.cos (Real.pi / 4) ^ 2 = 1 / 2 := by
  rw [Real.cos_pi_div_four, div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]; norm_num

/-- The two-state Stern-Gerlach `π/4` rotation gives probability `1/2` for the
`-` outcome: `sin²(π/4) = 1/2`. -/
lemma sg_sin_sq_quarter : Real.sin (Real.pi / 4) ^ 2 = 1 / 2 := by
  rw [Real.sin_pi_div_four, div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]; norm_num

end BookProof.ChapterSternGerlach
