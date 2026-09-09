import Mathlib

/-!
# Chapter "Wave-function parametrization of a probability measure" /
# Introduction §"Wave-function collapse versus Euler's formula" —
# the gauge ambiguity of the Born-rule parametrization

Source: `book.tex`, Introduction, section *"Wave-function collapse versus Euler's
formula"* (`book.tex` line ~805): *"the wave-function is nothing else than one
possible parametrization of any probability distribution; the parametrization is
a surjective map from an hypersphere to the set of all possible probability
distributions. **Two wave-functions are always related by a rotation of the
hypersphere**, which is a linear transformation and it preserves the
hypersphere."*

Surjectivity of the Born map is already formalized (`ChapterB.born_forward`,
`ChapterE.stickBreaking_surjective`, `ChapterEulerNState.euler_reproduces`).  This
file formalizes the complementary statement — the exact **fiber** of the Born
map, i.e. precisely *when two wave-functions give the same probability
distribution*.  This is the "gauge ambiguity" of the parametrization: two
complex wave-functions reproduce the same Born probabilities **iff** they differ
by a coordinate-wise phase `e^{iθₖ}` (a diagonal unitary), and two real
wave-functions differ by a coordinate-wise sign `±1`.

## Main results

* `Complex.normSq_eq_iff_exists_phase` — pointwise: `normSq z = normSq w ↔
  ∃ θ, w = e^{iθ}·z`.
* `born_fiber_complex` — for `u v : Fin n → ℂ`, they have equal Born
  probabilities (`∀ k, normSq (u k) = normSq (v k)`) iff there is a
  coordinate-wise phase `θ : Fin n → ℝ` with `v k = e^{iθₖ}·u k`.
* `sq_eq_iff_exists_sign` — pointwise real: `u^2 = v^2 ↔ ∃ s ∈ {±1}, v = s·u`.
* `born_fiber_real` — for `u v : Fin n → ℝ`, equal Born probabilities
  (`∀ k, (u k)^2 = (v k)^2`) iff there is a coordinate-wise sign `s : Fin n → ℝ`
  (each `s k = 1 ∨ s k = -1`) with `v k = s k · u k`.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open Complex

namespace BookProof.ChapterBornPhaseFiber

/-
Pointwise complex phase fiber: two complex numbers have equal squared modulus
iff they differ by a unit phase `e^{iθ}`.
-/
theorem Complex.normSq_eq_iff_exists_phase (z w : ℂ) :
    Complex.normSq z = Complex.normSq w ↔ ∃ θ : ℝ, w = Complex.exp (θ * Complex.I) * z := by
  constructor <;> intro h;
  · rw [ ← Complex.norm_mul_exp_arg_mul_I w, ← Complex.norm_mul_exp_arg_mul_I z ];
    simp_all only [normSq_eq_norm_sq, norm_nonneg, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true,
        pow_left_inj₀, norm_mul_exp_arg_mul_I];
    exact ⟨ w.arg - z.arg, by push_cast; rw [ mul_left_comm, ← Complex.exp_add ] ; simp [
                              Complex.ext_iff, Complex.exp_re, Complex.exp_im ] ⟩;
  · obtain ⟨ θ, rfl ⟩ := h; simp [ Complex.normSq_eq_norm_sq, Complex.norm_exp ] ;

/-
**Born fiber (complex case).** Two complex wave-functions `u, v : Fin n → ℂ`
reproduce the same Born probability distribution (`normSq (u k) = normSq (v k)`
for all `k`) if and only if they are related by a coordinate-wise phase
`e^{iθₖ}` — a diagonal unitary. This is the gauge ambiguity of the Born-rule
parametrization referenced in the book.
-/
theorem born_fiber_complex {n : ℕ} (u v : Fin n → ℂ) :
    (∀ k, Complex.normSq (u k) = Complex.normSq (v k)) ↔
      ∃ θ : Fin n → ℝ, ∀ k, v k = Complex.exp (θ k * Complex.I) * u k := by
  constructor;
  · intro h;
    exact ⟨ fun k => Classical.choose ( Complex.normSq_eq_iff_exists_phase ( u k ) ( v k ) |>.1 ( h
        k ) ), fun k => Classical.choose_spec ( Complex.normSq_eq_iff_exists_phase ( u k ) ( v k )
            |>.1 ( h k ) ) ⟩;
  · rintro ⟨ θ, hθ ⟩ k; simp [ hθ k, Complex.normSq_eq_norm_sq ] ;

