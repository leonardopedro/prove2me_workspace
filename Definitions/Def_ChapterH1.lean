import Mathlib


/-!
# Chapter H1 — Hashimoto SIRK: φ-functions and resolvent algebra (roadmap N13, §0 S7)

This file formalizes the algebraic backbone of the Hashimoto–Nodera *Shift-invert
Rational Krylov (SIRK)* method (source `RiemannProof/Hashimoto.md`; `book.tex`
cites at lines 1147 / 2055).  It follows §0 S7 of the roadmap (the numerical
backbone of the Mehler/Hashimoto Fock formalism), and the `IsSchurFull`/`EXTERNAL`
design pattern: the genuinely deep analytic inputs (Crouzeix's inequality, the
Göckler–Grimm / Hashimoto RK error theorems) are named hypotheses with citation
docstrings in `ChapterH2.lean`, never axioms; everything here is proved outright.

## Deliverables (this file)

* **H1.1 — the φ-functions.** `phi : ℕ → ℂ → ℂ`, `phi 0 = exp`,
  `phi (k+1) z = ∫ s in 0..1, exp (s·z)·(1−s)^k / k!` (eq. 3); `phi_zero`,
  `phi_at_zero : phi k 0 = 1/k!`.
* **H1.2 — the φ-recurrence.** `phi_succ_mul : z · phi (k+1) z = phi k z − 1/k!`
  (integration by parts); corollary `phi_one : z ≠ 0 → phi 1 z = (exp z − 1)/z`.
* **H1.4 — numerical range & eigenvalue inclusion.** `numericalRange A` (the set
  of Rayleigh quotients) with `eigenvalue_mem_numericalRange` (every eigenvalue
  lies in `W(A)` — the easy half of Toeplitz–Hausdorff).
* **H1.6 — the resolvent shift identity (the clean SIRK algebra core).** The
  resolvent identity `resolvent_identity` and the SIRK shift form
  `resolvent_shift_mul : X_j · (1 + h(m−j)·X_m) = X_m` for `γ_j = N − h·j`
  (§4, between eqs. (10)–(11)) — purely algebraic, no analysis.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis**.
-/

open scoped BigOperators
open intervalIntegral

namespace BookProof.ChapterH1

noncomputable section

/-! ## H1.1 — the φ-functions and their values -/

/-- The φ-functions (Hashimoto eq. 3): `φ₀ = exp`, and for `k ≥ 0`
`φ_{k+1}(z) = ∫₀¹ e^{s z} (1−s)^k / k! ds`.  Each `φ_k` is entire (a convergent
power series). -/
noncomputable def phi : ℕ → ℂ → ℂ
  | 0, z => Complex.exp z
  | (k + 1), z => ∫ s in (0 : ℝ)..1, Complex.exp (s * z) * (1 - s) ^ k / k.factorial



@[simp] theorem phi_zero_apply (z : ℂ) : phi 0 z = Complex.exp z := rfl



/-
**H1.1** (values at `0`): `φ_k(0) = 1/k!`.
For `k = 0` this is `exp 0 = 1`.  For `k+1`, the integrand at `z = 0` is
`(1−s)^k / k!`, whose integral over `[0,1]` is `1/((k+1)·k!) = 1/(k+1)!`.
-/


/-! ## H1.2 — the φ-recurrence -/

/-
**H1.2** (recurrence): `z · φ_{k+1}(z) = φ_k(z) − 1/k!`.
Integration by parts on the defining integral: with `u = e^{s z}` and
`dv = (1−s)^k/k! ds`, the boundary terms give `φ_k(z) − 1/k!` and the remaining
integral is `z·φ_{k+1}(z)`.
-/
e,_succ, phi ];
        field_simp;
        grind;
      · exact Coear_combination h

/-! ## H1.3 — the exponential-integrator Duhamel identity -/