/-
Pointwise real sign fiber: two reals have equal squares iff they differ by a
sign `±1`.
-/
theorem sq_eq_iff_exists_sign (a b : ℝ) :
    a ^ 2 = b ^ 2 ↔ ∃ s : ℝ, (s = 1 ∨ s = -1) ∧ b = s * a := by
  grind

/-
**Born fiber (real case).** Two real wave-functions `u, v : Fin n → ℝ`
reproduce the same Born probability distribution (`(u k)^2 = (v k)^2` for all
`k`) if and only if they are related by a coordinate-wise sign `±1`.
-/
theorem born_fiber_real {n : ℕ} (u v : Fin n → ℝ) :
    (∀ k, (u k) ^ 2 = (v k) ^ 2) ↔
      ∃ s : Fin n → ℝ, (∀ k, s k = 1 ∨ s k = -1) ∧ ∀ k, v k = s k * u k := by
  refine ⟨ fun h => ?_, fun h => ?_ ⟩;
  · use fun k => if u k = 0 then 1 else v k / u k;
    grind;
  · grind


/-! ## Probability amplitudes and average versus maximal control -/

/-- A finite probability density has a square-root amplitude of squared `ℓ²`
norm one. -/
theorem sqrt_density_sq_sum {n : ℕ} (ρ : Fin n → ℝ)
    (hρ : ∀ i, 0 ≤ ρ i) (hsum : ∑ i, ρ i = 1) :
    ∑ i, (Real.sqrt (ρ i)) ^ 2 = 1 := by
  simp_rw [Real.sq_sqrt (hρ _)]
  exact hsum

/-- On a finite probability space, average squared error is bounded by maximal
squared error.  This cleanly separates `L²` average control from `L∞` control. -/
theorem average_sq_le_max_sq {n : ℕ} (p : Fin n → ℝ)
    (hp : ∀ i, 0 ≤ p i) (hsum : ∑ i, p i = 1)
    (e : Fin n → ℝ) (C : ℝ) (hC : ∀ i, |e i| ≤ C) :
    ∑ i, p i * (e i) ^ 2 ≤ C ^ 2 := by
  by_cases hn : n = 0
  · subst n
    simp only [Finset.univ_eq_empty, Finset.sum_empty]
    positivity
  have hC0 : 0 ≤ C :=
    (abs_nonneg (e ⟨0, Nat.pos_of_ne_zero hn⟩)).trans
      (hC ⟨0, Nat.pos_of_ne_zero hn⟩)
  calc
    ∑ i, p i * (e i) ^ 2 ≤ ∑ i, p i * C ^ 2 := by
      apply Finset.sum_le_sum
      intro i _
      apply mul_le_mul_of_nonneg_left _ (hp i)
      simpa only [sq_abs] using
        (sq_le_sq₀ (abs_nonneg (e i)) hC0 |>.mpr (hC i))
    _ = C ^ 2 := by rw [← Finset.sum_mul, hsum, one_mul]

/-- Multiplication operators by scalar functions commute pointwise; this is the
finite-dimensional abelian-algebra core of the `L∞` multiplication-operator
statement. -/
theorem multiplication_operators_commute {n : ℕ} (f g v : Fin n → ℂ) :
    (fun i => f i * (g i * v i)) = (fun i => g i * (f i * v i)) := by
  funext i
  ring

end BookProof.ChapterBornPhaseFiber