/-- The **operator φ₁-function** as a vector-valued integral (Hashimoto eq. 3 at
`k = 0`, operator form): `phiOp1 M g = ∫₀¹ e^{s·M} g ds`.  This is the operator
analogue of `phi 1` (which is `∫₀¹ e^{s z} ds`). -/
noncomputable def phiOp1 {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) (g : Fin n → ℂ)  {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (g : Fin n → ℂ) (δ : ℝ) :
    (∫ s in (0 : ℝ)..δ, (NormedSpace.exp ((δ - s) ervalIntegral.integral_comp_div _ _ using 3 <;> ring <;> norm_num [ hδ ];
    simp [ hδ, smul_smul ]

/-! ## H1.4 — numerical range and eigenvalue inclusion -/

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- The **numerical range** `W(A)` of an operator: the set of Rayleigh quotients
`⟪v, A v⟫` over unit vectors `v`. -/
def numericalRange (A : E →ₗ[ℂ] E) : Set ℂ :=
  { c | ∃ v : E, ‖v‖ = 1 ∧ (inner (𝕜 := ℂ) v (A v)) = c }

/-
**H1.4** (eigenvalue inclusion = by
  use v;
  simp_all [ inner_self_eq_norm_sq_to_K ]

/-! ## H1.5 — the operator φ-function via the resolvent (Definition 2.4) -/

/-- The Taylor(1951)/Güttel(2010) transformed function `ψ_{k,γ}(x) := φ_k(γ − x⁻¹)`
(Hashimoto Definition 2.4).  The operator φ-function is then `φ_k(A) = ψ_{k,γ}(X)`
with `X = (γI − A)⁻¹` (evaluated by the holomorphic functional calculus). -/
noncomputable def nvalue `z` of
`A` the resolvent has eigenvalue `(γ − z)⁻¹`, and the transformed function
recovers `φ_k`: `ψ_{k,γ}((γ − z)⁻¹) = φ_k(z)`.  This is the spectral/
finite-rank-component identity that (via §0 S3, the holomorphic functional
calculus `f_γ((γI−A)⁻¹) = f(A)`) lifts to the operator equalidSpace ℂ F]
    (T : F →L[ℂ] F) (X : F →L[ℂ] F) (γ z : ℂ) (v : F)
    (hTv : T v = z • v) (hz : γ - z ≠ 0)
    (_hXr : (γ • (1 : F →L[ℂ] F) - T) * X = 1)
    (hXl : X * (γ • (1 : F →L[ℂ] F) - T) = 1) :
    X v = (γ - z)⁻¹ • v := by
  have key : X ((γ - z) • v) = v := by
    have := congr_arg ( fun f => f v ) hXl
    simpa [ sub_smul, hTva) = 1)
    (hml : (algebraMap ℂ A gm - a) * Xm = 1) (_hmr : Xm * (algebraMap ℂ A gm - a) = 1) :
    Xj - Xm = (gm - gj) • (Xj * Xm) := by
  -- Using the fact that $Xj * (γ_m - a) = 1$ and $Xm * (γ_m - a) = 1$, we can simplify the
  -- expression.
  have h_simp : Xj * (gm - gj) • 1 * Xm = Xj * (alg
    (_hjl : (algebraMap ℂ A (N - h * j) - a) * Xj = 1)
    (hjr : Xj * (algebraMap ℂ A (N - h * j) - a) = 1)
    (hml : (algebraMap ℂ A (N - h * m) - a) * Xm = 1)
    (_hmr : Xm * (algebraMap ℂ A (N - h * m) - a) = 1) :
    Xj * (1 + (h * (m - j)) • Xm) = Xm := by
  simp_all only [map_sub, map_mul, sub_mul, mul_sub, Algebra.smul_def, mul_add, mul_one];
  apply_fun ( · * Xm ) at hjr ; simp_all [ mul_assoc, sub_mul ];
  simp_all [ sub_eq_iff_eq_add ];
  simp_all [ mul_add ];
  grind

/-
**H1.7** (rational-Krylov representation, eq. 11 generating step): with the SIRK
shifts `γ_j = N − h·j` the resolvent `X_j` is the rational f⅟(1 + (h * (m - j)) • Xm) = ⅟(1 + (h * (m - j)) • Xm) * Xm := by
    apply_fun (fun x => x * ⅟(1 + (h * (m - j)) • Xm)) at hu_comm;
    simp_all only [map_sub, map_mul, mul_assoc, mul_invOf_self', mul_one];
    apply_fun (fun x => ⅟(1 + (h * (m - j)) • Xm) * x) at hu_comm; simp_all ;
  convert congr_arg ( fun x => x * ⅟ ( 1 + ( h * ( m - j ) ) • Xm ) ) ( resolvent_shift_mul a N h j
      m Xj Xm hjl hjr hml hmr ) using 1;
  · simp [ mul_assoc ];
  · exact hu_inv_comm.symm

end

end BookProof.ChapterH1
